/*
 * state.cc
 *
 * track the current state
 *
 * by WangLu
 * 2012.08.14
 */

/*
 * TODO
 * optimize lines using nested <span> (reuse classes)
 */

#include <algorithm>

#include "HTMLRenderer.h"
#include "namespace.h"


namespace pdf2htmlEX {

using std::max;
using std::abs;

void HTMLRenderer::updateAll(GfxState * state) 
{ 
    all_changed = true; 
    updateTextPos(state);
}
void HTMLRenderer::updateRise(GfxState * state)
{
    rise_changed = true;
}
void HTMLRenderer::updateTextPos(GfxState * state) 
{
    text_pos_changed = true;
    cur_tx = state->getLineX(); 
    cur_ty = state->getLineY(); 
}
void HTMLRenderer::updateTextShift(GfxState * state, double shift) 
{
    text_pos_changed = true;
    cur_tx -= shift * 0.001 * state->getFontSize() * state->getHorizScaling(); 
}
void HTMLRenderer::updateFont(GfxState * state) 
{
    font_changed = true; 
}
void HTMLRenderer::updateCTM(GfxState * state, double m11, double m12, double m21, double m22, double m31, double m32) 
{
    ctm_changed = true; 
}
void HTMLRenderer::updateTextMat(GfxState * state) 
{
    text_mat_changed = true; 
}
void HTMLRenderer::updateHorizScaling(GfxState * state)
{
    hori_scale_changed = true;
}
void HTMLRenderer::updateCharSpace(GfxState * state)
{
    letter_space_changed = true;
}

void HTMLRenderer::updateWordSpace(GfxState * state)
{
    word_space_changed = true;
}

void HTMLRenderer::updateFillColor(GfxState * state) 
{
    color_changed = true; 
}
void HTMLRenderer::check_state_change(GfxState * state)
{
    // DEPENDENCY WARNING
    // don't adjust the order of state checking 
    
    new_line_state = NLS_NONE;

    bool need_recheck_position = false;
    bool need_rescale_font = false;
    bool draw_scale_changed = false;

    // text position
    // we've been tracking the text position positively in the update*** functions
    if(all_changed || text_pos_changed)
    {
        need_recheck_position = true;
    }

    // font name & size
    if(all_changed || font_changed)
    {
        const FontInfo * new_font_info = install_font(state->getFont());

        if(!(new_font_info->id == cur_font_info->id))
        {
            new_line_state = max(new_line_state, NLS_DIV);
            cur_font_info = new_font_info;
        }

        double new_font_size = state->getFontSize();
        if(!_equal(cur_font_size, new_font_size))
        {
            need_rescale_font = true;
            cur_font_size = new_font_size;
        }
    }  

    // backup the current ctm for need_recheck_position
    double old_ctm[6];
    memcpy(old_ctm, cur_ctm, sizeof(old_ctm));

    // ctm & text ctm & hori scale
    if(all_changed || ctm_changed || text_mat_changed || hori_scale_changed)
    {
        double new_ctm[6];

        const double * m1 = state->getCTM();
        const double * m2 = state->getTextMat();
        double hori_scale = state->getHorizScaling();

        new_ctm[0] = (m1[0] * m2[0] + m1[2] * m2[1]) * hori_scale;
        new_ctm[1] = (m1[1] * m2[0] + m1[3] * m2[1]) * hori_scale;
        new_ctm[2] = m1[0] * m2[2] + m1[2] * m2[3];
        new_ctm[3] = m1[1] * m2[2] + m1[3] * m2[3];
        new_ctm[4] = m1[0] * m2[4] + m1[2] * m2[5] + m1[4]; 
        new_ctm[5] = m1[1] * m2[4] + m1[3] * m2[5] + m1[5];
        //new_ctm[4] = new_ctm[5] = 0;

        if(!_tm_equal(new_ctm, cur_ctm))
        {
            need_recheck_position = true;
            need_rescale_font = true;
            memcpy(cur_ctm, new_ctm, sizeof(cur_ctm));
        }
    }

    // draw_ctm, draw_scale
    // depends: font size & ctm & text_ctm & hori scale
    if(need_rescale_font)
    {
        double new_draw_ctm[6];
        memcpy(new_draw_ctm, cur_ctm, sizeof(new_draw_ctm));

        double new_draw_scale = (param->font_size_multiplier) * sqrt(new_draw_ctm[2] * new_draw_ctm[2] + new_draw_ctm[3] * new_draw_ctm[3]);

        double new_draw_font_size = cur_font_size;
        if(_is_positive(new_draw_scale))
        {
            new_draw_font_size *= new_draw_scale;
            for(int i = 0; i < 4; ++i)
                new_draw_ctm[i] /= new_draw_scale;
        }
        else
        {
            new_draw_scale = 1.0;
        }

        if(!(_equal(new_draw_scale, draw_scale)))
        {
            draw_scale_changed = true;
            draw_scale = new_draw_scale;
        }

        if(!(_equal(new_draw_font_size, draw_font_size)))
        {
            new_line_state = max(new_line_state, NLS_SPAN);
            draw_font_size = new_draw_font_size;
            cur_fs_id = install_font_size(draw_font_size);
        }
        if(!(_tm_equal(new_draw_ctm, draw_ctm, 4)))
        {
            new_line_state = max(new_line_state, NLS_DIV);
            memcpy(draw_ctm, new_draw_ctm, sizeof(draw_ctm));
            cur_tm_id = install_transform_matrix(draw_ctm);
        }
    }

    // see if we can merge with the current line
    // depends: rise & text position & transformation
    if(need_recheck_position)
    {
        // try to transform the old origin under the new TM
        /*
         * OldTM * (draw_tx, draw_ty, 1)^T = CurTM * (draw_tx + dx, draw_ty + dy, 1)^T
         *
         * OldTM[4] = CurTM[0] * dx + CurTM[2] * dy + CurTM[4] 
         * OldTM[5] = CurTM[1] * dx + CurTM[3] * dy + CurTM[5] 
         *
         * We just care if we can map the origin y to the same new y
         * So just let dy = cur_y - old_y, and try to solve dx
         *
         * TODO, writing mode, set dx and solve dy
         */

        bool merged = false;
        if(_tm_equal(old_ctm, cur_ctm, 4))
        {
            double dy = cur_ty - draw_ty;
            double tdx = old_ctm[4] - cur_ctm[4] - cur_ctm[2] * dy;
            double tdy = old_ctm[5] - cur_ctm[5] - cur_ctm[3] * dy;

            if(_equal(cur_ctm[0] * tdy, cur_ctm[1] * tdx))
            {
                if(abs(cur_ctm[0]) > EPS)
                {
                    draw_tx += tdx / cur_ctm[0];
                    draw_ty += dy;
                    merged = true;
                }
                else if (abs(cur_ctm[1]) > EPS)
                {
                    draw_tx += tdy / cur_ctm[1];
                    draw_ty += dy;
                    merged = true;
                }
                else
                {
                    if((abs(tdx) < EPS) && (abs(tdy) < EPS))
                    {
                        // free
                        draw_tx = cur_tx;
                        draw_ty += dy;
                        merged = true;
                    }
                    // else fail
                }
            }
            //else no solution
        }
        // else force new lien

        if(!merged)
        {
            new_line_state = max(new_line_state, NLS_DIV);
        }
    }

    // letter space
    // depends: draw_scale
    if(all_changed || letter_space_changed || draw_scale_changed)
    {
        double new_letter_space = state->getCharSpace();
        if(!_equal(cur_letter_space, new_letter_space))
        {
            new_line_state = max(new_line_state, NLS_SPAN);
            cur_letter_space = new_letter_space;
            cur_ls_id = install_letter_space(cur_letter_space * draw_scale);
        }
    }

    // word space
    // depends draw_scale
    if(all_changed || word_space_changed || draw_scale_changed)
    {
        double new_word_space = state->getWordSpace();
        if(!_equal(cur_word_space, new_word_space))
        {
            new_line_state = max(new_line_state, NLS_SPAN);
            cur_word_space = new_word_space;
            cur_ws_id = install_word_space(cur_word_space * draw_scale);
        }
    }

    // color
    if(all_changed || color_changed)
    {
        GfxRGB new_color;
        state->getFillRGB(&new_color);
        if(!((new_color.r == cur_color.r) && (new_color.g == cur_color.g) && (new_color.b == cur_color.b)))
        {
            new_line_state = max(new_line_state, NLS_SPAN);
            cur_color = new_color;
            cur_color_id = install_color(&new_color);
        }
    }

    // rise
    // depends draw_scale
    if(all_changed || rise_changed || draw_scale_changed)
    {
        double new_rise = state->getRise();
        if(!_equal(cur_rise, new_rise))
        {
            new_line_state = max(new_line_state, NLS_SPAN);
            cur_rise = new_rise;
            cur_rise_id = install_rise(new_rise * draw_scale);
        }
    }

    reset_state_change();
}

void HTMLRenderer::reset_state_change()
{
    all_changed = false;

    rise_changed = false;
    text_pos_changed = false;

    font_changed = false;
    ctm_changed = false;
    text_mat_changed = false;
    hori_scale_changed = false;

    letter_space_changed = false;
    word_space_changed = false;

    color_changed = false;
}
void HTMLRenderer::prepare_line(GfxState * state)
{
    if(!line_opened)
    {
        new_line_state = NLS_DIV;
    }
    
    if(new_line_state == NLS_DIV)
    {
        close_line();

        line_buf.reset(state);

        //resync position
        draw_ty = cur_ty;
        draw_tx = cur_tx;
    }
    else
    {
        // align horizontal position
        // try to merge with the last line if possible
        double target = (cur_tx - draw_tx) * draw_scale;
        if(abs(target) < param->h_eps)
        {
            // ignore it
        }
        else
        {
            line_buf.append_offset(target);
            draw_tx += target / draw_scale;
        }
    }

    if(new_line_state != NLS_NONE)
    {
        line_buf.append_state();
    }

    line_opened = true;
}

void HTMLRenderer::close_line()
{
    if(line_opened)
    {
        line_opened = false;
        line_buf.flush();
    }
}

} //namespace pdf2htmlEX

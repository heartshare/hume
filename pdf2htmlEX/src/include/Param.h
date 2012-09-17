/*
 * Parameters
 *
 * Wang Lu
 * 2012.08.03
 */


#ifndef PARAM_H__
#define PARAM_H__

#include <string>

namespace pdf2htmlEX {

struct Param
{
    // PDF stuff
    std::string owner_password, user_password;
    std::string input_filename, output_filename;

    // path
    std::string dest_dir, tmp_dir, data_dir;

    // normal parameters
    int first_page, last_page;

    double zoom;
    double h_dpi, v_dpi;

    int process_nontext;
    int single_html;
    int split_pages;
    int embed_base_font;
    int embed_external_font;
    int decompose_ligature;

    // Advanced tweak
    double h_eps, v_eps;
    double space_threshold;
    double font_size_multiplier;
    int tounicode;
    int space_as_offset;

    std::string css_filename;
    std::string font_suffix, font_format;

    int debug;
    int clean_tmp;
};

} // namespace pdf2htmlEX

#endif //PARAM_h__

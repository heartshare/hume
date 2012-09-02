



<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
 <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" >
 
 <meta name="ROBOTS" content="NOARCHIVE">
 
 <link rel="icon" type="image/vnd.microsoft.icon" href="http://www.gstatic.com/codesite/ph/images/phosting.ico">
 
 
 <script type="text/javascript">
 
 
 
 
 var codesite_token = null;
 
 
 var CS_env = {"profileUrl":null,"token":null,"assetHostPath":"http://www.gstatic.com/codesite/ph","domainName":null,"assetVersionPath":"http://www.gstatic.com/codesite/ph/13884470904824429500","projectHomeUrl":"/p/go","relativeBaseUrl":"","projectName":"go","loggedInUserEmail":null};
 var _gaq = _gaq || [];
 _gaq.push(
 ['siteTracker._setAccount', 'UA-18071-1'],
 ['siteTracker._trackPageview']);
 
 _gaq.push(
 ['projectTracker._setAccount', 'UA-11222381-1'],
 ['projectTracker._trackPageview']);
 
 (function() {
 var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
 ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
 (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(ga);
 })();
 
 </script>
 
 
 <title>godoc.vim - 
 go -
 
 
 The Go Programming Language - Google Project Hosting
 </title>
 <link type="text/css" rel="stylesheet" href="http://www.gstatic.com/codesite/ph/13884470904824429500/css/core.css">
 
 <link type="text/css" rel="stylesheet" href="http://www.gstatic.com/codesite/ph/13884470904824429500/css/ph_detail.css" >
 
 
 <link type="text/css" rel="stylesheet" href="http://www.gstatic.com/codesite/ph/13884470904824429500/css/d_sb.css" >
 
 
 
<!--[if IE]>
 <link type="text/css" rel="stylesheet" href="http://www.gstatic.com/codesite/ph/13884470904824429500/css/d_ie.css" >
<![endif]-->
 <style type="text/css">
 .menuIcon.off { background: no-repeat url(http://www.gstatic.com/codesite/ph/images/dropdown_sprite.gif) 0 -42px }
 .menuIcon.on { background: no-repeat url(http://www.gstatic.com/codesite/ph/images/dropdown_sprite.gif) 0 -28px }
 .menuIcon.down { background: no-repeat url(http://www.gstatic.com/codesite/ph/images/dropdown_sprite.gif) 0 0; }
 
 
 
  tr.inline_comment {
 background: #fff;
 vertical-align: top;
 }
 div.draft, div.published {
 padding: .3em;
 border: 1px solid #999; 
 margin-bottom: .1em;
 font-family: arial, sans-serif;
 max-width: 60em;
 }
 div.draft {
 background: #ffa;
 } 
 div.published {
 background: #e5ecf9;
 }
 div.published .body, div.draft .body {
 padding: .5em .1em .1em .1em;
 max-width: 60em;
 white-space: pre-wrap;
 white-space: -moz-pre-wrap;
 white-space: -pre-wrap;
 white-space: -o-pre-wrap;
 word-wrap: break-word;
 font-size: 1em;
 }
 div.draft .actions {
 margin-left: 1em;
 font-size: 90%;
 }
 div.draft form {
 padding: .5em .5em .5em 0;
 }
 div.draft textarea, div.published textarea {
 width: 95%;
 height: 10em;
 font-family: arial, sans-serif;
 margin-bottom: .5em;
 }

 
 .nocursor, .nocursor td, .cursor_hidden, .cursor_hidden td {
 background-color: white;
 height: 2px;
 }
 .cursor, .cursor td {
 background-color: darkblue;
 height: 2px;
 display: '';
 }
 
 
.list {
 border: 1px solid white;
 border-bottom: 0;
}

 
 </style>
</head>
<body class="t4">
<script type="text/javascript">
 window.___gcfg = {lang: 'en'};
 (function() 
 {var po = document.createElement("script");
 po.type = "text/javascript"; po.async = true;po.src = "https://apis.google.com/js/plusone.js";
 var s = document.getElementsByTagName("script")[0];
 s.parentNode.insertBefore(po, s);
 })();
</script>
<div class="headbg">

 <div id="gaia">
 

 <span>
 
 
 <a href="#" id="projects-dropdown" onclick="return false;"><u>My favorites</u> <small>&#9660;</small></a>
 | <a href="https://www.google.com/accounts/ServiceLogin?service=code&amp;ltmpl=phosting&amp;continue=http%3A%2F%2Fcode.google.com%2Fp%2Fgo%2Fsource%2Fbrowse%2Fmisc%2Fvim%2Fsyntax%2Fgodoc.vim&amp;followup=http%3A%2F%2Fcode.google.com%2Fp%2Fgo%2Fsource%2Fbrowse%2Fmisc%2Fvim%2Fsyntax%2Fgodoc.vim" onclick="_CS_click('/gb/ph/signin');"><u>Sign in</u></a>
 
 </span>

 </div>

 <div class="gbh" style="left: 0pt;"></div>
 <div class="gbh" style="right: 0pt;"></div>
 
 
 <div style="height: 1px"></div>
<!--[if lte IE 7]>
<div style="text-align:center;">
Your version of Internet Explorer is not supported. Try a browser that
contributes to open source, such as <a href="http://www.firefox.com">Firefox</a>,
<a href="http://www.google.com/chrome">Google Chrome</a>, or
<a href="http://code.google.com/chrome/chromeframe/">Google Chrome Frame</a>.
</div>
<![endif]-->



 <table style="padding:0px; margin: 0px 0px 10px 0px; width:100%" cellpadding="0" cellspacing="0"
 itemscope itemtype="http://schema.org/CreativeWork">
 <tr style="height: 58px;">
 
 <td id="plogo">
 <link itemprop="url" href="/p/go">
 <a href="/p/go/">
 
 
 <img src="/p/go/logo?cct=1346440427"
 alt="Logo" itemprop="image">
 
 </a>
 </td>
 
 <td style="padding-left: 0.5em">
 
 <div id="pname">
 <a href="/p/go/"><span itemprop="name">go</span></a>
 </div>
 
 <div id="psum">
 <a id="project_summary_link"
 href="/p/go/"><span itemprop="description">The Go Programming Language</span></a>
 
 </div>
 
 
 </td>
 <td style="white-space:nowrap;text-align:right; vertical-align:bottom;">
 
 <form action="/hosting/search">
 <input size="30" name="q" value="" type="text">
 
 <input type="submit" name="projectsearch" value="Search projects" >
 </form>
 
 </tr>
 </table>

</div>

 
<div id="mt" class="gtb"> 
 <a href="/p/go/" class="tab ">Project&nbsp;Home</a>
 
 
 
 
 <a href="/p/go/downloads/list" class="tab ">Downloads</a>
 
 
 
 
 
 <a href="/p/go/wiki/WikiIndex?tm=6" class="tab ">Wiki</a>
 
 
 
 
 
 <a href="/p/go/issues/list"
 class="tab ">Issues</a>
 
 
 
 
 
 <a href="/p/go/wiki/Source?tm=4"
 class="tab active">Source</a>
 
 
 
 
 
 
 
 <div class=gtbc></div>
</div>
<table cellspacing="0" cellpadding="0" width="100%" align="center" border="0" class="st">
 <tr>
 
 
 
 
 
 
 
 <td class="subt">
 <div class="st2">
 <div class="isf">
 
 <form action="/p/go/source/browse" style="display: inline">
 
 Repository:
 <select name="repo" id="repo" style="font-size: 92%" onchange="submit()">
 <option value="default">default</option><option value="wiki">wiki</option><option value="example">example</option><option value="empty">empty</option><option value="crypto">crypto</option><option value="net">net</option><option value="codereview">codereview</option><option value="image">image</option><option value="talks">talks</option>
 </select>
 </form>
 
 


 <span class="inst1"><a href="/p/go/source/checkout">Checkout</a></span> &nbsp;
 <span class="inst2"><a href="/p/go/source/browse/">Browse</a></span> &nbsp;
 <span class="inst3"><a href="/p/go/source/list">Changes</a></span> &nbsp;
 <span class="inst4"><a href="/p/go/source/clones">Clones</a></span> &nbsp; 
 &nbsp;
 
 
 <form action="/p/go/source/search" method="get" style="display:inline"
 onsubmit="document.getElementById('codesearchq').value = document.getElementById('origq').value">
 <input type="hidden" name="q" id="codesearchq" value="">
 <input type="text" maxlength="2048" size="38" id="origq" name="origq" value="" title="Google Code Search" style="font-size:92%">&nbsp;<input type="submit" value="Search Trunk" name="btnG" style="font-size:92%">
 
 
 </form>
 <script type="text/javascript">
 
 function codesearchQuery(form) {
 var query = document.getElementById('q').value;
 if (query) { form.action += '%20' + query; }
 }
 </script>
 </div>
</div>

 </td>
 
 
 
 <td align="right" valign="top" class="bevel-right"></td>
 </tr>
</table>


<script type="text/javascript">
 var cancelBubble = false;
 function _go(url) { document.location = url; }
</script>
<div id="maincol"
 
>

 
<!-- IE -->




<div class="expand">
<div id="colcontrol">
<style type="text/css">
 #file_flipper { white-space: nowrap; padding-right: 2em; }
 #file_flipper.hidden { display: none; }
 #file_flipper .pagelink { color: #0000CC; text-decoration: underline; }
 #file_flipper #visiblefiles { padding-left: 0.5em; padding-right: 0.5em; }
</style>
<table id="nav_and_rev" class="list"
 cellpadding="0" cellspacing="0" width="100%">
 <tr>
 
 <td nowrap="nowrap" class="src_crumbs src_nav" width="33%">
 <strong class="src_nav">Source path:&nbsp;</strong>
 <span id="crumb_root">
 
 <a href="/p/go/source/browse/">hg</a>/&nbsp;</span>
 <span id="crumb_links" class="ifClosed"><a href="/p/go/source/browse/misc/">misc</a><span class="sp">/&nbsp;</span><a href="/p/go/source/browse/misc/vim/">vim</a><span class="sp">/&nbsp;</span><a href="/p/go/source/browse/misc/vim/syntax/">syntax</a><span class="sp">/&nbsp;</span>godoc.vim</span>
 
 
 
 
 
 <form class="src_nav">
 
 <span class="sourcelabel"><strong>Branch:</strong>
 <select id="branch_select" name="name" onchange="submit()">
 
 <option value="default"
 selected>
 default
 </option>
 
 <option value="release-branch.go1"
 >
 release-branch.go1
 </option>
 
 <option value="release-branch.r57"
 >
 release-branch.r57
 </option>
 
 <option value="release-branch.r58"
 >
 release-branch.r58
 </option>
 
 <option value="release-branch.r59"
 >
 release-branch.r59
 </option>
 
 <option value="release-branch.r60"
 >
 release-branch.r60
 </option>
 
 
 </select>
 </span>
 </form>
 
 
 
 
 <form class="src_nav">
 
 <span class="sourcelabel">
 <strong>Tag:</strong>
 <select id="tag_select" name="name" onchange="submit()">
 <option value="">&lt;none&gt;</option>
 
 <option value="go1" >go1</option>
 
 <option value="go1.0.1" >go1.0.1</option>
 
 <option value="go1.0.2" >go1.0.2</option>
 
 <option value="release" >release</option>
 
 <option value="release.r56" >release.r56</option>
 
 <option value="release.r57" >release.r57</option>
 
 <option value="release.r57.1" >release.r57.1</option>
 
 <option value="release.r57.2" >release.r57.2</option>
 
 <option value="release.r58" >release.r58</option>
 
 <option value="release.r58.1" >release.r58.1</option>
 
 <option value="release.r58.2" >release.r58.2</option>
 
 <option value="release.r59" >release.r59</option>
 
 <option value="release.r60" >release.r60</option>
 
 <option value="release.r60.1" >release.r60.1</option>
 
 <option value="release.r60.2" >release.r60.2</option>
 
 <option value="release.r60.3" >release.r60.3</option>
 
 <option value="weekly" >weekly</option>
 
 <option value="weekly.2009-11-06" >weekly.2009-11-06</option>
 
 <option value="weekly.2009-11-10" >weekly.2009-11-10</option>
 
 <option value="weekly.2009-11-10.1" >weekly.2009-11-10.1</option>
 
 <option value="weekly.2009-11-12" >weekly.2009-11-12</option>
 
 <option value="weekly.2009-11-17" >weekly.2009-11-17</option>
 
 <option value="weekly.2009-12-07" >weekly.2009-12-07</option>
 
 <option value="weekly.2009-12-09" >weekly.2009-12-09</option>
 
 <option value="weekly.2009-12-22" >weekly.2009-12-22</option>
 
 <option value="weekly.2010-01-05" >weekly.2010-01-05</option>
 
 <option value="weekly.2010-01-13" >weekly.2010-01-13</option>
 
 <option value="weekly.2010-01-27" >weekly.2010-01-27</option>
 
 <option value="weekly.2010-02-04" >weekly.2010-02-04</option>
 
 <option value="weekly.2010-02-17" >weekly.2010-02-17</option>
 
 <option value="weekly.2010-02-23" >weekly.2010-02-23</option>
 
 <option value="weekly.2010-03-04" >weekly.2010-03-04</option>
 
 <option value="weekly.2010-03-15" >weekly.2010-03-15</option>
 
 <option value="weekly.2010-03-22" >weekly.2010-03-22</option>
 
 <option value="weekly.2010-03-30" >weekly.2010-03-30</option>
 
 <option value="weekly.2010-04-13" >weekly.2010-04-13</option>
 
 <option value="weekly.2010-04-27" >weekly.2010-04-27</option>
 
 <option value="weekly.2010-05-04" >weekly.2010-05-04</option>
 
 <option value="weekly.2010-05-27" >weekly.2010-05-27</option>
 
 <option value="weekly.2010-06-09" >weekly.2010-06-09</option>
 
 <option value="weekly.2010-06-21" >weekly.2010-06-21</option>
 
 <option value="weekly.2010-07-01" >weekly.2010-07-01</option>
 
 <option value="weekly.2010-07-14" >weekly.2010-07-14</option>
 
 <option value="weekly.2010-07-29" >weekly.2010-07-29</option>
 
 <option value="weekly.2010-08-04" >weekly.2010-08-04</option>
 
 <option value="weekly.2010-08-11" >weekly.2010-08-11</option>
 
 <option value="weekly.2010-08-25" >weekly.2010-08-25</option>
 
 <option value="weekly.2010-09-06" >weekly.2010-09-06</option>
 
 <option value="weekly.2010-09-15" >weekly.2010-09-15</option>
 
 <option value="weekly.2010-09-22" >weekly.2010-09-22</option>
 
 <option value="weekly.2010-09-29" >weekly.2010-09-29</option>
 
 <option value="weekly.2010-10-13" >weekly.2010-10-13</option>
 
 <option value="weekly.2010-10-13.1" >weekly.2010-10-13.1</option>
 
 <option value="weekly.2010-10-20" >weekly.2010-10-20</option>
 
 <option value="weekly.2010-10-27" >weekly.2010-10-27</option>
 
 <option value="weekly.2010-11-02" >weekly.2010-11-02</option>
 
 <option value="weekly.2010-11-10" >weekly.2010-11-10</option>
 
 <option value="weekly.2010-11-23" >weekly.2010-11-23</option>
 
 <option value="weekly.2010-12-02" >weekly.2010-12-02</option>
 
 <option value="weekly.2010-12-08" >weekly.2010-12-08</option>
 
 <option value="weekly.2010-12-15" >weekly.2010-12-15</option>
 
 <option value="weekly.2010-12-15.1" >weekly.2010-12-15.1</option>
 
 <option value="weekly.2010-12-22" >weekly.2010-12-22</option>
 
 <option value="weekly.2011-01-06" >weekly.2011-01-06</option>
 
 <option value="weekly.2011-01-12" >weekly.2011-01-12</option>
 
 <option value="weekly.2011-01-19" >weekly.2011-01-19</option>
 
 <option value="weekly.2011-01-20" >weekly.2011-01-20</option>
 
 <option value="weekly.2011-02-01" >weekly.2011-02-01</option>
 
 <option value="weekly.2011-02-01.1" >weekly.2011-02-01.1</option>
 
 <option value="weekly.2011-02-15" >weekly.2011-02-15</option>
 
 <option value="weekly.2011-02-24" >weekly.2011-02-24</option>
 
 <option value="weekly.2011-03-07" >weekly.2011-03-07</option>
 
 <option value="weekly.2011-03-07.1" >weekly.2011-03-07.1</option>
 
 <option value="weekly.2011-03-15" >weekly.2011-03-15</option>
 
 <option value="weekly.2011-03-28" >weekly.2011-03-28</option>
 
 <option value="weekly.2011-04-04" >weekly.2011-04-04</option>
 
 <option value="weekly.2011-04-13" >weekly.2011-04-13</option>
 
 <option value="weekly.2011-04-27" >weekly.2011-04-27</option>
 
 <option value="weekly.2011-05-22" >weekly.2011-05-22</option>
 
 <option value="weekly.2011-06-02" >weekly.2011-06-02</option>
 
 <option value="weekly.2011-06-09" >weekly.2011-06-09</option>
 
 <option value="weekly.2011-06-16" >weekly.2011-06-16</option>
 
 <option value="weekly.2011-06-23" >weekly.2011-06-23</option>
 
 <option value="weekly.2011-07-07" >weekly.2011-07-07</option>
 
 <option value="weekly.2011-07-19" >weekly.2011-07-19</option>
 
 <option value="weekly.2011-07-29" >weekly.2011-07-29</option>
 
 <option value="weekly.2011-08-10" >weekly.2011-08-10</option>
 
 <option value="weekly.2011-08-17" >weekly.2011-08-17</option>
 
 <option value="weekly.2011-09-01" >weekly.2011-09-01</option>
 
 <option value="weekly.2011-09-07" >weekly.2011-09-07</option>
 
 <option value="weekly.2011-09-16" >weekly.2011-09-16</option>
 
 <option value="weekly.2011-09-21" >weekly.2011-09-21</option>
 
 <option value="weekly.2011-10-06" >weekly.2011-10-06</option>
 
 <option value="weekly.2011-10-18" >weekly.2011-10-18</option>
 
 <option value="weekly.2011-10-25" >weekly.2011-10-25</option>
 
 <option value="weekly.2011-10-26" >weekly.2011-10-26</option>
 
 <option value="weekly.2011-11-01" >weekly.2011-11-01</option>
 
 <option value="weekly.2011-11-02" >weekly.2011-11-02</option>
 
 <option value="weekly.2011-11-08" >weekly.2011-11-08</option>
 
 <option value="weekly.2011-11-09" >weekly.2011-11-09</option>
 
 <option value="weekly.2011-11-18" >weekly.2011-11-18</option>
 
 <option value="weekly.2011-12-01" >weekly.2011-12-01</option>
 
 <option value="weekly.2011-12-02" >weekly.2011-12-02</option>
 
 <option value="weekly.2011-12-06" >weekly.2011-12-06</option>
 
 <option value="weekly.2011-12-14" >weekly.2011-12-14</option>
 
 <option value="weekly.2011-12-22" >weekly.2011-12-22</option>
 
 <option value="weekly.2012-01-15" >weekly.2012-01-15</option>
 
 <option value="weekly.2012-01-20" >weekly.2012-01-20</option>
 
 <option value="weekly.2012-01-27" >weekly.2012-01-27</option>
 
 <option value="weekly.2012-02-07" >weekly.2012-02-07</option>
 
 <option value="weekly.2012-02-14" >weekly.2012-02-14</option>
 
 <option value="weekly.2012-02-22" >weekly.2012-02-22</option>
 
 <option value="weekly.2012-03-04" >weekly.2012-03-04</option>
 
 <option value="weekly.2012-03-13" >weekly.2012-03-13</option>
 
 <option value="weekly.2012-03-22" >weekly.2012-03-22</option>
 
 <option value="weekly.2012-03-27" >weekly.2012-03-27</option>
 
 </select>
 </span>
 </form>
 
 
 
 


 </td>
 
 
 <td nowrap="nowrap" width="33%" align="right">
 <table cellpadding="0" cellspacing="0" style="font-size: 100%"><tr>
 
 
 <td class="flipper"><b>272e1dd72156</b></td>
 
 </tr></table>
 </td> 
 </tr>
</table>

<div class="fc">
 
 
 
<style type="text/css">
.undermouse span {
 background-image: url(http://www.gstatic.com/codesite/ph/images/comments.gif); }
</style>
<table class="opened" id="review_comment_area"
><tr>
<td id="nums">
<pre><table width="100%"><tr class="nocursor"><td></td></tr></table></pre>
<pre><table width="100%" id="nums_table_0"><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_1"

><td id="1"><a href="#1">1</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_2"

><td id="2"><a href="#2">2</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_3"

><td id="3"><a href="#3">3</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_4"

><td id="4"><a href="#4">4</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_5"

><td id="5"><a href="#5">5</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_6"

><td id="6"><a href="#6">6</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_7"

><td id="7"><a href="#7">7</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_8"

><td id="8"><a href="#8">8</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_9"

><td id="9"><a href="#9">9</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_10"

><td id="10"><a href="#10">10</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_11"

><td id="11"><a href="#11">11</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_12"

><td id="12"><a href="#12">12</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_13"

><td id="13"><a href="#13">13</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_14"

><td id="14"><a href="#14">14</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_15"

><td id="15"><a href="#15">15</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_16"

><td id="16"><a href="#16">16</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_17"

><td id="17"><a href="#17">17</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_18"

><td id="18"><a href="#18">18</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_19"

><td id="19"><a href="#19">19</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_20"

><td id="20"><a href="#20">20</a></td></tr
></table></pre>
<pre><table width="100%"><tr class="nocursor"><td></td></tr></table></pre>
</td>
<td id="lines">
<pre><table width="100%"><tr class="cursor_stop cursor_hidden"><td></td></tr></table></pre>
<pre ><table id="src_table_0"><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_1

><td class="source">&quot; Copyright 2011 The Go Authors. All rights reserved.<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_2

><td class="source">&quot; Use of this source code is governed by a BSD-style<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_3

><td class="source">&quot; license that can be found in the LICENSE file.<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_4

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_5

><td class="source">if exists(&quot;b:current_syntax&quot;)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_6

><td class="source">  finish<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_7

><td class="source">endif<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_8

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_9

><td class="source">syn case match<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_10

><td class="source">syn match  godocTitle &quot;^\([A-Z]*\)$&quot;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_11

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_12

><td class="source">command -nargs=+ HiLink hi def link &lt;args&gt;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_13

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_14

><td class="source">HiLink godocTitle Title<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_15

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_16

><td class="source">delcommand HiLink<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_17

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_18

><td class="source">let b:current_syntax = &quot;godoc&quot;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_19

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_20

><td class="source">&quot; vim:ts=4 sts=2 sw=2:<br></td></tr
></table></pre>
<pre><table width="100%"><tr class="cursor_stop cursor_hidden"><td></td></tr></table></pre>
</td>
</tr></table>

 
<script type="text/javascript">
 var lineNumUnderMouse = -1;
 
 function gutterOver(num) {
 gutterOut();
 var newTR = document.getElementById('gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_' + num);
 if (newTR) {
 newTR.className = 'undermouse';
 }
 lineNumUnderMouse = num;
 }
 function gutterOut() {
 if (lineNumUnderMouse != -1) {
 var oldTR = document.getElementById(
 'gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_' + lineNumUnderMouse);
 if (oldTR) {
 oldTR.className = '';
 }
 lineNumUnderMouse = -1;
 }
 }
 var numsGenState = {table_base_id: 'nums_table_'};
 var srcGenState = {table_base_id: 'src_table_'};
 var alignerRunning = false;
 var startOver = false;
 function setLineNumberHeights() {
 if (alignerRunning) {
 startOver = true;
 return;
 }
 numsGenState.chunk_id = 0;
 numsGenState.table = document.getElementById('nums_table_0');
 numsGenState.row_num = 0;
 if (!numsGenState.table) {
 return; // Silently exit if no file is present.
 }
 srcGenState.chunk_id = 0;
 srcGenState.table = document.getElementById('src_table_0');
 srcGenState.row_num = 0;
 alignerRunning = true;
 continueToSetLineNumberHeights();
 }
 function rowGenerator(genState) {
 if (genState.row_num < genState.table.rows.length) {
 var currentRow = genState.table.rows[genState.row_num];
 genState.row_num++;
 return currentRow;
 }
 var newTable = document.getElementById(
 genState.table_base_id + (genState.chunk_id + 1));
 if (newTable) {
 genState.chunk_id++;
 genState.row_num = 0;
 genState.table = newTable;
 return genState.table.rows[0];
 }
 return null;
 }
 var MAX_ROWS_PER_PASS = 1000;
 function continueToSetLineNumberHeights() {
 var rowsInThisPass = 0;
 var numRow = 1;
 var srcRow = 1;
 while (numRow && srcRow && rowsInThisPass < MAX_ROWS_PER_PASS) {
 numRow = rowGenerator(numsGenState);
 srcRow = rowGenerator(srcGenState);
 rowsInThisPass++;
 if (numRow && srcRow) {
 if (numRow.offsetHeight != srcRow.offsetHeight) {
 numRow.firstChild.style.height = srcRow.offsetHeight + 'px';
 }
 }
 }
 if (rowsInThisPass >= MAX_ROWS_PER_PASS) {
 setTimeout(continueToSetLineNumberHeights, 10);
 } else {
 alignerRunning = false;
 if (startOver) {
 startOver = false;
 setTimeout(setLineNumberHeights, 500);
 }
 }
 }
 function initLineNumberHeights() {
 // Do 2 complete passes, because there can be races
 // between this code and prettify.
 startOver = true;
 setTimeout(setLineNumberHeights, 250);
 window.onresize = setLineNumberHeights;
 }
 initLineNumberHeights();
</script>

 
 
 <div id="log">
 <div style="text-align:right">
 <a class="ifCollapse" href="#" onclick="_toggleMeta(this); return false">Show details</a>
 <a class="ifExpand" href="#" onclick="_toggleMeta(this); return false">Hide details</a>
 </div>
 <div class="ifExpand">
 
 
 <div class="pmeta_bubble_bg" style="border:1px solid white">
 <div class="round4"></div>
 <div class="round2"></div>
 <div class="round1"></div>
 <div class="box-inner">
 <div id="changelog">
 <p>Change log</p>
 <div>
 <a href="/p/go/source/detail?spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9&amp;r=2ffd085d488a76c501956f3c54570db11bd27579">2ffd085d488a</a>
 by Yasuhiro Matsumoto &lt;mattn.jp&gt;
 on Aug 2, 2011
 &nbsp; <a href="/p/go/source/diff?spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9&r=2ffd085d488a76c501956f3c54570db11bd27579&amp;format=side&amp;path=/misc/vim/syntax/godoc.vim&amp;old_path=/misc/vim/syntax/godoc.vim&amp;old=">Diff</a>
 </div>
 <pre>misc/vim: Godoc command.
vim command 'Godoc' to see godoc.

R=golang-dev, dsymonds
CC=golang-dev
<a href="http://codereview.appspot.com/4815071" rel="nofollow">http://codereview.appspot.com/4815071</a>

Committer: David Symonds
&lt;dsymonds@golang.org&gt;</pre>
 </div>
 
 
 
 
 
 
 <script type="text/javascript">
 var detail_url = '/p/go/source/detail?r=2ffd085d488a76c501956f3c54570db11bd27579&spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9';
 var publish_url = '/p/go/source/detail?r=2ffd085d488a76c501956f3c54570db11bd27579&spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9#publish';
 // describe the paths of this revision in javascript.
 var changed_paths = [];
 var changed_urls = [];
 
 changed_paths.push('/misc/vim/ftplugin/go/godoc.vim');
 changed_urls.push('/p/go/source/browse/misc/vim/ftplugin/go/godoc.vim?r\x3d2ffd085d488a76c501956f3c54570db11bd27579\x26spec\x3dsvn272e1dd72156cbe4b548c37be8285f38c39ccbb9');
 
 
 changed_paths.push('/misc/vim/plugin/godoc.vim');
 changed_urls.push('/p/go/source/browse/misc/vim/plugin/godoc.vim?r\x3d2ffd085d488a76c501956f3c54570db11bd27579\x26spec\x3dsvn272e1dd72156cbe4b548c37be8285f38c39ccbb9');
 
 
 changed_paths.push('/misc/vim/readme.txt');
 changed_urls.push('/p/go/source/browse/misc/vim/readme.txt?r\x3d2ffd085d488a76c501956f3c54570db11bd27579\x26spec\x3dsvn272e1dd72156cbe4b548c37be8285f38c39ccbb9');
 
 
 changed_paths.push('/misc/vim/syntax/godoc.vim');
 changed_urls.push('/p/go/source/browse/misc/vim/syntax/godoc.vim?r\x3d2ffd085d488a76c501956f3c54570db11bd27579\x26spec\x3dsvn272e1dd72156cbe4b548c37be8285f38c39ccbb9');
 
 var selected_path = '/misc/vim/syntax/godoc.vim';
 
 
 function getCurrentPageIndex() {
 for (var i = 0; i < changed_paths.length; i++) {
 if (selected_path == changed_paths[i]) {
 return i;
 }
 }
 }
 function getNextPage() {
 var i = getCurrentPageIndex();
 if (i < changed_paths.length - 1) {
 return changed_urls[i + 1];
 }
 return null;
 }
 function getPreviousPage() {
 var i = getCurrentPageIndex();
 if (i > 0) {
 return changed_urls[i - 1];
 }
 return null;
 }
 function gotoNextPage() {
 var page = getNextPage();
 if (!page) {
 page = detail_url;
 }
 window.location = page;
 }
 function gotoPreviousPage() {
 var page = getPreviousPage();
 if (!page) {
 page = detail_url;
 }
 window.location = page;
 }
 function gotoDetailPage() {
 window.location = detail_url;
 }
 function gotoPublishPage() {
 window.location = publish_url;
 }
</script>

 
 <style type="text/css">
 #review_nav {
 border-top: 3px solid white;
 padding-top: 6px;
 margin-top: 1em;
 }
 #review_nav td {
 vertical-align: middle;
 }
 #review_nav select {
 margin: .5em 0;
 }
 </style>
 <div id="review_nav">
 <table><tr><td>Go to:&nbsp;</td><td>
 <select name="files_in_rev" onchange="window.location=this.value">
 
 <option value="/p/go/source/browse/misc/vim/ftplugin/go/godoc.vim?r=2ffd085d488a76c501956f3c54570db11bd27579&amp;spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9"
 
 >/misc/vim/ftplugin/go/godoc.vim</option>
 
 <option value="/p/go/source/browse/misc/vim/plugin/godoc.vim?r=2ffd085d488a76c501956f3c54570db11bd27579&amp;spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9"
 
 >/misc/vim/plugin/godoc.vim</option>
 
 <option value="/p/go/source/browse/misc/vim/readme.txt?r=2ffd085d488a76c501956f3c54570db11bd27579&amp;spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9"
 
 >/misc/vim/readme.txt</option>
 
 <option value="/p/go/source/browse/misc/vim/syntax/godoc.vim?r=2ffd085d488a76c501956f3c54570db11bd27579&amp;spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9"
 selected="selected"
 >/misc/vim/syntax/godoc.vim</option>
 
 </select>
 </td></tr></table>
 
 
 




 
 </div>
 
 
 </div>
 <div class="round1"></div>
 <div class="round2"></div>
 <div class="round4"></div>
 </div>
 <div class="pmeta_bubble_bg" style="border:1px solid white">
 <div class="round4"></div>
 <div class="round2"></div>
 <div class="round1"></div>
 <div class="box-inner">
 <div id="older_bubble">
 <p>Older revisions</p>
 
 <a href="/p/go/source/list?path=/misc/vim/syntax/godoc.vim&r=2ffd085d488a76c501956f3c54570db11bd27579">All revisions of this file</a>
 </div>
 </div>
 <div class="round1"></div>
 <div class="round2"></div>
 <div class="round4"></div>
 </div>
 
 <div class="pmeta_bubble_bg" style="border:1px solid white">
 <div class="round4"></div>
 <div class="round2"></div>
 <div class="round1"></div>
 <div class="box-inner">
 <div id="fileinfo_bubble">
 <p>File info</p>
 
 <div>Size: 399 bytes,
 20 lines</div>
 
 <div><a href="//go.googlecode.com/hg/misc/vim/syntax/godoc.vim">View raw file</a></div>
 </div>
 
 </div>
 <div class="round1"></div>
 <div class="round2"></div>
 <div class="round4"></div>
 </div>
 </div>
 </div>


</div>

</div>
</div>


<script src="http://www.gstatic.com/codesite/ph/13884470904824429500/js/source_file_scripts.js"></script>

 <script type="text/javascript" src="http://www.gstatic.com/codesite/ph/13884470904824429500/js/kibbles.js"></script>
 <script type="text/javascript">
 var lastStop = null;
 var initialized = false;
 
 function updateCursor(next, prev) {
 if (prev && prev.element) {
 prev.element.className = 'cursor_stop cursor_hidden';
 }
 if (next && next.element) {
 next.element.className = 'cursor_stop cursor';
 lastStop = next.index;
 }
 }
 
 function pubRevealed(data) {
 updateCursorForCell(data.cellId, 'cursor_stop cursor_hidden');
 if (initialized) {
 reloadCursors();
 }
 }
 
 function draftRevealed(data) {
 updateCursorForCell(data.cellId, 'cursor_stop cursor_hidden');
 if (initialized) {
 reloadCursors();
 }
 }
 
 function draftDestroyed(data) {
 updateCursorForCell(data.cellId, 'nocursor');
 if (initialized) {
 reloadCursors();
 }
 }
 function reloadCursors() {
 kibbles.skipper.reset();
 loadCursors();
 if (lastStop != null) {
 kibbles.skipper.setCurrentStop(lastStop);
 }
 }
 // possibly the simplest way to insert any newly added comments
 // is to update the class of the corresponding cursor row,
 // then refresh the entire list of rows.
 function updateCursorForCell(cellId, className) {
 var cell = document.getElementById(cellId);
 // we have to go two rows back to find the cursor location
 var row = getPreviousElement(cell.parentNode);
 row.className = className;
 }
 // returns the previous element, ignores text nodes.
 function getPreviousElement(e) {
 var element = e.previousSibling;
 if (element.nodeType == 3) {
 element = element.previousSibling;
 }
 if (element && element.tagName) {
 return element;
 }
 }
 function loadCursors() {
 // register our elements with skipper
 var elements = CR_getElements('*', 'cursor_stop');
 var len = elements.length;
 for (var i = 0; i < len; i++) {
 var element = elements[i]; 
 element.className = 'cursor_stop cursor_hidden';
 kibbles.skipper.append(element);
 }
 }
 function toggleComments() {
 CR_toggleCommentDisplay();
 reloadCursors();
 }
 function keysOnLoadHandler() {
 // setup skipper
 kibbles.skipper.addStopListener(
 kibbles.skipper.LISTENER_TYPE.PRE, updateCursor);
 // Set the 'offset' option to return the middle of the client area
 // an option can be a static value, or a callback
 kibbles.skipper.setOption('padding_top', 50);
 // Set the 'offset' option to return the middle of the client area
 // an option can be a static value, or a callback
 kibbles.skipper.setOption('padding_bottom', 100);
 // Register our keys
 kibbles.skipper.addFwdKey("n");
 kibbles.skipper.addRevKey("p");
 kibbles.keys.addKeyPressListener(
 'u', function() { window.location = detail_url; });
 kibbles.keys.addKeyPressListener(
 'r', function() { window.location = detail_url + '#publish'; });
 
 kibbles.keys.addKeyPressListener('j', gotoNextPage);
 kibbles.keys.addKeyPressListener('k', gotoPreviousPage);
 
 
 }
 </script>
<script src="http://www.gstatic.com/codesite/ph/13884470904824429500/js/code_review_scripts.js"></script>
<script type="text/javascript">
 function showPublishInstructions() {
 var element = document.getElementById('review_instr');
 if (element) {
 element.className = 'opened';
 }
 }
 var codereviews;
 function revsOnLoadHandler() {
 // register our source container with the commenting code
 var paths = {'svn272e1dd72156cbe4b548c37be8285f38c39ccbb9': '/misc/vim/syntax/godoc.vim'}
 codereviews = CR_controller.setup(
 {"profileUrl":null,"token":null,"assetHostPath":"http://www.gstatic.com/codesite/ph","domainName":null,"assetVersionPath":"http://www.gstatic.com/codesite/ph/13884470904824429500","projectHomeUrl":"/p/go","relativeBaseUrl":"","projectName":"go","loggedInUserEmail":null}, '', 'svn272e1dd72156cbe4b548c37be8285f38c39ccbb9', paths,
 CR_BrowseIntegrationFactory);
 
 codereviews.registerActivityListener(CR_ActivityType.REVEAL_DRAFT_PLATE, showPublishInstructions);
 
 codereviews.registerActivityListener(CR_ActivityType.REVEAL_PUB_PLATE, pubRevealed);
 codereviews.registerActivityListener(CR_ActivityType.REVEAL_DRAFT_PLATE, draftRevealed);
 codereviews.registerActivityListener(CR_ActivityType.DISCARD_DRAFT_COMMENT, draftDestroyed);
 
 
 
 
 
 
 
 var initialized = true;
 reloadCursors();
 }
 window.onload = function() {keysOnLoadHandler(); revsOnLoadHandler();};

</script>
<script type="text/javascript" src="http://www.gstatic.com/codesite/ph/13884470904824429500/js/dit_scripts.js"></script>

 
 
 
 <script type="text/javascript" src="http://www.gstatic.com/codesite/ph/13884470904824429500/js/ph_core.js"></script>
 
 
 
 
</div> 

<div id="footer" dir="ltr">
 <div class="text">
 <a href="/projecthosting/terms.html">Terms</a> -
 <a href="http://www.google.com/privacy.html">Privacy</a> -
 <a href="/p/support/">Project Hosting Help</a>
 </div>
</div>
 <div class="hostedBy" style="margin-top: -20px;">
 <span style="vertical-align: top;">Powered by <a href="http://code.google.com/projecthosting/">Google Project Hosting</a></span>
 </div>

 
 


 
 </body>
</html>






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
 | <a href="https://www.google.com/accounts/ServiceLogin?service=code&amp;ltmpl=phosting&amp;continue=http%3A%2F%2Fcode.google.com%2Fp%2Fgo%2Fsource%2Fbrowse%2Fmisc%2Fvim%2Fplugin%2Fgodoc.vim&amp;followup=http%3A%2F%2Fcode.google.com%2Fp%2Fgo%2Fsource%2Fbrowse%2Fmisc%2Fvim%2Fplugin%2Fgodoc.vim" onclick="_CS_click('/gb/ph/signin');"><u>Sign in</u></a>
 
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
 <span id="crumb_links" class="ifClosed"><a href="/p/go/source/browse/misc/">misc</a><span class="sp">/&nbsp;</span><a href="/p/go/source/browse/misc/vim/">vim</a><span class="sp">/&nbsp;</span><a href="/p/go/source/browse/misc/vim/plugin/">plugin</a><span class="sp">/&nbsp;</span>godoc.vim</span>
 
 
 
 
 
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
 
 
 <td class="flipper">
 <ul class="leftside">
 
 <li><a href="/p/go/source/browse/misc/vim/plugin/godoc.vim?r=1ce42d48298d0ef498d342a278f2fe615e673bcb" title="Previous">&lsaquo;1ce42d48298d</a></li>
 
 </ul>
 </td>
 
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
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_21"

><td id="21"><a href="#21">21</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_22"

><td id="22"><a href="#22">22</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_23"

><td id="23"><a href="#23">23</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_24"

><td id="24"><a href="#24">24</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_25"

><td id="25"><a href="#25">25</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_26"

><td id="26"><a href="#26">26</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_27"

><td id="27"><a href="#27">27</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_28"

><td id="28"><a href="#28">28</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_29"

><td id="29"><a href="#29">29</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_30"

><td id="30"><a href="#30">30</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_31"

><td id="31"><a href="#31">31</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_32"

><td id="32"><a href="#32">32</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_33"

><td id="33"><a href="#33">33</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_34"

><td id="34"><a href="#34">34</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_35"

><td id="35"><a href="#35">35</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_36"

><td id="36"><a href="#36">36</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_37"

><td id="37"><a href="#37">37</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_38"

><td id="38"><a href="#38">38</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_39"

><td id="39"><a href="#39">39</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_40"

><td id="40"><a href="#40">40</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_41"

><td id="41"><a href="#41">41</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_42"

><td id="42"><a href="#42">42</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_43"

><td id="43"><a href="#43">43</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_44"

><td id="44"><a href="#44">44</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_45"

><td id="45"><a href="#45">45</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_46"

><td id="46"><a href="#46">46</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_47"

><td id="47"><a href="#47">47</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_48"

><td id="48"><a href="#48">48</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_49"

><td id="49"><a href="#49">49</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_50"

><td id="50"><a href="#50">50</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_51"

><td id="51"><a href="#51">51</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_52"

><td id="52"><a href="#52">52</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_53"

><td id="53"><a href="#53">53</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_54"

><td id="54"><a href="#54">54</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_55"

><td id="55"><a href="#55">55</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_56"

><td id="56"><a href="#56">56</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_57"

><td id="57"><a href="#57">57</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_58"

><td id="58"><a href="#58">58</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_59"

><td id="59"><a href="#59">59</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_60"

><td id="60"><a href="#60">60</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_61"

><td id="61"><a href="#61">61</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_62"

><td id="62"><a href="#62">62</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_63"

><td id="63"><a href="#63">63</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_64"

><td id="64"><a href="#64">64</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_65"

><td id="65"><a href="#65">65</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_66"

><td id="66"><a href="#66">66</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_67"

><td id="67"><a href="#67">67</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_68"

><td id="68"><a href="#68">68</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_69"

><td id="69"><a href="#69">69</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_70"

><td id="70"><a href="#70">70</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_71"

><td id="71"><a href="#71">71</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_72"

><td id="72"><a href="#72">72</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_73"

><td id="73"><a href="#73">73</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_74"

><td id="74"><a href="#74">74</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_75"

><td id="75"><a href="#75">75</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_76"

><td id="76"><a href="#76">76</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_77"

><td id="77"><a href="#77">77</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_78"

><td id="78"><a href="#78">78</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_79"

><td id="79"><a href="#79">79</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_80"

><td id="80"><a href="#80">80</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_81"

><td id="81"><a href="#81">81</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_82"

><td id="82"><a href="#82">82</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_83"

><td id="83"><a href="#83">83</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_84"

><td id="84"><a href="#84">84</a></td></tr
><tr id="gr_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_85"

><td id="85"><a href="#85">85</a></td></tr
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

><td class="source">&quot;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_5

><td class="source">&quot; godoc.vim: Vim command to see godoc.<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_6

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_7

><td class="source">if exists(&quot;g:loaded_godoc&quot;)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_8

><td class="source">  finish<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_9

><td class="source">endif<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_10

><td class="source">let g:loaded_godoc = 1<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_11

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_12

><td class="source">let s:buf_nr = -1<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_13

><td class="source">let s:last_word = &#39;&#39;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_14

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_15

><td class="source">function! s:GodocView()<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_16

><td class="source">  if !bufexists(s:buf_nr)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_17

><td class="source">    leftabove new<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_18

><td class="source">    file `=&quot;[Godoc]&quot;`<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_19

><td class="source">    let s:buf_nr = bufnr(&#39;%&#39;)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_20

><td class="source">  elseif bufwinnr(s:buf_nr) == -1<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_21

><td class="source">    leftabove split<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_22

><td class="source">    execute s:buf_nr . &#39;buffer&#39;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_23

><td class="source">    delete _<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_24

><td class="source">  elseif bufwinnr(s:buf_nr) != bufwinnr(&#39;%&#39;)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_25

><td class="source">    execute bufwinnr(s:buf_nr) . &#39;wincmd w&#39;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_26

><td class="source">  endif<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_27

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_28

><td class="source">  setlocal filetype=godoc<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_29

><td class="source">  setlocal bufhidden=delete<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_30

><td class="source">  setlocal buftype=nofile<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_31

><td class="source">  setlocal noswapfile<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_32

><td class="source">  setlocal nobuflisted<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_33

><td class="source">  setlocal modifiable<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_34

><td class="source">  setlocal nocursorline<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_35

><td class="source">  setlocal nocursorcolumn<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_36

><td class="source">  setlocal iskeyword+=:<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_37

><td class="source">  setlocal iskeyword-=-<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_38

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_39

><td class="source">  nnoremap &lt;buffer&gt; &lt;silent&gt; K :Godoc&lt;cr&gt;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_40

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_41

><td class="source">  au BufHidden &lt;buffer&gt; call let &lt;SID&gt;buf_nr = -1<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_42

><td class="source">endfunction<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_43

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_44

><td class="source">function! s:GodocWord(word)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_45

><td class="source">  let word = a:word<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_46

><td class="source">  silent! let content = system(&#39;godoc &#39; . word)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_47

><td class="source">  if v:shell_error || !len(content)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_48

><td class="source">    if len(s:last_word)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_49

><td class="source">      silent! let content = system(&#39;godoc &#39; . s:last_word.&#39;/&#39;.word)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_50

><td class="source">      if v:shell_error || !len(content)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_51

><td class="source">        echo &#39;No documentation found for &quot;&#39; . word . &#39;&quot;.&#39;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_52

><td class="source">        return<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_53

><td class="source">      endif<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_54

><td class="source">      let word = s:last_word.&#39;/&#39;.word<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_55

><td class="source">    else<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_56

><td class="source">      echo &#39;No documentation found for &quot;&#39; . word . &#39;&quot;.&#39;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_57

><td class="source">      return<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_58

><td class="source">    endif<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_59

><td class="source">  endif<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_60

><td class="source">  let s:last_word = word<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_61

><td class="source">  silent! call s:GodocView()<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_62

><td class="source">  setlocal modifiable<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_63

><td class="source">  silent! %d _<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_64

><td class="source">  silent! put! =content<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_65

><td class="source">  silent! normal gg<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_66

><td class="source">  setlocal nomodifiable<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_67

><td class="source">  setfiletype godoc<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_68

><td class="source">endfunction<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_69

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_70

><td class="source">function! s:Godoc(...)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_71

><td class="source">  let word = join(a:000, &#39; &#39;)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_72

><td class="source">  if !len(word)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_73

><td class="source">    let word = expand(&#39;&lt;cword&gt;&#39;)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_74

><td class="source">  endif<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_75

><td class="source">  let word = substitute(word, &#39;[^a-zA-Z0-9\\/._~-]&#39;, &#39;&#39;, &#39;g&#39;)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_76

><td class="source">  if !len(word)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_77

><td class="source">    return<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_78

><td class="source">  endif<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_79

><td class="source">  call s:GodocWord(word)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_80

><td class="source">endfunction<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_81

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_82

><td class="source">command! -nargs=* -range -complete=customlist,go#complete#Package Godoc :call s:Godoc(&lt;q-args&gt;)<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_83

><td class="source">nnoremap &lt;silent&gt; &lt;Plug&gt;(godoc-keyword) :&lt;C-u&gt;call &lt;SID&gt;Godoc(&#39;&#39;)&lt;CR&gt;<br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_84

><td class="source"><br></td></tr
><tr
id=sl_svn272e1dd72156cbe4b548c37be8285f38c39ccbb9_85

><td class="source">&quot; vim:ts=4:sw=4:et<br></td></tr
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
 <a href="/p/go/source/detail?spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9&amp;r=7fb0e868dc39677df0bf041d42bbf40053c3a418">7fb0e868dc39</a>
 by Tobias Columbus &lt;tobias.columbus&gt;
 on Aug 27 (5 days ago)
 &nbsp; <a href="/p/go/source/diff?spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9&r=7fb0e868dc39677df0bf041d42bbf40053c3a418&amp;format=side&amp;path=/misc/vim/plugin/godoc.vim&amp;old_path=/misc/vim/plugin/godoc.vim&amp;old=1ce42d48298d0ef498d342a278f2fe615e673bcb">Diff</a>
 </div>
 <pre>misc/vim: fix for autocompletion

    Vim autocompletion respects the
$GOPATH variable and does not
    ignore dashes ('-'), dots ('.') and
underscores ('_') like found
    in many remote packages.
    Environment variable $GOROOT is
determined by calling
    'go env GOROOT' instead of relying on
the user's environment
    variables.
...</pre>
 </div>
 
 
 
 
 
 
 <script type="text/javascript">
 var detail_url = '/p/go/source/detail?r=7fb0e868dc39677df0bf041d42bbf40053c3a418&spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9';
 var publish_url = '/p/go/source/detail?r=7fb0e868dc39677df0bf041d42bbf40053c3a418&spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9#publish';
 // describe the paths of this revision in javascript.
 var changed_paths = [];
 var changed_urls = [];
 
 changed_paths.push('/misc/vim/autoload/go/complete.vim');
 changed_urls.push('/p/go/source/browse/misc/vim/autoload/go/complete.vim?r\x3d7fb0e868dc39677df0bf041d42bbf40053c3a418\x26spec\x3dsvn272e1dd72156cbe4b548c37be8285f38c39ccbb9');
 
 
 changed_paths.push('/misc/vim/plugin/godoc.vim');
 changed_urls.push('/p/go/source/browse/misc/vim/plugin/godoc.vim?r\x3d7fb0e868dc39677df0bf041d42bbf40053c3a418\x26spec\x3dsvn272e1dd72156cbe4b548c37be8285f38c39ccbb9');
 
 var selected_path = '/misc/vim/plugin/godoc.vim';
 
 
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
 
 <option value="/p/go/source/browse/misc/vim/autoload/go/complete.vim?r=7fb0e868dc39677df0bf041d42bbf40053c3a418&amp;spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9"
 
 >/misc/vim/autoload/go/complete.vim</option>
 
 <option value="/p/go/source/browse/misc/vim/plugin/godoc.vim?r=7fb0e868dc39677df0bf041d42bbf40053c3a418&amp;spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9"
 selected="selected"
 >/misc/vim/plugin/godoc.vim</option>
 
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
 
 
 <div class="closed" style="margin-bottom:3px;" >
 <img class="ifClosed" onclick="_toggleHidden(this)" src="http://www.gstatic.com/codesite/ph/images/plus.gif" >
 <img class="ifOpened" onclick="_toggleHidden(this)" src="http://www.gstatic.com/codesite/ph/images/minus.gif" >
 <a href="/p/go/source/detail?spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9&r=1ce42d48298d0ef498d342a278f2fe615e673bcb">1ce42d48298d</a>
 by Yasuhiro Matsumoto &lt;mattn.jp&gt;
 on Aug 17, 2011
 &nbsp; <a href="/p/go/source/diff?spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9&r=1ce42d48298d0ef498d342a278f2fe615e673bcb&amp;format=side&amp;path=/misc/vim/plugin/godoc.vim&amp;old_path=/misc/vim/plugin/godoc.vim&amp;old=2ffd085d488a76c501956f3c54570db11bd27579">Diff</a>
 <br>
 <pre class="ifOpened">misc/vim: command complete using
autoload helper function.

R=golang-dev, dsymonds, jnwhiteh,
n13m3y3r, gustavo
...</pre>
 </div>
 
 <div class="closed" style="margin-bottom:3px;" >
 <img class="ifClosed" onclick="_toggleHidden(this)" src="http://www.gstatic.com/codesite/ph/images/plus.gif" >
 <img class="ifOpened" onclick="_toggleHidden(this)" src="http://www.gstatic.com/codesite/ph/images/minus.gif" >
 <a href="/p/go/source/detail?spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9&r=2ffd085d488a76c501956f3c54570db11bd27579">2ffd085d488a</a>
 by Yasuhiro Matsumoto &lt;mattn.jp&gt;
 on Aug 2, 2011
 &nbsp; <a href="/p/go/source/diff?spec=svn272e1dd72156cbe4b548c37be8285f38c39ccbb9&r=2ffd085d488a76c501956f3c54570db11bd27579&amp;format=side&amp;path=/misc/vim/plugin/godoc.vim&amp;old_path=/misc/vim/plugin/godoc.vim&amp;old=">Diff</a>
 <br>
 <pre class="ifOpened">misc/vim: Godoc command.
vim command 'Godoc' to see godoc.

R=golang-dev, dsymonds
CC=golang-dev
...</pre>
 </div>
 
 
 <a href="/p/go/source/list?path=/misc/vim/plugin/godoc.vim&r=7fb0e868dc39677df0bf041d42bbf40053c3a418">All revisions of this file</a>
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
 
 <div>Size: 2080 bytes,
 85 lines</div>
 
 <div><a href="//go.googlecode.com/hg/misc/vim/plugin/godoc.vim">View raw file</a></div>
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
 var paths = {'svn272e1dd72156cbe4b548c37be8285f38c39ccbb9': '/misc/vim/plugin/godoc.vim'}
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


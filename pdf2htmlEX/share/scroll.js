$(function() {
  var $pages = $(".p"), 
      $pageWrappers = $(".b"),
      $main  = $("#pdf-main"),
      l = $pages.length;

  function isPageVisible(i, H) {
    var $pw = $($pageWrappers[i]),
        t   = $pw.offset().top,
        b   = t + $pw.height() ;
    return ( ! ( b < 0 || t >= H ) );
  }

  function setVisibilities(from, to, visible) {
    for(var i = from; i <= to; ++i) {
      var $p = $($pages[i]);
      if(visible) $p.show(); else $p.hide();
    }
  }

  // Selectively rendering of pages that are visible or will be visible
  function selectiveRender() {
    var first = 0, last = l - 1,
        H = $main.height();

    // Find the first visible page
    while(first < l && !isPageVisible(first, H))
      first++; 
    // Find the last visible page
    while(last >= 0 && !isPageVisible(last, H))
      last--;
    // Set invisible
    setVisibilities(first > 0 ? first-1 : first, 
                    last < l -1 ? last + 1 : last, true);
    setVisibilities(0, first - 2, false);
    setVisibilities(last + 2, l-1, false);
  }

  // Listen to scrolling events to render proper pages
  var scrollTimer = null;
  $("#pdf-main").scroll(function() {
    // Now
    lastScrollTime = Date.now();
    // Make sure at most one timer runs
    clearInterval(scrollTimer);
    // Check when scrolling stops
    scrollTimer = setInterval(function() {
      // If scrolling pauses 200+ms
      if (Date.now() - lastScrollTime > 200) {
        clearInterval(scrollTimer);
        // Only render pages that are or will be visible
        selectiveRender();
      }
    }, 200);
  });

  // Trigger the event
  $("#pdf-main").scroll();
});

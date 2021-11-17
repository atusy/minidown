document.addEventListener('DOMContentLoaded', function() {
  function getBGColor(el) {
    const b = window.getComputedStyle(el).backgroundColor;
    return (b !== "transparent" &&
            b !== "rgba(0, 0, 0, 0)" &&
            b !== "rgba(255,255,255,0)") ? b
         : (el.parentNode === null)      ? "white"
                                         : getBGColor(el.parentNode);
  }

  function argMin(x) {
    return x.indexOf(Math.min(...x));
  }

  const anchors = document.querySelectorAll('#TOC li>a');
  const headerIDs = Array.from(anchors).map(x => x.attributes.href.value.substring(1));
  let highlighted = 0;

  window.document.styleSheets[0].insertRule(
    `#TOC a.highlight{display:inline-block;width:100%;color:${getBGColor(anchors[0])};background-color:${window.getComputedStyle(anchors[0]).color}`
  );

  function highlight() {
    const closest = argMin(headerIDs.map(
      x => Math.pow(document.getElementById(x).getBoundingClientRect().top, 2)
    ));
    if (highlighted !== closest) {
      anchors[highlighted].classList.remove("highlight");
    }
    anchors[closest].classList.add("highlight");
    highlighted = closest;
  }

  highlight();
  document.addEventListener('scroll', highlight, {passive: true});
});

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

  function updateStyle(style, hash) {
    Object.keys(hash).forEach(key => style[key] = hash[key]);
  }

  const anchors = document.querySelectorAll('#TOC li>a');
  const sections = Array.from(anchors).map(x => document.querySelector(x.hash));
  const hiStyle = {display: "inline-block", width: "100%",
                   color: getBGColor(anchors[0]),
                   backgroundColor: window.getComputedStyle(anchors[0]).color};
  const noStyle = {display: "", width: "", color: "", backgroundColor: ""};
  let highlighted = 0;

  function highlight() {
    const closest = argMin(Array.from(sections).map(
      section => Math.pow(section.getBoundingClientRect().top, 2)
    ));
    if (highlighted != closest) {
      updateStyle(anchors[highlighted].style, noStyle);
    }
    updateStyle(anchors[closest].style, hiStyle);
    highlighted = closest;
  }

  highlight();
  document.addEventListener('scroll', highlight, {passive: true});
});

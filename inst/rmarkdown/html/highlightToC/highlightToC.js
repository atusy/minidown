document.addEventListener('DOMContentLoaded', function() {
  const anchors = document.querySelectorAll('#TOC li>a');
  const sections = Array.from(anchors).map(x => document.querySelector(x.hash));
  const computedStyle = window.getComputedStyle(anchors[0]);
  const hiColor = computedStyle.backgroundColor.
    replace(/rgba.*, 0\)/, "white").
    replace(/(rgba.*), [0-9]+/, "$1, 255");
  const hiBackgroundColor = computedStyle.color;
  let highlighted = 0;

  function argMin(x) {
    return x.indexOf(Math.min(...x));
  }

  function highlight() {
    const y = window.scrollY;
    console.log(Array.from(sections).map(
      section => section.getBoundingClientRect().top
    ));
    const closest = argMin(Array.from(sections).map(
      section => Math.pow(section.getBoundingClientRect().top, 2)
    ));
    if (highlighted != closest) {
      anchors[highlighted].style.display = "";
      anchors[highlighted].style.width = "";
      anchors[highlighted].style.color = "";
      anchors[highlighted].style.backgroundColor = "";
    }
    anchors[closest].style.display = "inline-block";
    anchors[closest].style.width = "100%";
    anchors[closest].style.color = hiColor;
    anchors[closest].style.backgroundColor = hiBackgroundColor;
    highlighted = closest;
  }

  highlight();
  document.addEventListener('scroll', highlight, {passive: true});
});

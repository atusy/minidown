document.addEventListener('DOMContentLoaded', function() {
  const anchors = document.querySelectorAll('#TOC li>a');
  const sections = Array.from(anchors).map(x => document.querySelector(x.hash));
  let highlighted = 0;

  function argMin(x) {
    return x.indexOf(Math.min(...x));
  }

  function highlight() {
    const y = window.scrollY;
    const closest = argMin(Array.from(sections).map(
      section => Math.pow(section.getBoundingClientRect().top - y, 2)
    ));
    if (highlighted != closest) {
      anchors[highlighted].parentNode.classList.remove("highlight");
    }
    anchors[closest].parentNode.classList.add("highlight");
    highlighted = closest;
  }

  highlight();
  document.addEventListener('scroll', highlight, {passive: true});
});

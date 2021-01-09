document.addEventListener('DOMContentLoaded', function() {
  const toc = Array.from(document.querySelectorAll('#TOC li>a')).reduce(
    (hash, elem) => {
      hash[elem.hash] = elem.parentNode.classList;
      return hash;
    }, {});
  let previous = null;

  const callback = (entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const target = "#" + entry.target.id;
        if (previous !== null) {toc[previous].remove("highlight")}
        toc[target].add("highlight");
        previous = target;
      }
    });
  };

  const observer = new IntersectionObserver(
    callback, {root: null, rootMargin: "0px", threshold: 0}
  );

  Object.keys(toc).
    map(x => document.querySelector(x)).
    map(x => observer.observe(x));
});

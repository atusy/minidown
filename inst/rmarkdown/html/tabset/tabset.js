document.addEventListener('DOMContentLoaded', function() {
  let tabHashes = [];

  function toggle(elem, from = 0, to = 0) {
    elem[from].classList.remove("active");
    elem[to].classList.add("active");
  }

  // Implement
  Array.from(document.querySelectorAll("section.tabset")).forEach(section => {
    const tabs = section.querySelectorAll(":scope>section");
    const tabIds = Array.from(tabs).map(tab => {
      tab.classList.add("tab");
      return tab.id;
    });
    tabHashes.push(...tabIds.map(id => "#" + id));
    let active = 0;
    toggle(tabs);

    const ul = section.insertBefore(document.createElement("ul"), tabs[0]);
    ul.classList.add("tabmenu");
    tabIds.forEach(tabId => {
      const current = tabIds.indexOf(tabId);
      tabs[current].removeAttribute("id");
      const button = ul.appendChild(document.createElement("li")).
        appendChild(document.createElement("button"));
      button.id = tabId;
      button.textContent = tabs[current].children[0].textContent;
      button.addEventListener("click", function() {
        history.pushState(null, null, "#" + tabId);
        toggle(tabs, active, current);
        toggle(ul.children, active, current);
        active = current;
      });
    });
    toggle(ul.children);
  });

  // Navigation
  window.addEventListener("hashchange", function() {
    if (tabHashes.indexOf(location.hash) >= 0) {
      document.querySelector(location.hash).click();
    }
  });
});

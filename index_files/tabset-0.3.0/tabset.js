window.addEventListener('load', function() {
  let allTabIds = [];

  function toggle(elem, from = 0, to = 0) {
    elem[from].classList.remove("active");
    elem[to].classList.add("active");
    return to;
  }

  function initialize(tabs) {
    const active = Array.from(tabs).findIndex(function(x) {
      const isActive = x.classList.contains("active");
      x.classList.remove("active");
      return isActive;
    });
    return toggle(tabs, 0, active * (active > 0));
  }

  // Implement
  Array.from(document.querySelectorAll("section.tabset")).forEach(section => {
    const tabs = section.querySelectorAll(":scope>section");
    const tabIds = Array.from(tabs).map(tab => {
      tab.dataset.id = tab.id;
      tab.classList.add("tab");
      tab.removeAttribute("id");
      return tab.dataset.id;
    });
    allTabIds.push(...tabIds);
    let active = initialize(tabs);

    const ul = section.insertBefore(document.createElement("ul"), tabs[0]);
    ul.classList.add("tabmenu");
    tabs.forEach((tab, current) => {
      const button = document.createElement("button");
      ul.appendChild(document.createElement("li")).appendChild(button);
      button.id = tab.dataset.id;
      button.textContent = tab.children[0].textContent;
      button.addEventListener("click", function() {
        history.pushState(null, null, "#" + button.id);
        toggle(tabs, active, current);
        active = toggle(ul.children, active, current);
      });
    });
    toggle(ul.children, 0, active);
  });

  // Navigation
  function showHashTab() {
    const buttonId = allTabIds.find(x => ('#' + x) === location.hash);
    if (!buttonId) return;
    const button = document.getElementById(buttonId);
    let el = button.parentElement.parentElement.parentElement;
    while (el) {
      if (
        el.tagName === "SECTION"
        && el.classList.contains("tab")
        && !el.classList.contains("active")
      ) {
        document.getElementById(el.dataset.id).click();
      }
      el = el.parentElement;
    }
    button.click();
    button.scrollIntoView();
  }
  showHashTab();
  window.addEventListener("hashchange", showHashTab); 
});

document.addEventListener('DOMContentLoaded', function() {
  Array.from(document.querySelectorAll("section.tabset")).forEach(section => {
    const tabs = section.querySelectorAll(":scope>section");
    const tabIds = Array.from(tabs).map(tab => {
      tab.style.display = tab.children[0].style.dsiplay = "none";
      return tab.id;
    });
    let shown = tabs[0];
    shown.style.display = "";

    const ul = section.insertBefore(document.createElement("ul"), tabs[0]);
    tabIds.forEach(tabId => {
      const a = ul.appendChild(document.createElement("li")).
        appendChild(document.createElement("a", {href: "#" + tabId}));
      a.textContent = tabId;
      a.addEventListener("click", function() {
        shown.style.display = "none";
        shown = tabs[tabIds.indexOf(tabId)];
        shown.style.display = "";
      });
    });
  });
});

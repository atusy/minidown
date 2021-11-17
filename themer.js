document.addEventListener("DOMContentLoaded", function() {
  function getBGColor(el) {
    const b = window.getComputedStyle(el).backgroundColor;
    return (b !== "transparent" &&
            b !== "rgba(0, 0, 0, 0)" &&
            b !== "rgba(255,255,255,0)") ? b
         : (el.tagName === "BODY")       ? "white"
                                         : getBGColor(el.parentNode);
  }

  function addRulesToC(style, aside) {
    const toc = document.querySelector("#TOC li>a:not(.highlight)");
    style.innerText = String.prototype.concat(
      style.innerText,
      '#TOC a.highlight{',
        `color:${getBGColor(toc)};`,
        `background-color:${window.getComputedStyle(toc).color}`,
      '}',
      '@media screen and (min-width: 960px){#TOC>ul{',
        `top: ${aside.offsetHeight}px !important;`,
        `height: calc(100vh - ${aside.offsetHeight}px) !important`,
      '}}'
    );
  }

  function addRulesExtra(style, href) {
    const xhr = new XMLHttpRequest();
    xhr.addEventListener("load", function() {
      style.innerText = style.innerText + xhr.responseText;
    });
    xhr.open("GET", href, true);
    xhr.send(null);
  }

  function updateRules(style, hrefTheme, aside) {
    const xhr = new XMLHttpRequest();
    xhr.addEventListener("load", function() {
      style.innerText = xhr.responseText;
      addRulesToC(style, aside);
    });
    xhr.open("GET", hrefTheme, true);
    xhr.send(null);
  }

  const main = document.getElementsByTagName("main")[0];
  const aside = main.parentElement.insertBefore(
    document.getElementById("aside-select-framework"), main);
  const selectors = Array.from(aside.querySelectorAll("select"));

  const themeSelectors = selectors.slice(1).reduce(
    function(x, y) {
      x[y.id.replace(/^select-theme-/, "")] = y;
      return x;
    },
    {}
  );
  selectors.slice(2).forEach(function(selector) {
    return selector.classList.add("inactive");
  });

  const frameworkSelector = selectors[0];
  const minidown = frameworkSelector.dataset.minidown;
  let framework = frameworkSelector.selectedOptions[0];
  const label = document.getElementById("label-select-theme");
  label.setAttribute("for", themeSelectors[framework.value].id);
  function updateThemeSelector() {
    themeSelectors[framework.value].classList.add("inactive");
    framework = frameworkSelector.selectedOptions[0];
    themeSelectors[framework.value].classList.remove("inactive");
    label.setAttribute("for", themeSelectors[framework.value].id);
  }
  frameworkSelector.addEventListener("change", updateThemeSelector);

  function findTheme() {
    const theme = themeSelectors[framework.value].selectedOptions[0].value;
    return `index_files/minidown-${minidown}/${theme}`;
  }
  let currentTheme = findTheme();
  const linkTheme = document.querySelector("link[href='" + currentTheme + "']");
  const style = linkTheme.parentElement.insertBefore(
    document.createElement("style"), linkTheme);

  updateRules(style, linkTheme.href, aside);
  linkTheme.remove();

  function selectIndex(x, label) {
    x.selectedIndex = Array.from(x.children).findIndex(x => x.label == label);
  }

  const searchParams = new URLSearchParams(window.location.search);
  function updateSearchParams() {
    searchParams.set("framework", framework.label);
    searchParams.set("theme", themeSelectors[framework.value].selectedOptions[0].label);
    history.replaceState("", "", window.location.pathname + "?" + searchParams.toString() + window.location.hash);
  }

  document.getElementById("button-go").addEventListener("click", function() {
    const theme = findTheme();
    if (theme !== currentTheme) {
      updateRules(style, theme, aside);
      currentTheme = theme;
      updateSearchParams();
    }
  });

  if (searchParams.has("framework") && searchParams.has("theme")) {
    selectIndex(frameworkSelector, searchParams.get("framework"));
    updateThemeSelector();
    selectIndex(themeSelectors[framework.value], searchParams.get("theme"));
    document.getElementById("button-go").click();
  } else {
    updateSearchParams();
  }
});

document.addEventListener("DOMContentLoaded", function() {
  const aside = document.getElementById("aside-select-framework");
  function scroll() {
    if (document.getElementById(location.hash.substring(1)) !== null) {
      window.scrollBy(0, -aside.offsetHeight);
    }
  }
  scroll();
  window.addEventListener("hashchange", scroll);
});

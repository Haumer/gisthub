const loadSpinner = () => {
  const importGistsBtn = document.getElementById("import-gists");
  if (importGistsBtn) {
    const spinner = `<div class="spinner-border text-light" role="status">
                          <span class="sr-only">Loading...</span>
                        </div>`;
    importGistsBtn.addEventListener("click", () => {
      importGistsBtn.innerHTML = spinner;
    });
  }
}

export { loadSpinner }
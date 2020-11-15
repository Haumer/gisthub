const initTooltips = () => {
  const tooltips = document.querySelectorAll('[data-toggle="tooltip"]');
  $(function () {
    $('[data-toggle="tooltip"]').tooltip(); // Tooltips are opt-in from Bootstrap. They must be initialized by hand
  });
}

export { initTooltips }

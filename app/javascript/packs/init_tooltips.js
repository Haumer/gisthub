const initTooltips = () => {
  const tooltips = $('[data-toggle="tooltip"]');
  if (tooltips) {
    $(function () {
      tooltips.tooltip(); // Tooltips are opt-in from Bootstrap. They must be initialized by hand
    });
  }
}

export { initTooltips }

let labels = Array.from(document.querySelectorAll(".group-info .group"))
function invertColor(element) {
  let color = element.dataset.color
  element.style.color = invert(color, true)
  element.style.borderColor = invert(color, true)
}
labels.forEach(invertColor)

import invert from 'invert-color';
export { invertColor }

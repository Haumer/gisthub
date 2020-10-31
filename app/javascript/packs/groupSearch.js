let input = document.querySelector('#group_search_keyword')
let results = Array.from(document.querySelectorAll('.group-results li'))
const form = document.querySelector('.simple_form.group_search')
if (form) {
  form.setAttribute('autocomplete', 'off')
}

const search = (e) => {
  let keyword = e.target.value.trim()
  filter(keyword)
}

const filter = (keyword) => {
  results.forEach((element) => {
    if (element.innerText.toLowerCase().includes(keyword) || element.innerText.includes(keyword)) {
      element.classList.remove('d-none')
    } else {
      element.classList.add('d-none')
    }
  })
}

if (input) {
  input.addEventListener('keyup', search)
}

export {search, filter}

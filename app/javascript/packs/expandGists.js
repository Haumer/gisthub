let gists = Array.from(document.querySelectorAll(".gist-data.small-gist"))
const expandGists = () => {
  gists.forEach((gist) => {
    gist.addEventListener("click", () =>{
      gist.classList.remove(".small-gist")
    })
  })
}

export { expandGists }

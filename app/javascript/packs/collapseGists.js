let gists = document.querySelectorAll(".gist-data")

const collapseGists = () =>{
  gists.forEach((gist) => {
    gist.classList.add("small-gist")
  })
}

export { collapseGists }

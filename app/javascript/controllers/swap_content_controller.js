import { Controller } from "stimulus"
import Rails from "@rails/ujs"


export default class extends Controller {
  static targets = [ "display", "form" ]

  swap() {
    if (this.formTarget.classList.contains('d-none')) {
      this.displayTarget.classList.add('d-none')
      this.formTarget.classList.remove('d-none')
    } else {
      this.displayTarget.classList.remove('d-none')
      this.formTarget.classList.add('d-none')
    }
  }
}

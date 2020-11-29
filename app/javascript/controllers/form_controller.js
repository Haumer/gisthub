import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  submit(event) {
    event.preventDefault()
    Rails.fire(this.element, "submit")
  }
}

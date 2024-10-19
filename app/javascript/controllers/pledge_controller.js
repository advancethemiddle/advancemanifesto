import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  closeNotification() {
    this.element.parentElement.remove()
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { authorId: String }

  connect() {
    const currentUserId = document.querySelector('meta[name="current-user-id"]')?.content
    const isAdmin = document.querySelector('meta[name="current-user-admin"]')?.content === "true"

    if (currentUserId === this.authorIdValue || isAdmin) {
      this.element.style.display = 'block'
    } else {
      this.element.style.display = 'none'
    }
  }
}

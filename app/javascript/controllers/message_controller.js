import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message"
export default class extends Controller {
  connect() {
    const metaTag = document.querySelector("meta[name='current-user-id']")
    if(!metaTag) return 

    const currentUserId = metaTag.content

    const authorId = this.element.dataset.authorId

    if(currentUserId === authorId){
      this.element.classList.add("my-message")
    }
  }
}

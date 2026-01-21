import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String, name: String }

  open(event) {
    event.preventDefault()

    if (this.urlValue && this.urlValue.trim() !== "") {
      window.open(this.urlValue, "_blank", "noopener,noreferrer")
    } else {
      this.showFlash(`The ${this.nameValue} URL is not given or missing`)
    }
  }

  showFlash(message) {
    const flashContainer = document.querySelector("header nav").parentElement
    const existingFlash = document.querySelector("[data-flash-message]")
    if (existingFlash) existingFlash.remove()

    const flash = document.createElement("div")
    flash.setAttribute("data-flash-message", "")
    flash.className = "max-w-screen-xl mx-auto px-4 pt-4"
    flash.innerHTML = `
      <div class="rounded-md bg-red-50 p-4 mb-2">
        <div class="flex">
          <div class="flex-shrink-0">
            <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.28 7.22a.75.75 0 00-1.06 1.06L8.94 10l-1.72 1.72a.75.75 0 101.06 1.06L10 11.06l1.72 1.72a.75.75 0 101.06-1.06L11.06 10l1.72-1.72a.75.75 0 00-1.06-1.06L10 8.94 8.28 7.22z" clip-rule="evenodd" />
            </svg>
          </div>
          <div class="ml-3">
            <p class="text-sm font-medium text-red-800">${message}</p>
          </div>
        </div>
      </div>
    `
    flashContainer.appendChild(flash)

    setTimeout(() => flash.remove(), 5000)
  }
}

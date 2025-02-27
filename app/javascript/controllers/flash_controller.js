import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["progress"]
  defaultInterval = 50

  connect() {
    this.intervalId = setInterval(() => {
      this.progressTarget.value++
    }, this.defaultInterval)

    const animationDuration = 100 * (this.defaultInterval + 1)
    this.element.style.animation = "fade-inout " + animationDuration + "ms"

    this.timeoutId = setTimeout(() => {
      this.close()
    }, animationDuration);
  }

  close() {
    this.element.remove()
  }

  disconnect() {
    clearInterval(this.intervalId);
    clearTimeout(this.timeoutId);
  }
}
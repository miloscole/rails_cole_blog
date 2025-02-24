import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidenav"
export default class extends Controller {
  static targets = ["menu", "overlay"]

  // Temporary solution with style.display (open and disconnect) to prevent flickering on navigation.  
  // Downside: Close animation is skipped when clicking links.  
  // Consider using Turbo Frames or improving state handling and avoid document.querySelector.  

  open() {
    this.menuTarget.style.display = 'flex'
    this.overlayTarget.style.display = 'block'

    setTimeout(() => {
      this.menuTarget.classList.add("open")
      this.overlayTarget.removeAttribute("hidden")
      document.body.classList.add("no-scroll")
    }, 100);
  }

  close() {
    this.menuTarget.classList.remove("open")
    this.overlayTarget.setAttribute("hidden", '')
    document.body.classList.remove("no-scroll")
  }

  disconnect() {
    if (window.innerWidth < 993) {
      document.querySelector('#nav-right').style.display = 'none'
      document.querySelector('#overlay').style.display = 'none'
    }
  }
}


import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidenav"
export default class extends Controller {
  // By default page will be redirected before we are able to close the sidenav.
  // Temporary solution with preventDefaultOnLinkClicked to prevent flickering on navigation.  
  // Consider using Turbo Frames or improving state handling and avoid preventDefault. 

  static targets = ["menu", "overlay"]

  connect() {
    this.menuTarget.querySelectorAll('a').forEach(link => {
      link.setAttribute('data-action', 'click->sidenav#preventDefaultOnLinkClicked')
    });
  }

  open() {
    this.menuTarget.classList.add("open")
    this.overlayTarget.removeAttribute("hidden")
    document.body.classList.add("no-scroll")
  }

  close() {
    this.menuTarget.classList.remove("open")
    this.overlayTarget.setAttribute("hidden", '')
    document.body.classList.remove("no-scroll")
  }

  preventDefaultOnLinkClicked(event) {
    if (window.innerWidth < 993) {
      event.preventDefault()
      const url = event.currentTarget.getAttribute('href')
      this.close()
      Turbo.visit(url)
      // Need to rethink about animation on link clicked since we need to have delay before redirecting.
      // setTimeout(() => {
      //   Turbo.visit(url)
      // }, 300);
    }
  }
}
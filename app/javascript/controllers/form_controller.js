import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["submit","processing","summary_form"]
  connect() {
    console.log("connecting to form controller")
  }

  freeze(event) {
    console.log("freezing form...")

    // NOTE: preventDefault if manually submitting the form
    //event.preventDefault()

    // Freeze all input fields input, button, textarea, select"
    this.summary_formTarget.querySelectorAll("#book_title, #book_temp, #model_name").forEach(input => {
      console.log("found element: ",input)

      // NOTE: disabling doesn't work, it prevents the form submission from sending the params back!
      // input.disabled = true
    })

    console.log("submit target is: ", this.submitTarget)
    console.log("processing target is: ", this.processingTarget)
    console.log("summary_form target is: ", this.summary_formTarget)

    // Show spinner
    this.submitTarget.classList.toggle("hidden")
    this.processingTarget.classList.toggle("hidden")

    // NOTE: Manually submitting the form didn't work as expected
    //this.summary_formTarget.submit()

    // You might want to actually submit the form here or perform the operation
    // For example, use `this.element.submit()` to submit the form
    // Or use fetch() to perform an async operation, then unfreeze on completion

  }
}

import { Controller } from "@hotwired/stimulus"

// Manage UI changes for turbo stream form submission
// Connects to data-controller="form"
export default class extends Controller {
  // turbo events
  static TURBO_SUBMIT_START = "turbo:submit-start";
  static TURBO_SUBMIT_END = "turbo:submit-end";

  static targets = ["submit","processing","summaryForm"]

  initialize() {
    //console.log('initializing form')
    this.#setup_form_event_handlers()
  }

  connect() {
    //console.log("connecting to form controller")
  }

  // add form event handlers to disable input fields and show spinner on submission
  // and restore the form on completion
  #setup_form_event_handlers() {
    this.summaryFormTarget.addEventListener(this.constructor.TURBO_SUBMIT_START, (event) => {
      //console.log("Form is being submitted...");
      this.#freeze_form(true)
    });

    this.summaryFormTarget.addEventListener(this.constructor.TURBO_SUBMIT_END, (event) => {
      //console.log("Form submission completed.");
      this.#freeze_form(false)
    });
  }


  // when disabled is true, show spinner and freeze input fields
  // when disabled is false, show submit button, unfreeze input fields
  #freeze_form(disabled) {
    this.submitTarget.classList.toggle("hidden")
    this.processingTarget.classList.toggle("hidden")
    this.summaryFormTarget.querySelectorAll("#book_title, #book_temp, #model_name").forEach(input => {
      //console.log(`${disabled ? "disabling" : "enabling"} found element: `,input)
      input.disabled = disabled
    })

  }

  // NOTE: attempts to use the submit button click to freeze the form didn't work as expected
  // current implementation sets event handlers on form submission start and end see above
  // TODO: Review/confirm why this approach can't work
  submit_pressed(event) {
    //console.log("freezing form...")

    // NOTE: preventDefault if manually submitting the form
    // event.preventDefault()

    // NOTE: disabling doesn't work, it prevents the form submission from sending the params back!
    // Freeze all input fields input, button, textarea, select"
    //this.summaryFormTarget.querySelectorAll("#book_title, #book_temp, #model_name").forEach(input => {
      // console.log("found element: ",input)
      // input.disabled = true
    //})

    //console.log("submit target is: ", this.submitTarget)
    //console.log("processing target is: ", this.processingTarget)
    //console.log("summary_form target is: ", this.summaryFormTarget)

    // Show spinner
    //this.submitTarget.classList.toggle("hidden")
    //this.processingTarget.classList.toggle("hidden")

    // NOTE: Manually submitting the form didn't work as expected
    // this.summaryFormTarget.submit()

    // You might want to actually submit the form here or perform the operation
    // For example, use `this.element.submit()` to submit the form
    // Or use fetch() to perform an async operation, then unfreeze on completion
  }
}

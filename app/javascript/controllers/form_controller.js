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

}

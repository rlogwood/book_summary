// see https://dev.to/citronak/modern-rails-flash-messages-part-1-viewcomponent-stimulus-tailwind-css-3alm
// updated for current version of Turbo/Stimulus

// TODO: implement action button

import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["buttons", "countdown"]
    static values = {timeout: Number}

    connect() {
        // console.log("notification_component_controller: connect")
        // console.log("notification_component_controller data:", this.data)
        // console.log("notification_component_controller countdown:",this.countdownTarget)
        // console.log("notification_component_controller countdown id:",this.countdownTarget.id)
        // console.log("notification_component_controller countdown name:",this.countdownTarget.name)
        // console.log("notification_component_controller hasCountdownTarget:",this.hasCountdownTarget)
        // console.log("csrfToken:", this.csrfToken)
        // console.log("notification_component: timeoutValue(", this.timeoutValue, ")")
        // will only have buttons target if action specified
        console.log("notification_component_controller: has buttonsTarget:",this.hasButtonsTarget)
        if (this.hasButtonsTarget) {
            console.log("notification_component_controller: buttonsTarget:",this.buttonsTarget)
        }
        //     console.log("notification_component_controller: buttons:",this.buttonsTarget)
        const timeoutSeconds = parseInt(this.timeoutValue)

        if (!this.isPreview) {
            console.log("showing element timeout seconds:(", timeoutSeconds, ")")
            setTimeout(() => {
                this.element.classList.remove('hidden');
                this.element.classList.add('transform', 'ease-out', 'duration-300', 'transition', 'translate-y-2', 'opacity-0', 'sm:translate-y-0', 'sm:translate-x-2');

                // Trigger transition
                setTimeout(() => {
                    this.element.classList.add('translate-y-0', 'opacity-100', 'sm:translate-x-0');
                }, 100);

                // Trigger countdown
                if (this.hasCountdownTarget) {
                    this.countdownTarget.style.animation = 'notification-countdown linear ' + timeoutSeconds + 's';
                }

            }, 500);
            this.timeoutId = setTimeout(() => {
                this.close();
            }, timeoutSeconds * 1000 + 500);
        }
    }

    run(e) {
        e.preventDefault();
        this.stop();
        let _this = this;
        this.buttonsTarget.innerHTML = '<span class="text-sm leading-5 font-medium text-grey-700">Processing...</span>';

        // Call the action
        fetch(this.data.get("action-url"), {
            method: this.data.get("action-method").toUpperCase(),
            dataType: 'script',
            credentials: "include",
            headers: {
                "X-CSRF-Token": this.csrfToken
            },
        })
            .then(function (response) {
                let content;

                // Example of the response, content should be provided from the controller
                if (response.status === 200) {
                    content = '<span class="text-sm leading-5 font-medium text-green-700">Done!</span>'
                } else {
                    content = '<span class="text-sm leading-5 font-medium text-red-700">Error!</span>'
                }

                // Set new content
                _this.buttonsTarget.innerHTML = content;

                // Close
                setTimeout(() => {
                    _this.close();
                }, 1000);
            });
    }

    stop() {
        clearTimeout(this.timeoutId)
        this.timeoutId = null
    }

    close() {
        console.log("notification_controller: close")
        // Remove with transition
        this.element.classList.remove('transform', 'ease-out', 'duration-300', 'translate-y-2', 'opacity-0', 'sm:translate-y-0', 'sm:translate-x-2', 'translate-y-0', 'sm:translate-x-0');
        this.element.classList.add('ease-in', 'duration-100')

        // Trigger transition
        setTimeout(() => {
            this.element.classList.add('opacity-0');
        }, 100);

        // Remove element after transition
        setTimeout(() => {
            this.element.remove();
        }, 300);
    }

    get isPreview() {
        // NOTE: old attribute name 'data-turbolinks-preview')
        return document.documentElement.hasAttribute('data-turbo-preview')
    }

    get csrfToken() {
        const element = document.head.querySelector('meta[name="csrf-token"]')
        return element.getAttribute("content")
    }
}
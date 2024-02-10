// Generic StimulusJS controller that can be modified for any dynamic list

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    initialize() {
        this.updateChoices()
        //console.log("Stimulus at your service!")
    }

    connect() {
        //console.log("connected to forms controller");
    }

    handleChange(e) {
        //console.log("the dropdown changed");
        //console.log("e.target.value:", e.target.value);

    }

    handleClick() {
        //console.log("clicked the dropdown");
    }

    handleMousedown() {
        //console.log("mouse down on the dropdown");
    }

    handleFocus() {
        //console.log("focus on the dropdown");
        //console.log("updating choices");
        this.updateChoices()
    }


    updateChoices() {
        //console.log("updateChoices")
        fetch(`/chatgpt_models.json`)
            .then(response => response.json())
            .then(data => {
                const modelDropdown = document.querySelector('#model_name');
                modelDropdown.innerHTML = '';
                data.forEach(model => {
                    const optionDescription = `${model.name} (${model.tier})`
                    //console.log("optionDescription:", optionDescription)
                    const option = new Option(optionDescription, model.id);
                    modelDropdown.appendChild(option);
                });
            });
    }
}

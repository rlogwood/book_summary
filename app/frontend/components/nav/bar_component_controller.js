import {Controller} from "@hotwired/stimulus";

export default class extends Controller {

    static targets = ['burgerMenu', 'mobileMenu', 'mobileClose']

    closeMobileMenu() {
        console.log("this.mobileMenuClose: ", this.mobileMenuClose)
        this.mobileMenuTarget.classList.add("hidden")
    }
    openMobileMenu() {
        console.log("this.mobileMenuTarget: ", this.mobileMenuTarget)
        this.mobileMenuTarget.classList.remove("hidden")
    }


    connect() {
        console.log("connect bar-component controller")
        console.log("burgerMenuTarget: ",this.burgerMenuTarget)
        //this.burgerMenuTarget.classList.toggle("hidden")
        console.log("burgerMenuClassList: ",this.burgerMenuTarget.classList)
    }
}

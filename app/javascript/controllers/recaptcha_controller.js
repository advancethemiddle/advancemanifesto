import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  validate(event) {
    event.preventDefault();

    const siteKey = document
      .getElementById("recaptcha-initlializer")
      .src.split("?render=")
      .slice(-1)[0];
    const form = this.element;
    const tokenInput = form.querySelector("input[name='g_recaptcha_response']");
    const submitButton = form.querySelector("button[type='submit']");

    grecaptcha.ready(function () {
      grecaptcha
        .execute(siteKey, {
          action: "submit",
        })
        .then(function (token) {
          tokenInput.value = token;
          form.requestSubmit(submitButton);
        });
    });
  }
}

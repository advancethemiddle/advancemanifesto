import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['form', 'hero', 'pitch']
  heroHeight = this.heroTarget.offsetHeight
  heroBuffer = 300
  pitchYPadding = 100 * 2
  pitchHeight = this.pitchTarget.offsetHeight - (this.heroBuffer + this.pitchYPadding)
  heroPitchHeight = this.heroHeight + this.pitchHeight
  form = this.formTarget
  inputs = this.form.querySelectorAll('input')
  formParagraphs = this.form.querySelectorAll('p')
  formLists = this.form.querySelectorAll('ul')
  formArrow = this.form.querySelector('svg')

  connect() {
    document.addEventListener('scroll', this.handleDocumentScroll.bind(this))
    this.inputs.forEach(input => input.addEventListener('focus', this.handleInputFocus.bind(this)))
  }

  handleDocumentScroll() {
    const scrolledBeyondHero = window.scrollY > this.heroHeight
    const scolledIntoHero = window.scrollY < this.heroHeight
    const scrolledIntoPitch = window.scrollY < this.heroPitchHeight
    const scrolledPastPitch = window.scrollY > this.heroPitchHeight

    if (scrolledBeyondHero) {
      this.toggleOpacity(this.form, 100)
    }

    if (scolledIntoHero) {
      this.toggleOpacity(this.form, 0)
    }

    if (scrolledIntoPitch) {
      this.toggleFormState('fixed')
    }

   if (scrolledPastPitch) {
    this.toggleFormState('relative')
   }
  }

  toggleOpacity(element, targetOpacity) {
    if (targetOpacity === 0) {
      if (element.classList.contains('opacity-100')) {
        element.classList.remove('opacity-100')
        element.classList.add('opacity-0')
      }
    } else if (targetOpacity === 100) {
      if(element.classList.contains('opacity-0')) {
        element.classList.remove('opacity-0')
        element.classList.add('opacity-100')
      }
    } else {
      throw new Error('targetOpacity must be a value equal to 0 or 100')
    }
  }

  toggleFormState(targetState) {
    if (targetState === 'relative') {
      if (this.form.classList.contains('fixed')) {
        this.form.classList.remove('fixed', 'py-8')
        this.form.classList.add('relative', 'py-24')
        this.formParagraphs.forEach(element => {
          element.classList.add('block', 'opacity-100')
          element.classList.remove('hidden', 'opacity-0')
        })
        this.formLists.forEach(element => {
          element.classList.add('block', 'opacity-100')
          element.classList.remove('hidden', 'opacity-0')
        })
        this.toggleOpacity(this.formArrow, 100)
      }
    } else if (targetState === 'fixed') {
      if (this.form.classList.contains('relative')) {
        this.form.classList.remove('relative', 'py-24')
        this.form.classList.add('fixed', 'py-8')
        this.formParagraphs.forEach(element => {
          element.classList.add('hidden', 'opacity-0')
          element.classList.remove('block', 'opacity-100')
        })
        this.formLists.forEach(element => {
          element.classList.add('hidden', 'opacity-0')
          element.classList.remove('block', 'opacity-100')
        })
        this.toggleOpacity(this.formArrow, 0)
      }
    } else {
      throw new Error("targetState must be a value equal to 'relative' or 'fixed'")
    }
  }

  handleInputFocus() {
    this.toggleOpacity(this.form, 100)
    this.toggleFormState('relative')
    this.form.scrollIntoView({ behavior: 'smooth', block: 'start' })
  }

  closeNotification() {
    this.element.parentElement.remove()
  }
}

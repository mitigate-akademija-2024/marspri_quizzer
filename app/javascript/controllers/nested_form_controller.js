import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["target", "template"]

  addToBottom(event) {
    event.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    const newQuestionContainer = document.getElementById('new-question-container')
    
    // Remove existing new question form if it exists
    const existingNewForm = newQuestionContainer.querySelector('.nested-form-wrapper')
    if (existingNewForm) {
      existingNewForm.remove()
    }
    
    // Add new question form to the bottom
    newQuestionContainer.innerHTML = content
    
    // Scroll to the new question form
    newQuestionContainer.scrollIntoView({ behavior: 'smooth', block: 'end' })
  }

  remove(event) {
    event.preventDefault()
    const wrapper = event.target.closest('.nested-form-wrapper')
    if (wrapper.dataset.newRecord === 'true') {
      wrapper.remove()
    } else {
      wrapper.style.display = 'none'
      const destroyField = wrapper.querySelector("input[name*='_destroy']")
      destroyField.value = '1'
    }
  }
}

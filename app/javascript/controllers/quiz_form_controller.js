import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["questions"]

  connect() {
    this.questionTemplate = document.getElementById('question-template').innerHTML
    document.getElementById('add-question').addEventListener('click', this.addQuestion.bind(this))
  }

  addQuestion(event) {
    event.preventDefault()
    const timestamp = new Date().getTime()
    const newQuestionHtml = this.questionTemplate.replace(/NEW_RECORD/g, timestamp)
    this.questionsTarget.insertAdjacentHTML('beforeend', newQuestionHtml)
  }
}

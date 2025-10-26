import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 
    "titleInput",
    "status",
    "titleOutput",
    "synopsis",
    "releaseYear",
    "duration",
    "director" 
  ]

  async fetch(event) {
    event.preventDefault() 

    const title = this.titleInputTarget.value.trim()

    if (title === "") {
      this.statusTarget.textContent = "Por favor, digite um título para buscar."
      this.statusTarget.style.color = "orange";
      return
    }

    this.statusTarget.textContent = "Buscando dados..."
    this.statusTarget.style.color = "blue";

    try {
      const url = `/fetch_movie_data?title=${encodeURIComponent(title)}`

      const response = await fetch(url)
      const data = await response.json()

      if (data.success) {
        const movie = data.movie

        if (this.hasSynopsisTarget && movie.synopsis) {
          this.synopsisTarget.value = movie.synopsis;
        }
        if (this.hasReleaseYearTarget && movie.release_year) {
          this.releaseYearTarget.value = movie.release_year;
        }
        if (this.hasDurationTarget && movie.duration) {
          this.durationTarget.value = movie.duration;
        }
        if (this.hasDirectorTarget && movie.director) {
          this.directorTarget.value = movie.director;
        }

        this.statusTarget.textContent = "Dados preenchidos com sucesso!"
        this.statusTarget.style.color = "green";

      } else {
        this.statusTarget.textContent = `Erro: ${data.error || 'Não foi possível buscar os dados.'}`
        this.statusTarget.style.color = "red";
      }
    } catch (error) {
      console.error("Fetch error:", error)
      this.statusTarget.textContent = "Erro de comunicação ao buscar dados."
      this.statusTarget.style.color = "red";
    }
  }
}
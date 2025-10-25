# Desafio Mainô - Catálogo de Filmes

Este projeto é um catálogo de filmes desenvolvido como parte do Desafio Técnico de Estágio Backend da Mainô.

**Site em Produção:** [https://catalogo-web-pedro.onrender.com](https://catalogo-web-pedro.onrender.com)
*(Nota: O plano gratuito do Render pode desativar o servidor após inatividade, causando um primeiro carregamento lento de 50 segundos.)*

---

## 🚀 Funcionalidades Implementadas

Funcionalidades Obrigatórias

* **Área Pública:**
    * [X] Listagem de todos os filmes (ordenados do mais novo para o mais antigo).
    * [X] Paginação da listagem (6 filmes por página).
    * [X] Visualização dos detalhes de um filme (título, sinopse, ano, duração, diretor).
    * [X] Sistema de comentários anônimos (informando nome e conteúdo).
    * [X] Comentários exibidos do mais recente para o mais antigo.
    * [X] Cadastro de novo usuário.
    * [X] Recuperação de senha.
* **Área Autenticada:**
    * [X] Login / Logout de usuário.
    * [X] Cadastro, Edição e Exclusão de filmes.
    * [X] Autorização (usuário só pode editar/apagar filmes criados por ele).
    * [X] Comentários autenticados (nome vinculado automaticamente).
    * [X] Edição de perfil e alteração de senha.

Funcionalidades Opcionais 

*(Esta seção será atualizada conforme o desenvolvimento)*

* [x] Upload de imagem (poster) com Active Storage
* [x] Categorias de filmes
* [x] Busca de filmes
* [x] Filtros
* [x] Tags
* [x] Internacionalização (I18n)
* [x] Testes automatizados

---

🛠️ Como Rodar o Projeto Localmente 

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/Pedro142P4/catalogo-filmes-rails.git](https://github.com/Pedro142P4/catalogo-filmes-rails.git)
    cd catalogo-filmes-rails
    ```

2.  **Instale as dependências:**
    (Certifique-se de ter o Ruby, Rails e PostgreSQL instalados)
    ```bash
    bundle install
    ```

3.  **Configure o Banco de Dados:**
    * Configure seu usuário/senha no arquivo `config/database.yml`.
    * Crie e migre o banco de dados:
    ```bash
    rails db:create
    rails db:migrate
    ```

4.  **Rode o servidor:**
    ```bash
    rails s
    ```

5.  Acesse [http://localhost:3000](http://localhost:3000) no seu navegador.
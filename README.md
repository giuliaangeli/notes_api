# Notes API

Essa API suporta métodos HTTP para interagir com os dados de forma eficiente.

## Endpoints

- `GET /api/notes` - Retorna todas as notas
- `GET /api/notes/:id` - Retorna uma nota específica
- `POST /api/notes` - Cria uma nova nota
- `PATCH /api/notes/:id` - Atualiza uma nota existente
- `DELETE /api/notes/:id` - Exclui uma nota existente

## Requisitos

- Ruby 3.0.0
- Rails 7.0.8
- Sqlite3

## Configuração

1. Clone o repositório:

`git clone git@github.com:giuliaangeli/notes_api.git`

2.Instale as dependências:

`bundle install`

3.Configure o banco de dados:

`rails db:create db:migrate`

4.Inicie o servidor:

`rails server`

Você poderá usar a interface em `http://localhost:3000/notes`

Ou se preferir pode fazer testes manuais pelo endpoint `http://localhost:3000/api/notes`

**GET /api/notes**
- Método: GET
- URL: `http://localhost:3000/api/notes`
- Retorna todas as notas no formato JSON.

**GET /api/notes/:id**
- Método: GET
- URL: `http://localhost:3000/api/notes/:id`
- Retorna a nota com o id no formato JSON.

**POST /api/notes**
- Método: POST
- URL: `http://localhost:3000/api/notes`

Body Example:
```
{
  "title": "New Note",
  "content": "This is the content of the new note."
}
```
- Cria uma nova nota e retorna os dados da nota criada.
**não é possível criar notas título ou conteúdo

**PATCH /api/notes/:id**
- Método: PATCH
- URL: `http://localhost:3000/api/notes/:id`

Body Example:
```
{
  "title": "New Title",
  "content": "This is a different content."
}
```
- Atualiza a nota informada e retorna os dados da nota atualizada.
**não é possível atualizar notas com título ou conteúdo nulos

**DELETE /api/notes/:id**
- Método: DELETE
- URL: `http://localhost:3000/api/notes/:id`
- Exclui a nota informada e retorna o status 204 No Content.

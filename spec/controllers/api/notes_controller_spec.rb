require 'rails_helper'

RSpec.describe "Api::Notes", type: :request do
  let!(:note) { Note.create(title: 'Sample Title', content: 'Sample Content') }
  let(:valid_attributes) { { title: 'New Title', content: 'New Content' } }
  let(:invalid_attributes) { { title: '', content: '' } }

  describe "GET /api/notes" do
    it "returns a list of notes" do
      get api_notes_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Sample Title')
    end
  end

  describe "GET /api/notes/:id" do
    it "returns a specific note" do
      get api_note_path(note)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Sample Title')
    end
  end

  describe "POST /api/notes" do
    context "with valid parameters" do
      it "creates a new note" do
        expect {
          post api_notes_path, params: { note: valid_attributes }, as: :json
        }.to change(Note, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(response.body).to include('New Title')
      end
    end

    context "with invalid parameters" do
      it "does not create a new note" do
        expect {
          post api_notes_path, params: { note: invalid_attributes }, as: :json
        }.to change(Note, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH/PUT /api/notes/:id" do
    context "with valid parameters" do
      it "updates the requested note" do
        patch api_note_path(note), params: { note: valid_attributes }, as: :json
        note.reload

        expect(response).to have_http_status(:success)
        expect(note.title).to eq('New Title')
      end
    end

    context "with invalid parameters" do
      it "does not update the note" do
        patch api_note_path(note), params: { note: invalid_attributes }, as: :json
        note.reload

        expect(response).to have_http_status(:unprocessable_entity)
        expect(note.title).to eq('Sample Title')
      end
    end
  end

  describe "DELETE /api/notes/:id" do
    it "deletes the requested note" do
      expect {
        delete api_note_path(note), as: :json
      }.to change(Note, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end

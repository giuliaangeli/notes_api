require 'rails_helper'

RSpec.describe "/notes", type: :request do
  let(:valid_attributes) {
    {title: 'Valid title', content: 'Valid content'}
  }

  let(:invalid_attributes) {
    {title: nil, content: nil}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Note.create! valid_attributes
      get notes_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      note = Note.create! valid_attributes
      get note_url(note)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_note_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      note = Note.create! valid_attributes
      get edit_note_url(note)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Note" do
        expect {
          post notes_url, params: { note: valid_attributes }
        }.to change(Note, :count).by(1)
      end

      it "redirects to the created note" do
        post notes_url, params: { note: valid_attributes }
        expect(response).to redirect_to(note_url(Note.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Note" do
        expect {
          post notes_url, params: { note: invalid_attributes }
        }.to change(Note, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post notes_url, params: { note: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {title: 'New valid title', content: 'New valid content'}
      }

      it "updates the requested note" do
        note = Note.create! valid_attributes
        patch note_url(note), params: { note: new_attributes }
        note.reload

        expect(note.title).to eq('New valid title')
        expect(note.content).to eq('New valid content')
      end

      it "redirects to the note" do
        note = Note.create! valid_attributes
        patch note_url(note), params: { note: new_attributes }
        note.reload
        expect(response).to redirect_to(note_url(note))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        note = Note.create! valid_attributes
        patch note_url(note), params: { note: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested note" do
      note = Note.create! valid_attributes
      expect {
        delete note_url(note)
      }.to change(Note, :count).by(-1)
    end

    it "redirects to the notes list" do
      note = Note.create! valid_attributes
      delete note_url(note)
      expect(response).to redirect_to(notes_url)
    end
  end
end

module Api
  class NotesController < ApplicationController
    # Skip CSRF token verification for API requests
    #(in a real scenario it would be necesario create an authentication method, for examples with jwt)
    skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

    before_action :set_note, only: [:show, :update, :destroy]

    # GET /api/notes
    def index
      notes = Note.all
      render json: notes
    end

    # GET /api/notes/:id
    def show
      render json: @note
    end

    # POST /api/notes
    def create
      note = Note.new(note_params)
      if note.save
        render json: note, status: :created
      else
        render json: note.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/notes/:id
    def update
      if @note.update(note_params)
        render json: @note
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/notes/:id
    def destroy
      @note.destroy
      head :no_content
    end

    private

    def set_note
      @note = Note.find(params[:id])
    end

    def note_params
      params.require(:note).permit(:title, :content)
    end
  end
end

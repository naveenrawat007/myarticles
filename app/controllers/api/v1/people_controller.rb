module Api
  module V1
    class PeopleController < MainController
      before_action :authorize_request, except: [:create]
      def index
        @people = Person.all
        render json: @people, each_serializer: PersonSerializer,root: false
      end

      def show
        person = Person.find(params[:id])
        render json: person, each_serializer: PersonSerializer,root: false
      end

      def create
        person = Person.new(person_params)
        if person.save
          render json: person
        else
          render json: {data:person.errors}
        end
      end

      def destroy
        person = Person.find(params[:id])
        if person.destroy
          render json: {message: "deleted", data:person}
        end
      end

      def update
        person = Person.find(params[:id])
        if person.update(person_params)
          render json: {message:"updated", data: person}
        else
          render json: {message:"error", data: person.errors}
        end
      end

      private
      def person_params
        params.require(:person).permit(:name, :gender)
      end
    end
  end
end

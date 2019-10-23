module Api
  module V1
    class ArticlesController < MainController
      before_action :authorize_request, except: [:create]
      def index
        @articles = Article.all;
        render json: @articles, each_serializer: ArticleSerializer,root: false
        # render json: {status: "Success", message: "loaded articles", data: @articles},status: :ok
      end

      def show
        article = Article.find(params[:id])
        render json: article,serializer: ArticleSerializer
      end

      def create
        article = Article.new(article_params)
        if(article.save)
          render json: {status: "Success", message: "SuccessFully saved", date: article},status: :ok
        else
          render json: {status: "Error", message: "Not saved", data: article.errors},status: :unprocessable_entity
        end
      end

      def destroy
        article = Article.find(params[:id])
        if (article.destroy)
          render json: {status: "Sucess", message: "SuccessFully deleted", data: article},status: :ok
        end
      end

      def update
        article = Article.find(params[:id])
        if article.update(article_params)
          render json: {status: "Sucess", message: "SuccessFully Updated", data: article},status: :ok
        else
            render json: {status: "Error", message: "not updated", data: article.errors},status: :unprocessable_entity
        end
      end

      private
      def article_params
        params.require(:article).permit(:title, :body,:person_id)
      end
    end
  end
end

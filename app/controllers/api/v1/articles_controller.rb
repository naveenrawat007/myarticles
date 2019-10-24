module Api
  module V1
    class ArticlesController < MainController
      before_action :authorize_request, except: [:create, :find_articles_by_date, :find_articles_by_month, :find_articles_by_year]
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

      def find_articles_by_date
        if (params[:date].present?)
          date = ActiveSupport::TimeZone['New Delhi'].parse(params[:date])
          @articles = Article.articles_by_date(date)
          render json: {message:"Articles for this day", data: @articles, status: 200}
        else
          render json: {message:"date not present", status:404, data:nil}
        end
      end

      def find_articles_by_month
        if params[:date].present?
          date = ActiveSupport::TimeZone['New Delhi'].parse(params[:date])
          @articles = Article.get_articles_by_month(date)
          render json: {message: "Articles created in this month", status:200, data: @articles}
        else
          render json: {message: "date not present", status: 404, data: nil}
        end
      end

      def find_articles_by_year
        if params[:date].present?
          date = ActiveSupport::TimeZone['New Delhi'].parse(params[:date])
          @articles = Article.get_articles_by_year(date)
          render json: { message: "Articles thats created in year", data: @articles, status: 200}
        else
          render json: {message: "date not present", status: 404, data: nil}
        end
      end

      private
      def article_params
        params.require(:article).permit(:title, :body, :person_id)
      end
    end
  end
end

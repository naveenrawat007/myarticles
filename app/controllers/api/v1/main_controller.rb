class MainController < ActionController::API
  def authorize_request
    header = request.headers['Authorization']
    # user = User.find(header)
    # if user.present?
    #   render json: { current_user_id: user.id }
    # end
    header = header.split(' ').last if header
    begin
      @decoded = JWT.decode(header,nil,false)
      @current_user = User.find(@decoded.first['user_id'])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end

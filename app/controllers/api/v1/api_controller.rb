module Api
  module  V1
    class ApiController < ApplicationController

      include ActionController::Serialization
      include ActionController::RequestForgeryProtection

      @@user_login=nil

      @@errors = {
          code: 'API_ERROR',
          detail: ''
      }

      @@messages = {
          bad_parameters: 'The request was incorrect, is bad parameters sent from the app.',
          bad_credentials: 'Bad credentials.',
          login_error: 'wrong credentials',
          login_success: 'user logged in successfully',
          email_not_found: 'the specified user doesn\'t exist',
          logout_error: 'the specified user doesn\'t exist',
          logout_success: 'user logged out successfully'
      }

      @@page = 12

      def test
        render json: User.all
      end

      def users
        # weeks = Week.where(number_week: params[:number_week])
        service = Service.find_by(id: params[:service_id])

        items = service.users

        render json: items, each_serializer: UserSerializer, scope: {number_week: params[:number_week]}
      end

      def services
        items = Service.all

        render json: items
      end

      def weeks
        number_week = Time.now.strftime('%U').to_i

        items = Week.where(service_id: params[:service_id].to_i)
                    .where("weeks.number_week>=?", number_week)
                    .limit(5).number_week_asc

        render json: items
      end

      def days
        items = Day.where(number_week: params[:number_week].to_i).date_asc

        render json: items
      end

      protected

      private

    end
  end
end
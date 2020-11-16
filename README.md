# README
.env file
  GOOGLE_OAUTH_CLIENT_ID=
  GOOGLE_OAUTH_CLIENT_SECRET=

gems
  gem 'dotenv-rails', '~> 2.7'
  gem 'omniauth'
  gem 'omniauth-google-oauth2'


oauth controller app/controllers/users/omniauth_callbacks_controller.rb

  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
      def google_oauth2
        user = User.from_google(from_google_params)
        
        if user.present?
          sign_out_all_scopes
          flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
          sign_in_and_redirect user, event: :authentication
        else
          flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
          redirect_to new_user_session_path
        end
      end
    
      protected
    
      def after_omniauth_failure_path_for(_scope)
        new_user_session_path
      end
    
      def after_sign_in_path_for(resource_or_scope)
        stored_location_for(resource_or_scope) || root_path
      end
    
      private
    
      def from_google_params
        @from_google_params ||= {
          uid: auth.uid,
          email: auth.info.email,
          full_name: auth.info.name,
          avatar_url: auth.info.image
        }
      end
    
      def auth
        @auth ||= request.env['omniauth.auth']
      end
  end

User model
  class User < ApplicationRecord
    has_many :students
    has_many :teachers, through: :students
    has_many :lessons, through: :students
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth_2]

    # def self.from_google(uid:, email:, full_name:, avatar_url:)
    #   if user = User.find_by(email: email)
    #     user.update(uid: uid, full_name: full_name, avatar_url: avatar_url) unless user.uid.present?
    #     user
    #   else
    #     User.create(
    #       email: email,
    #       uid: uid,
    #       full_name: full_name,
    #       avatar_url: avatar_url,
    #       password: SecureRandom.hex
    #     )
    #   end
    # end
    <!-- def self.from_google(uid:, email:, full_name:, avatar_url:)
      user = User.find_or_create_by(email: email) do |u|
        u.uid = uid
        u.full_name = full_name
        u.avatar_url = avatar_url
        u.password = SecureRandom.hex
      end
        user.update(uid: uid, full_name: full_name, avatar_url: avatar_url)
        user
    end -->
  end




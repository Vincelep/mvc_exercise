# frozen_string_literal: true

module Administration
  class ProfilesController < ApplicationController
    before_action :set_profile, except: [:index]

    def index
      @emails = User.emails_of_all_users
      @user = User.all
    end

    def show
      @profile = Profile.find(params[:id])
    end

    def send_email
      @profile = Profile.find(params[:id])
      @profile.send_email
      redirect_back fallback_location: root_path
    end

    private

    def set_profile
      @profile = Profile.find(params[:id])
    end
  end
end

# frozen_string_literal: true

class AdministrationController < ApplicationController
  layout "administration"
  before_action :authenticate_admin!
end

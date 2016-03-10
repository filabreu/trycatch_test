class FoosController < ApplicationController

  before_action :authenticate

  authorize_action [:index, :show], [:admin, :user, :guest]
  authorize_action [:create, :update, :destroy], [:admin, :user]

  def index
    head :ok
  end

  def show
    head :ok
  end

  def create
    head :ok
  end

  def update
    head :ok
  end

  def destroy
    head :ok
  end

end

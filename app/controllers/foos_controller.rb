class FoosController < ApplicationController

  before_action :authenticate

  skip_before_action :verify_authenticity_token

  authorize_action [:index, :show], [:admin, :user, :guest]
  authorize_action [:create, :update, :destroy], [:admin, :user]

  def index
    @foos = Foo.all

    head :ok
  end

  def show
    @foo = Foo.find(params[:id])

    head :ok
  end

  def create
    @foo = current_user.foos.build(foo_params)

    head :ok
  end

  def update
    @foo = role_scope(:foos, params[:id])

    head :ok
  end

  def destroy
    @foo = role_scope(:foos, params[:id])

    head :ok
  end

  protected

    def foo_params
      params.require(:foo).permit(:title)
    end

end

class FoosController < ApplicationController

  before_action :authenticate

  skip_before_action :verify_authenticity_token

  authorize_action [:index, :show], [:admin, :user, :guest]
  authorize_action [:create, :update, :destroy], [:admin, :user]

  def index
    @foos = Foo.all

    render json: @foos
  end

  def show
    @foo = Foo.find(params[:id])

    render json: @foo
  end

  def create
    @foo = current_user.foos.build(foo_params)

    if @foo.save
      render json: @foo
    else
      render json: @foo.errors, status: :unprocessable_entity
    end
  end

  def update
    @foo = role_scope(:foos, params[:id])

    if @foo.update(foo_params)
      render json: @foo
    else
      render json: @foo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @foo = role_scope(:foos, params[:id])

    @foo.destroy

    head :ok
  end

  protected

    def foo_params
      params.require(:foo).permit(:title)
    end

end

class BarsController < ApplicationController

  before_action :authenticate
  before_action :find_foo, only: [:create, :update, :destroy]

  skip_before_action :verify_authenticity_token

  authorize_action [:index, :show], [:admin, :user, :guest]
  authorize_action [:create, :update, :destroy], [:admin, :user]


  def index
    @foo = Foo.find(params[:foo_id])
    @bars = @foo.bars

    head :ok
  end

  def show
    @foo = Foo.find(params[:foo_id])
    @bar = @foo.bars.find(params[:id])

    head :ok
  end

  def create
    @foo = role_scope(:foos, params[:foo_id])
    @bar = @foo.bars.build(bar_params)

    head :ok
  end

  def update
    @foo = role_scope(:foos, params[:foo_id])
    @bar = role_scope(:bars, params[:id], @foo)

    head :ok
  end

  def destroy
    @foo = role_scope(:foos, params[:foo_id])
    @bar = role_scope(:bars, params[:id], @foo)

    head :ok
  end

  protected

    def find_foo
      @foo = role_scope(:foos, params[:foo_id])
    end

    def bar_params
      params.require(:bar).permit(:title)
    end

end

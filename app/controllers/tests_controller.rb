class TestsController < Simpler::Controller

  def index
    @time = Time.now
    render plain: '2tests/index'
  end

  def create

  end

end

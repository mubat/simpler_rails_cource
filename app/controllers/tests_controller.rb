class TestsController < Simpler::Controller

  def index
    @time = Time.now
    render plain: 'tests/index'
  end

  def create

  end

end

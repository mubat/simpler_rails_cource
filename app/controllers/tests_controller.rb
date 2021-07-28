class TestsController < Simpler::Controller

  def index
    @time = Time.now
    headers['X-Simpler-Teest'] = 'success'
    render plain: '2tests/index'
  end

  def create

  end

  def show
    @test = Test.find(id: params[:id])
  end
end

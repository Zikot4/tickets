class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    p 'test worker'
  end
end

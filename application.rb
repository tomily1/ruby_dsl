require 'yaml'
require './config/boot.rb'
require './lib/router'

class Application
  attr_reader :router

  def initialize
    @router = Router.new(ROUTES)
  end

  def call(env)
    result = router.resolve(env)
    [result.status, result.headers, result.content]
  end

  def  self.root
    File .dirname ( __FILE__ )
  end
end

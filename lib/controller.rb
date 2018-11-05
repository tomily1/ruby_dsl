class Controller
  attr_reader :name, :action
  attr_accessor :status, :headers, :content

  def initialize(name: nil, action: nil)
    @name = name
    @action = action
  end

  def call
    send(action)
    self  .status  = 200
    self  .headers = {"Content-Type" => "text/html"}
    self  .content = [template.render(self)]
    self
  end

  def not_found
    self  .status  = 404
    self  .headers = {"Content-Type" => "text/html"}
    self  .content = [error(404).render]
    self
  end

  def internal_error
    self  .status  = 500
    self  .headers = {"Content-Type" => "text/html"}
    self  .content = [error(500).render]
    self
  end

  private

  def error(type)
    Slim::Template.new(File.join(Application.root, 'public', "#{type.to_s}.html.slim"))
  end

  def template
    Slim::Template.new(File.join(Application.root, 'app', 'views', "#{self.name}", "#{self.action}.html.slim"))
  end
end

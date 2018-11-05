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
    self  .content = [error_404.render('404')]
    self
  end

  def internal_error
    self  .status  = 500
    self  .headers = {"Content-Type" => "text/html"}
    self  .content = [error_500.render('500')]
    self
  end

  private

  def error_404
    Slim::Template.new(File.join(Application.root, 'public', "404.html.slim"))
  end

  def error_500
    Slim::Template.new(File.join(Application.root, 'public', "500.html.slim"))
  end

  def template
    Slim::Template.new(File.join(Application.root, 'app', 'views', "#{self.name}", "#{self.action}.html.slim"))
  end
end

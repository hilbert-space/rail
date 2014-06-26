require 'minitest/spec'
require 'minitest/autorun'

require_relative 'project/controller'

describe Rail::Application do
  it 'handles uncompressed CoffeeScript assets' do
    controller = Controller.new do
      config.compress = false
    end
    body = controller.process('/application.js')
    assert_equal body.strip, <<-BODY.strip
(function() {
  window.Font = (function() {
    function Font(name) {
      this.name = name;
    }

    return Font;

  })();

}).call(this);
(function() {
  var font;

  font = new Font('Benton Modern Display');

}).call(this);
    BODY
  end

  it 'handles compressed CoffeeScript assets' do
    controller = Controller.new do
      config.compress = true
    end
    body = controller.process('/application.js')
    assert_equal body.strip, <<-BODY.strip
(function(){window.Font=function(){function n(n){this.name=n}return n}()}).call(this),function(){var n;n=new Font(\"Benton Modern Display\")}.call(this);
    BODY
  end
end
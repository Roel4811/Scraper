module ApplicationHelper
  def component(component_name, locals = {}, &block)
    name = component_name.split("_").first
    render("components/#{name}/#{component_name}", locals, &block)
  end

  alias c component

  def current_class?(test_path)
    request.path == test_path ? 'active' : ''
  end

end

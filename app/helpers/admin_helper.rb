module AdminHelper
  def admin_component(component_name, locals = {}, &block)
    name = component_name.split("_").first
    render("components/admin/#{name}/#{component_name}", locals, &block)
  end

  alias admin_c admin_component
end

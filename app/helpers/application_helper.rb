

module ApplicationHelper
  def active_header_menu?(controllers)
    controllers.each do |controller|
      next unless controller[0] == params[:controller]
      return 'active' if controller[1] == '*' || controller[1].include?(params[:action])
    end
  end

  def active_collapse_menu?(controllers)
    controllers.each do |controller|
      next unless controller[0] == params[:controller]
      return 'here show' if controller[1] == '*' || controller[1].include?(params[:action])
    end
  end

  def active_modulo?(modulo)
    'active' if modulo == (controller.send :_layout, [modulo])
  end

  def set_proximo_dia_util(data) 
    return data.wday == 6 ? data + 2.day : data.wday == 0 ? data + 1.day : data
  end

  def current_module?(path)
    bool = path.include?('dunnas_admin') ? true : path.include?('autenticacao') ? true : path.include?('dunnas_pagamento') ? true : path.include?('pagamento') ? true : false
    
    bool
  end
end

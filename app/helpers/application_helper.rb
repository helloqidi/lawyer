module ApplicationHelper

  def render_page_title
    @page_title ? @page_title : Settings[:site_title]
  end


  #flash提示信息(notice,error)
  def flash_message
    flash_messages = []

    flash.each do |type, message|
      #使用bootstrap的警告样式
      case type
        when 'error'
          type = :danger
          fade_time = 5000
        else
          type = :success
          fade_time = 3000
      end

      #div提示内容(close是bootstrap自带的关闭方法)
      text = content_tag(:div, link_to("x", "#", :class => "close", 'data-dismiss' => "alert") + message, :class => "alert alert-#{type}")
      flash_messages << text if message
      #javascript定时隐藏脚本
      script = javascript_tag "setTimeout(\"$('.alert-#{type}').fadeOut('slow').remove()\",#{fade_time})"
      flash_messages << script if message
    end

    flash_messages.join("\n").html_safe
  end

  #设定当前样式
  def css_active?(css)
     "active" if css.present?  
  end


  MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                        'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                        'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                        'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                        'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'
  #判断是否是移动设备
  def mobile?
    agent_str = request.user_agent.to_s.downcase
    return false if agent_str =~ /ipad/
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end

  #返回图标按钮
  def return_icon_btn(url=nil)
    icon = raw( content_tag(:span, "", :class => "icon_return_cuanhuo") )
    if url.present?
      link_to(icon, url, :title=>"返回", :class=>"btn btn-icon btn-xs")
    else
      link_to(icon, "#", :title=>"返回", :onclick=>"window.history.back();return false;", :class=>"btn btn-icon btn-xs")
    end
  end

end
class HomeController < ApplicationController
	layout "weixinjs", :only => :jstest

	def index
	end

	#调用js sdk的测试页面
	def jstest
		@share_title = "测试标题"
		@share_desc = "描述内容是。。。"
		@share_url = "http://www.baidu.com"
		@share_img = "http://images.huxiu.com/article/cover/201507/31/012331714616.png"
	end

end

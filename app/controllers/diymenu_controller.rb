class DiymenuController < ApplicationController
    layout "weixinjs", :only => :redirect_test

    #创建菜单
    def create
        #获得授权跳转的地址(redirect_test_url是在路由中配置好的)
        redirect_url = $client.authorize_url(redirect_test_url)
	    menu = '{"button":[
	    			{"type":"view","name":"授权登录","url":"'+redirect_url+'"},
	    			{"type":"click","name":"歌手简介","key":"V1001_TODAY_SINGER"},
	    			{"name":"菜单","sub_button":[
	    				{"type":"view","name":"搜索","url":"http://www.soso.com/"},
	    				{"type":"view","name":"视频","url":"http://v.qq.com/"},
	    				{"type":"click","name":"赞一下我们","key":"V1001_GOOD"}
	    			]}
	    		]}'
	    response = $client.create_menu(JSON.load(menu)) # or Json string
	    #0是正确的
	    render :text => response.code
    	#expect(response.code).to eq(WeixinAuthorize::OK_CODE)
    end

    #查看菜单
    def query
    	menu_info = $client.menu
    	render :text => menu_info.result
    end

    #获取用户信息
    def user
    	#在关注者与公众号产生消息交互后，公众号可获得关注者的OpenID
    	user_info = $client.user(Settings.my_OpenID) #需要传递用户的OpenID
        puts $client.get_access_token
    	render :text => user_info.result
    end

    #发送用户信息
    def send_user_text
        response = $client.send_text_custom(Settings.my_OpenID, "你好")
        render :text => response.code
    end

    #网页授权跳转测试
    #注：此实现有问题，后台报错：ERROR TypeError: no implicit conversion of true into String，但是不影响使用
    def redirect_test
        # 回调后，获取code请求token或者openid:
        sns_info = $client.get_oauth_access_token(params[:code])
        #如果网页授权作用域为snsapi_userinfo，则此时开发者可以通过access_token和openid拉取用户信息了
        #auth_info = $client.get_oauth_userinfo(sns_info.result[:openid], sns_info.result[:access_token])
        #puts auth_info.result
        @user_info = $client.user(sns_info.result[:openid])
    end

end

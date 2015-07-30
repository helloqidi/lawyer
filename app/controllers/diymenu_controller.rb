class DiymenuController < ApplicationController

    #创建菜单
    def create
	    menu = '{"button":[
	    			{"type":"click","name":"今日歌曲","key":"V1001_TODAY_MUSIC"},
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
    	user_info = $client.user("owIvev8VSNGKjy_tGBle-a_iHCic") #需要传递用户的OpenID
    	render :text => user_info.result
    end

    #发送用户信息
    def send_user_text
        response = $client.send_text_custom("owIvev8VSNGKjy_tGBle-a_iHCic", "你好")
        render :text => response.code
    end

end

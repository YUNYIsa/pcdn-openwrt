
module("luci.controller.bdcdn", package.seeall)


function index()
    -- 定义一个共同的父菜单
    entry({"admin", "services", "bdcdn"}, template("bdcdn"), _("本电运行状态"), 1).index = true
    entry({"admin", "services", "bdcdn", "bdcdn_data"}, call("bdcdn_func")) -- 在这里添加了逗号
    entry({"admin", "services", "bdcdn", "tiefast"}, cbi("tietie/tietie"), _("本电CDN设置"), 2)
    entry({"admin", "services", "bdcdn", "black"}, form("tietie/black"), _("硬盘挂载"), 3)
    -- 子菜单项2：本电CDN设置
    
end

function bdcdn_func()
    luci.http.prepare_content("application/json")
    local A = luci.util.exec("cat /etc/dogbox/vision")
    local T = luci.util.exec("sh /etc/dogbox/wan_uptime")
    local J = luci.util.exec("cat /etc/ipes/bin/ipes_sn") 
    local M = luci.util.exec("sh /etc/dogbox/snzt")          
   luci.http.write_json({
        vision = A,
	id=J,
        uptime = B and B:match("%S+"),
        wanuptime = T and T:match("%S+"),
        snzt = M,
	})
end
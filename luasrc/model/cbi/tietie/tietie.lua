n = Map("tietie", translate("猕猴桃"))
d = n:section(TypedSection, "tietie")
d.anonymous = true
pp = d:option(ListValue, "area", translate("开关"))
pp:value("open", translate("开启"))
pp:value("close", translate("关闭"))



local apply = luci.http.formvalue("cbi.apply")
if apply then
    io.popen("sleep 10 && /etc/init.d/tietie start > /dev/null &")

end

return n

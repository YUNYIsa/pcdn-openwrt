local fs=require "nixio.fs"
local conffile="/etc/ipes/var/db/ipes/happ-conf/custom.yml"

f=SimpleForm("custom")
t=f:field(TextValue,"conf")
t.rmempty=true
t.rows=13
t.description=translate("请按照您的硬盘实际挂载地址填写，如/mnt/sda1/地址填写为- '/mnt/sda1/'")
function t.cfgvalue()
	return fs.readfile(conffile) or ""
end

function f.handle(self,state,data)
	if state == FORM_VALID then
		if data.conf then
			fs.writefile(conffile,data.conf:gsub("\r\n","\n"))
		else
			luci.sys.call("> /etc/ipes/var/db/ipes/happ-conf/custom.yml")
		end
		luci.sys.exec("./etc/ipes/bin/ipes stop")
	end
	return true
end

return f

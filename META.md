# 数据库设计

**[数据库信息]**

@Cinf: version, createTm, upgradeTm

产品配置信息表.

**[员工]**

@Employee: id, uname, phone(s), pwd, name(s), perms

雇员表, 登录后可用于查看和处理业务数据。

phone/pwd
: String. 员工登录用的用户名（一般用手机号）和密码. 密码采用md5加密。

perms
: List(perm/String). 逗号分隔的权限列表，如"emp,mgr". 可用值: emp,mgr, 对应权限AUTH_EMP, PERM_MGR。

**[用户]**

@User: id, uname, phone(s), pwd, name(s), createTm

phone/pwd
: 登录用的用户名和密码。密码采用md5加密。

createTm
: DateTime. 注册日期. 可用于分析用户数增长。

**[订单]**

@Ordr: id, userId, status(2), amount, dscr(l), cmt(l)

status
: Enum. 订单状态。CR-新创建,RE-已服务,CA-已取消. 其它备用值: PA-已付款(待服务), ST-开始服务, CL-已结算.

**[API调用日志]**

@ApiLog: id, tm, addr, ua(l), app, ses, userId, ac, t&, retval&, req(t), res(t), reqsz&, ressz&, ver

app
: "user"|"emp"|"store"...

ua
: userAgent

ses
: the php session id.

t
: 执行时间(单位：ms)

ver
: 客户端版本。格式为："web"表示通用网页(通过ua可查看明细浏览器)，"wx/{ver}"表示微信版本如"wx/6.2.5", "a/{ver}"表示安卓客户端及版本如"a/1", "ios/{ver}"表示苹果客户端版本如"ios/15".


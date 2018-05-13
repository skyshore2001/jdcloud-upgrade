# jdcloud-upgrade

筋斗云一站式数据模型部署工具。

- 根据设计文档中的数据模型定义，创建或更新数据库表。
- 数据库支持mysql，此外，对mssql(microsoft sqlserver)与sqlite提供基本功能支持。

详细命令及用法请查阅[参考手册](jdcloud-upgrade.html)。

工具要求php5.4以上版本环境。

## 快速上手

参照META.md，在文本文件中定义数据库表和字段，比如：

	@ApiLog: id, tm, addr

这样就定义了表ApiLog以及它的字段。

在mysql中创建一个新的数据库，名为jdcloud。

参照upgrade.sh，配置数据库连接参数，如：

	export P_DB=localhost/jdcloud
	export P_DBCRED=demo:demo123

然后运行它（一般在git-bash中运行）：

	./upgrade.sh

回车确认连接后，输入命令`initdb`，即可创建数据库表。
也可以直接用一个非交互的命令：

	./upgrade.sh initdb

当在META.md中修改了数据库设计，比如添加了表或字段，再重新运行升级脚本时，可刷新数据库表。

要查看所有建表的SQL语句，可以用：

	./upgrade.sh showtable

## 与你的项目集成

- 安装php5.4+环境，建议安装git环境。
- 将目录中的upgrade.php, upglib.php复制到你的项目下，习惯放在tool目录下。
- 创建设计文档，定义数据模型。（参考META.md）
- 参考upgrade.sh创建升级脚本，配置好参数。

例如设计文档为根目录下的DESIGN.md，则应有：

	export P_METAFILE=../DESIGN.md

在筋斗云应用框架中内置了本工具。

## 定义数据模型

数据模型主要为表和字段，一般在设计文档中定义，最常见的形式如：

	@ApiLog: id, tm, addr

这样就定义了表ApiLog以及它的字段。
字段类型根据命名规范自动判断，比如以id结尾的字段会被自动作为整型创建，以tm结尾会被当作日期时间类型创建，其它默认是字符串，规则如下：

| 规则 | 类型 |
| --   | --   |
| 以"Id"结尾                           | Integer
| 以"Price"/"Total"/"Qty"/"Amount"结尾 | Currency
| 以"Tm"/"Dt"/"Time"结尾               | Datetime/Date/Time
| 以"Flag"结尾                         | TinyInt(1B) NOT NULL

例如，"total", "docTotal", "total2", "docTotal2"都被认为是Currency类型（字段名后面有数字的，判断类型时数字会被忽略）。
 
也可以用一个类型后缀表示，如 `retVal&`表示整型，类型后缀规则如下：

| 后缀 | 类型 |
| --   | --   |
| &    | Integer
| @    | Currency
| #    | Double

字符串可以指定长度如`status(2)`，`name(s)`，字串长度以如下方式描述：

| 标记 | 长度 |
|--    | --   |
| s | small=20            |
| m | medium=50 (default) |
| l | long=255            |
| t | text                |

## 配置环境变量

可设置环境变量来定制运行参数。

- P_METAFILE: 指定META文件，一般即主设计文档，根据其中定义的数据模型生成数据库。默认为项目根目录下的"DESIGN.md"
- P_DBTYPE,P_DB,P_DBCRED: 设置数据库连接，参考下节。

连接mysql示例(注意在php.ini中打开php_pdo_mysql扩展)，设置以下环境变量：

	P_DB=172.12.77.221/jdcloud
	P_DBCRED=demo:demo123

要连接mssql或sqlite，请查阅参考手册。

注意：

- 升级工具只创建表, 不创建数据库本身。
- TODO: 不会删除表或字段。如有需要请手工操作。
- TODO: 对已有的字段，不能修改字段类型。需要手工操作。


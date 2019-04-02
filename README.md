# campusHelp
校园帮项目
校园即时服务平台
##开发环境
jdk1.8+tomcat8.5+mysql5.7
##开始使用
数据库放在/campusHelp/WebContent/db/campushelp.sql
将项目导入eclipse后
修改文件/campusHelp/src/applicationContext.xml
	<bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource">
		<property name="driverClassName" value="com.mysql.jdbc.Driver" />
		<property name="url" value="jdbc:mysql://yourIp:3306/campushelp" />
		<property name="username" value="yourName" />
		<property name="password" value="yourPassword" />
	</bean>
  放入tomcat运行即可

# campusHelp
校园帮项目
校园即时服务平台
## 开发环境
jdk1.8+tomcat8.5+mysql5.7
## 开始使用
将项目导入eclipse后  
修改文件/campusHelp/src/applicationContext.xml  
```sh
	<bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource">  
		<property name="driverClassName" value="com.mysql.jdbc.Driver" />  
		<property name="url" value="jdbc:mysql://yourIp:3306/campushelp" />  
		<property name="username" value="yourName" />  
		<property name="password" value="yourPassword" />  
	</bean>  
```
  放入tomcat运行即可  
## 关注公众号【HelloWeb烟梦网络】留言问题，及时为你解答。
## 效果展示
![Image text](https://raw.githubusercontent.com/shh2lm/campusHelp/master/img-folder/1.png)
![Image text](https://raw.githubusercontent.com/shh2lm/campusHelp/master/img-folder/2.png)
![Image text](https://raw.githubusercontent.com/shh2lm/campusHelp/master/img-folder/3.png)
![Image text](https://raw.githubusercontent.com/shh2lm/campusHelp/master/img-folder/4.png)
![Image text](https://raw.githubusercontent.com/shh2lm/campusHelp/master/img-folder/5.png)
![Image text](https://raw.githubusercontent.com/shh2lm/campusHelp/master/img-folder/6.png)
## 其他毕业设计项目
智能家居：https://github.com/ytu-shh/smartHome

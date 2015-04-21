# WHAT IS IT
基于一个线下社区的，用户发起简单的订单任务，有能力或时间的人帮助完成，并获取用户佣金

后期应支持线上支付。


# IDEA
不论是`外卖`或者各种`帮取物品`业务在大学校园不断发展,

懒人用户有非常多的理由通过他人的`顺路`或者`专业`来节省时间。



#LOGIC
用户注册或第三方登录后可以发布订单，            `status->waiting`

订单以手机号为联系方式

在未过期（用户设定过期时间）前，他人可以接单，   `status->serving`

接单员电话联系用户，讲清任务逻辑，

接单员开始实施，

或取消订单。                                  `status->terminated`

实施完成，接单员确认完成。                     `status->pending`

用户确认完成，评分。                          `status->finished`

用户受到欺骗，提交纠纷处理单。                 `status->wrong`



----

    waiting -> serving --->-->-->-->------  
                 ^         |             |  
                 |      terminated     pending  
                 |         |             |  
                 |         |       ---<------>----  
                 <--<-------       |             |  
                server=>NULL    finished       wrong  




---

    TODO:
        #order#show 显示process
        #user#show
        notification
        #finished button
        #wrong  button
        把orders controller里的方法移出来
        User验证页面，
        用户两天没有确认，默认为完成状态

很久之前的截图：
![Demo Picture](http://although2013.com/uploads/pictures/detail_2015-03-30_19_08_26____.png)


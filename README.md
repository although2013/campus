用户登陆发布任务，主要是顺路帮带东西什么的  
商户实时抢单，商户提前支付订金与账户内  

主要模块就是 任务，User，余额（后面要有支付宝在线支付），商户的评分，短信验证，  

主页做展示，说明网站何用，注册，登陆链接  

浏览：实时展示任务单，实时，抢单后右侧显示计时，同时拥有最多X个任务  


~~能搞得定再考虑Android客户端吧~~  



ADD

Get Order failed ->  
把informatoin 放右边，固定于窗口什么的，  

![Demo Picture](http://although2013.com/uploads/pictures/detail_2015-03-30_19_08_26____.png)


----

    waiting -> serving --->-->-->-->------  
                 ^         |             |  
                 |      terminated     pending  
                 |         |             |  
                 |         |       ---<------>----  
                 <--<-------       |             |  
               server=>NULL     finished       wrong  


前期线下应该在接单后 打电话确认  
后期可以在线预支付，冻结资金，接单员冻结部分金额保证质量  


用户发单，       `Order.status->waiting`  
接单，           `Order.status->serving`,  `quantity + 1`  
终止terminated  
发单者接收到消息，`Order.status->terminated`  

接单并完成，接单员按下完成按钮，发送通知，`Order.status->pending`  

用户便可以评价，Ajax--> `(User.score * User.quantity + this.Score)/(User.quantity+1)`  
用户点击‘是的，任务完成’，Ajax--> `Order.status->finished`  
        用户两天没有确认，默认为完成状态  

用户点击‘没有，任务出错’，Ajax--> `Order.status->wrong`  
        接单员出错任务数加一，  
        用户填写错误表单，生成错误单，发送消息告知接单员，让其填写申辩理由，  
        交由人工处理  


    用户属性：
            使用：
                    电话
                    昵称
                    邮箱地址
                    余额
            接单：
                    出错数
                    接单总数
                    评分1-10
                    终止订单数量
                
    Order
            process: pending:"2015/03/28 13:24:30 +8",finished:time

---

    TODO:
        order#show 显示process
        user#show
        notification
        finished button
        wrong  button

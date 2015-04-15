
User.create(

[{
id:1,
name:'although',
email:'although@123.com',
password:"foobar",
password_confirmation:"foobar"
},

{
id:2,
name:'Howard',
email:'howard@123.com',
password:"foobar",
password_confirmation:"foobar"
},

{
id:3,
name:'Lucy',
email:'lucy@123.com',
password:"foobar",
password_confirmation:"foobar"
},

{
id:4,
name:'Mandy',
email:'mandy@123.com',
password:"foobar",
password_confirmation:"foobar"
},

{
id:5,
name:'comeon',
email:'comeon@123.com',
password:"foobar",
password_confirmation:"foobar"
}]

)



Order.create(
[{
user_id:1,
title:"买中饭",
content:"买一份鸡排饭",
deadline:"2015-05-06 18:38:40",
location:"18舍",
phone:"13305070488",
status:"waiting",
server:"",
total:"15.00"
},

{
user_id:3,
title:"租一名女生周末逛街帮买衣服",
content:"要有良好的审美，没有男盆友，3.5小时",
deadline:"2015-05-06 18:38:40",
location:"16舍",
phone:"13345540488",
status:"waiting",
server:"",
total:"200"
},

{
user_id:1,
title:"帮替课",
content:"一节25块，电话联系",
deadline:"2015-05-06 18:35:29",
location:"8舍",
phone:"13300006666",
status:"waiting",
server:"",
total:"5.00"
},

{
user_id:1,
title:"买饮料",
content:"一瓶可乐600ml",
deadline:"2015-05-06 18:38:40",
location:"18舍",
phone:"13786450099",
status:"waiting",
server:"",
total:"4.00"
},

{
user_id:2,
title:"买晚餐",
content:"给大爷来一份特色的漱口水",
deadline:"2015-05-06 16:38:40",
location:"18舍",
phone:"13305070488",
status:"waiting",
server:"",
total:"5.00"
},

{
user_id:2,
title:"帮忙拿快递",
content:"电话沟通",
deadline:"2015-05-05 15:15:06",
location:"18舍",
phone:"13305070488",
status:"waiting",
server:"",
total:"5.00"
},

{
user_id:3,
title:"买份鸡排饭1",
content:"买份鸡排饭",
deadline:"2015-05-06 13:30:52",
location:"18舍",
phone:"13305070488",
status:"waiting",
server:"",
total:"10.00"
},

{
user_id:3,
title:"买份鸡排饭2",
content:"买份鸡排饭",
deadline:"2015-05-06 12:38:40",
location:"18舍",
phone:"13305070488",
status:"waiting",
server:"",
total:"13.50"
},

{
user_id:3,
title:"买份鸡排饭3",
content:"买份鸡排饭",
deadline:"2015-05-06 18:38:40",
location:"18舍",
phone:"13305070488",
status:"waiting",
server:"",
total:"12.00"
},

{
user_id:4,
title:"买份鸡排饭4",
content:"买份鸡排饭",
deadline:"2015-05-06 18:38:40",
location:"18舍",
phone:"13305070488",
status:"waiting",
server:"",
total:"13.00"
}]

)
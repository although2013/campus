5.times do |i|
  Order.create(
                user_id:1,
                title:"dagerensh#{i}",
                content:"#{i}",
                deadline:"0",
                location:"18she#{i}",
                phone:"13305070488",
                status:"sgfdfsdfgdfg",
                server:"",
                total:"5.00"
              )
end
3.times do |i|
  Order.create(
                user_id:1,
                title:"买中饭",
                content:"买#{i}份鸡排饭",
                deadline:"2015-03-31 18:38:40",
                location:"18舍#{i}",
                phone:"13305070488",
                status:"sgfdfsdfgdfg",
                server:"",
                total:"5.00"
              )
end
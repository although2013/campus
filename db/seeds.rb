5.times do |i|
  Order.create(
                user_id:1,
                title:"dagerensh#{i}",
                content:"sffsdgdfgdfvdfgdfg#{i}",
                deadline:"be quick#{i}",
                location:"18she#{i}",
                phone:"13305070488",
                status:"sgfdfsdfgdfg",
                server:"",
                total:"5.00"
              )
end
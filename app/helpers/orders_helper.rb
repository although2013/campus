module OrdersHelper
  def dead_line_type(dead_line)
    case dead_line
    when 0
      "尽快送达"
    else
      dead_line.to_i
    end
  end

  def parse_phone(phone)
    "#{phone[0..2]}-#{phone[3..6]}-#{phone[7..10]}"
  end
end

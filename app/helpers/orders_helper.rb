module OrdersHelper
  def dead_line_str(dead_line)
    case dead_line
    when 0
      "尽快送达"
    else
      del = dead_line.to_i - Time.now.to_i
      
      s = del % 60
      m = (del / 60) % 60
      h = del / 3600

      if h == 0
        h = ""
      elsif h > 0 && h < 10
        h = "0#{h}小时"
      else
        h = "#{h}小时"
      end

      if m < 10
        m = "0#{m}分"
      else
        m = "#{m}分"
      end

      if s < 10
        s = "0#{s}秒"
      else
        s = "#{s}秒"
      end
      "还剩：#{h}#{m}#{s}"
    end
  end

  def parse_phone(phone)
    "#{phone[0..2]}-#{phone[3..6]}-#{phone[7..10]}"
  end

end

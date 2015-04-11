module OrdersHelper
  def dead_line_str(dead_line)
    del = dead_line.to_i - Time.now.to_i
    s = del % 60
    m = (del / 60) % 60
    h = del / 3600
    "还剩：#{check_time(h, "小时")}#{check_time(m, "分")}#{check_time(s, "秒")}"
  end

  def check_time(n, s)
    if  n == 0 && s == "小时"
      return ""
    end
    if n < 10
      "0#{n}#{s}"
    else
      "#{n}#{s}"
    end
  end

  def parse_phone(phone)
    "#{phone[0..2]}-#{phone[3..6]}-#{phone[7..10]}"
  end

end

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

  def format_process(process)
    数组 = process.scan(/(\w+):(\d+\-\d+\-\d+\s\d+:\d+:\d+\s\+\d{4}),#(\d):(.*)\n/)
    超级文本 = ""
    数组.each do |line|
      超级文本.prepend "<tr><td>#{line[0]}</td><td>#{line[1][0,19]}</td><td>#{line[3]}</td></tr>"
    end

    """<table class='table'>
      <thead>
        <tr>
          <th>状态</th>
          <th>发生时间</th>
          <th>用户名</th>
        </tr>
      </thead>
      <tbody>
        #{超级文本}
      </tbody>
    </table>"""
  end

  def order_process(order, user)
    status_moment = Time.now
    if order.process.blank?
      "#{order.status}:#{status_moment},##{user.id}:#{user.name}\n"
    else
      "#{order.process}#{order.status}:#{status_moment},##{user.id}:#{user.name}\n"
    end
  end

end

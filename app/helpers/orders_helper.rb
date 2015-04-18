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
    Rails.logger.info "-------------#{process.inspect}------------"
    arr = process.scan(/(\w+):(\d+-\d+-\d+\s\d+:\d+:\d+\s.\d+),#(\d+):(\w+)/)
    html_str = ""
    Rails.logger.info "-------------#{arr.inspect}------------"

    arr.each do |line|
      formated_status = case "#{line[0]}"
      when 'waiting'
        '等待'
      when 'terminated'
        '被取消'
      when 'serving'
        '被接单'
      when 'pending'
        '等待您确认'
      when 'finished'
        '完成'
      when 'wrong'
        '出错'
      end
      Rails.logger.info "-------------#{formated_status}------------"
      datetime = DateTime.parse(line[1]).new_offset(8.0/24).strftime('%Y-%m-%d %H:%M:%S')
      html_str.prepend "<tr><td>#{formated_status}</td><td>#{datetime}</td><td>#{line[3]}</td></tr>"
    end

    Rails.logger.info "-------------#{html_str}------------"

    """<table class='table'>
      <thead>
        <tr>
          <th>状态</th>
          <th>发生时间</th>
          <th>用户名</th>
        </tr>
      </thead>
      <tbody>
        #{html_str}
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

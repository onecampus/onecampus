def w_f(f, tmp_arr, code, tail, level)
  f.puts tmp_arr[0] + ' ' + tmp_arr[1] + ' ' + code + tail + ' ' + level
end

f = File.new('./china_city_han.txt', 'w')
File.open('./china_city.txt', 'r') do |file|
  while line  = file.gets
    if line[0] != "\n" && line[0] != "\r"
      tmp_arr = line.split(' ')
      # f.puts tmp_arr[0] + ' ' + tmp_arr[1] 3515

      1100.upto(8300).each do |k|
        # han_city(tmp_arr, k.to_s[0], k.to_s[1], k.to_s[2..3], f)
        a = k.to_s[0]
        b = k.to_s[1]
        c = k.to_s[2..3]
        code = a + b
        if tmp_arr[0].start_with?(code + '0000')
          f.puts tmp_arr[0] + ' ' + tmp_arr[1] + ' 0' + ' 1'
          break
        elsif tmp_arr[0].start_with?(code + c) && tmp_arr[0].start_with?(code + c + '00')
          w_f(f, tmp_arr, code, '0000', '2')
          break
        elsif tmp_arr[0].start_with?(code + c)
          w_f(f, tmp_arr, code, c + '00', '3')
          break
        end
      end

    end
  end
end
f.close
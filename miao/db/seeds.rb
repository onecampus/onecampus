p '==' * 10
time_start = Time.now

user = User.new(
  last_name: '杨',
  first_name: '浮生',
  nick_name: '浮生',
  uid: 'flowerwrong',
  salt: 'flowerwrong',
  pass: User.hash_password('123456', 'flowerwrong'),
  avatar: '/test.png',
  email: 'yk@gmail.com',
  age: 22,
  university: '中山大学',
  address_current: '12.089, 72.569',
  birthday: (DateTime.now - 22.years),
  tel: '88888888',
  mobile: '13560474456',
  gender: 'male',
  access_token: 'O4K4EGheju926VhH67KXOQ',
  expiration_time: (DateTime.now + 10.days),
  last_login_ip: '127.0.0.1',
  register_status: 'active',
  last_sign_in_at: (DateTime.now - 10.days),
  language: 'zh_CN',
  register_type: 'mobile',
  personalized_signature: 'flowerwrong',
  country: '中国',
  province: '广东',
  city: '广州',
  region: '番禺',
  postcode: '510000'
)
user.save!

user2 = User.new(
  last_name: '杨',
  first_name: '浮生',
  nick_name: '浮生',
  uid: 'flowerwrong2',
  salt: 'flowerwrong',
  pass: User.hash_password('123456', 'flowerwrong'),
  avatar: '/test.png',
  email: 'yk2@gmail.com',
  age: 22,
  university: '中山大学',
  address_current: '12.089, 72.569',
  birthday: (DateTime.now - 22.years),
  tel: '88888888',
  mobile: '13560474452',
  gender: 'male',
  access_token: 'O4K4EGheju926VhH67KXOQ',
  expiration_time: (DateTime.now + 10.days),
  last_login_ip: '127.0.0.1',
  register_status: 'active',
  last_sign_in_at: (DateTime.now - 10.days),
  language: 'zh_CN',
  register_type: 'mobile',
  personalized_signature: 'flowerwrong',
  country: '中国',
  province: '广东',
  city: '广州',
  region: '番禺',
  postcode: '510000'
)
user2.save!

time_end = Time.now
time = time_end - time_start
puts time.to_s
p '==' * 10
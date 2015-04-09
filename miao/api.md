## Api

```ruby
{
  status: 'success/fail/error',
  code: 404,
  msg: 'Unable to communicate with database',
  data: { # or data: nil
    posts: [
      {id: 1},
      {id: 2}
    ]
  },
  links: {
    self: 'http://example.com/posts',
    next: 'http://example.com/posts?page[offset]=2',
    last: 'http://example.com/posts?page[offset]=10'
  }
}
```

### 错误码, 参考[rails render](http://guides.rubyonrails.org/layouts_and_rendering.html)

HTTP返回码 | 描述 | 符号
---|---|---
200 | 成功 | :ok
201 | 数据新建成功 | :created
403 | 禁止访问 | :forbidden
404 | 数据库记录404 | :not_found
404 | url404 | :not_found
401 | 未授权 | :unauthorized
422 | 数据更新(包括新建，更新，删除)失败 | :unprocessable_entity
500 | 服务器内部错误 | :internal_server_error
501 | 未实现 | :not_implemented
1201| 已注册(自定义) | :already_registered
1401| access_token未发送(自定义) | :none_token
1402| access_token已过期(自定义) | :token_expired
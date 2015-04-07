## Api

```json
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

### 错误码

HTTP返回码 | 描述
---|---
404 | 数据库记录404
404 | url404
401 | 未授权
418 | access_token未发送
419 | access_token已过期
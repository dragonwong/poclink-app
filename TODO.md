# TODO

## 20260525

### 登录语音服务还是失败

> 已解决：缺少 MMKV 库初始化

当前三方登录流程：

- 谷歌登录 signInWithPresentingViewController
- 三方登录 PostAuthWithIdToken
- 获取 url GetServiceUrlWithAccount
- 设置 url setExtendUrl（不需要执行）
- 登录语音服务 login_account

login_account 返回值 -1

> -1 也没关系，关键看 kPOST_CMCC_NOTIFICATION_LOGIN 是否触发。
> 
> 至于 -1 到底什么意思，对面开发始终没有说。

kPOST_CMCC_NOTIFICATION_LOGIN 和 kPOST_CMCC_NOTIFICATION_OTHER_LOGIN 都没有通知

日志：

- [poc_app]2026-05-26 02:30:07.703	[VERBOSE]	echat_imp	echat_imp_do_login login_state:1 context:std
- get_internet_date=Tue May 26 02:30:07 2026
- 获取网络时间戳=1779733807.704020
- [CMCCSDK]2026-05-25 18:30:07 +0000:Notify:ui_on_echat_notify notify: eid=2 p1=2 p2=0
- get_internet_date=Tue May 26 02:30:07 2026
- 获取网络时间戳=1779733807.704122
- [CMCCSDK]2026-05-25 18:30:07 +0000:EN_ONLINE_STATUS_CHANGED 收到的通知
- get_internet_date=Tue May 26 02:30:07 2026
- 获取网络时间戳=1779733807.704555
- get_internet_date=Tue May 26 02:30:07 2026
- 获取网络时间戳=1779733807.705239
- [CMCCSDK]2026-05-25 18:30:07 +0000:EN_ONLINE_STATUS_CHANGED online=2
- get_internet_date=Tue May 26 02:30:07 2026
- 获取网络时间戳=1779733807.705815
- [poc_app]2026-05-26 02:30:07.706	[VERBOSE]	connection	connection_shutdown !!!
- [poc_app]2026-05-26 02:30:07.706	[VERBOSE]	echat_imp	connection status:1

邮箱密码登录也是一样的问题。

### `init_dns` 新增参数都是什么？

- **serviceAudio**
- api
- extend
- update
- sos
- shareMsg
- fence

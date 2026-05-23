# PocLink iOS 项目结构说明

## 根目录文件

| 文件 | 说明 |
|------|------|
| `main.m` | 应用入口文件，包含 `main()` 函数，是程序启动的第一个执行点 |

## 应用委托 (AppDelegate)

| 文件 | 说明 |
|------|------|
| `AppDelegate.h` / `.m` | 应用生命周期管理：处理启动、后台切换等全局事件，包含 SDK 初始化逻辑 |
| `SceneDelegate.h` / `.m` | iOS 13+ 场景生命周期管理：处理多窗口场景的激活、断开等事件 |

## 页面控制器 (ViewControllers)

| 文件 | 说明 |
|------|------|
| `LandingViewController.h` / `.m` | **新首页**：包含"登录"和"进入首页"两个按钮，是应用启动后的第一个页面 |
| `LoginViewController.h` / `.m` | **登录页**：空白页面，预留用于实现登录功能 |
| `ViewController.h` / `.m` | **原首页**：包含谷歌登录按钮、按住讲话按钮和状态标签，是 PTT 对讲功能主界面 |

## 资源配置 (Assets)

| 文件/目录 | 说明 |
|-----------|------|
| `Assets.xcassets/` | 资源目录，管理应用图标、颜色等资源 |
| `├─ AppIcon.appiconset/` | 应用图标资源 |
| `├─ AccentColor.colorset/` | 主题色资源 |
| `└─ Contents.json` | 资源索引文件 |

## 故事板 (Storyboard)

| 文件 | 说明 |
|------|------|
| `Base.lproj/Main.storyboard` | 主界面布局文件：可视化定义页面结构和导航关系，当前包含 NavigationController → LandingViewController → ViewController |
| `Base.lproj/LaunchScreen.storyboard` | 启动页布局文件：应用启动时显示的闪屏界面 |

## 配置文件

| 文件 | 说明 |
|------|------|
| `Info.plist` | 应用配置文件：包含 Bundle ID、权限声明、启动配置等元数据 |

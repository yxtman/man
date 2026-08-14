# 曼联指南站点质量改进设计

## 目标

在保持纯静态 GitHub Pages 架构和现有视觉风格不变的前提下，提升导航无障碍、图片加载性能、分享 SEO 信息和回归检查能力。

## 方案

- 在现有 `js/main.js` 中补充 Escape、点击外部关闭和移动端滚动锁定。
- 为导航按钮和导航容器补充 ARIA 关联，为当前页面链接补充 `aria-current`。
- 为站内图片补充 `loading`、`decoding` 及尺寸属性。
- 为内容页统一补充 `og:url`、`og:description`、`og:locale` 和 Twitter 卡片标签。
- 添加 PowerShell 静态检查脚本，覆盖 404 以外页面的 SEO 标签、导航属性和图片属性。

## 验证

- `powershell -NoProfile -ExecutionPolicy Bypass -File tests/check-site.ps1`
- `node --check js/main.js`
- `git diff --check`

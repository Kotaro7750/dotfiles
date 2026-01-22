---
name: execute-plan-with-codex
description: Claude CodeのPlanモードで作成した計画をOpenAI Codex CLIで実行・実装させる。「codexで実装して」「codexで実行して」「codexに任せて」「codexに委譲して」などの指示があった場合に使用する。Planモードでの計画作成後、実装フェーズをCodexに委譲したい場合に最適。
---

# Execute Plan with Codex

Claude CodeのPlanモードで作成した計画をOpenAI Codex CLIに渡して実装させるスキル。

## ワークフロー

### 1. 計画の準備

Planモードで作成した計画ファイルの場所を確認する。通常は以下のいずれか：
- ユーザーが指定したファイル
- 会話中で言及されたファイル

計画が明確でない場合はユーザーに確認する。

### 2. Codex CLIの実行

**方法A: 直接指示（短い計画向け）**

```bash
codex exec -c model_reasoning_effort='"high"' "計画の内容をここに記述"
```

**方法B: ファイル参照（長い計画向け）**

```bash
codex exec -c model_reasoning_effort='"high"' "/path/to/plan.md に記載された実装計画に従って実装してください"
```

**方法C: 作業ディレクトリ指定**

```bash
cd /path/to/project && codex exec -c model_reasoning_effort='"high"' "計画内容"
```

### 3. 結果の確認

Codexの実行完了後：
1. 実行ログを確認する
2. 生成・変更されたファイルを確認する
3. 必要に応じてテストを実行する
4. 結果をユーザーに報告する

## 注意事項

- Codexは自律的に動作するため、実行前に計画内容が適切か確認する
- 長時間実行される可能性があるため、バックグラウンド実行を検討する
- Codexの出力が大きい場合は要約して報告する

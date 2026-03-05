# Additional Mount into Container

ホスト側の任意パスをコンテナに bind mount します。

最大 9 本まで指定できます。

この Feature は以下の **ホスト環境変数** を参照します。

- `ADDITIONAL_MOUNT_SOURCE_1`: ホスト側のパス
- `ADDITIONAL_MOUNT_TARGET_1`: コンテナ側のマウント先パス
- `ADDITIONAL_MOUNT_SOURCE_2`: 2 本目のホスト側パス
- `ADDITIONAL_MOUNT_TARGET_2`: 2 本目のコンテナ側マウント先
- `ADDITIONAL_MOUNT_SOURCE_3`: 3 本目のホスト側パス
- `ADDITIONAL_MOUNT_TARGET_3`: 3 本目のコンテナ側マウント先
- `ADDITIONAL_MOUNT_SOURCE_4` 〜 `ADDITIONAL_MOUNT_SOURCE_9`
- `ADDITIONAL_MOUNT_TARGET_4` 〜 `ADDITIONAL_MOUNT_TARGET_9`

## 例

```bash
export ADDITIONAL_MOUNT_SOURCE_1="$HOME/.claude"
export ADDITIONAL_MOUNT_TARGET_1="/home/vscode/.claude"

export ADDITIONAL_MOUNT_SOURCE_2="$HOME/.config/my-tool"
export ADDITIONAL_MOUNT_TARGET_2="/home/vscode/.config/my-tool"

export ADDITIONAL_MOUNT_SOURCE_3="$HOME/.ssh"
export ADDITIONAL_MOUNT_TARGET_3="/home/vscode/.ssh-host"
```

```jsonc
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "./src/additional-mount": {}
  }
}
```

## コンテナ内でも同じ値を使う場合

`ADDITIONAL_MOUNT_*` は `mounts` 解決には使われますが、Feature だけではコンテナ環境変数としては自動注入されません。
コンテナ内スクリプトからも参照したい場合は、利用側の `devcontainer.json` で `containerEnv` に橋渡しします。

```jsonc
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "./src/additional-mount": {}
  },
  "containerEnv": {
    "ADDITIONAL_MOUNT_SOURCE": "${localEnv:ADDITIONAL_MOUNT_SOURCE_1}",
    "ADDITIONAL_MOUNT_TARGET": "${localEnv:ADDITIONAL_MOUNT_TARGET_1}",
    "ADDITIONAL_MOUNT_SOURCE_2": "${localEnv:ADDITIONAL_MOUNT_SOURCE_2}",
    "ADDITIONAL_MOUNT_TARGET_2": "${localEnv:ADDITIONAL_MOUNT_TARGET_2}"
  }
}
```

> 注意: `mounts` は Feature の `options` を直接参照できないため、可変値は環境変数経由で指定します。
>
> `ADDITIONAL_MOUNT_TARGET_n` を指定する場合は、`/home/vscode/...` のような絶対パスを直接指定してください。
>
> 未設定スロットはデフォルト値（`/tmp` → `/tmp/additional-mount-N`）で処理されるため、必要な本数だけ環境変数を設定すれば動作します。
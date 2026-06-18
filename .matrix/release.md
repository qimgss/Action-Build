# 内核构建配置详情

## 构建信息
- **KernelSU 版本**: `${{ needs.build.outputs.KSU_BRANCH_VERSION }}`
- **构建时间**: `${{ env.KBUILD_BUILD_TIMESTAMP }}`
- **自定义后缀**: `${{ github.event.inputs.SUFFIX }}`

## 功能开关状态
| 功能 | 状态 | 说明 |
|------|------|------|
| KernelSU分支 | `${{ github.event.inputs.KERNELSU_BRANCH }}` | KernelSU分支 |
| 内核模块实现 | `${{ github.event.inputs.KPM }}` | 内核模块实现方式 |
| 关键分区写入保护 | ${{ github.event.inputs.LSM_BBG == 'true' && '✅' || '❌' }} | BBG分区保护 |
| 网络功能拓展 | ${{ github.event.inputs.NETFILTER == 'true' && '✅' || '❌' }} | 网络功能拓展 |
| 网络拥塞控制 | ${{ github.event.inputs.CCM == 'true' && '✅' || '❌' }} | 网络拥塞控住 |
| Unicode字码点修复 | ${{ github.event.inputs.UNICODE_BYPASS == 'true' && '✅' || '❌' }} | 零宽字符修复 |
| 轻量级Linux容器 | ${{ github.event.inputs.DROID_SPACES == 'true' && '✅' || '❌' }} | 轻量级Linux容器 |
| Re-Kernel | ${{ github.event.inputs.RE_KERNEL == 'true' && '✅' || '❌' }} | Re-Kernel |
| 风驰内核调度 | ${{ env.SCHED_HMBIRD == 'true' && '✅' || '❌' }} | 风驰游戏内核调度 |

> 工作流运行: [#${{ github.run_number }}](${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }})
> 哈希值： [${GITHUB_SHA:0:7}]
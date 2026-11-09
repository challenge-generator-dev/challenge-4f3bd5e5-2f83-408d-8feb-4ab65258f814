import 'package:flutter/material.dart';
import 'package:payment_app/domain/entities/entities.dart';

class SyncIndicator extends StatefulWidget {
  final SyncStatus status;
  final int pendingCount;
  final int failedCount;
  final VoidCallback? onSyncPressed;
  final VoidCallback? onRetryPressed;
  final bool showDetails;

  const SyncIndicator({
    super.key,
    required this.status,
    this.pendingCount = 0,
    this.failedCount = 0,
    this.onSyncPressed,
    this.onRetryPressed,
    this.showDetails = true,
  });

  @override
  State<SyncIndicator> createState() => _SyncIndicatorState();
}

class _SyncIndicatorState extends State<SyncIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.status == SyncStatus.syncing) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(SyncIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status == SyncStatus.syncing &&
        oldWidget.status != SyncStatus.syncing) {
      _animationController.repeat(reverse: true);
    } else if (widget.status != SyncStatus.syncing &&
        oldWidget.status == SyncStatus.syncing) {
      _animationController.stop();
      _animationController.reset();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor();
    final statusConfig = _getStatusConfig();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildAnimatedIcon(statusConfig.icon, statusColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statusConfig.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      statusConfig.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.status == SyncStatus.pending &&
                  widget.onSyncPressed != null)
                _buildActionButton(
                  icon: Icons.sync,
                  label: 'Sync Now',
                  onPressed: widget.onSyncPressed,
                  color: theme.colorScheme.primary,
                ),
              if (widget.status == SyncStatus.failed &&
                  widget.onRetryPressed != null)
                _buildActionButton(
                  icon: Icons.refresh,
                  label: 'Retry',
                  onPressed: widget.onRetryPressed,
                  color: theme.colorScheme.error,
                ),
            ],
          ),
          if (widget.showDetails && _shouldShowDetails()) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            _buildDetailsSection(theme),
          ],
        ],
      ),
    );
  }

  Widget _buildAnimatedIcon(IconData icon, Color color) {
    if (widget.status == SyncStatus.syncing) {
      return AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required Color color,
  }) {
    return Material(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsSection(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDetailItem(
          context,
          icon: Icons.schedule,
          label: 'Pending',
          count: widget.pendingCount,
          color: Colors.orange,
        ),
        _buildDetailItem(
          context,
          icon: Icons.error_outline,
          label: 'Failed',
          count: widget.failedCount,
          color: Colors.red,
        ),
        _buildDetailItem(
          context,
          icon: Icons.check_circle_outline,
          label: 'Synced',
          count: _calculateSyncedCount(),
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int count,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          count.toString(),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (widget.status) {
      case SyncStatus.synced:
        return Colors.green;
      case SyncStatus.pending:
        return Colors.orange;
      case SyncStatus.syncing:
        return Colors.blue;
      case SyncStatus.failed:
        return Colors.red;
    }
  }

  _SyncStatusConfig _getStatusConfig() {
    switch (widget.status) {
      case SyncStatus.synced:
        return _SyncStatusConfig(
          title: 'All Synced',
          subtitle: 'All transactions are up to date',
          icon: Icons.cloud_done,
        );
      case SyncStatus.pending:
        return _SyncStatusConfig(
          title: 'Pending Sync',
          subtitle: '${widget.pendingCount} transaction(s) waiting to sync',
          icon: Icons.cloud_upload_outlined,
        );
      case SyncStatus.syncing:
        return _SyncStatusConfig(
          title: 'Syncing...',
          subtitle: 'Uploading pending transactions',
          icon: Icons.sync,
        );
      case SyncStatus.failed:
        return _SyncStatusConfig(
          title: 'Sync Failed',
          subtitle: '${widget.failedCount} transaction(s) failed to sync',
          icon: Icons.cloud_off,
        );
    }
  }

  bool _shouldShowDetails() {
    return widget.pendingCount > 0 ||
        widget.failedCount > 0 ||
        widget.status == SyncStatus.synced;
  }

  int _calculateSyncedCount() {
    if (widget.pendingCount == 0 && widget.failedCount == 0) {
      return 0;
    }
    return (widget.pendingCount + widget.failedCount) > 0
        ? (10 - widget.pendingCount - widget.failedCount).clamp(0, 10)
        : 0;
  }
}

class _SyncStatusConfig {
  final String title;
  final String subtitle;
  final IconData icon;

  _SyncStatusConfig({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
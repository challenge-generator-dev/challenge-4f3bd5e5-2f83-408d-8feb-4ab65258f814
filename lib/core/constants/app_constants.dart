package payment_app.core.constants;

class AppConstants {
  AppConstants._();

  // API Configuration
  static const String baseUrl = 'https://api.payments.example.com';
  static const String apiVersion = 'v1';
  static const String transactionsEndpoint = '/transactions';
  static const String usersEndpoint = '/users';
  static const String syncEndpoint = '/sync';

  // Timeouts (in milliseconds)
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;
  static const int databaseOperationTimeout = 10000;

  // Retry Configuration
  static const int maxRetryCount = 3;
  static const int retryDelayMs = 2000;
  static const int retryBackoffMultiplier = 2;
  static const int maxRetryDelayMs = 30000;

  // Database Configuration
  static const String databaseName = 'payment_app.db';
  static const int databaseVersion = 1;
  static const int databaseVersionOld = 1;

  // Table Names
  static const String transactionsTable = 'transactions';
  static const String usersTable = 'users';
  static const String syncQueueTable = 'sync_queue';
  static const String settingsTable = 'settings';

  // Sync Configuration
  static const int syncBatchSize = 50;
  static const int syncIntervalMinutes = 5;
  static const int maxPendingTransactions = 1000;
  static const int syncRetryIntervalMinutes = 15;

  // Transaction Limits
  static const double maxTransactionAmount = 10000.0;
  static const double minTransactionAmount = 0.01;
  static const String defaultCurrency = 'USD';

  // Network Configuration
  static const int connectivityCheckIntervalSeconds = 30;
  static const int networkTimeoutSeconds = 45;
  static const List<String> allowedCurrencies = [
    'USD',
    'EUR',
    'GBP',
    'MXN',
    'COP',
    'ARS',
    'BRL',
  ];

  // UI Configuration
  static const int maxTransactionHistoryItems = 100;
  static const int animationDurationMs = 300;
  static const int debounceDelayMs = 500;

  // Security Configuration
  static const int tokenRefreshBufferMinutes = 5;
  static const int maxAuthAttempts = 3;
  static const int lockoutDurationMinutes = 30;

  // Validation
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
  static final RegExp uuidRegex = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );

  // Logging
  static const bool enableDebugLogs = true;
  static const bool enableNetworkLogs = false;
  static const bool enableDatabaseLogs = false;

  // Feature Flags
  static const bool enableOfflineMode = true;
  static const bool enableAutoSync = true;
  static const bool enablePushNotifications = false;
  static const bool enableBiometricAuth = false;
  static const bool enableTransactionReceipts = true;

  // Cache Configuration
  static const int cacheExpirationHours = 24;
  static const int maxCacheSizeMb = 50;
  static const bool enableCacheAnalytics = true;

  // Date Formats
  static const String iso8601Format = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayTimeFormat = 'HH:mm';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';

  // Error Messages
  static const String genericErrorMessage = 'An unexpected error occurred. Please try again.';
  static const String networkErrorMessage = 'No internet connection. Your transaction will be saved and synced when connection is restored.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String validationErrorMessage = 'Please check your input and try again.';
  static const String syncErrorMessage = 'Failed to sync. Will retry automatically.';

  // Success Messages
  static const String transactionCreatedMessage = 'Transaction created successfully.';
  static const String transactionSyncedMessage = 'Transaction synced successfully.';
  static const String transactionPendingMessage = 'Transaction saved locally. Will sync when online.';
}
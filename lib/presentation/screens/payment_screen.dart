import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:payment_app/domain/entities/entities.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_event.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_state.dart';
import 'package:payment_app/presentation/blocs/sync/sync_bloc.dart';
import 'package:payment_app/presentation/blocs/sync/sync_state.dart';
import 'package:payment_app/presentation/widgets/transaction_form.dart';
import 'package:payment_app/presentation/widgets/sync_indicator.dart';
import 'package:payment_app/core/errors/failures.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  String _selectedCurrency = 'USD';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  void _submitTransaction() {
    if (!_formKey.currentState!.validate()) return;
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      _showError('El monto debe ser un número positivo');
      setState(() => _isSubmitting = false);
      return;
    }

    final recipientId = _recipientController.text.trim();
    if (recipientId.isEmpty) {
      _showError('El destinatario es requerido');
      setState(() => _isSubmitting = false);
      return;
    }

    final transaction = TransactionEntity(
      id: const Uuid().v4(),
      userId: 'current_user_id',
      amount: amount,
      currency: _selectedCurrency,
      recipientId: recipientId,
      createdAt: DateTime.now(),
      syncStatus: SyncStatus.pending,
      retryCount: 0,
    );

    context.read<TransactionBloc>().add(CreateTransactionEvent(transaction));
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Cerrar',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _resetForm() {
    _amountController.clear();
    _recipientController.clear();
    setState(() {
      _selectedCurrency = 'USD';
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Pago'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          BlocBuilder<SyncBloc, SyncState>(
            builder: (context, state) {
              return const SyncIndicator();
            },
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TransactionBloc, TransactionState>(
            listener: (context, state) {
              if (state is TransactionCreated) {
                _showSuccess(
                  'Transacción creada exitosamente. '
                  'Se sincronizará cuando haya conexión.',
                );
                _resetForm();
              } else if (state is TransactionError) {
                setState(() => _isSubmitting = false);
                _showError(_mapFailureToMessage(state.failure));
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.payment,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Detalles del Pago',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TransactionForm(
                          amountController: _amountController,
                          recipientController: _recipientController,
                          selectedCurrency: _selectedCurrency,
                          onCurrencyChanged: (value) {
                            setState(() => _selectedCurrency = value ?? 'USD');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    final isLoading = state is TransactionLoading || _isSubmitting;
                    return FilledButton.icon(
                      onPressed: isLoading ? null : _submitTransaction,
                      icon: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.send),
                      label: Text(
                        isLoading ? 'Procesando...' : 'Enviar Pago',
                        style: const TextStyle(fontSize: 16),
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<SyncBloc, SyncState>(
                  builder: (context, state) {
                    if (state is SyncInProgress) {
                      return Card(
                        color: Colors.blue.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Sincronizando ${state.pendingCount} transacciones pendientes...',
                                  style: TextStyle(color: Colors.blue.shade700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 24),
                _buildOfflineInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOfflineInfo() {
    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Si no hay conexión, la transacción se guardará localmente '
                'y se sincronizará automáticamente cuando se restablezca la conexión.',
                style: TextStyle(
                  color: Colors.orange.shade900,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Error del servidor: ${failure.message}';
    } else if (failure is CacheFailure) {
      return 'Error de almacenamiento local';
    } else if (failure is NetworkFailure) {
      return 'Sin conexión. La transacción se guardará localmente.';
    } else if (failure is ValidationFailure) {
      return 'Validación fallida: ${failure.message}';
    }
    return 'Error desconocido';
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/domain/entities/entities.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_event.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_state.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final String userId;
  final Function(TransactionEntity)? onTransactionCreated;

  const TransactionForm({
    super.key,
    required this.userId,
    this.onTransactionCreated,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  final _currencyController = TextEditingController(text: 'USD');
  bool _isSubmitting = false;

  final List<String> _availableCurrencies = ['USD', 'EUR', 'GBP', 'MXN', 'JPY'];

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final amount = double.tryParse(_amountController.text.trim());
    final recipientId = _recipientController.text.trim();
    final currency = _currencyController.text.trim();

    if (amount == null || amount <= 0) {
      _showErrorSnackBar('El monto debe ser un número positivo');
      setState(() {
        _isSubmitting = false;
      });
      return;
    }

    final transaction = TransactionEntity(
      id: const Uuid().v4(),
      userId: widget.userId,
      amount: amount,
      currency: currency,
      recipientId: recipientId,
      createdAt: DateTime.now(),
      updatedAt: null,
      syncStatus: SyncStatus.pending,
      retryCount: 0,
      serverId: null,
      errorMessage: null,
    );

    context.read<TransactionBloc>().add(CreateTransactionEvent(transaction));
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _resetForm() {
    _amountController.clear();
    _recipientController.clear();
    _currencyController.text = 'USD';
    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionCreated) {
          _showSuccessSnackBar('Transacción creada correctamente');
          _resetForm();
          widget.onTransactionCreated?.call(state.transaction);
        } else if (state is TransactionError) {
          _showErrorSnackBar(state.message);
          setState(() {
            _isSubmitting = false;
          });
        } else if (state is TransactionLoading) {
          setState(() {
            _isSubmitting = true;
          });
        }
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nueva Transacción',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Monto',
                    hintText: 'Ingrese el monto a transferir',
                    prefixIcon: const Icon(Icons.attach_money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingrese un monto';
                    }
                    final amount = double.tryParse(value.trim());
                    if (amount == null || amount <= 0) {
                      return 'El monto debe ser mayor a cero';
                    }
                    if (amount > 1000000) {
                      return 'El monto excede el límite permitido';
                    }
                    return null;
                  },
                  enabled: !_isSubmitting,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _currencyController.text,
                  decoration: InputDecoration(
                    labelText: 'Moneda',
                    prefixIcon: const Icon(Icons.currency_exchange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  items: _availableCurrencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: _isSubmitting
                      ? null
                      : (value) {
                          if (value != null) {
                            _currencyController.text = value;
                          }
                        },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _recipientController,
                  decoration: InputDecoration(
                    labelText: 'Destinatario',
                    hintText: 'Ingrese el ID del beneficiario',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingrese el destinatario';
                    }
                    if (value.trim().length < 3) {
                      return 'El ID del destinatario debe tener al menos 3 caracteres';
                    }
                    if (value.trim() == widget.userId) {
                      return 'No puede transferirse a sí mismo';
                    }
                    return null;
                  },
                  enabled: !_isSubmitting,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  icon: _isSubmitting
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
                    _isSubmitting ? 'Procesando...' : 'Enviar Transacción',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionError) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning_amber, color: Colors.red.shade700),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                state.message,
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shop/enums/auth_mode.dart';
import 'package:shop/viewModels/auth_view_model.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _authMode = AuthMode.register;
  final _authViewModel = AuthViewModel();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  _isLogin() => _authMode == AuthMode.login;

  _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    if (_isLogin()) {
    } else {}

    setState(() => _isLoading = true);
  }

  _switchAuthMode() {
    switch (_authMode) {
      case AuthMode.login:
        _authMode = AuthMode.register;
      case AuthMode.register:
        _authMode = AuthMode.login;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(20),
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: Text('Email')),
                validator: (email) {
                  email = email ?? '';

                  if (email.isEmpty || !email.contains("@")) {
                    return 'Informe um e-mail válido';
                  }

                  return null;
                },
                onSaved: (email) => _authViewModel.email = email,
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('Senha')),
                controller: _passwordController,
                obscureText: true,
                validator: (password) {
                  password = password ?? '';

                  if (password.isEmpty) return 'Informe a senha';

                  if (password.length < 5 && !_isLogin()) {
                    return 'Informe uma senha com mais de 5 caracteres';
                  }

                  return null;
                },
                onSaved: (password) => _authViewModel.password = password,
              ),
              if (!_isLogin())
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Confirmação de Senha'),
                  ),
                  obscureText: true,
                  validator: (passwordConfirmation) {
                    passwordConfirmation = passwordConfirmation ?? '';

                    if (passwordConfirmation.isEmpty ||
                        _passwordController.text != passwordConfirmation) {
                      return 'As senhas não conferem';
                    }

                    return null;
                  },
                ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: Text(_isLogin() ? 'Entrar' : 'Cadastrar'),
                    ),
              SizedBox(height: 20),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  _isLogin() ? 'Cadastrar nova conta' : 'Fazer Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

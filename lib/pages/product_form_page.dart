import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/product.dart';
import 'package:shop/model/product_list.dart';
import 'package:shop/viewModels/product_form_view_model.dart';

class ProductFormPage extends StatefulWidget {
  final Product? product;
  const ProductFormPage({super.key, this.product});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _formViewModel = ProductFormViewModel();

  bool _isUpdate = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocus.removeListener(_updateImage);
    _imageUrlFocus.dispose();
  }

  _updateImage() {
    setState(() {});
  }

  _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    final newProduct = Product(
      id: _isUpdate
          ? _formViewModel.id ?? ''
          : Random().nextDouble().toString(),
      title: _formViewModel.title ?? "",
      description: _formViewModel.description ?? "",
      price: _formViewModel.price ?? 0,
      imageUrl: _formViewModel.imageUrl ?? "",
      isFavorite: false,
    );

    try {
      if (_isUpdate) {
        await Provider.of<ProductList>(
          context,
          listen: false,
        ).updateProduct(newProduct);
        Navigator.of(context).pop();
      } else {
        await Provider.of<ProductList>(context, listen: false).addProduct(newProduct);
        Navigator.of(context).pop();
      }
    } catch (error) {
      return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Atenção'),
            content: Text('Falha ao salvar produto'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Fechar'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final product = ModalRoute.of(context)?.settings.arguments as Product?;

    if (product == null) {
      _formViewModel.id = '';
      _formViewModel.title = '';
      _formViewModel.description = '';
      _formViewModel.price = 0;
      _formViewModel.imageUrl = '';
    } else {
      _formViewModel.id = product.id;
      _formViewModel.title = product.title;
      _formViewModel.description = product.description;
      _formViewModel.price = product.price;
      _formViewModel.imageUrl = product.imageUrl;

      _imageUrlController.text = product.imageUrl;

      _isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Produto'),
        actions: [IconButton(onPressed: _submitForm, icon: Icon(Icons.save))],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formViewModel.title,
                      decoration: InputDecoration(labelText: "Título"),
                      textInputAction: TextInputAction.next,
                      onSaved: (title) => _formViewModel.title = title ?? "",
                      validator: (name) {
                        name = name ?? '';

                        if (name.trim().isEmpty) {
                          return 'O nome não pode ser vázio';
                        }

                        if (name.trim().length < 3) {
                          return 'O nome deve ter pelo menos 3 caracteres';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formViewModel.price.toString(),
                      decoration: InputDecoration(labelText: "Preço (R\$)"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onSaved: (String? price) =>
                          _formViewModel.price = double.parse(price ?? "0"),
                      validator: (price) {
                        price = price ?? '';

                        if (price.trim().isEmpty) {
                          return 'O preço precisa ser informado';
                        }

                        var priceInt = double.tryParse(price.trim()) ?? 0;

                        if (priceInt <= 0) {
                          return 'O preço informado deve ser maior do que zero';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formViewModel.description,
                      decoration: InputDecoration(labelText: "Descrição"),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (description) =>
                          _formViewModel.description = description ?? "",
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _imageUrlController,
                            decoration: InputDecoration(
                              labelText: 'Url da Imagem',
                            ),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            focusNode: _imageUrlFocus,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imageUrl) =>
                                _formViewModel.imageUrl = imageUrl ?? "",
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 10, left: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: BoxBorder.all(color: Colors.black),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Informe a Url')
                              : FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.network(
                                    _imageUrlController.text,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

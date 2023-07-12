// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tktinder/repositories/storage/storage_repository.dart';

class CustomImageContainer extends StatelessWidget {
  final String? imageUrl;
  const CustomImageContainer({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            top: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            left: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            right: BorderSide(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        child: (imageUrl == null)
            ? Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () async {
                    ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No image was selected.')));
                    }

                    if (image != null) {
                      log('Uploading ...');
                      StorageRepository().uploadImage(image);
                    }
                  },
                ),
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

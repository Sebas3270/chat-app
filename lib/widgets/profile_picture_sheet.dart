import 'package:chat_app/models/models.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePictureSheet extends StatelessWidget {

  User user;

  ProfilePictureSheet({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final authService = Provider.of<AuthService>(context);
    final ImagePicker _picker = ImagePicker();
    final isThereImage = user.image != null;

    return SizedBox(
      height: (isThereImage) ? 220 : 170,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 17
                  ),
                )
              )
            ],
          ),

          ListTile(
            title: Text((!isThereImage) ? 'Upload profile picture' : 'Update profile picture'),
            trailing: const Icon(FluentSystemIcons.ic_fluent_person_add_regular),
            onTap: () async{
              // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

              final pickedFile = await _picker.pickImage(
                source: ImageSource.gallery,
                imageQuality: 100
              ); 

              if(pickedFile == null){
                return;
              }

              print(pickedFile.path);

              await authService.uploadProfilePicture(pickedFile.path);

              Navigator.of(context).pop();
            },
          ),

          (isThereImage)
          ? ListTile(
            title: Text('Delete profile picture'),
            trailing: Icon(FluentSystemIcons.ic_fluent_delete_regular),
            onTap: () async {
              await authService.deleteProfilePicture();
              Navigator.of(context).pop();
            },
          )
          : const SizedBox()
          
        ],
        

      )
    );
  }
}
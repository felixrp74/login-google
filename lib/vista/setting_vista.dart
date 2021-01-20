import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_google/controlador/theme_controller.dart';
import 'package:login_google/modelo/menu_option_model.dart';
import 'package:login_google/vista/actualizar_perfil_vista.dart';
import 'package:login_google/vista/segmented_selector.dart'; 


class SettingsUI extends StatelessWidget {
  //final LanguageController languageController = LanguageController.to;
  //final ThemeController themeController = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configuracion"),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {

    return ListView(
      children: <Widget>[
        // languageListTile(context),
        themeListTile(context),

        ListTile(
          title: Text("Perfil"),
          trailing: RaisedButton(
            onPressed: () async {
              Get.to(ActualizarPerfilVista());
            },
            child: Text(
              "Actualizar"
            ),
          )),



        ListTile(
          title: Text("Salir"),
          trailing: RaisedButton(
            onPressed: () {
              // AuthController.to.signOut();
            },
            child: Text( 
              "Salir",
            ),
          ),
        )




      ],
    );
  }

  // languageListTile(BuildContext context) {
  //   return GetBuilder<LanguageController>(
  //     builder: (controller) => ListTile(
  //       title: Text(labels.settings.language),
  //       trailing: DropdownPicker(
  //         menuOptions: Globals.languageOptions,
  //         selectedOption: controller.currentLanguage,
  //         onChanged: (value) async {
  //           await controller.updateLanguage(value);
  //           Get.forceAppUpdate();
  //         },
  //       ),
  //     ),
  //   );
  // }

  themeListTile(BuildContext context) {

    

    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system",
          value: "System",
          icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light",
          value: "Light",
          icon: Icons.brightness_low ),
      MenuOptionsModel(
          key: "dark", 
          value: "Dark", 
          icon: Icons.brightness_3 )
    ];
    
    return GetBuilder<ThemeController>(
      builder: (controller) => ListTile(
        title: Text("tema"),
        trailing: SegmentedSelector(
          selectedOption: controller.currentTheme,
          menuOptions: themeOptions,
          onValueChanged: (value) {
            controller.setThemeMode(value);
          },
        ),
      ),
    );
  }
}
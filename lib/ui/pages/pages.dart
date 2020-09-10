import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pdf_previewer/pdf_previewer.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:super_telyu/bloc/bloc.dart';
import 'package:super_telyu/data/datas.dart';
import 'package:super_telyu/models/models.dart';
import 'package:super_telyu/services/services.dart';
import 'package:super_telyu/shared/shared.dart';
import 'package:super_telyu/ui/widgets/widgets.dart';
import 'package:super_telyu/extensions/extensions.dart';

part 'main_page.dart';
part 'wrapper.dart';
part 'splash_page.dart';
part 'submissions_page.dart';
part 'login_page.dart';
part 'choose_role_page.dart';
part 'registration_page.dart';
part 'account_confirmation_page.dart';
part 'personal_data_page.dart';
part 'company_data_page.dart';
part 'uploaded_file_page.dart';
part 'pdf_view_page.dart';
part 'success_page.dart';
part 'submission_detail_page.dart';
part 'help_page.dart';
part 'dispen_data_page.dart';
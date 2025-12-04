import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get last_name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get invalid_email;

  /// No description provided for @invalid_password.
  ///
  /// In en, this message translates to:
  /// **'Invalid Password'**
  String get invalid_password;

  /// No description provided for @invalid_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get invalid_confirm_password;

  /// No description provided for @access_account.
  ///
  /// In en, this message translates to:
  /// **'Access Account'**
  String get access_account;

  /// No description provided for @create_new_account.
  ///
  /// In en, this message translates to:
  /// **'Create a New Account'**
  String get create_new_account;

  /// No description provided for @login_generic_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to login.'**
  String get login_generic_error;

  /// No description provided for @login_user_not_found_error.
  ///
  /// In en, this message translates to:
  /// **'Account doesn\'t exist.'**
  String get login_user_not_found_error;

  /// No description provided for @register_generic_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to register.'**
  String get register_generic_error;

  /// No description provided for @register_email_conflict_error.
  ///
  /// In en, this message translates to:
  /// **'Email already in use.'**
  String get register_email_conflict_error;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sign_out;

  /// No description provided for @create_group.
  ///
  /// In en, this message translates to:
  /// **'Create Group'**
  String get create_group;

  /// No description provided for @filter_assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get filter_assigned;

  /// No description provided for @filter_owned.
  ///
  /// In en, this message translates to:
  /// **'Owned'**
  String get filter_owned;

  /// No description provided for @completion_summary.
  ///
  /// In en, this message translates to:
  /// **'Completion Summary'**
  String get completion_summary;

  /// No description provided for @overdue_summary.
  ///
  /// In en, this message translates to:
  /// **'Overdue Summary'**
  String get overdue_summary;

  /// No description provided for @priority_summary.
  ///
  /// In en, this message translates to:
  /// **'Priority Summary'**
  String get priority_summary;

  /// No description provided for @status_summary.
  ///
  /// In en, this message translates to:
  /// **'Status Summary'**
  String get status_summary;

  /// No description provided for @groups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get groups;

  /// No description provided for @empty_groups_title.
  ///
  /// In en, this message translates to:
  /// **'You don\'t belong to any groups yet.'**
  String get empty_groups_title;

  /// No description provided for @empty_groups_description_1.
  ///
  /// In en, this message translates to:
  /// **'You can create a new group by tapping the'**
  String get empty_groups_description_1;

  /// No description provided for @empty_groups_description_2.
  ///
  /// In en, this message translates to:
  /// **'button or join an existing one with an invitation.'**
  String get empty_groups_description_2;

  /// No description provided for @invites.
  ///
  /// In en, this message translates to:
  /// **'Invites'**
  String get invites;

  /// No description provided for @empty_invites_description.
  ///
  /// In en, this message translates to:
  /// **'No invitations for now.'**
  String get empty_invites_description;

  /// No description provided for @invited_by.
  ///
  /// In en, this message translates to:
  /// **'Invited by:'**
  String get invited_by;

  /// No description provided for @update_group.
  ///
  /// In en, this message translates to:
  /// **'Update Group'**
  String get update_group;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @group_invite_members.
  ///
  /// In en, this message translates to:
  /// **'Invite people'**
  String get group_invite_members;

  /// No description provided for @group_manage_members.
  ///
  /// In en, this message translates to:
  /// **'Manage members'**
  String get group_manage_members;

  /// No description provided for @group_members_selected.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String group_members_selected(int count);

  /// No description provided for @search_user.
  ///
  /// In en, this message translates to:
  /// **'Search users'**
  String get search_user;

  /// No description provided for @invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get invite;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get members;

  /// No description provided for @leave_group.
  ///
  /// In en, this message translates to:
  /// **'Leave Group'**
  String get leave_group;

  /// No description provided for @create_task.
  ///
  /// In en, this message translates to:
  /// **'Create Task'**
  String get create_task;

  /// No description provided for @tasks_list_view.
  ///
  /// In en, this message translates to:
  /// **'Tasks List View'**
  String get tasks_list_view;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @list.
  ///
  /// In en, this message translates to:
  /// **'list'**
  String get list;

  /// No description provided for @assignee.
  ///
  /// In en, this message translates to:
  /// **'Assignee'**
  String get assignee;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @myself.
  ///
  /// In en, this message translates to:
  /// **'Myself'**
  String get myself;

  /// No description provided for @others.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others;

  /// No description provided for @completion.
  ///
  /// In en, this message translates to:
  /// **'Completion'**
  String get completion;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @to_do.
  ///
  /// In en, this message translates to:
  /// **'To Do'**
  String get to_do;

  /// No description provided for @in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get in_progress;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @sort_date.
  ///
  /// In en, this message translates to:
  /// **'Sort Date'**
  String get sort_date;

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get newest;

  /// No description provided for @oldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest'**
  String get oldest;

  /// No description provided for @sort_priority.
  ///
  /// In en, this message translates to:
  /// **'Sort Priority'**
  String get sort_priority;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @highest.
  ///
  /// In en, this message translates to:
  /// **'Highest'**
  String get highest;

  /// No description provided for @lowest.
  ///
  /// In en, this message translates to:
  /// **'Lowest'**
  String get lowest;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @empty_tasks_title.
  ///
  /// In en, this message translates to:
  /// **'No tasks created yet.'**
  String get empty_tasks_title;

  /// No description provided for @empty_tasks_description_1.
  ///
  /// In en, this message translates to:
  /// **'Create a new task by tapping the'**
  String get empty_tasks_description_1;

  /// No description provided for @empty_tasks_description_2.
  ///
  /// In en, this message translates to:
  /// **'button.'**
  String get empty_tasks_description_2;

  /// No description provided for @empty_filtered_tasks_title.
  ///
  /// In en, this message translates to:
  /// **'No tasks found for selected filters.'**
  String get empty_filtered_tasks_title;

  /// No description provided for @update_task.
  ///
  /// In en, this message translates to:
  /// **'Update Task'**
  String get update_task;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @due_date_time.
  ///
  /// In en, this message translates to:
  /// **'Due Date and Time'**
  String get due_date_time;

  /// No description provided for @assign_to.
  ///
  /// In en, this message translates to:
  /// **'Assign To'**
  String get assign_to;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @no_description.
  ///
  /// In en, this message translates to:
  /// **'No description.'**
  String get no_description;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @action_cannot_be_undone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get action_cannot_be_undone;

  /// No description provided for @duplicate_task.
  ///
  /// In en, this message translates to:
  /// **'Duplicate Task'**
  String get duplicate_task;

  /// No description provided for @edit_task.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get edit_task;

  /// No description provided for @delete_task.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get delete_task;

  /// No description provided for @due_by.
  ///
  /// In en, this message translates to:
  /// **'Due By'**
  String get due_by;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @created_at.
  ///
  /// In en, this message translates to:
  /// **'Created at'**
  String get created_at;

  /// No description provided for @updated_at.
  ///
  /// In en, this message translates to:
  /// **'Updated at'**
  String get updated_at;

  /// No description provided for @no_comments.
  ///
  /// In en, this message translates to:
  /// **'No comments yet.'**
  String get no_comments;

  /// No description provided for @progression.
  ///
  /// In en, this message translates to:
  /// **'Progression'**
  String get progression;

  /// No description provided for @one_month.
  ///
  /// In en, this message translates to:
  /// **'1 Month'**
  String get one_month;

  /// No description provided for @three_months.
  ///
  /// In en, this message translates to:
  /// **'3 Months'**
  String get three_months;

  /// No description provided for @six_months.
  ///
  /// In en, this message translates to:
  /// **'6 Months'**
  String get six_months;

  /// No description provided for @one_year.
  ///
  /// In en, this message translates to:
  /// **'1 Year'**
  String get one_year;

  /// No description provided for @completed_tasks.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed_tasks;

  /// No description provided for @overdue_tasks.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue_tasks;

  /// No description provided for @total_tasks.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total_tasks;

  /// No description provided for @dashboard_upcoming_tasks.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Tasks'**
  String get dashboard_upcoming_tasks;

  /// No description provided for @dashboard_overdue_tasks.
  ///
  /// In en, this message translates to:
  /// **'Overdue Tasks'**
  String get dashboard_overdue_tasks;

  /// No description provided for @dashboard_highlights.
  ///
  /// In en, this message translates to:
  /// **'Highlights'**
  String get dashboard_highlights;

  /// No description provided for @dashboard_showing_progression.
  ///
  /// In en, this message translates to:
  /// **'Show Summaries'**
  String get dashboard_showing_progression;

  /// No description provided for @dashboard_showing_highlights.
  ///
  /// In en, this message translates to:
  /// **'Show Highlights'**
  String get dashboard_showing_highlights;

  /// No description provided for @checklist.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get checklist;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring;

  /// No description provided for @recurrence_daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get recurrence_daily;

  /// No description provided for @recurrence_weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get recurrence_weekly;

  /// No description provided for @recurrence_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get recurrence_monthly;

  /// No description provided for @ending_on.
  ///
  /// In en, this message translates to:
  /// **'Ending On'**
  String get ending_on;

  /// No description provided for @never.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get never;

  /// No description provided for @group_color.
  ///
  /// In en, this message translates to:
  /// **'Group Color'**
  String get group_color;

  /// No description provided for @group_color_red.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get group_color_red;

  /// No description provided for @group_color_green.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get group_color_green;

  /// No description provided for @group_color_blue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get group_color_blue;

  /// No description provided for @remove_color.
  ///
  /// In en, this message translates to:
  /// **'Remove Color'**
  String get remove_color;

  /// No description provided for @select_color.
  ///
  /// In en, this message translates to:
  /// **'Select Color'**
  String get select_color;

  /// No description provided for @go_to_current_date.
  ///
  /// In en, this message translates to:
  /// **'Go to Current Date'**
  String get go_to_current_date;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @empty_filtered_groups_title.
  ///
  /// In en, this message translates to:
  /// **'No groups found with searched title and/or description.'**
  String get empty_filtered_groups_title;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get first_name => 'First Name';

  @override
  String get last_name => 'Last Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get invalid_email => 'Invalid Email';

  @override
  String get invalid_password => 'Invalid Password';

  @override
  String get invalid_confirm_password => 'Passwords do not match';

  @override
  String get access_account => 'Access Account';

  @override
  String get create_new_account => 'Create a New Account';

  @override
  String get login_generic_error => 'Unable to login.';

  @override
  String get login_user_not_found_error => 'Account doesn\'t exist.';

  @override
  String get register_generic_error => 'Unable to register.';

  @override
  String get register_email_conflict_error => 'Email already in use.';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get sign_out => 'Sign Out';

  @override
  String get create_group => 'Create Group';

  @override
  String get filter_assigned => 'Assigned';

  @override
  String get filter_owned => 'Owned';

  @override
  String get completion_summary => 'Completion Summary';

  @override
  String get overdue_summary => 'Overdue Summary';

  @override
  String get priority_summary => 'Priority Summary';

  @override
  String get status_summary => 'Status Summary';

  @override
  String get groups => 'Groups';

  @override
  String get empty_groups_title => 'You don\'t belong to any groups yet.';

  @override
  String get empty_groups_description_1 => 'You can create a new group by tapping the';

  @override
  String get empty_groups_description_2 => 'button or join an existing one with an invitation.';

  @override
  String get invites => 'Invites';

  @override
  String get empty_invites_description => 'No invitations for now.';

  @override
  String get invited_by => 'Invited by:';

  @override
  String get update_group => 'Update Group';

  @override
  String get name => 'Name';

  @override
  String get description => 'Description';

  @override
  String get group_invite_members => 'Invite people';

  @override
  String get group_manage_members => 'Manage members';

  @override
  String group_members_selected(int count) {
    return '$count selected';
  }

  @override
  String get search_user => 'Search users';

  @override
  String get invite => 'Invite';

  @override
  String get create => 'Create';

  @override
  String get update => 'Update';

  @override
  String get delete => 'Delete';

  @override
  String get details => 'Details';

  @override
  String get actions => 'Actions';

  @override
  String get members => 'Members';

  @override
  String get leave_group => 'Leave Group';

  @override
  String get create_task => 'Create Task';

  @override
  String get tasks_list_view => 'Tasks List View';

  @override
  String get calendar => 'Calendar';

  @override
  String get list => 'list';

  @override
  String get assignee => 'Assignee';

  @override
  String get all => 'All';

  @override
  String get myself => 'Myself';

  @override
  String get others => 'Others';

  @override
  String get completion => 'Conpletion';

  @override
  String get pending => 'Pending';

  @override
  String get completed => 'Completed';

  @override
  String get status => 'Status';

  @override
  String get to_do => 'To Do';

  @override
  String get in_progress => 'In Progress';

  @override
  String get done => 'Done';

  @override
  String get priority => 'Priority';

  @override
  String get low => 'Low';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get sort_date => 'Sort Date';

  @override
  String get newest => 'Newest';

  @override
  String get oldest => 'Oldest';

  @override
  String get sort_priority => 'Sort Priority';

  @override
  String get none => 'None';

  @override
  String get highest => 'Highest';

  @override
  String get lowest => 'Lowest';

  @override
  String get reset => 'Reset';

  @override
  String get empty_tasks_title => 'No tasks created yet.';

  @override
  String get empty_tasks_description_1 => 'Create a new task by tapping the';

  @override
  String get empty_tasks_description_2 => 'button.';

  @override
  String get empty_filtered_tasks_title => 'No tasks found for selected filters.';

  @override
  String get update_task => 'Update Task';

  @override
  String get title => 'Title';

  @override
  String get due_date_time => 'Due Date and Time';

  @override
  String get assign_to => 'Assign To';

  @override
  String get complete => 'Complete';

  @override
  String get no_description => 'No description.';

  @override
  String get overdue => 'Overdue';

  @override
  String get cancel => 'Cancel';

  @override
  String get leave => 'Leave';

  @override
  String get action_cannot_be_undone => 'This action cannot be undone.';

  @override
  String get duplicate_task => 'Duplicate Task';

  @override
  String get edit_task => 'Edit Task';

  @override
  String get delete_task => 'Delete Task';

  @override
  String get due_by => 'Due By';

  @override
  String get comments => 'Comments';

  @override
  String get comment => 'Comment';

  @override
  String get created_at => 'Created at';

  @override
  String get updated_at => 'Updated at';

  @override
  String get no_comments => 'No comments yet.';

  @override
  String get progression => 'Progression';

  @override
  String get one_month => '1 Month';

  @override
  String get three_months => '3 Months';

  @override
  String get six_months => '6 Months';

  @override
  String get one_year => '1 Year';

  @override
  String get completed_tasks => 'Completed';

  @override
  String get overdue_tasks => 'Overdue';

  @override
  String get total_tasks => 'Total';

  @override
  String get dashboard_upcoming_tasks => 'Upcoming Tasks';

  @override
  String get dashboard_overdue_tasks => 'Overdue Tasks';

  @override
  String get dashboard_highlights => 'Highlights';

  @override
  String get dashboard_showing_progression => 'Show Summaries';

  @override
  String get dashboard_showing_highlights => 'Show Highlights';

  @override
  String get checklist => 'Checklist';

  @override
  String get recurring => 'Recurring';

  @override
  String get recurrence_daily => 'Daily';

  @override
  String get recurrence_weekly => 'Weekly';

  @override
  String get recurrence_monthly => 'Monthly';

  @override
  String get ending_on => 'Ending On';

  @override
  String get never => 'Never';

  @override
  String get group_color => 'Group Color';

  @override
  String get group_color_red => 'Red';

  @override
  String get group_color_green => 'Green';

  @override
  String get group_color_blue => 'Blue';

  @override
  String get remove_color => 'Remove Color';

  @override
  String get select_color => 'Select Color';
}

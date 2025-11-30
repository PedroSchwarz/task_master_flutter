import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/users/data/models/user_response.dart';

class InviteUsersSheet extends StatefulWidget {
  const InviteUsersSheet({
    required this.users,
    required this.selectedUsersIds,
    required this.isUpdating,
    required this.onPressed,
    super.key,
  });

  final List<UserResponse> users;
  final List<String> selectedUsersIds;
  final bool isUpdating;
  final Function(List<String>) onPressed;

  @override
  State<InviteUsersSheet> createState() => _InviteUsersSheetState();
}

class _InviteUsersSheetState extends State<InviteUsersSheet> {
  List<UserResponse> _users = [];
  List<String> _selectedIds = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _users = widget.users;
        _selectedIds = widget.selectedUsersIds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.close),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .stretch,
          spacing: AppSpacing.s,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  AppSliverHeaderWrapper.floating(
                    padding: 0,
                    child: Container(
                      padding: const .all(AppSpacing.s),
                      color: theme.scaffoldBackgroundColor,
                      child: AppTextField(
                        label: localization.search_user,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            setState(() {
                              _users = widget.users;
                            });
                          } else {
                            setState(() {
                              _users = widget.users
                                  .where(
                                    (element) =>
                                        element.firstName
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        element.lastName.toLowerCase().contains(
                                          value.toLowerCase(),
                                        ) ||
                                        element.email.toLowerCase().contains(
                                          value.toLowerCase(),
                                        ),
                                  )
                                  .toList();
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, position) {
                      final user = _users[position];
                      final isSelected = _selectedIds.contains(user.id);

                      return CheckboxListTile(
                        value: isSelected,
                        title: Text(user.completeName),
                        subtitle: Text(user.email),
                        secondary: CircleAvatar(child: Text(user.initials)),
                        checkboxShape: const CircleBorder(),
                        checkboxScaleFactor: 1.2,
                        selected: isSelected,
                        onChanged: (value) => toggleInvite(
                          user.id,
                          value: value,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const .symmetric(horizontal: AppSpacing.s),
              child: FilledButton(
                onPressed: () => widget.onPressed(_selectedIds),
                child: Text(
                  widget.isUpdating ? localization.update : localization.invite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleInvite(String userId, {required bool? value}) {
    if (value == true) {
      setState(() {
        _selectedIds = [..._selectedIds, userId];
      });
    } else {
      setState(() {
        _selectedIds = _selectedIds.where((id) => id != userId).toList();
      });
    }
  }
}

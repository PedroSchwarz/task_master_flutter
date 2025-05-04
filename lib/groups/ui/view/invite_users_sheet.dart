import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/users/data/models/user_response.dart';

class InviteUsersSheet extends StatefulWidget {
  const InviteUsersSheet({
    required this.users,
    required this.selectedUsersIds,
    required this.onPressed,
    super.key,
  });

  final List<UserResponse> users;
  final List<String> selectedUsersIds;
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpacing.s,
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  AppSliverHeaderWrapper.floating(
                    child: AppTextField(
                      label: 'Search user',
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            _users = widget.users;
                          });
                        } else {
                          setState(() {
                            _users =
                                widget.users
                                    .where(
                                      (element) =>
                                          element.firstName
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
                                          element.lastName
                                              .toLowerCase()
                                              .contains(value.toLowerCase()) ||
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
                  SliverList.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, position) {
                      final user = _users[position];
                      final isSelected = _selectedIds.contains(user.id);

                      return CheckboxListTile(
                        value: isSelected,
                        title: Text(user.firstName),
                        subtitle: Text('${user.lastName} - ${user.email}'),
                        secondary: CircleAvatar(
                          child: Text(
                            '${user.firstName.substring(0, 1)}${user.lastName.substring(0, 1)}',
                          ),
                        ),
                        checkboxShape: const CircleBorder(),
                        checkboxScaleFactor: 1.2,
                        selected: isSelected,
                        onChanged: (value) {
                          if (value == true) {
                            setState(() {
                              _selectedIds = [..._selectedIds, user.id];
                            });
                          } else {
                            setState(() {
                              _selectedIds =
                                  _selectedIds
                                      .where((id) => id != user.id)
                                      .toList();
                            });
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.s),
              child: FilledButton(
                onPressed: () => widget.onPressed(_selectedIds),
                child: const Text('Invite'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

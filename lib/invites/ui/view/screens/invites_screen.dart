import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task_master/app/app.dart';
import 'package:task_master/invites/invites.dart';
import 'package:task_master/invites/ui/view/components/invite_item.dart';

class InvitesScreen extends StatefulWidget {
  const InvitesScreen({super.key});

  static const String routeName = 'invites';

  @override
  State<InvitesScreen> createState() => _InvitesScreenState();
}

class _InvitesScreenState extends State<InvitesScreen> {
  final bloc = getIt<InvitesCubit>();

  @override
  void initState() {
    super.initState();
    bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = context.localization;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, _) => [
          SliverAppBar.medium(
            title: Text(localization.invites),
            bottom: PreferredSize(
              preferredSize: const Size(0, AppSpacing.s),
              child: BlocSelector<InvitesCubit, InvitesState, bool>(
                bloc: bloc,
                selector: (state) => state.isLoading || state.isRefreshing,
                builder: (context, isLoading) => isLoading
                    ? const LinearProgressIndicator()
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
        body: BlocBuilder<InvitesCubit, InvitesState>(
          bloc: bloc,
          buildWhen: (previous, current) =>
              previous.invites != current.invites || //
              previous.isLoading != current.isLoading,
          builder: (context, state) {
            if (state.isLoading) {
              return ListView.separated(
                padding: const .all(AppSpacing.s),
                itemCount: 10,
                itemBuilder: (_, _) {
                  return const AppSkeleton(
                    isLoading: true,
                    child: SizedBox(height: 100, width: .infinity),
                  );
                },
                separatorBuilder: (_, _) => const Gap(AppSpacing.s),
              );
            }

            if (state.invites.isEmpty) {
              return Center(
                child: Text(
                  localization.empty_invites_description,
                  style: theme.textTheme.titleLarge,
                ),
              );
            }

            return ListView.separated(
              padding: const .only(
                top: AppSpacing.s,
                bottom: AppSpacing.max,
              ),
              itemCount: state.invites.length,
              itemBuilder: (_, position) {
                return InviteItem(
                  invite: state.invites[position],
                  onAccepted: bloc.acceptInvite,
                  onRejected: bloc.rejectInvite,
                );
              },
              separatorBuilder: (_, _) => const Divider(),
            );
          },
        ),
      ),
    );
  }
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get login => 'Entrar';

  @override
  String get register => 'Registrar';

  @override
  String get first_name => 'Nome';

  @override
  String get last_name => 'Sobrenome';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get confirm_password => 'Confirmar Senha';

  @override
  String get invalid_email => 'E-mail inválido';

  @override
  String get invalid_password => 'Senha inválida';

  @override
  String get invalid_confirm_password => 'As senhas não coincidem';

  @override
  String get access_account => 'Acessar Conta';

  @override
  String get create_new_account => 'Criar Nova Conta';

  @override
  String get login_generic_error => 'Não foi possível fazer login.';

  @override
  String get login_user_not_found_error => 'Conta não encontrada.';

  @override
  String get register_generic_error => 'Não foi possível criar uma conta.';

  @override
  String get register_email_conflict_error => 'E-mail já em uso.';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get sign_out => 'Sair';

  @override
  String get create_group => 'Criar Grupo';

  @override
  String get filter_assigned => 'Atribuídas';

  @override
  String get filter_owned => 'Criadas';

  @override
  String get completion_summary => 'Resumo de Conclusão';

  @override
  String get overdue_summary => 'Resumo de Atrasos';

  @override
  String get priority_summary => 'Resumo de Prioridade';

  @override
  String get status_summary => 'Resumo de Status';

  @override
  String get groups => 'Grupos';

  @override
  String get empty_groups_title => 'Você não pertence a um grupo ainda.';

  @override
  String get empty_groups_description_1 =>
      'Para criar um novo grupo basta apertar o botão';

  @override
  String get empty_groups_description_2 =>
      'ou ser convidado para um já existente.';

  @override
  String get invites => 'Convites';

  @override
  String get empty_invites_description => 'Sem convites for agora.';

  @override
  String get invited_by => 'Convidado por:';

  @override
  String get update_group => 'Editar Grupo';

  @override
  String get name => 'Nome';

  @override
  String get description => 'Descrição';

  @override
  String get group_invite_members => 'Convidar pessoas';

  @override
  String get group_manage_members => 'Gerenciar membros';

  @override
  String group_members_selected(int count) {
    return '$count selecionados';
  }

  @override
  String get search_user => 'Procurar usuários';

  @override
  String get invite => 'Convidar';

  @override
  String get create => 'Criar';

  @override
  String get update => 'Atualizar';

  @override
  String get delete => 'Deletar';

  @override
  String get details => 'Detalhes';

  @override
  String get actions => 'Ações';

  @override
  String get members => 'Membros';

  @override
  String get leave_group => 'Sair do Grupo';

  @override
  String get create_task => 'Criar Tarefa';

  @override
  String get tasks_list_view => 'Tipo de Visualização';

  @override
  String get calendar => 'Calendário';

  @override
  String get list => 'Lista';

  @override
  String get assignee => 'Responsável';

  @override
  String get all => 'Todos';

  @override
  String get myself => 'Eu';

  @override
  String get others => 'Outros';

  @override
  String get completion => 'Conclusão';

  @override
  String get pending => 'Pendente';

  @override
  String get completed => 'Concluído';

  @override
  String get status => 'Status';

  @override
  String get to_do => 'A Fazer';

  @override
  String get in_progress => 'Em Progresso';

  @override
  String get done => 'Feito';

  @override
  String get priority => 'Prioridade';

  @override
  String get low => 'Baixa';

  @override
  String get medium => 'Média';

  @override
  String get high => 'Alta';

  @override
  String get sort_date => 'Ordenar por Data';

  @override
  String get newest => 'Mais Recentes';

  @override
  String get oldest => 'Mais Antigos';

  @override
  String get sort_priority => 'Ordenar por Prioridade';

  @override
  String get none => 'Nenhuma';

  @override
  String get highest => 'Maior';

  @override
  String get lowest => 'Menor';

  @override
  String get reset => 'Redefinir';

  @override
  String get empty_tasks_title => 'Nenhuma tarefa criada ainda.';

  @override
  String get empty_tasks_description_1 =>
      'Crie uma nova tarefa apertando o botão';

  @override
  String get empty_tasks_description_2 => '.';

  @override
  String get empty_filtered_tasks_title =>
      'Nehuma tarefa encontrada para os filtros selecionados.';

  @override
  String get update_task => 'Editar Tarefa';

  @override
  String get title => 'Título';

  @override
  String get due_date_time => 'Data e Hora de Vencimento';

  @override
  String get assign_to => 'Atribuir Para';

  @override
  String get complete => 'Completar';

  @override
  String get no_description => 'Sem descrição.';

  @override
  String get overdue => 'Vencida';

  @override
  String get cancel => 'Cancelar';

  @override
  String get leave => 'Sair';

  @override
  String get action_cannot_be_undone => 'Essa ação não pode ser desfeita.';

  @override
  String get duplicate_task => 'Duplicar Tarefa';

  @override
  String get edit_task => 'Editar Tarefa';

  @override
  String get delete_task => 'Deletar Tarefa';

  @override
  String get due_by => 'Vence em';

  @override
  String get comments => 'Comentários';

  @override
  String get comment => 'Comentário';

  @override
  String get created_at => 'Criada em';

  @override
  String get updated_at => 'Atualizada em';

  @override
  String get no_comments => 'Sem comentários ainda.';

  @override
  String get progression => 'Progresso';

  @override
  String get one_month => '1 Mês';

  @override
  String get three_months => '3 Meses';

  @override
  String get six_months => '6 Meses';

  @override
  String get one_year => '1 Ano';

  @override
  String get completed_tasks => 'Concluídas';

  @override
  String get overdue_tasks => 'Vencidas';

  @override
  String get total_tasks => 'Total';

  @override
  String get dashboard_upcoming_tasks => 'Tarefas a Vencer';

  @override
  String get dashboard_overdue_tasks => 'Tarefas Vencidas';

  @override
  String get dashboard_highlights => 'Destaques';

  @override
  String get dashboard_showing_progression => 'Mostrar Resumos';

  @override
  String get dashboard_showing_highlights => 'Mostrar Destaques';

  @override
  String get checklist => 'Checklist';

  @override
  String get recurring => 'Recorrente';

  @override
  String get recurrence_daily => 'Diariamente';

  @override
  String get recurrence_weekly => 'Semanalmente';

  @override
  String get recurrence_monthly => 'Mensalmente';

  @override
  String get ending_on => 'Termina em';

  @override
  String get never => 'Nunca';

  @override
  String get group_color => 'Cor do Grupo';

  @override
  String get group_color_red => 'Vermelho';

  @override
  String get group_color_green => 'Verde';

  @override
  String get group_color_blue => 'Azul';

  @override
  String get remove_color => 'Remover Cor';

  @override
  String get select_color => 'Selecionar Cor';
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_property_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_property/owner_property_bloc.dart';
import 'package:sewain/presentasion/owner/property/owner_property_detail_page.dart';
import 'package:sewain/presentasion/owner/property/owner_property_form_page.dart';

class OwnerPropertyPage extends StatefulWidget {
  const OwnerPropertyPage({super.key});

  @override
  State<OwnerPropertyPage> createState() => _OwnerPropertyPageState();
}

class _OwnerPropertyPageState extends State<OwnerPropertyPage> {
  String? selectedType;

  @override
  void initState() {
    super.initState();
    _getProperties();
  }

  void _getProperties() {
    context.read<OwnerPropertyBloc>().add(
      OwnerPropertyEvent.getList(type: selectedType),
    );
  }

  Future<void> _refresh() async => _getProperties();

  void _changeType(String? type) {
    setState(() => selectedType = type);
    _getProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          final result = await context.push(const OwnerPropertyFormPage());
          if (result == true && mounted) _getProperties();
        },
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _filter(),
            Expanded(
              child: BlocConsumer<OwnerPropertyBloc, OwnerPropertyState>(
                listener: (context, state) {
                  state.maybeWhen(
                    success: (message) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(message)));
                      _getProperties();
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    listLoaded: (items) {
                      if (items.isEmpty) {
                        return _emptyState();
                      }

                      return RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return _propertyCard(items[index]);
                          },
                        ),
                      );
                    },
                    error: (message) => Center(
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.red),
                      ),
                    ),
                    orElse: () => const SizedBox(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Properti Saya',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filter() {
    final filters = [
      {'label': 'Semua', 'value': null},
      {'label': 'Kos', 'value': 'kos'},
      {'label': 'Kontrakan', 'value': 'kontrakan'},
      {'label': 'Apartemen', 'value': 'apartemen'},
    ];

    return SizedBox(
      height: 46,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SpaceWidth(8),
        itemBuilder: (context, index) {
          final item = filters[index];
          final label = item['label'] as String;
          final value = item['value'] as String?;
          final selected = selectedType == value;

          return InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => _changeType(value),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.stroke,
                ),
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: selected ? AppColors.white : AppColors.gray,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _propertyCard(OwnerPropertyModel item) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () async {
        if (item.id != null) {
          final result = await context.push(
            OwnerPropertyDetailPage(id: item.id!),
          );
          if (result == true && mounted) _getProperties();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.stroke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.12),
                  child: const Icon(
                    Icons.home_work_outlined,
                    color: AppColors.primary,
                  ),
                ),
                const SpaceWidth(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name ?? '-',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SpaceHeight(4),
                      Text(
                        '${item.typeLabel} • ${item.city ?? '-'}',
                        style: const TextStyle(
                          color: AppColors.gray,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _statusBadge(item),
              ],
            ),
            const SpaceHeight(16),
            Row(
              children: [
                Expanded(child: _miniStat('Kamar', '${item.roomsCount}')),
                Expanded(
                  child: _miniStat('Terisi', '${item.occupiedRoomsCount}'),
                ),
                Expanded(
                  child: _miniStat('Kosong', '${item.availableRoomsCount}'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniStat(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
          const SpaceHeight(4),
          Text(
            title,
            style: const TextStyle(color: AppColors.gray, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(OwnerPropertyModel item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: item.isActive
            ? AppColors.primary.withOpacity(0.12)
            : AppColors.gray.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        item.statusLabel,
        style: TextStyle(
          color: item.isActive ? AppColors.primary : AppColors.gray,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _emptyState() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          SpaceHeight(120),
          Icon(Icons.home_work_outlined, size: 80, color: AppColors.gray),
          SpaceHeight(16),
          Text(
            'Belum Ada Properti',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SpaceHeight(8),
          Text(
            'Tambahkan properti pertama kamu.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.gray),
          ),
        ],
      ),
    );
  }
}

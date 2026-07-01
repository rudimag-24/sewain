import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewain/core/core.dart';
import 'package:sewain/data/models/response/owner/owner_report_response_model.dart';
import 'package:sewain/presentasion/bloc/owner_report/owner_report_bloc.dart';

class OwnerReportPage extends StatefulWidget {
  const OwnerReportPage({super.key});

  @override
  State<OwnerReportPage> createState() => _OwnerReportPageState();
}

class _OwnerReportPageState extends State<OwnerReportPage> {
  @override
  void initState() {
    super.initState();
    _getReport();
  }

  void _getReport() {
    context.read<OwnerReportBloc>().add(const OwnerReportEvent.getReport());
  }

  Future<void> _refresh() async {
    _getReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(title: const Text('Laporan')),
      body: BlocBuilder<OwnerReportBloc, OwnerReportState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (data) {
              return RefreshIndicator(
                onRefresh: _refresh,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    _occupancyCard(data.occupancy),
                    const SpaceHeight(16),
                    _currentMonthCard(data.currentMonth),
                    const SpaceHeight(24),
                    const Text(
                      'Laporan 6 Bulan Terakhir',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SpaceHeight(12),
                    if (data.monthlyReport.isEmpty)
                      _emptyCard()
                    else
                      ...data.monthlyReport.map(_monthlyItem),
                  ],
                ),
              );
            },
            error: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.red),
                ),
              ),
            ),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }

  Widget _occupancyCard(OwnerReportOccupancyModel? occupancy) {
    final rate = occupancy?.occupancyRate ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tingkat Hunian',
            style: TextStyle(color: AppColors.white, fontSize: 14),
          ),
          const SpaceHeight(10),
          Text(
            '$rate%',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 38,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SpaceHeight(16),
          LinearProgressIndicator(
            value: (rate / 100).clamp(0, 1).toDouble(),
            backgroundColor: AppColors.white.withOpacity(0.25),
            color: AppColors.white,
            minHeight: 8,
            borderRadius: BorderRadius.circular(20),
          ),
          const SpaceHeight(18),
          Row(
            children: [
              Expanded(
                child: _headerMiniStat(
                  title: 'Total',
                  value: '${occupancy?.totalRooms ?? 0}',
                ),
              ),
              Expanded(
                child: _headerMiniStat(
                  title: 'Terisi',
                  value: '${occupancy?.occupiedRooms ?? 0}',
                ),
              ),
              Expanded(
                child: _headerMiniStat(
                  title: 'Kosong',
                  value: '${occupancy?.availableRooms ?? 0}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerMiniStat({required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SpaceHeight(4),
          Text(
            title,
            style: const TextStyle(color: AppColors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _currentMonthCard(OwnerReportCurrentMonthModel? current) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bulan Ini',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SpaceHeight(16),
          _row('Periode', current?.period ?? '-'),
          _row('Total Tagihan', '${current?.totalBills ?? 0}'),
          _row('Sudah Dibayar', current?.paidRp ?? 0.currencyFormatRp),
          _row('Belum Dibayar', current?.unpaidRp ?? 0.currencyFormatRp),
        ],
      ),
    );
  }

  Widget _monthlyItem(OwnerMonthlyReportModel item) {
    return Container(
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
          Text(
            item.period ?? '-',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          const SpaceHeight(12),
          Row(
            children: [
              Expanded(
                child: _smallBox(title: 'Income', value: item.incomeRp),
              ),
              const SpaceWidth(10),
              Expanded(
                child: _smallBox(title: 'Pending', value: item.pendingAmountRp),
              ),
            ],
          ),
          const SpaceHeight(12),
          _row('Total Tagihan', '${item.totalBills}'),
          _row('Lunas', '${item.paidBills}'),
          _row('Belum Bayar', '${item.unpaidBills}'),
        ],
      ),
    );
  }

  Widget _smallBox({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: AppColors.gray, fontSize: 11),
          ),
          const SpaceHeight(6),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: const TextStyle(color: AppColors.gray)),
          ),
          const SpaceWidth(12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.stroke),
      ),
      child: const Text(
        'Belum ada laporan bulanan.',
        style: TextStyle(color: AppColors.gray),
      ),
    );
  }
}

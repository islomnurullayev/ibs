import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibs/blocs/vancancies/vacancies.dart';
import 'package:ibs/model/vacancy.dart';
import 'package:ibs/screens/vacancies/vacancy.dart';
import 'package:ibs/theme/style.dart';

class VacanciesController extends StatefulWidget {
  const VacanciesController({Key? key}) : super(key: key);

  @override
  State<VacanciesController> createState() => _VacanciesControllerState();
}

class _VacanciesControllerState extends State<VacanciesController> {
  @override
  void initState() {
    super.initState();
    context.read<VacanciesCubit>().fetchVacancies();
  }

  void openVacancy(VacancyModel vacancy) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => VacancyController(vacancy: vacancy)),
    );
  }

  List<String> roles = [
    "Dasturchi",
    "Dizayner",
    "3D dizayner",
  ];

  List<Color> roleColors = [
    Style.colors.blue,
    Style.colors.pink,
    Style.colors.yellow,
  ];

  Color backgroundColor(String role) {
    late Color color;
    switch (role) {
      case "coder":
        color = Style.colors.blue;
        break;
      case "designer":
        color = Style.colors.pink;
        break;
      case "3d":
        color = Style.colors.yellow;
        break;
      default:
        color = Style.colors.blue;
    }
    return color;
  }

  Widget get roleList => SizedBox(
        height: 30,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            padding: Style.padding4,
            decoration: BoxDecoration(
              color: roleColors[index],
              borderRadius: Style.border20,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.none,
                child: Text(
                  roles[index],
                  style: Style.caption!.copyWith(
                    color: index == 2 ? Style.colors.black : Style.colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          separatorBuilder: (_, index) => const SizedBox(width: 10),
          itemCount: 3,
        ),
      );

  Widget header(VacanciesState state, int index) => Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: Style.border10,
              color: backgroundColor(state.data![index].role),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(state.data![index].employer, style: Style.body1),
              const SizedBox(height: 5),
              Text(
                state.data![index].address,
                style: Style.caption,
              ),
            ],
          ),
          const Spacer(),
          Text(
            state.data![index].type,
            style: Style.caption,
          ),
        ],
      );

  Widget get vacancies => BlocBuilder<VacanciesCubit, VacanciesState>(
        builder: (context, state) {
          return state.fetching
              ? const CupertinoActivityIndicator()
              : ListView.separated(
                  separatorBuilder: (_, index) => const SizedBox(height: 10),
                  itemCount: state.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () => openVacancy(state.data![index]),
                    child: Card(
                      elevation: 2,
                      shape:
                          RoundedRectangleBorder(borderRadius: Style.border10),
                      child: Container(
                        padding: Style.padding16,
                        decoration: BoxDecoration(
                          borderRadius: Style.border10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            header(state, index),
                            const SizedBox(height: 10),
                            Text(
                              state.data![index].vacancy,
                              style: Style.body1.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              state.data![index].salary,
                              style: Style.body2,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  state.data![index].daysAgo,
                                  style: Style.body2,
                                ),
                                const Spacer(),
                                Container(
                                  width: 60,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: Style.border8,
                                    color: Style.colors.primary,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        },
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          padding: Style.padding16,
          physics: const ClampingScrollPhysics(),
          children: [
            Text(
              "Vakansiyalar!",
              maxLines: 2,
              style: Style.headline5!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            roleList,
            const SizedBox(height: 20),
            vacancies
          ],
        ),
      ),
    );
  }
}

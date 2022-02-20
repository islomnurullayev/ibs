import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ibs/model/vacancy.dart';
import 'package:ibs/theme/style.dart';
import 'dart:async';

class VacancyController extends StatefulWidget {
  final VacancyModel vacancy;
  const VacancyController({Key? key, required this.vacancy}) : super(key: key);

  @override
  State<VacancyController> createState() => _VacancyControllerState();
}

class _VacancyControllerState extends State<VacancyController> {
  double? latitude;
  double? longitude;
  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = <Marker>{};

  @override
  void initState() {
    super.initState();
    latitude = widget.vacancy.lat;
    longitude = widget.vacancy.long;
    markers.add(
      Marker(
        markerId: MarkerId(LatLng(latitude!, longitude!).toString()),
        position: LatLng(latitude!, longitude!),
        infoWindow: InfoWindow(
          title: widget.vacancy.address,
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

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

  Widget get map => Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: Style.border10),
        child: SizedBox(
          height: 200,
          child: longitude == null
              ? const Center(child: CupertinoActivityIndicator())
              : ClipRRect(
                  borderRadius: Style.border10,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    scrollGesturesEnabled: false,
                    onMapCreated: mapController.complete,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(latitude!, longitude!),
                      zoom: 18,
                    ),
                    markers: markers,
                  ),
                ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: Style.colors.black,
        trailing: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: Style.colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                child: Image.asset("assets/images/logo.png"),
                padding: Style.padding8,
              )
            ],
          ),
        ),
      ),
      child: ListView(
        padding: Style.padding16,
        physics: const ClampingScrollPhysics(),
        children: [
          Row(
            children: [
              Text(
                widget.vacancy.vacancy,
                style: Style.headline5!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: Style.border10,
                  color: backgroundColor(widget.vacancy.role),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.vacancy.salary,
            style: Style.body1.copyWith(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.vacancy.employer,
            style: Style.caption!.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.vacancy.address,
            style: Style.caption!.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Divider(thickness: 1, color: Style.colors.black),
          const SizedBox(height: 10),
          Text(
            "Talab qilinadigan ish tajribasi: ${widget.vacancy.minExp}",
            style: Style.caption!.copyWith(fontSize: 14),
          ),
          Text(
            widget.vacancy.workingTime,
            style: Style.caption!.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 10),
          Text(
            "Vazifalar:",
            style: Style.caption!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.vacancy.obligation,
            style: Style.caption!.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            "Talablar:",
            style: Style.caption!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.vacancy.requirements,
            style: Style.caption!.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 20),
          Text(
            "Manzil:",
            style: Style.caption!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.vacancy.address + " Buyuk Turon, 23-uy",
            style: Style.caption!.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 10),
          map,
          const SizedBox(height: 20),
          Text(
            widget.vacancy.phone,
            style: Style.caption!.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            widget.vacancy.name,
            style: Style.caption!.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            widget.vacancy.telegram,
            style: Style.caption!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

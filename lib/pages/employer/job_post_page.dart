import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:dockwalker/controllers/employer/job_post_controller.dart';
import 'package:get/get.dart';
import 'package:dockwalker/utils/AppColors.dart';

class JobPostPage extends StatefulWidget {
  const JobPostPage({super.key});

  @override
  State<JobPostPage> createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {

  final JobPostController controller = Get.put(JobPostController());
  final HomeService homeService = Get.find<HomeService>();

  String _selectedCurrency = 'EUR';
  String _selectedPeriod = 'week';
  bool _isUrgent = false;
  bool _isFeatured = false;
  DateTime _startDate = DateTime(2024, 2, 1);
  String _duration = 'Permanent';

  // Dummy data


  static ThemeData _buildPageTheme(BuildContext context) {
    // Get the default theme or the parent theme and copy/override it
    return Theme.of(context).copyWith(
      // primaryColor: const Color(0xFF1E88E5),
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ).copyWith(
        secondary: AppColors.secondary,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFFEEEEEE), // Light gray background for fields
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          backgroundColor: const Color(0xFF1E88E5),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _buildPageTheme(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          title: const Text( 'Post New Job' ),
          centerTitle: true,
        ),
        body: Obx(()=> SafeArea(
          child: controller.homeService.urlloading.value == true ?
          Center(child: CircularProgressIndicator()) :
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildSectionTitle('Basic Information'),
                        const SizedBox(height: 8),

                        Text('Job Title *', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        _buildTextFormField(
                            tlabel: "Job Title",
                            tController: controller.titleController,
                            tvalidator: controller.textValidation
                        ),
                        const SizedBox(height: 8),

                        Text('Department *', style: TextStyle(fontWeight: FontWeight.w600)),
                        _buildDepartmentChips(),
                        const SizedBox(height: 16),

                        Text('Yacht Name *', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        _buildTextFormField(
                            tlabel: 'Yacht Name',
                            tController: controller.yachtController,
                            tvalidator: controller.textValidation
                        ),

                        Text('Location *', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        _buildTextFormField(
                          tlabel: 'Location',
                          tController: controller.locationController,
                          tvalidator: controller.textValidation,
                          prefixIcon: Icons.location_pin,
                        ),

                        _buildSectionTitle('Compensation'),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Min Salary *', style: TextStyle(fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),
                                  _buildTextFormField(
                                      tlabel: 'Min Salary',
                                      tController: controller.salaryMinController,
                                      tvalidator: controller.textValidation,
                                      keyboardType: TextInputType.number
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Max Salary *', style: TextStyle(fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 8),
                                  _buildTextFormField(
                                      tlabel: 'Max Salary',
                                      tController: controller.salaryMaxController,
                                      tvalidator: controller.textValidation,
                                      keyboardType: TextInputType.number
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        Text('Currency *', style: TextStyle(fontWeight: FontWeight.w600)),
                        _buildCurrencyChips(),
                        const SizedBox(height: 16),

                        Text('Period *', style: TextStyle(fontWeight: FontWeight.w600)),
                        _buildPeriodChips(),
                        const SizedBox(height: 16),

                        _buildSectionTitle('Job Detail'),
                        const SizedBox(height: 8),

                        Text('Description *', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        _buildTextFormField(
                            tlabel: 'Description',
                            tController: controller.descriptionController,
                            tvalidator: controller.textValidation,
                            minLine: 4,
                            maxLine: 6
                        ),

                        Text('Requirements *', style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('Separate each requirements with new line.', style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
                        const SizedBox(height: 8),
                        _buildTextFormField(
                            tlabel: 'Requirements',
                            tController: controller.requirementsController,
                            tvalidator: controller.textValidation,
                            minLine: 4,
                            maxLine: 6
                        ),

                        Text('Start Date *', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        _buildStartDateField(
                            tlabel: 'Start Date',
                            tController: controller.startDateController,
                            tvalidator: controller.textValidation,
                            prefixIcon: Icons.calendar_today,
                            textEditingController: controller.startDateController
                        ),

                        Text('Deadline *', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        _buildStartDateField(
                            tlabel: 'Deadline',
                            tController: controller.deadlineController,
                            tvalidator: controller.textValidation,
                            prefixIcon: Icons.calendar_today,
                            textEditingController: controller.deadlineController
                        ),

                        Text('Duration *', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        _buildTextFormField(
                            tlabel: 'Duration',
                            tController: controller.durationController,
                            tvalidator: controller.textValidation,
                            prefixIcon: Icons.alarm
                        ),

                        Text('Vacancies *', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        _buildTextFormField(
                            tlabel: 'Vacancies',
                            tController: controller.vacanciesController,
                            tvalidator: controller.textValidation,
                            keyboardType: TextInputType.number
                        ),

                        Text('Required Experience *', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        _buildDropdownField(
                          tlabel: 'Required Experience',
                          selectedValue: controller.selectedExperience.value,
                          items: controller.masterJobExperience.value,
                          prefixIcon: Icons.work_outline,
                          tvalidator: (value) {
                            if (value == null || value.isEmpty) return "Please select a experience";
                            return null;
                          },
                          onChanged: (value) {
                            controller.selectedExperience.value = value ?? "";
                          },
                        ),

                        Text('Visa *', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        _buildDropdownField(
                          tlabel: 'Visa',
                          selectedValue: controller.selectedVisa.value,
                          items: controller.masterJobVisa.value,
                          prefixIcon: Icons.work_outline,
                          tvalidator: (value) {
                            if (value == null || value.isEmpty) return "Please select a visa";
                            return null;
                          },
                          onChanged: (value) {
                            controller.selectedVisa.value = value ?? "";
                          },
                        ),

                        _buildSectionTitle('Visibility Options'),
                        const SizedBox(height: 8),

                        _buildVisibilityOption(
                          title: 'Mark as Urgent',
                          subtitle: 'Highlight this job to attract more attention',
                          value: controller.isUrgent.value,
                          onChanged: (val) => setState(() => controller.isUrgent.value = val),
                        ),
                        _buildVisibilityOption(
                          title: 'Feature this Job',
                          subtitle: 'Display prominently in search results',
                          value: controller.isFeatured.value,
                          onChanged: (val) => setState(() => controller.isFeatured.value = val),
                        )
                      ],
                    ),
                  )
                ),
              ),
              // --- Sticky Footer/Action Buttons ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        bool success = await controller.postNewJob();
                        if (success) { Navigator.pop(context); }
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white
                      ),
                      child: const Text('Post Job'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () { Get.back(); },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: BorderSide(color: AppColors.secondary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: AppColors.primary,
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      )
    );
  }

  // Helper widget for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text( title, style: const TextStyle( fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87 ) ),
    );
  }

  Widget _buildTextFormField({
    required String tlabel,
    required TextEditingController tController,
    required FormFieldValidator<String> tvalidator,
    int maxLine= 4,
    int minLine = 1,
    TextInputType? keyboardType,
    IconData? prefixIcon}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: tController,
        validator: tvalidator,
        maxLines: maxLine,
        minLines: minLine,
        keyboardType: keyboardType != null ? keyboardType : TextInputType.text,
        decoration: InputDecoration(
          labelText: tlabel,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey.shade400,) : null,
          labelStyle: const TextStyle( color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: .1, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: .1, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildStartDateField({
    required String tlabel,
    required TextEditingController tController,
    required FormFieldValidator<String> tvalidator,
    int maxLine= 4,
    int minLine = 1,
    TextInputType? keyboardType,
    TextEditingController? textEditingController,
    IconData? prefixIcon}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: tController,
        validator: tvalidator,
        maxLines: maxLine,
        minLines: minLine,
        keyboardType: keyboardType != null ? keyboardType : TextInputType.text,
        readOnly: true,
        onTap: () { controller.selectDate(textEditingController!); },
        decoration: InputDecoration(
          labelText: tlabel,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey.shade400,) : null,
          labelStyle: const TextStyle( color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: .1, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: .1, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String tlabel,
    required String? selectedValue,
    required List<String> items,
    required FormFieldValidator<String> tvalidator,
    required ValueChanged<String?> onChanged,
    IconData? prefixIcon,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        validator: tvalidator,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: tlabel,
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey.shade400)
              : null,
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.1, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 0.1, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 1, color: Colors.red),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDepartmentChips() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: controller.masterJobDepartment.map((department) {
        final isSelected = department == controller.selectedDepartment.value;
        return FilterChip(
          label: Text(department),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              controller.selectedDepartment.value = selected ? department : null;
            });
          },
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          selectedColor: AppColors.primary,
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        );
      }).toList(),
    );
  }

  Widget _buildCurrencyChips() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: controller.masterJobCurrency.map((department) {
        final isSelected = department == controller.selectedCurrency.value;
        return FilterChip(
          label: Text(department),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              controller.selectedCurrency.value = selected ? department : null;
            });
          },
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          selectedColor: AppColors.primary, // Primary blue
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        );
      }).toList(),
    );
  }

  Widget _buildPeriodChips() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: controller.masterJobPeriod.map((department) {
        final isSelected = department == controller.selectedPeriod.value;
        return FilterChip(
          label: Text(department),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              controller.selectedPeriod.value = selected ? department : null;
            });
          },
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          selectedColor: AppColors.primary, // Primary blue
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        );
      }).toList(),
    );
  }

  // Helper widget for currency/period toggles
  Widget _buildSegmentedToggle({
    required List<dynamic> options,
    required String selectedValue,
    required ValueChanged<String> onChanged,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              final isSelected = option == selectedValue;
              return GestureDetector(
                onTap: () => onChanged(option),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1E88E5) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    option.toUpperCase(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Helper widget for text fields
  Widget _buildTextField({
    required String label,
    String hint = '',
    int maxLines = 1,
    Widget? prefixIcon,
    String? initialValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              children: label.endsWith('*')
                  ? [
                const TextSpan(
                  text: '',
                  style: TextStyle(color: Colors.red),
                )
              ]
                  : null,
            ),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            hintStyle: TextStyle(color: Colors.grey[500]),
          ),
        ),
        if (label == 'Requirements *')
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Separate each requirement with a new line',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          )
      ],
    );
  }

  // Builds the date and duration selection section
  Widget _buildDateAndDuration() {
    return Row(
      children: [
        Expanded(
          child: _buildDateInput(
            label: 'Start Date *',
            icon: Icons.calendar_today_outlined,
            value: _startDate,
            onTap: () async {
              // Placeholder for Date Picker logic
              final picked = await showDatePicker(
                context: context,
                initialDate: _startDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
              );
              if (picked != null && picked != _startDate) {
                setState(() {
                  _startDate = picked;
                });
              }
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDateInput(
            label: 'Duration *',
            icon: Icons.timer_outlined,
            valueText: _duration,
            onTap: () {
              // This is a static value 'Permanent' in the image,
              // but for realism, it should be a selector.
            },
          ),
        ),
      ],
    );
  }

  // Helper for Start Date and Duration input fields
  Widget _buildDateInput({
    required String label,
    IconData? icon,
    DateTime? value,
    String? valueText,
    VoidCallback? onTap,
  }) {
    final displayValue = valueText ?? (value != null ? '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}' : 'Select Date');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(icon, color: Colors.grey),
                  ),
                Expanded(
                  child: Text(
                    displayValue,
                    style: TextStyle(
                      color: valueText == 'Permanent' ? Colors.black87 : Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Builds a visibility option row (e.g., Mark as Urgent)
  Widget _buildVisibilityOption({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            inactiveTrackColor: const Color(0xFFE0E0E0),
            inactiveThumbColor: const Color(0xFF9E9E9E),
            activeColor: AppColors.primary, // Primary blue
          ),
        ],
      ),
    );
  }

}

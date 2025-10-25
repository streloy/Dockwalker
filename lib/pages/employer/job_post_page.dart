import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';

class JobPostPage extends StatefulWidget {
  const JobPostPage({super.key});

  @override
  State<JobPostPage> createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {

  final HomeService homeService = Get.find<HomeService>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? _selectedDepartment = 'Interior';
  String _selectedCurrency = 'EUR';
  String _selectedPeriod = 'week';
  bool _isUrgent = false;
  bool _isFeatured = false;
  DateTime _startDate = DateTime(2024, 2, 1);
  String _duration = 'Permanent';

  // Dummy data
  final List<String> _departments = ['Interior', 'Deck', 'Galley', 'Engineering', 'Stewardess', 'Chef'];
  final List<String> _currencies = ['EUR', 'USD', 'GBP'];
  final List<String> _periods = ['day', 'week', 'month'];

  static ThemeData _buildPageTheme(BuildContext context) {
    // Get the default theme or the parent theme and copy/override it
    return Theme.of(context).copyWith(
      primaryColor: const Color(0xFF1E88E5), // Blue 600 for primary
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
      ).copyWith(
        secondary: const Color(0xFF1E88E5), // Blue for accents
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
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // --- Basic Information Section ---
                      _buildSectionTitle('Basic Information'),
                      _buildTextField(label: 'Job Title *', hint: 'e.g., Chief Stewardess', initialValue: 'Chief Stewardess'),
                      const SizedBox(height: 16),
                      // Department
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4.0),
                        child: Text('Department *', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      _buildDepartmentChips(),
                      const SizedBox(height: 16),
                      // Yacht Name
                      _buildTextField(label: 'Yacht Name', hint: 'e.g., M/Y Serenity', initialValue: 'M/Y Serenity'),
                      const SizedBox(height: 16),
                      // Location
                      _buildTextField(
                        label: 'Location *',
                        hint: 'e.g., Monaco, Mediterranean',
                        prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey),
                        initialValue: 'e.g., Monaco, Mediterranean',
                      ),
                      const SizedBox(height: 16),

                      // --- Compensation Section ---
                      _buildSectionTitle('Compensation'),
                      // Min/Max Salary
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(label: 'Min Salary *', hint: '\$ 5000', initialValue: '5000'),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(label: 'Max Salary *', hint: '\$ 7000', initialValue: '7000'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Currency and Period Toggles
                      Column(
                        children: [
                          // Currency Toggle
                          _buildSegmentedToggle(
                            options: _currencies,
                            selectedValue: _selectedCurrency,
                            onChanged: (val) => setState(() => _selectedCurrency = val),
                            label: 'Currency',
                          ),
                          const SizedBox(height: 16),
                          // Period Toggle
                          _buildSegmentedToggle(
                            options: _periods,
                            selectedValue: _selectedPeriod,
                            onChanged: (val) => setState(() => _selectedPeriod = val),
                            label: 'Period',
                          ),
                        ],
                      ),

                      // --- Job Details Section ---
                      _buildSectionTitle('Job Details'),
                      // Description
                      _buildTextField(
                        label: 'Description *',
                        maxLines: 4,
                        hint: 'Describe the position, responsibilities, and what makes this opportunity unique...',
                      ),
                      const SizedBox(height: 16),
                      // Requirements
                      _buildTextField(
                        label: 'Requirements *',
                        maxLines: 5,
                        initialValue: 'STCW Basic Safety Training\nENG1 Medical Certificate\n3+ years experience...',
                      ),
                      const SizedBox(height: 16),

                      // Start Date & Duration
                      _buildDateAndDuration(),
                      const SizedBox(height: 16),

                      // --- Visibility Options Section ---
                      _buildSectionTitle('Visibility Options'),
                      // Mark as Urgent
                      _buildVisibilityOption(
                        title: 'Mark as Urgent',
                        subtitle: 'Highlight this job to attract more attention',
                        value: _isUrgent,
                        onChanged: (val) => setState(() => _isUrgent = val),
                      ),
                      // Feature this Job
                      _buildVisibilityOption(
                        title: 'Feature this Job',
                        subtitle: 'Display prominently in search results',
                        value: _isFeatured,
                        onChanged: (val) => setState(() => _isFeatured = val),
                      ),
                      const SizedBox(height: 80), // Extra space for the floating footer
                    ],
                  ),
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
                      onPressed: () {
                        // Logic to post the job
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Job Posted! (Action Placeholder)')),
                        );
                      },
                      child: const Text('Post Job'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        // Logic to cancel
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cancelled. (Action Placeholder)')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(color: Color(0xFF1E88E5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: const Color(0xFF1E88E5),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
    int minLine = 1 }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: tController,
        validator: tvalidator,
        maxLines: maxLine,
        minLines: minLine,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: tlabel,
          labelStyle: const TextStyle( color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2.0, color: Colors.red),
          ),
        ),
      ),
    );
  }

  // Helper widget for department chips/toggles
  Widget _buildDepartmentChips() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: _departments.map((department) {
        final isSelected = department == _selectedDepartment;
        return FilterChip(
          label: Text(department),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              _selectedDepartment = selected ? department : null;
            });
          },
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          backgroundColor: const Color(0xFFF5F5F5),
          selectedColor: const Color(0xFF1E88E5), // Primary blue
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
    required List<String> options,
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
            activeColor: const Color(0xFF1E88E5), // Primary blue
          ),
        ],
      ),
    );
  }

}

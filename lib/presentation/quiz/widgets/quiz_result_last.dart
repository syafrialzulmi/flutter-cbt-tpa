// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:flutter_cbt_tpa/data/models/responses/nilai_response_model.dart';
import 'package:flutter_cbt_tpa/presentation/quiz/models/quiz_model.dart';

import '../../../core/constants/colors.dart';
import 'result_value.dart';

class QuizResultLast extends StatelessWidget {
  final QuizModel data;
  final NilaiResponseModel dataNilai;

  const QuizResultLast({
    Key? key,
    required this.data,
    required this.dataNilai,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int correct = dataNilai.benar;
    int wrong = dataNilai.salah;
    int totalQuestion = correct + wrong;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hasil Tes Terakhir',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.14),
                blurRadius: 17,
                offset: const Offset(0, 8),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    ResultValue.correct(correct),
                    const SizedBox(height: 18.0),
                    ResultValue.wrong(wrong),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    CircularStepProgressIndicator(
                      totalSteps: totalQuestion,
                      currentStep: correct,
                      stepSize: 10,
                      selectedColor: AppColors.green,
                      unselectedColor: AppColors.primary,
                      padding: 0,
                      width: 140,
                      height: 140,
                      selectedStepSize: 24,
                      unselectedStepSize: 24,
                      roundedCap: (_, __) => true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

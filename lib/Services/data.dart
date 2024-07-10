import 'package:cloud_firestore/cloud_firestore.dart';

void addModulesToFirestore() {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> modules = [
    {
      'title': 'Basic Life Support (BLS) Certification',
      'category': 'Emergency Medicine',
      'difficulty': 'Intermediate',
      'description':
          'Learn the fundamentals of Basic Life Support, including CPR techniques and emergency response protocols.',
      'requirements': [
        'Pass the assessment',
      ],
      'isFavorite': false
    },
    {
      'title': 'Advanced Cardiac Life Support (ACLS)',
      'category': 'Cardiology',
      'difficulty': 'Advanced',
      'description':
          'Gain advanced skills in managing cardiac emergencies, including drug protocols and resuscitation techniques.',
      'requirements': [
        'Pass the assessment',
      ],
      'isFavorite': false
    },
    {
      'title': 'Infection Control Practices',
      'category': 'General Medicine',
      'difficulty': 'Beginner',
      'description':
          'Understand the best practices for infection control in healthcare settings, including PPE usage and hygiene protocols.',
      'requirements': [
        'Pass the assessment',
      ],
      'isFavorite': false
    },
    {
      'title': 'Pediatric Advanced Life Support (PALS)',
      'category': 'Pediatrics',
      'difficulty': 'Advanced',
      'description':
          'Learn to recognize and manage critically ill infants and children, including advanced resuscitation techniques.',
      'requirements': [
        'Pass the assessment',
      ],
      'isFavorite': false
    },
    {
      'title': 'Telemedicine Best Practices',
      'category': 'Telehealth',
      'difficulty': 'Intermediate',
      'description':
          'Explore the principles of effective telemedicine, including communication skills, technology use, and patient management.',
      'requirements': [
        'Pass the assessment',
      ],
      'isFavorite': false
    },
    {
      'title': 'Evidence-Based Medicine',
      'category': 'Research',
      'difficulty': 'Intermediate',
      'description':
          'Understand how to apply evidence-based practices to clinical decision-making and patient care.',
      'requirements': [
        'Pass the assessment',
      ],
      'isFavorite': false
    },
    {
      'title': 'Mental Health First Aid',
      'category': 'Psychiatry',
      'difficulty': 'Beginner',
      'description':
          'Learn the basics of identifying and supporting individuals with mental health issues.',
      'requirements': [
        'Pass the assessment',
      ],
      'isFavorite': false
    },
    {
      'title': 'Geriatric Care',
      'category': 'Geriatrics',
      'difficulty': 'Intermediate',
      'description':
          'Gain skills in managing the healthcare needs of elderly patients, including chronic disease management and palliative care.',
      'requirements': [
        'Pass the assessment',
      ],
      'isFavorite': false
    },
    {
      'title': 'Healthcare Leadership and Management',
      'category': 'Administration',
      'difficulty': 'Advanced',
      'description':
          'Develop leadership skills and learn management strategies for effective healthcare administration.',
      'requirements': [
        'Pass the assessment',
      ],
      'isFavorite': false
    },
    {
      'title': 'Digital Health Innovations',
      'category': 'Technology',
      'difficulty': 'Advanced',
      'description':
          'Explore the latest digital health technologies and their applications in improving patient care and healthcare delivery.',
      'requirements': [
        'Pass the assessment',
      ],
      'isFavorite': false
    },
  ];

  List<Map<String, dynamic>> assignments = [
    {
      'moduleId': 'module_id_1',
      'questions': [
        {
          'question': 'What does BLS stand for?',
          'options': [
            'Basic Life Support',
            'Basic Life Safety',
            'Basic Life Skills'
          ],
          'answer': 'Basic Life Support'
        },
        {
          'question': 'How often should you perform chest compressions?',
          'options': [
            '80-100 per minute',
            '100-120 per minute',
            '120-140 per minute'
          ],
          'answer': '100-120 per minute'
        },
        {
          'question': 'What is the first step in BLS?',
          'options': [
            'Check for responsiveness',
            'Start chest compressions',
            'Give rescue breaths'
          ],
          'answer': 'Check for responsiveness'
        },
        {
          'question': 'How deep should chest compressions be for adults?',
          'options': ['1-1.5 inches', '2-2.4 inches', '3-3.5 inches'],
          'answer': '2-2.4 inches'
        },
        {
          'question': 'What is the ratio of compressions to breaths in CPR?',
          'options': ['15:2', '30:2', '20:2'],
          'answer': '30:2'
        },
        {
          'question': 'When should you stop CPR?',
          'options': [
            'When the person shows signs of life',
            'After 5 minutes',
            'When you are tired'
          ],
          'answer': 'When the person shows signs of life'
        },
        {
          'question':
              'What should you do if the person is breathing normally but unresponsive?',
          'options': [
            'Start chest compressions',
            'Place them in the recovery position',
            'Leave them alone'
          ],
          'answer': 'Place them in the recovery position'
        },
        {
          'question': 'How do you open the airway in an unresponsive person?',
          'options': ['Jaw thrust', 'Head tilt-chin lift', 'Back blows'],
          'answer': 'Head tilt-chin lift'
        },
        {
          'question':
              'What should you do if the chest does not rise during rescue breaths?',
          'options': [
            'Try a different method',
            'Reposition the head and try again',
            'Give up'
          ],
          'answer': 'Reposition the head and try again'
        },
        {
          'question':
              'What device can provide an electric shock to a person in cardiac arrest?',
          'options': ['ECG', 'AED', 'CPAP'],
          'answer': 'AED'
        },
        {
          'question':
              'What is the recommended rate for chest compressions in adults?',
          'options': [
            '60-80 per minute',
            '80-100 per minute',
            '100-120 per minute'
          ],
          'answer': '100-120 per minute'
        },
        {
          'question':
              'Where should you place your hands for chest compressions?',
          'options': [
            'On the lower half of the breastbone',
            'On the upper half of the breastbone',
            'On the left side of the chest'
          ],
          'answer': 'On the lower half of the breastbone'
        },
        {
          'question':
              'What should you do if you are alone and find an unresponsive infant?',
          'options': [
            'Start CPR immediately',
            'Call 911 after 2 minutes of CPR',
            'Call 911 immediately'
          ],
          'answer': 'Call 911 after 2 minutes of CPR'
        },
        {
          'question':
              'How often should you switch chest compression providers?',
          'options': ['Every 2 minutes', 'Every 5 minutes', 'Every 10 minutes'],
          'answer': 'Every 2 minutes'
        },
        {
          'question':
              'What should you do if someone is choking but can still breathe?',
          'options': [
            'Perform abdominal thrusts',
            'Encourage them to cough',
            'Start chest compressions'
          ],
          'answer': 'Encourage them to cough'
        },
        {
          'question': 'What is the recommended compression depth for infants?',
          'options': ['1-1.5 inches', '1.5-2 inches', '2-2.4 inches'],
          'answer': '1.5-2 inches'
        },
        {
          'question':
              'How many hands should you use for chest compressions on an infant?',
          'options': ['One hand', 'Two hands', 'Two fingers'],
          'answer': 'Two fingers'
        },
        {
          'question': 'When using an AED, what is the first step?',
          'options': [
            'Place the pads on the chest',
            'Turn on the AED',
            'Give a shock'
          ],
          'answer': 'Turn on the AED'
        },
        {
          'question':
              'What is the recommended rate for chest compressions in infants?',
          'options': [
            '80-100 per minute',
            '100-120 per minute',
            '120-140 per minute'
          ],
          'answer': '100-120 per minute'
        },
        {
          'question': 'What should you do if the AED advises no shock?',
          'options': ['Continue CPR', 'Stop CPR', 'Wait for EMS'],
          'answer': 'Continue CPR'
        },
        {
          'question': 'How should you position a person for CPR?',
          'options': [
            'On their back on a firm surface',
            'On their side',
            'Sitting up'
          ],
          'answer': 'On their back on a firm surface'
        },
        {
          'question':
              'What is the first thing you should do when you find an unresponsive person?',
          'options': [
            'Call 911',
            'Check for responsiveness',
            'Start chest compressions'
          ],
          'answer': 'Check for responsiveness'
        },
        {
          'question':
              'What is the ratio of chest compressions to breaths for an infant?',
          'options': ['30:2', '15:2', '20:2'],
          'answer': '30:2'
        },
        {
          'question':
              'What should you do if an infant is choking and cannot breathe?',
          'options': [
            'Perform back slaps and chest thrusts',
            'Start CPR',
            'Call 911'
          ],
          'answer': 'Perform back slaps and chest thrusts'
        },
        {
          'question':
              'What is the maximum time you should take to check for a pulse?',
          'options': ['10 seconds', '20 seconds', '30 seconds'],
          'answer': '10 seconds'
        },
        {
          'question': 'Where should you check for a pulse in an adult?',
          'options': ['Carotid artery', 'Radial artery', 'Brachial artery'],
          'answer': 'Carotid artery'
        },
        {
          'question': 'Where should you check for a pulse in an infant?',
          'options': ['Carotid artery', 'Radial artery', 'Brachial artery'],
          'answer': 'Brachial artery'
        },
        {
          'question': 'How do you perform a head tilt-chin lift?',
          'options': [
            'Push down on the forehead and lift the chin',
            'Push up on the chin and tilt the head forward',
            'Push down on the chest and lift the chin'
          ],
          'answer': 'Push down on the forehead and lift the chin'
        },
        {
          'question': 'What should you do if you are unsure about giving CPR?',
          'options': [
            'Give CPR anyway',
            'Wait for EMS to arrive',
            'Check for breathing only'
          ],
          'answer': 'Give CPR anyway'
        },
        {
          'question':
              'What is the compression-to-ventilation ratio for 2-rescuer CPR on an adult?',
          'options': ['30:2', '15:2', '20:2'],
          'answer': '30:2'
        },
        {
          'question': 'How should you give rescue breaths?',
          'options': [
            'Blow hard and fast',
            'Blow gently and steadily',
            'Blow short and sharp breaths'
          ],
          'answer': 'Blow gently and steadily'
        },
      ]
    },
    {
      'moduleId': 'module_id_2',
      'questions': [
        {
          'question': 'What is the first step in ACLS?',
          'options': [
            'Start chest compressions',
            'Check patient responsiveness',
            'Administer epinephrine'
          ],
          'answer': 'Check patient responsiveness'
        },
        {
          'question': 'What drug is used in ACLS for bradycardia?',
          'options': ['Adenosine', 'Atropine', 'Amiodarone'],
          'answer': 'Atropine'
        },
        {
          'question': 'What is the recommended compression rate for adult CPR?',
          'options': [
            '80-100 compressions per minute',
            '100-120 compressions per minute',
            '120-140 compressions per minute'
          ],
          'answer': '100-120 compressions per minute'
        },
        {
          'question': 'What is the primary purpose of defibrillation?',
          'options': [
            'Start the heart',
            'Stop abnormal heart rhythm',
            'Increase heart rate'
          ],
          'answer': 'Stop abnormal heart rhythm'
        },
        {
          'question': 'Which rhythm is considered shockable in ACLS?',
          'options': [
            'Asystole',
            'Pulseless ventricular tachycardia',
            'Normal sinus rhythm'
          ],
          'answer': 'Pulseless ventricular tachycardia'
        },
        {
          'question':
              'Which drug is administered for ventricular fibrillation?',
          'options': ['Amiodarone', 'Atropine', 'Adenosine'],
          'answer': 'Amiodarone'
        },
        {
          'question':
              'How often should you administer epinephrine during cardiac arrest?',
          'options': [
            'Every 3-5 minutes',
            'Every 5-10 minutes',
            'Every 10-15 minutes'
          ],
          'answer': 'Every 3-5 minutes'
        },
        {
          'question':
              'What is the first dose of amiodarone for refractory VF/pulseless VT?',
          'options': ['150 mg', '300 mg', '450 mg'],
          'answer': '300 mg'
        },
        {
          'question': 'Which rhythm is NOT treated with defibrillation?',
          'options': [
            'Ventricular fibrillation',
            'Pulseless ventricular tachycardia',
            'Asystole'
          ],
          'answer': 'Asystole'
        },
        {
          'question':
              'What is the purpose of administering magnesium sulfate in ACLS?',
          'options': [
            'Treat bradycardia',
            'Treat torsades de pointes',
            'Treat VF'
          ],
          'answer': 'Treat torsades de pointes'
        },
        {
          'question':
              'Which of the following is a reversible cause of cardiac arrest?',
          'options': ['Hyperthermia', 'Hyperglycemia', 'Hypovolemia'],
          'answer': 'Hypovolemia'
        },
        {
          'question':
              'What is the recommended energy dose for the first defibrillation attempt in adults?',
          'options': ['50-100 joules', '120-200 joules', '300-360 joules'],
          'answer': '120-200 joules'
        },
        {
          'question':
              'When should you consider termination of resuscitation efforts?',
          'options': [
            'After 5 minutes',
            'When there is no ROSC and no shockable rhythm',
            'When the patient is cold'
          ],
          'answer': 'When there is no ROSC and no shockable rhythm'
        },
        {
          'question': 'What is the purpose of therapeutic hypothermia?',
          'options': [
            'To cool the heart',
            'To improve neurological outcomes',
            'To slow down metabolism'
          ],
          'answer': 'To improve neurological outcomes'
        },
        {
          'question':
              'Which is a characteristic of PEA (Pulseless Electrical Activity)?',
          'options': [
            'No electrical activity',
            'Electrical activity without a pulse',
            'Rapid electrical activity'
          ],
          'answer': 'Electrical activity without a pulse'
        },
        {
          'question':
              'What is the recommended depth of chest compressions for adults?',
          'options': ['1-1.5 inches', '2-2.4 inches', '3-3.5 inches'],
          'answer': '2-2.4 inches'
        },
        {
          'question': 'Which medication is indicated for torsades de pointes?',
          'options': ['Atropine', 'Epinephrine', 'Magnesium sulfate'],
          'answer': 'Magnesium sulfate'
        },
        {
          'question': 'When is synchronized cardioversion used?',
          'options': [
            'For asystole',
            'For stable tachyarrhythmias',
            'For unstable tachyarrhythmias'
          ],
          'answer': 'For unstable tachyarrhythmias'
        },
        {
          'question':
              'What is the correct action for a witnessed collapse with no pulse?',
          'options': [
            'Start CPR and use an AED as soon as possible',
            'Wait for EMS to arrive',
            'Give two rescue breaths'
          ],
          'answer': 'Start CPR and use an AED as soon as possible'
        },
        {
          'question': 'What is the primary purpose of an AED?',
          'options': [
            'Monitor heart rhythm',
            'Provide advanced airway management',
            'Deliver a shock to restore normal heart rhythm'
          ],
          'answer': 'Deliver a shock to restore normal heart rhythm'
        },
        {
          'question': 'What does ROSC stand for?',
          'options': [
            'Return of Spontaneous Circulation',
            'Rate of Shock Compression',
            'Recovery of Sinus Conduction'
          ],
          'answer': 'Return of Spontaneous Circulation'
        },
        {
          'question': 'Which rhythm is treated with transcutaneous pacing?',
          'options': ['Bradycardia', 'Tachycardia', 'Ventricular fibrillation'],
          'answer': 'Bradycardia'
        },
        {
          'question':
              'What is the recommended initial dose of atropine for bradycardia?',
          'options': ['0.5 mg', '1 mg', '2 mg'],
          'answer': '0.5 mg'
        },
        {
          'question':
              'What is the compression-to-ventilation ratio for adult CPR in ACLS?',
          'options': ['15:2', '30:2', '20:2'],
          'answer': '30:2'
        },
        {
          'question':
              'Which drug is used for the treatment of stable narrow-complex tachycardia?',
          'options': ['Epinephrine', 'Adenosine', 'Atropine'],
          'answer': 'Adenosine'
        },
        {
          'question':
              'What is the primary action to take for a patient in asystole?',
          'options': [
            'Start chest compressions',
            'Give a shock',
            'Administer amiodarone'
          ],
          'answer': 'Start chest compressions'
        },
        {
          'question':
              'Which medication is used to treat hypotension after ROSC?',
          'options': ['Epinephrine', 'Atropine', 'Dopamine'],
          'answer': 'Dopamine'
        },
        {
          'question':
              'How long should you check for a pulse before starting CPR?',
          'options': [
            'No more than 10 seconds',
            'No more than 20 seconds',
            'No more than 30 seconds'
          ],
          'answer': 'No more than 10 seconds'
        },
        {
          'question': 'What is a common cause of PEA?',
          'options': ['Hypovolemia', 'Hypertension', 'Hyperglycemia'],
          'answer': 'Hypovolemia'
        },
        {
          'question':
              'What is the recommended joules for biphasic defibrillation in adults?',
          'options': ['100-120 joules', '120-200 joules', '200-300 joules'],
          'answer': '120-200 joules'
        },
        {
          'question': 'What is the role of naloxone in ACLS?',
          'options': [
            'To reverse opioid overdose',
            'To treat bradycardia',
            'To treat ventricular fibrillation'
          ],
          'answer': 'To reverse opioid overdose'
        }
      ]
    },
    {
      'moduleId': 'module_id_3',
      'questions': [
        {
          'question': 'What is the primary goal of infection control?',
          'options': [
            'To eliminate all pathogens',
            'To reduce the risk of spreading infections',
            'To ensure all staff wear PPE'
          ],
          'answer': 'To reduce the risk of spreading infections'
        },
        {
          'question': 'What does PPE stand for?',
          'options': [
            'Personal Protective Equipment',
            'Patient Protective Equipment',
            'Professional Protective Equipment'
          ],
          'answer': 'Personal Protective Equipment'
        },
        {
          'question':
              'Which of the following is a standard precaution in infection control?',
          'options': [
            'Using antibiotics for all patients',
            'Hand hygiene',
            'Double gloving for all procedures'
          ],
          'answer': 'Hand hygiene'
        },
        {
          'question':
              'What is the most effective method for preventing the spread of infections?',
          'options': ['Wearing masks', 'Hand washing', 'Using disinfectants'],
          'answer': 'Hand washing'
        },
        {
          'question': 'Which of the following is NOT a type of PPE?',
          'options': ['Gloves', 'Gown', 'Hand sanitizer'],
          'answer': 'Hand sanitizer'
        },
        {
          'question':
              'What is the purpose of using gloves in infection control?',
          'options': [
            'To keep hands warm',
            'To protect hands from contaminants',
            'To provide comfort'
          ],
          'answer': 'To protect hands from contaminants'
        },
        {
          'question': 'What should you do if a glove tears during a procedure?',
          'options': [
            'Continue the procedure',
            'Remove and replace the glove',
            'Ignore it'
          ],
          'answer': 'Remove and replace the glove'
        },
        {
          'question':
              'How often should healthcare workers perform hand hygiene?',
          'options': [
            'Before and after patient contact',
            'Only after patient contact',
            'Only before patient contact'
          ],
          'answer': 'Before and after patient contact'
        },
        {
          'question':
              'What is the recommended duration for hand washing with soap and water?',
          'options': ['10 seconds', '20 seconds', '30 seconds'],
          'answer': '20 seconds'
        },
        {
          'question': 'When should an N95 respirator be used?',
          'options': [
            'For all patient interactions',
            'For aerosol-generating procedures',
            'Only in the operating room'
          ],
          'answer': 'For aerosol-generating procedures'
        },
        {
          'question': 'What is the first step in donning PPE?',
          'options': ['Putting on gloves', 'Putting on a gown', 'Hand hygiene'],
          'answer': 'Hand hygiene'
        },
        {
          'question': 'Which of the following is a contact precaution?',
          'options': [
            'Using a face shield',
            'Wearing a gown and gloves',
            'Using an N95 respirator'
          ],
          'answer': 'Wearing a gown and gloves'
        },
        {
          'question': 'What is the main purpose of a face shield?',
          'options': [
            'To protect the face from splashes',
            'To protect the eyes from bright light',
            'To provide respiratory protection'
          ],
          'answer': 'To protect the face from splashes'
        },
        {
          'question':
              'What type of hand hygiene is recommended when hands are visibly soiled?',
          'options': [
            'Using hand sanitizer',
            'Washing with soap and water',
            'Using antiseptic wipes'
          ],
          'answer': 'Washing with soap and water'
        },
        {
          'question': 'What is the correct order for removing PPE?',
          'options': [
            'Gloves, gown, mask',
            'Gown, gloves, mask',
            'Mask, gloves, gown'
          ],
          'answer': 'Gloves, gown, mask'
        },
        {
          'question': 'How should used PPE be disposed of?',
          'options': [
            'In regular trash',
            'In a designated biohazard container',
            'In a recycling bin'
          ],
          'answer': 'In a designated biohazard container'
        },
        {
          'question': 'Which of the following is a droplet precaution?',
          'options': [
            'Wearing a surgical mask',
            'Wearing a gown and gloves',
            'Using an N95 respirator'
          ],
          'answer': 'Wearing a surgical mask'
        },
        {
          'question':
              'What is the minimum alcohol content for hand sanitizers to be effective?',
          'options': ['40%', '60%', '80%'],
          'answer': '60%'
        },
        {
          'question': 'When should a face mask be discarded?',
          'options': [
            'When it is visibly soiled',
            'After 8 hours of use',
            'When it becomes loose'
          ],
          'answer': 'When it is visibly soiled'
        },
        {
          'question': 'What is the purpose of isolation precautions?',
          'options': [
            'To isolate the patient for privacy',
            'To prevent the spread of infections',
            'To reduce the workload of healthcare workers'
          ],
          'answer': 'To prevent the spread of infections'
        },
        {
          'question':
              'Which is a common source of healthcare-associated infections?',
          'options': [
            'Contaminated surfaces',
            'Healthy visitors',
            'Properly sterilized equipment'
          ],
          'answer': 'Contaminated surfaces'
        },
        {
          'question': 'What should be done before entering an isolation room?',
          'options': [
            'Remove all PPE',
            'Perform hand hygiene and don appropriate PPE',
            'Call the patient'
          ],
          'answer': 'Perform hand hygiene and don appropriate PPE'
        },
        {
          'question':
              'How often should high-touch surfaces be cleaned in healthcare settings?',
          'options': ['Once a day', 'Twice a day', 'After each patient use'],
          'answer': 'After each patient use'
        },
        {
          'question':
              'Which of the following is NOT a part of standard precautions?',
          'options': [
            'Hand hygiene',
            'Respiratory hygiene',
            'Universal blood testing'
          ],
          'answer': 'Universal blood testing'
        },
        {
          'question':
              'What is the primary mode of transmission for respiratory infections?',
          'options': ['Bloodborne', 'Droplet', 'Vector-borne'],
          'answer': 'Droplet'
        },
        {
          'question': 'What type of PPE is required for airborne precautions?',
          'options': ['Surgical mask', 'N95 respirator', 'Face shield'],
          'answer': 'N95 respirator'
        },
        {
          'question': 'What should be done immediately after removing PPE?',
          'options': ['Wash hands', 'Dispose of PPE', 'Report to supervisor'],
          'answer': 'Wash hands'
        },
        {
          'question':
              'Which of the following is a sign of proper hand hygiene?',
          'options': [
            'Dry hands',
            'Hands are visibly clean',
            'Hands have a pleasant odor'
          ],
          'answer': 'Hands are visibly clean'
        },
        {
          'question': 'When should healthcare workers wear gowns?',
          'options': [
            'For all patient interactions',
            'When there is a risk of exposure to body fluids',
            'Only during surgeries'
          ],
          'answer': 'When there is a risk of exposure to body fluids'
        },
        {
          'question': 'What is a nosocomial infection?',
          'options': [
            'An infection acquired in the community',
            'An infection acquired in a healthcare setting',
            'An infection acquired from food'
          ],
          'answer': 'An infection acquired in a healthcare setting'
        }
      ]
    },
    {
      'moduleId': 'module_id_4',
      'questions': [
        {
          'question': 'What is the focus of Pediatric Advanced Life Support?',
          'options': [
            'Adult resuscitation',
            'Pediatric emergency care',
            'Geriatric care'
          ],
          'answer': 'Pediatric emergency care'
        },
        {
          'question': 'What age group does PALS primarily serve?',
          'options': ['Adults', 'Infants and children', 'Elderly'],
          'answer': 'Infants and children'
        },
        {
          'question':
              'Which of the following is a common cause of cardiac arrest in children?',
          'options': ['Heart attack', 'Respiratory failure', 'Stroke'],
          'answer': 'Respiratory failure'
        },
        {
          'question':
              'What is the recommended depth of chest compressions for infants during CPR?',
          'options': [
            'At least one-third the depth of the chest',
            '2 inches',
            '1 inch'
          ],
          'answer': 'At least one-third the depth of the chest'
        },
        {
          'question':
              'What is the appropriate rate of chest compressions in PALS?',
          'options': [
            '80-100 per minute',
            '100-120 per minute',
            '120-140 per minute'
          ],
          'answer': '100-120 per minute'
        },
        {
          'question':
              'Which of the following drugs is commonly used in PALS for bradycardia?',
          'options': ['Adenosine', 'Atropine', 'Amiodarone'],
          'answer': 'Atropine'
        },
        {
          'question':
              'What is the initial energy dose for defibrillation in pediatric patients?',
          'options': ['1 J/kg', '2 J/kg', '4 J/kg'],
          'answer': '2 J/kg'
        },
        {
          'question':
              'What is the preferred method for confirming endotracheal tube placement in children?',
          'options': ['Chest X-ray', 'Capnography', 'Auscultation'],
          'answer': 'Capnography'
        },
        {
          'question': 'What is the first step in the PALS assessment sequence?',
          'options': [
            'Start chest compressions',
            'Assess the child’s appearance',
            'Administer epinephrine'
          ],
          'answer': 'Assess the child’s appearance'
        },
        {
          'question':
              'What is the recommended compression-to-ventilation ratio for single rescuer CPR in children?',
          'options': ['15:2', '30:2', '3:1'],
          'answer': '30:2'
        },
        {
          'question':
              'Which of the following is an indication for epinephrine in pediatric cardiac arrest?',
          'options': ['Ventricular fibrillation', 'Bradycardia', 'Asystole'],
          'answer': 'Asystole'
        },
        {
          'question':
              'What is the correct dosage of amiodarone for a pediatric patient in ventricular fibrillation?',
          'options': ['5 mg/kg', '10 mg/kg', '15 mg/kg'],
          'answer': '5 mg/kg'
        },
        {
          'question':
              'What is the appropriate method for opening the airway in an unconscious child?',
          'options': [
            'Jaw-thrust maneuver',
            'Head-tilt, chin-lift',
            'Hyperextension of the neck'
          ],
          'answer': 'Head-tilt, chin-lift'
        },
        {
          'question':
              'Which of the following is a sign of respiratory distress in children?',
          'options': [
            'Slow breathing',
            'Use of accessory muscles',
            'Absence of breath sounds'
          ],
          'answer': 'Use of accessory muscles'
        },
        {
          'question':
              'What is the recommended intervention for a child in respiratory arrest?',
          'options': [
            'Start chest compressions',
            'Provide rescue breathing',
            'Administer atropine'
          ],
          'answer': 'Provide rescue breathing'
        },
        {
          'question':
              'Which of the following is a common cause of shock in children?',
          'options': ['Heart attack', 'Sepsis', 'Stroke'],
          'answer': 'Sepsis'
        },
        {
          'question': 'What is the initial fluid bolus for a child in shock?',
          'options': ['10 ml/kg', '20 ml/kg', '30 ml/kg'],
          'answer': '20 ml/kg'
        },
        {
          'question':
              'Which of the following rhythms is shockable in pediatric cardiac arrest?',
          'options': [
            'Asystole',
            'Ventricular fibrillation',
            'Pulseless electrical activity'
          ],
          'answer': 'Ventricular fibrillation'
        },
        {
          'question':
              'What is the recommended ventilation rate for a child with an advanced airway in place?',
          'options': [
            '8-10 breaths per minute',
            '10-12 breaths per minute',
            '12-15 breaths per minute'
          ],
          'answer': '10-12 breaths per minute'
        },
        {
          'question': 'Which drug is used to treat anaphylaxis in children?',
          'options': ['Atropine', 'Epinephrine', 'Amiodarone'],
          'answer': 'Epinephrine'
        },
        {
          'question':
              'What is the appropriate action for a child with a foreign body airway obstruction?',
          'options': [
            'Perform chest compressions',
            'Perform abdominal thrusts',
            'Administer epinephrine'
          ],
          'answer': 'Perform abdominal thrusts'
        },
        {
          'question':
              'Which of the following is a reversible cause of pediatric cardiac arrest?',
          'options': ['Trauma', 'Hypoxia', 'Hyperthermia'],
          'answer': 'Hypoxia'
        },
        {
          'question':
              'What is the recommended treatment for a child with hypoglycemia?',
          'options': [
            'Administer insulin',
            'Administer dextrose',
            'Administer glucagon'
          ],
          'answer': 'Administer dextrose'
        },
        {
          'question':
              'What is the primary focus during the first assessment of a pediatric patient?',
          'options': [
            'Airway, Breathing, Circulation',
            'Blood pressure, Pulse, Respiration',
            'Temperature, Oxygen saturation, Glucose level'
          ],
          'answer': 'Airway, Breathing, Circulation'
        },
        {
          'question':
              'Which of the following is an early sign of respiratory failure in children?',
          'options': ['Bradycardia', 'Tachypnea', 'Cyanosis'],
          'answer': 'Tachypnea'
        },
        {
          'question':
              'What is the appropriate response to a child in pulseless electrical activity?',
          'options': [
            'Defibrillation',
            'Chest compressions and epinephrine',
            'Administer amiodarone'
          ],
          'answer': 'Chest compressions and epinephrine'
        },
        {
          'question':
              'Which of the following is a late sign of shock in children?',
          'options': ['Tachycardia', 'Bradycardia', 'Capillary refill'],
          'answer': 'Bradycardia'
        },
        {
          'question':
              'What is the appropriate intervention for a child with a heart rate below 60 bpm and signs of poor perfusion?',
          'options': [
            'Start chest compressions',
            'Administer atropine',
            'Provide rescue breathing'
          ],
          'answer': 'Start chest compressions'
        },
        {
          'question':
              'Which of the following is NOT a component of the Pediatric Assessment Triangle?',
          'options': ['Appearance', 'Work of Breathing', 'Pupil size'],
          'answer': 'Pupil size'
        },
        {
          'question':
              'What is the preferred site for intraosseous access in children?',
          'options': ['Distal femur', 'Proximal tibia', 'Proximal humerus'],
          'answer': 'Proximal tibia'
        }
      ]
    },
    {
      'moduleId': 'module_id_5',
      'questions': [
        {
          'question': 'What is a key component of effective telemedicine?',
          'options': [
            'In-person visits',
            'Video consultations',
            'Phone calls only'
          ],
          'answer': 'Video consultations'
        },
        {
          'question': 'Which is NOT a principle of telemedicine?',
          'options': [
            'Patient confidentiality',
            'Use of technology',
            'Physical presence'
          ],
          'answer': 'Physical presence'
        },
        {
          'question': 'What technology is commonly used in telemedicine?',
          'options': [
            'MRI machines',
            'Video conferencing tools',
            'X-ray machines'
          ],
          'answer': 'Video conferencing tools'
        },
        {
          'question': 'What is the primary benefit of telemedicine?',
          'options': [
            'Increased paperwork',
            'Improved access to care',
            'Longer wait times'
          ],
          'answer': 'Improved access to care'
        },
        {
          'question': 'Which of the following is a challenge in telemedicine?',
          'options': [
            'Improved patient outcomes',
            'Technological issues',
            'Better patient engagement'
          ],
          'answer': 'Technological issues'
        },
        {
          'question':
              'What should be maintained during a telemedicine consultation?',
          'options': [
            'Patient’s medical history',
            'Professional attire',
            'High internet speed'
          ],
          'answer': 'Patient’s medical history'
        },
        {
          'question':
              'Which of the following is essential for a successful telemedicine session?',
          'options': [
            'A quiet environment',
            'A public space',
            'A noisy background'
          ],
          'answer': 'A quiet environment'
        },
        {
          'question': 'How can telemedicine enhance patient care?',
          'options': [
            'By delaying treatment',
            'By providing timely consultations',
            'By avoiding medical records'
          ],
          'answer': 'By providing timely consultations'
        },
        {
          'question': 'What is a common use of telemedicine?',
          'options': [
            'Remote patient monitoring',
            'In-person surgeries',
            'Traditional office visits'
          ],
          'answer': 'Remote patient monitoring'
        },
        {
          'question':
              'Which of the following is a potential benefit of telemedicine for rural areas?',
          'options': [
            'Increased travel time',
            'Reduced access to specialists',
            'Improved access to healthcare'
          ],
          'answer': 'Improved access to healthcare'
        },
        {
          'question':
              'What type of internet connection is preferred for telemedicine?',
          'options': ['Dial-up', 'Broadband', 'No internet needed'],
          'answer': 'Broadband'
        },
        {
          'question':
              'Which aspect is crucial for maintaining patient confidentiality in telemedicine?',
          'options': [
            'Sharing passwords',
            'Secure communication channels',
            'Public Wi-Fi'
          ],
          'answer': 'Secure communication channels'
        },
        {
          'question':
              'What is an important factor to consider when setting up a telemedicine appointment?',
          'options': [
            'The patient’s comfort with technology',
            'The patient’s ability to travel',
            'The patient’s physical appearance'
          ],
          'answer': 'The patient’s comfort with technology'
        },
        {
          'question':
              'What is the role of telemedicine in chronic disease management?',
          'options': [
            'To provide emergency surgeries',
            'To monitor and manage conditions remotely',
            'To replace in-person visits completely'
          ],
          'answer': 'To monitor and manage conditions remotely'
        },
        {
          'question':
              'Which of the following is a key consideration for telemedicine platforms?',
          'options': [
            'User-friendliness',
            'High cost',
            'Limited functionality'
          ],
          'answer': 'User-friendliness'
        },
        {
          'question':
              'What should be done before starting a telemedicine consultation?',
          'options': [
            'Prepare the medical records',
            'Disconnect from the internet',
            'Leave the patient waiting'
          ],
          'answer': 'Prepare the medical records'
        },
        {
          'question':
              'What is the benefit of telemedicine for healthcare providers?',
          'options': [
            'Increased workload',
            'Flexibility in scheduling',
            'Decreased patient interactions'
          ],
          'answer': 'Flexibility in scheduling'
        },
        {
          'question':
              'Which of the following is important for the quality of telemedicine services?',
          'options': [
            'Regular updates and maintenance of technology',
            'Avoiding new technologies',
            'Ignoring patient feedback'
          ],
          'answer': 'Regular updates and maintenance of technology'
        },
        {
          'question': 'What is a key legal consideration in telemedicine?',
          'options': [
            'Ignoring state laws',
            'Adhering to licensing requirements',
            'Avoiding patient consent'
          ],
          'answer': 'Adhering to licensing requirements'
        },
        {
          'question': 'How can telemedicine improve patient engagement?',
          'options': [
            'By reducing communication',
            'By providing interactive tools and resources',
            'By limiting patient access to information'
          ],
          'answer': 'By providing interactive tools and resources'
        },
        {
          'question':
              'Which of the following can enhance the effectiveness of telemedicine?',
          'options': [
            'Poor video quality',
            'Good communication skills',
            'Infrequent follow-ups'
          ],
          'answer': 'Good communication skills'
        },
        {
          'question':
              'What is a common barrier to the adoption of telemedicine?',
          'options': [
            'High internet speed',
            'Technological literacy',
            'Availability of devices'
          ],
          'answer': 'Technological literacy'
        },
        {
          'question': 'What is an advantage of asynchronous telemedicine?',
          'options': [
            'Real-time interaction',
            'Convenience for both patients and providers',
            'Immediate feedback'
          ],
          'answer': 'Convenience for both patients and providers'
        },
        {
          'question':
              'What should be done to ensure a successful telemedicine visit?',
          'options': [
            'Ignore technical issues',
            'Conduct a test call',
            'Skip patient introductions'
          ],
          'answer': 'Conduct a test call'
        },
        {
          'question': 'How does telemedicine support continuity of care?',
          'options': [
            'By providing sporadic updates',
            'By maintaining regular follow-ups',
            'By reducing patient data'
          ],
          'answer': 'By maintaining regular follow-ups'
        },
        {
          'question':
              'What is a major advantage of using telemedicine in emergencies?',
          'options': [
            'Delay in care',
            'Immediate access to specialists',
            'Complex procedures'
          ],
          'answer': 'Immediate access to specialists'
        },
        {
          'question':
              'Which of the following can improve telemedicine adoption rates?',
          'options': [
            'Lack of training',
            'Providing adequate training and support',
            'Technical jargon'
          ],
          'answer': 'Providing adequate training and support'
        },
        {
          'question': 'What is the role of data security in telemedicine?',
          'options': [
            'To share patient data freely',
            'To protect patient information',
            'To ignore patient privacy'
          ],
          'answer': 'To protect patient information'
        },
        {
          'question':
              'Which of the following technologies is often used in telemedicine for remote monitoring?',
          'options': ['MRI machines', 'Wearable devices', 'Traditional phones'],
          'answer': 'Wearable devices'
        },
        {
          'question':
              'What is an important aspect of telemedicine for pediatric patients?',
          'options': [
            'Ignoring the child’s comfort',
            'Engaging the child in the process',
            'Using complex medical terms'
          ],
          'answer': 'Engaging the child in the process'
        }
      ]
    },
    {
      'moduleId': 'module_id_6',
      'questions': [
        {
          'question': 'What is the basis of evidence-based medicine?',
          'options': ['Tradition', 'Anecdotes', 'Scientific research'],
          'answer': 'Scientific research'
        },
        {
          'question': 'What is a key practice in evidence-based medicine?',
          'options': [
            'Ignoring new studies',
            'Applying personal beliefs',
            'Reviewing scientific literature'
          ],
          'answer': 'Reviewing scientific literature'
        },
        {
          'question':
              'What type of studies are considered the highest level of evidence?',
          'options': [
            'Case reports',
            'Randomized controlled trials',
            'Expert opinion'
          ],
          'answer': 'Randomized controlled trials'
        },
        {
          'question':
              'What does PICO stand for in the context of evidence-based medicine?',
          'options': [
            'Patient, Intervention, Comparison, Outcome',
            'Population, Intervention, Control, Observation',
            'Patient, Innovation, Comparison, Outcome'
          ],
          'answer': 'Patient, Intervention, Comparison, Outcome'
        },
        {
          'question': 'What is a systematic review?',
          'options': [
            'A single case study',
            'A comprehensive review of multiple studies',
            'An expert opinion article'
          ],
          'answer': 'A comprehensive review of multiple studies'
        },
        {
          'question': 'What is the purpose of a meta-analysis?',
          'options': [
            'To review a single study',
            'To statistically combine results from multiple studies',
            'To provide a narrative review'
          ],
          'answer': 'To statistically combine results from multiple studies'
        },
        {
          'question': 'What is bias in research?',
          'options': [
            'A neutral perspective',
            'A systematic error in study design or conduct',
            'A random error'
          ],
          'answer': 'A systematic error in study design or conduct'
        },
        {
          'question': 'What is the purpose of a control group in a study?',
          'options': [
            'To provide treatment to all participants',
            'To compare outcomes against the intervention group',
            'To eliminate variables'
          ],
          'answer': 'To compare outcomes against the intervention group'
        },
        {
          'question': 'What is a confidence interval?',
          'options': [
            'A range of values that reflects the true value',
            'A single point estimate',
            'A measure of study duration'
          ],
          'answer': 'A range of values that reflects the true value'
        },
        {
          'question': 'What is the importance of sample size in research?',
          'options': [
            'It has no impact on the study',
            'Larger sample sizes increase the reliability of results',
            'Smaller sample sizes are always better'
          ],
          'answer': 'Larger sample sizes increase the reliability of results'
        },
        {
          'question': 'What is the role of peer review in scientific research?',
          'options': [
            'To publish research without evaluation',
            'To evaluate the quality and validity of research',
            'To delay publication'
          ],
          'answer': 'To evaluate the quality and validity of research'
        },
        {
          'question': 'What is an observational study?',
          'options': [
            'A study where the researcher actively intervenes',
            'A study where the researcher observes without intervention',
            'A study with no defined methodology'
          ],
          'answer': 'A study where the researcher observes without intervention'
        },
        {
          'question': 'What does blinding in a study aim to prevent?',
          'options': ['Data collection', 'Bias', 'Follow-up'],
          'answer': 'Bias'
        },
        {
          'question': 'What is the significance of a p-value in research?',
          'options': [
            'To measure study duration',
            'To assess the probability that the observed results occurred by chance',
            'To determine sample size'
          ],
          'answer':
              'To assess the probability that the observed results occurred by chance'
        },
        {
          'question': 'What is the main purpose of a cohort study?',
          'options': [
            'To follow a group over time to determine outcomes',
            'To test a new intervention',
            'To conduct a single case study'
          ],
          'answer': 'To follow a group over time to determine outcomes'
        },
        {
          'question': 'What is an inclusion criterion in a study?',
          'options': [
            'A factor that excludes participants',
            'A factor that allows participants to be part of the study',
            'A random selection process'
          ],
          'answer': 'A factor that allows participants to be part of the study'
        },
        {
          'question':
              'What is the purpose of randomization in clinical trials?',
          'options': [
            'To select specific patients for treatment',
            'To eliminate selection bias',
            'To choose the most suitable treatment'
          ],
          'answer': 'To eliminate selection bias'
        },
        {
          'question': 'What is the importance of replication in research?',
          'options': [
            'To validate the reliability of findings',
            'To reduce sample size',
            'To minimize study duration'
          ],
          'answer': 'To validate the reliability of findings'
        },
        {
          'question':
              'What is the function of an ethics committee in research?',
          'options': [
            'To review the scientific merit of a study',
            'To protect the rights and welfare of participants',
            'To fund the research'
          ],
          'answer': 'To protect the rights and welfare of participants'
        },
        {
          'question': 'What is a cross-sectional study?',
          'options': [
            'A study that examines data at one point in time',
            'A study that follows participants over time',
            'A study with multiple interventions'
          ],
          'answer': 'A study that examines data at one point in time'
        },
        {
          'question':
              'What does the term "generalizability" refer to in research?',
          'options': [
            'The application of findings to a wider population',
            'The precision of a measurement tool',
            'The accuracy of the data'
          ],
          'answer': 'The application of findings to a wider population'
        },
        {
          'question': 'What is the purpose of a literature review?',
          'options': [
            'To compile all relevant research on a topic',
            'To perform an experiment',
            'To ignore previous studies'
          ],
          'answer': 'To compile all relevant research on a topic'
        },
        {
          'question':
              'What is the difference between a hypothesis and a theory?',
          'options': [
            'A hypothesis is a proposed explanation; a theory is a well-substantiated explanation',
            'A hypothesis is always correct; a theory is always incorrect',
            'A hypothesis is a single observation; a theory is an anecdote'
          ],
          'answer':
              'A hypothesis is a proposed explanation; a theory is a well-substantiated explanation'
        },
        {
          'question': 'What is a confounding variable?',
          'options': [
            'A variable that is intentionally manipulated',
            'A variable that distorts the true relationship between the study variables',
            'A variable that has no impact on the study'
          ],
          'answer':
              'A variable that distorts the true relationship between the study variables'
        },
        {
          'question': 'What does the term "statistical significance" mean?',
          'options': [
            'The findings are likely due to chance',
            'The findings are unlikely to have occurred by chance',
            'The findings are irrelevant'
          ],
          'answer': 'The findings are unlikely to have occurred by chance'
        },
        {
          'question': 'What is an intention-to-treat analysis?',
          'options': [
            'Analyzing only those who completed the study as planned',
            'Including all participants as originally allocated regardless of completion',
            'Excluding participants who dropped out'
          ],
          'answer':
              'Including all participants as originally allocated regardless of completion'
        },
        {
          'question': 'What does "external validity" refer to?',
          'options': [
            'The accuracy of the measurements within the study',
            'The extent to which study findings can be generalized to other settings',
            'The ethical considerations of a study'
          ],
          'answer':
              'The extent to which study findings can be generalized to other settings'
        },
        {
          'question': 'What is a null hypothesis?',
          'options': [
            'A hypothesis that predicts no effect or no relationship',
            'A hypothesis that always predicts an effect',
            'A hypothesis that is always correct'
          ],
          'answer': 'A hypothesis that predicts no effect or no relationship'
        },
        {
          'question': 'What is a case-control study?',
          'options': [
            'A study that follows participants over time',
            'A study that compares individuals with a condition to those without',
            'A study with no control group'
          ],
          'answer':
              'A study that compares individuals with a condition to those without'
        },
        {
          'question': 'What is a key element of the CONSORT guidelines?',
          'options': [
            'Providing a framework for case reports',
            'Standardizing the reporting of randomized trials',
            'Eliminating the need for statistical analysis'
          ],
          'answer': 'Standardizing the reporting of randomized trials'
        },
        {
          'question': 'What does "internal validity" refer to?',
          'options': [
            'The extent to which a study establishes a trustworthy cause-and-effect relationship',
            'The relevance of the study to other settings',
            'The ethical considerations of a study'
          ],
          'answer':
              'The extent to which a study establishes a trustworthy cause-and-effect relationship'
        }
      ]
    },
    {
      'moduleId': 'module_id_7',
      'questions': [
        {
          'question': 'What is Mental Health First Aid?',
          'options': [
            'Physical first aid',
            'Support for mental health issues',
            'Nutritional advice'
          ],
          'answer': 'Support for mental health issues'
        },
        {
          'question': 'Who can benefit from Mental Health First Aid?',
          'options': [
            'Only healthcare professionals',
            'Anyone in the community',
            'Only mental health patients'
          ],
          'answer': 'Anyone in the community'
        },
        {
          'question': 'What is a common sign of depression?',
          'options': [
            'Increased energy',
            'Persistent sadness',
            'Excessive happiness'
          ],
          'answer': 'Persistent sadness'
        },
        {
          'question': 'What should you do if someone is having a panic attack?',
          'options': [
            'Leave them alone',
            'Help them breathe slowly and stay calm',
            'Give them caffeinated drinks'
          ],
          'answer': 'Help them breathe slowly and stay calm'
        },
        {
          'question': 'Which of the following is a risk factor for suicide?',
          'options': [
            'Having a strong support network',
            'History of mental illness',
            'Engaging in regular exercise'
          ],
          'answer': 'History of mental illness'
        },
        {
          'question':
              'What is an appropriate response to someone expressing suicidal thoughts?',
          'options': [
            'Ignore them',
            'Listen without judgment and seek professional help',
            'Tell them to get over it'
          ],
          'answer': 'Listen without judgment and seek professional help'
        },
        {
          'question':
              'What is one of the first steps in helping someone with a mental health issue?',
          'options': [
            'Diagnosing their condition',
            'Listening and providing support',
            'Prescribing medication'
          ],
          'answer': 'Listening and providing support'
        },
        {
          'question': 'Which of the following is a symptom of anxiety?',
          'options': ['Calmness', 'Excessive worrying', 'Lack of appetite'],
          'answer': 'Excessive worrying'
        },
        {
          'question': 'What is the role of a mental health first aider?',
          'options': [
            'Provide ongoing therapy',
            'Offer initial support and guide towards professional help',
            'Diagnose mental health conditions'
          ],
          'answer': 'Offer initial support and guide towards professional help'
        },
        {
          'question':
              'Which of the following is an effective way to support someone with a mental health issue?',
          'options': [
            'Judging their actions',
            'Encouraging them to talk about their feelings',
            'Ignoring their concerns'
          ],
          'answer': 'Encouraging them to talk about their feelings'
        },
        {
          'question': 'What is a common misconception about mental health?',
          'options': [
            'It can affect anyone',
            'It is a sign of weakness',
            'It can be treated'
          ],
          'answer': 'It is a sign of weakness'
        },
        {
          'question': 'Which of the following is a sign of substance abuse?',
          'options': [
            'Stable relationships',
            'Erratic behavior and neglecting responsibilities',
            'Consistent job performance'
          ],
          'answer': 'Erratic behavior and neglecting responsibilities'
        },
        {
          'question':
              'What should you avoid saying to someone with a mental health issue?',
          'options': [
            'I understand how you feel',
            'It\'s all in your head',
            'How can I help?'
          ],
          'answer': 'It\'s all in your head'
        },
        {
          'question':
              'What is the purpose of mental health first aid training?',
          'options': [
            'To replace professional therapy',
            'To provide initial help and support',
            'To diagnose mental health conditions'
          ],
          'answer': 'To provide initial help and support'
        },
        {
          'question':
              'Which of the following is a healthy coping mechanism for stress?',
          'options': [
            'Avoiding responsibilities',
            'Regular exercise and relaxation techniques',
            'Isolating oneself'
          ],
          'answer': 'Regular exercise and relaxation techniques'
        },
        {
          'question': 'What is a common effect of stigma on mental health?',
          'options': [
            'Encouragement to seek help',
            'Increased social support',
            'Reluctance to seek help'
          ],
          'answer': 'Reluctance to seek help'
        },
        {
          'question': 'What does PTSD stand for?',
          'options': [
            'Post-Traumatic Stress Disorder',
            'Pre-Treatment Stress Disorder',
            'Persistent Traumatic Stress Disorder'
          ],
          'answer': 'Post-Traumatic Stress Disorder'
        },
        {
          'question': 'Which of the following is a sign of an eating disorder?',
          'options': [
            'Healthy eating habits',
            'Dramatic weight loss',
            'Consistent meal patterns'
          ],
          'answer': 'Dramatic weight loss'
        },
        {
          'question':
              'What should you do if someone is having a mental health crisis?',
          'options': [
            'Leave them alone',
            'Stay with them and seek professional help',
            'Tell them to calm down'
          ],
          'answer': 'Stay with them and seek professional help'
        },
        {
          'question':
              'What is an important factor in recovering from a mental health issue?',
          'options': [
            'Isolation',
            'Support from friends and family',
            'Ignoring the issue'
          ],
          'answer': 'Support from friends and family'
        },
        {
          'question': 'Which of the following is a symptom of schizophrenia?',
          'options': ['Hallucinations', 'Feeling happy', 'Increased energy'],
          'answer': 'Hallucinations'
        },
        {
          'question':
              'What is an appropriate way to start a conversation about mental health?',
          'options': [
            'Why can’t you just be happy?',
            'I’ve noticed you seem down lately, want to talk about it?',
            'You should just get over it'
          ],
          'answer': 'I’ve noticed you seem down lately, want to talk about it?'
        },
        {
          'question':
              'Which of the following is a symptom of bipolar disorder?',
          'options': [
            'Consistent mood',
            'Mood swings between mania and depression',
            'Stable energy levels'
          ],
          'answer': 'Mood swings between mania and depression'
        },
        {
          'question': 'What is a key principle of mental health first aid?',
          'options': [
            'Judging the person',
            'Listening without judgment',
            'Ignoring the person'
          ],
          'answer': 'Listening without judgment'
        },
        {
          'question':
              'What is the first step in helping someone with a mental health crisis?',
          'options': [
            'Diagnosing the condition',
            'Ensuring safety and providing support',
            'Prescribing medication'
          ],
          'answer': 'Ensuring safety and providing support'
        },
        {
          'question': 'Which of the following is a myth about mental health?',
          'options': [
            'Mental health issues are common',
            'People with mental health issues can recover',
            'Mental health issues are a sign of weakness'
          ],
          'answer': 'Mental health issues are a sign of weakness'
        },
        {
          'question':
              'What should you do if you notice signs of mental illness in yourself?',
          'options': [
            'Seek professional help',
            'Ignore the signs',
            'Isolate yourself'
          ],
          'answer': 'Seek professional help'
        },
        {
          'question':
              'What is an effective way to reduce the stigma of mental illness?',
          'options': [
            'Educating others about mental health',
            'Avoiding conversations about mental health',
            'Judging people with mental health issues'
          ],
          'answer': 'Educating others about mental health'
        },
        {
          'question': 'What is the role of empathy in mental health first aid?',
          'options': [
            'To judge the person',
            'To understand and share the feelings of another',
            'To provide a clinical diagnosis'
          ],
          'answer': 'To understand and share the feelings of another'
        },
        {
          'question':
              'Which of the following can be a sign of post-traumatic stress disorder (PTSD)?',
          'options': [
            'Increased energy',
            'Nightmares and flashbacks',
            'Consistent mood'
          ],
          'answer': 'Nightmares and flashbacks'
        },
        {
          'question': 'What is the importance of self-care in mental health?',
          'options': [
            'It is unnecessary',
            'It helps maintain mental well-being',
            'It is only for people with mental health issues'
          ],
          'answer': 'It helps maintain mental well-being'
        }
      ]
    },
    {
      'moduleId': 'module_id_8',
      'questions': [
        {
          'question': 'What is a major concern in geriatric care?',
          'options': [
            'Pediatric emergencies',
            'Chronic disease management',
            'Sports injuries'
          ],
          'answer': 'Chronic disease management'
        },
        {
          'question': 'What is an important aspect of geriatric care?',
          'options': [
            'Aggressive treatments',
            'Palliative care',
            'Minimal interaction'
          ],
          'answer': 'Palliative care'
        },
        {
          'question': 'What is a common chronic disease in elderly patients?',
          'options': ['Chickenpox', 'Hypertension', 'Appendicitis'],
          'answer': 'Hypertension'
        },
        {
          'question': 'Why is polypharmacy a concern in geriatric care?',
          'options': [
            'It leads to better outcomes',
            'It increases the risk of adverse drug reactions',
            'It reduces the number of medications needed'
          ],
          'answer': 'It increases the risk of adverse drug reactions'
        },
        {
          'question': 'What is the goal of palliative care?',
          'options': [
            'Cure the disease',
            'Provide comfort and improve quality of life',
            'Perform surgeries'
          ],
          'answer': 'Provide comfort and improve quality of life'
        },
        {
          'question':
              'What is a common symptom of dementia in elderly patients?',
          'options': ['Improved memory', 'Memory loss', 'Increased energy'],
          'answer': 'Memory loss'
        },
        {
          'question':
              'What should be considered when prescribing medications to elderly patients?',
          'options': [
            'Their age only',
            'Potential drug interactions and their overall health',
            'Their weight only'
          ],
          'answer': 'Potential drug interactions and their overall health'
        },
        {
          'question':
              'What is a key component of managing diabetes in elderly patients?',
          'options': [
            'Ignoring blood sugar levels',
            'Regular monitoring of blood sugar levels',
            'Avoiding all medications'
          ],
          'answer': 'Regular monitoring of blood sugar levels'
        },
        {
          'question':
              'What is an important nutritional consideration for elderly patients?',
          'options': [
            'High calorie, low nutrient foods',
            'Balanced diet with adequate nutrients',
            'Skipping meals'
          ],
          'answer': 'Balanced diet with adequate nutrients'
        },
        {
          'question': 'What is a common cause of falls in the elderly?',
          'options': [
            'Good vision',
            'Poor balance and coordination',
            'Strong muscles'
          ],
          'answer': 'Poor balance and coordination'
        },
        {
          'question': 'What is the role of physical therapy in geriatric care?',
          'options': [
            'To prevent exercise',
            'To improve mobility and strength',
            'To reduce activity'
          ],
          'answer': 'To improve mobility and strength'
        },
        {
          'question': 'What is a sign of elder abuse?',
          'options': [
            'Bruises or injuries',
            'Good hygiene',
            'Healthy appearance'
          ],
          'answer': 'Bruises or injuries'
        },
        {
          'question':
              'What is an important factor in managing heart disease in elderly patients?',
          'options': [
            'High fat diet',
            'Regular physical activity',
            'Avoiding medications'
          ],
          'answer': 'Regular physical activity'
        },
        {
          'question':
              'What is a benefit of social interaction for elderly patients?',
          'options': [
            'Increased isolation',
            'Improved mental health',
            'Decreased cognitive function'
          ],
          'answer': 'Improved mental health'
        },
        {
          'question':
              'What is a common respiratory condition in elderly patients?',
          'options': [
            'Asthma',
            'COPD (Chronic Obstructive Pulmonary Disease)',
            'Sinusitis'
          ],
          'answer': 'COPD (Chronic Obstructive Pulmonary Disease)'
        },
        {
          'question':
              'What should be monitored in elderly patients with arthritis?',
          'options': [
            'Joint pain and inflammation',
            'Hair growth',
            'Nail length'
          ],
          'answer': 'Joint pain and inflammation'
        },
        {
          'question': 'What is a key aspect of end-of-life care?',
          'options': [
            'Aggressive treatments',
            'Comfort and dignity',
            'Multiple surgeries'
          ],
          'answer': 'Comfort and dignity'
        },
        {
          'question':
              'What can help prevent pressure ulcers in bedridden elderly patients?',
          'options': [
            'Regular repositioning',
            'Continuous lying in one position',
            'Ignoring skin care'
          ],
          'answer': 'Regular repositioning'
        },
        {
          'question':
              'What is a common mental health issue in elderly patients?',
          'options': ['ADHD', 'Depression', 'Autism'],
          'answer': 'Depression'
        },
        {
          'question':
              'What is an effective way to manage pain in elderly patients?',
          'options': [
            'Ignoring the pain',
            'Using appropriate pain relief methods',
            'Increasing physical activity only'
          ],
          'answer': 'Using appropriate pain relief methods'
        },
        {
          'question':
              'What is a key factor in managing incontinence in elderly patients?',
          'options': [
            'Ignoring it',
            'Proper hygiene and scheduled toileting',
            'Restricting fluids completely'
          ],
          'answer': 'Proper hygiene and scheduled toileting'
        },
        {
          'question':
              'What should be a focus in the care plan of an elderly patient with osteoporosis?',
          'options': [
            'High impact exercises',
            'Fall prevention',
            'Ignoring calcium intake'
          ],
          'answer': 'Fall prevention'
        },
        {
          'question':
              'What is a common cause of malnutrition in elderly patients?',
          'options': [
            'Healthy appetite',
            'Difficulty chewing or swallowing',
            'Regular balanced meals'
          ],
          'answer': 'Difficulty chewing or swallowing'
        },
        {
          'question':
              'What is an important aspect of post-operative care in elderly patients?',
          'options': [
            'Delaying mobility',
            'Early mobilization',
            'Avoiding medication'
          ],
          'answer': 'Early mobilization'
        },
        {
          'question':
              'What is a common cardiovascular issue in elderly patients?',
          'options': ['Hyperthyroidism', 'Heart failure', 'Appendicitis'],
          'answer': 'Heart failure'
        },
        {
          'question':
              'What is an effective way to manage sleep problems in elderly patients?',
          'options': [
            'Encouraging napping all day',
            'Establishing a regular sleep routine',
            'Ignoring sleep hygiene'
          ],
          'answer': 'Establishing a regular sleep routine'
        },
        {
          'question':
              'What is a common side effect of medications in elderly patients?',
          'options': [
            'Enhanced memory',
            'Dizziness and confusion',
            'Improved appetite'
          ],
          'answer': 'Dizziness and confusion'
        },
        {
          'question':
              'What is an important aspect of care for elderly patients with Alzheimer’s disease?',
          'options': [
            'Isolation',
            'Memory support and safety',
            'Complex instructions'
          ],
          'answer': 'Memory support and safety'
        },
        {
          'question':
              'What can help maintain cognitive function in elderly patients?',
          'options': [
            'Avoiding mental activities',
            'Engaging in cognitive exercises and social activities',
            'Ignoring hobbies'
          ],
          'answer': 'Engaging in cognitive exercises and social activities'
        },
        {
          'question': 'What is a sign of dehydration in elderly patients?',
          'options': [
            'Moist skin',
            'Dry mouth and confusion',
            'Normal urination'
          ],
          'answer': 'Dry mouth and confusion'
        },
        {
          'question':
              'What is an important consideration in the nutritional care of elderly patients?',
          'options': [
            'Low protein intake',
            'Adequate hydration and balanced diet',
            'High sugar intake'
          ],
          'answer': 'Adequate hydration and balanced diet'
        }
      ]
    },
    {
      'moduleId': 'module_id_9',
      'questions': [
        {
          'question': 'What is a key quality of healthcare leadership?',
          'options': [
            'Micromanagement',
            'Effective communication',
            'Avoiding team input'
          ],
          'answer': 'Effective communication'
        },
        {
          'question': 'What is a focus of healthcare management?',
          'options': [
            'Ignoring finances',
            'Improving patient care',
            'Eliminating staff training'
          ],
          'answer': 'Improving patient care'
        },
        {
          'question':
              'Which of the following is essential for effective healthcare leadership?',
          'options': [
            'Rigid decision making',
            'Adaptability and flexibility',
            'Avoiding feedback'
          ],
          'answer': 'Adaptability and flexibility'
        },
        {
          'question':
              'What role does strategic planning play in healthcare management?',
          'options': [
            'Short-term problem solving',
            'Long-term goal setting and achievement',
            'Ignoring market trends'
          ],
          'answer': 'Long-term goal setting and achievement'
        },
        {
          'question':
              'Which skill is crucial for resolving conflicts in a healthcare setting?',
          'options': [
            'Ignoring the issue',
            'Active listening',
            'Imposing decisions'
          ],
          'answer': 'Active listening'
        },
        {
          'question':
              'What is the primary goal of risk management in healthcare?',
          'options': [
            'To increase operational costs',
            'To reduce risks and improve patient safety',
            'To limit staff training'
          ],
          'answer': 'To reduce risks and improve patient safety'
        },
        {
          'question':
              'What is an important aspect of financial management in healthcare?',
          'options': [
            'Budgeting and resource allocation',
            'Ignoring financial reports',
            'Unlimited spending'
          ],
          'answer': 'Budgeting and resource allocation'
        },
        {
          'question': 'How does team collaboration impact healthcare outcomes?',
          'options': [
            'Decreases efficiency',
            'Improves patient care and satisfaction',
            'Creates conflicts'
          ],
          'answer': 'Improves patient care and satisfaction'
        },
        {
          'question':
              'What is a benefit of continuous professional development for healthcare leaders?',
          'options': [
            'Stagnation',
            'Keeping up-to-date with industry standards',
            'Limiting new knowledge'
          ],
          'answer': 'Keeping up-to-date with industry standards'
        },
        {
          'question': 'What does effective delegation involve?',
          'options': [
            'Retaining all tasks',
            'Assigning tasks based on team members’ strengths',
            'Avoiding responsibility'
          ],
          'answer': 'Assigning tasks based on team members’ strengths'
        },
        {
          'question':
              'What is a major component of quality improvement in healthcare?',
          'options': [
            'Maintaining status quo',
            'Implementing evidence-based practices',
            'Ignoring patient feedback'
          ],
          'answer': 'Implementing evidence-based practices'
        },
        {
          'question':
              'How should healthcare leaders approach change management?',
          'options': [
            'Resisting change',
            'Facilitating smooth transitions and supporting staff',
            'Forcing changes without consultation'
          ],
          'answer': 'Facilitating smooth transitions and supporting staff'
        },
        {
          'question': 'What is the role of ethics in healthcare leadership?',
          'options': [
            'Making arbitrary decisions',
            'Guiding decision-making with moral principles',
            'Ignoring ethical dilemmas'
          ],
          'answer': 'Guiding decision-making with moral principles'
        },
        {
          'question': 'What does patient-centered care focus on?',
          'options': [
            'Healthcare provider convenience',
            'Individual patient needs and preferences',
            'Reducing patient involvement'
          ],
          'answer': 'Individual patient needs and preferences'
        },
        {
          'question':
              'What is the significance of cultural competence in healthcare management?',
          'options': [
            'Promoting cultural insensitivity',
            'Enhancing patient care through understanding diverse backgrounds',
            'Ignoring cultural differences'
          ],
          'answer':
              'Enhancing patient care through understanding diverse backgrounds'
        },
        {
          'question':
              'How does technology integration benefit healthcare management?',
          'options': [
            'Increasing manual processes',
            'Enhancing efficiency and patient care',
            'Complicating tasks'
          ],
          'answer': 'Enhancing efficiency and patient care'
        },
        {
          'question':
              'What is a key strategy for effective communication in healthcare?',
          'options': [
            'Top-down communication only',
            'Open and transparent communication',
            'Selective sharing of information'
          ],
          'answer': 'Open and transparent communication'
        },
        {
          'question':
              'What is the importance of stakeholder engagement in healthcare projects?',
          'options': [
            'Ignoring stakeholder input',
            'Gaining support and ensuring project success',
            'Limiting collaboration'
          ],
          'answer': 'Gaining support and ensuring project success'
        },
        {
          'question':
              'What is an important consideration for leadership in crisis management?',
          'options': [
            'Panic and confusion',
            'Clear communication and decisive action',
            'Indecision and delay'
          ],
          'answer': 'Clear communication and decisive action'
        },
        {
          'question':
              'How does data-driven decision-making impact healthcare management?',
          'options': [
            'Increases guesswork',
            'Improves accuracy and outcomes',
            'Reduces information use'
          ],
          'answer': 'Improves accuracy and outcomes'
        },
        {
          'question':
              'What is the role of mentorship in healthcare leadership development?',
          'options': [
            'Limiting professional growth',
            'Providing guidance and fostering talent',
            'Discouraging learning'
          ],
          'answer': 'Providing guidance and fostering talent'
        },
        {
          'question':
              'How does effective time management benefit healthcare leaders?',
          'options': [
            'Increases stress',
            'Enhances productivity and reduces burnout',
            'Leads to procrastination'
          ],
          'answer': 'Enhances productivity and reduces burnout'
        },
        {
          'question':
              'What is a key aspect of strategic human resource management in healthcare?',
          'options': [
            'Random hiring',
            'Aligning workforce planning with organizational goals',
            'Ignoring staff development'
          ],
          'answer': 'Aligning workforce planning with organizational goals'
        },
        {
          'question':
              'What is a primary function of healthcare policy in management?',
          'options': [
            'Creating unnecessary rules',
            'Guiding operational practices and ensuring compliance',
            'Reducing organizational flexibility'
          ],
          'answer': 'Guiding operational practices and ensuring compliance'
        },
        {
          'question':
              'What is an effective approach to leadership in a diverse healthcare environment?',
          'options': [
            'Promoting uniformity',
            'Valuing and leveraging diversity',
            'Ignoring differences'
          ],
          'answer': 'Valuing and leveraging diversity'
        },
        {
          'question':
              'What is a benefit of interprofessional collaboration in healthcare?',
          'options': [
            'Increased silos',
            'Improved patient outcomes and team performance',
            'Decreased communication'
          ],
          'answer': 'Improved patient outcomes and team performance'
        },
        {
          'question':
              'What is the role of emotional intelligence in healthcare leadership?',
          'options': [
            'Ignoring emotions',
            'Understanding and managing one’s own emotions and those of others',
            'Promoting emotional detachment'
          ],
          'answer':
              'Understanding and managing one’s own emotions and those of others'
        },
        {
          'question':
              'What is a crucial aspect of leadership in healthcare innovation?',
          'options': [
            'Resisting new ideas',
            'Encouraging creative solutions and continuous improvement',
            'Avoiding risk-taking'
          ],
          'answer': 'Encouraging creative solutions and continuous improvement'
        },
        {
          'question':
              'What is an important factor in patient satisfaction in healthcare management?',
          'options': [
            'Providing inadequate information',
            'Effective communication and compassionate care',
            'Neglecting patient feedback'
          ],
          'answer': 'Effective communication and compassionate care'
        },
        {
          'question':
              'What is the significance of workforce engagement in healthcare?',
          'options': [
            'Reducing employee involvement',
            'Enhancing motivation and productivity',
            'Promoting disengagement'
          ],
          'answer': 'Enhancing motivation and productivity'
        }
      ]
    },
    {
      'moduleId': 'module_id_10',
      'questions': [
        {
          'question': 'What is a recent trend in digital health?',
          'options': [
            'Paper records',
            'Telemedicine',
            'Increased waiting times'
          ],
          'answer': 'Telemedicine'
        },
        {
          'question': 'What is an advantage of digital health innovations?',
          'options': [
            'Reduced patient engagement',
            'Improved patient care',
            'Increased paperwork'
          ],
          'answer': 'Improved patient care'
        },
        {
          'question':
              'Which technology allows for remote monitoring of patients?',
          'options': ['In-person visits', 'Wearable devices', 'Paper charts'],
          'answer': 'Wearable devices'
        },
        {
          'question': 'What does EHR stand for?',
          'options': [
            'Emergency Health Response',
            'Electronic Health Record',
            'Enhanced Healthcare Report'
          ],
          'answer': 'Electronic Health Record'
        },
        {
          'question': 'What is a benefit of using EHRs?',
          'options': [
            'More storage space required',
            'Easy access to patient records',
            'Increased use of paper'
          ],
          'answer': 'Easy access to patient records'
        },
        {
          'question': 'How does telehealth benefit rural patients?',
          'options': [
            'Increases travel time',
            'Provides access to specialists',
            'Reduces the number of available doctors'
          ],
          'answer': 'Provides access to specialists'
        },
        {
          'question': 'What is a key component of mobile health (mHealth)?',
          'options': [
            'Desktop computers',
            'Smartphones and apps',
            'Paper prescriptions'
          ],
          'answer': 'Smartphones and apps'
        },
        {
          'question': 'What is the role of AI in healthcare?',
          'options': [
            'Manual data entry',
            'Predictive analytics and diagnosis',
            'Increased paperwork'
          ],
          'answer': 'Predictive analytics and diagnosis'
        },
        {
          'question': 'How can digital health improve patient adherence?',
          'options': [
            'By ignoring patient habits',
            'Through reminder apps and monitoring',
            'By reducing communication'
          ],
          'answer': 'Through reminder apps and monitoring'
        },
        {
          'question': 'What is blockchain used for in healthcare?',
          'options': [
            'Gaming',
            'Secure and transparent data exchange',
            'Cooking recipes'
          ],
          'answer': 'Secure and transparent data exchange'
        },
        {
          'question': 'What is telemedicine primarily used for?',
          'options': [
            'In-person surgeries',
            'Remote consultations',
            'Hospital maintenance'
          ],
          'answer': 'Remote consultations'
        },
        {
          'question':
              'What technology can assist in surgery with high precision?',
          'options': ['Robotics', 'Typewriters', 'Fax machines'],
          'answer': 'Robotics'
        },
        {
          'question': 'What is the benefit of cloud computing in healthcare?',
          'options': [
            'Increased local storage',
            'Scalable data storage and access',
            'More physical servers'
          ],
          'answer': 'Scalable data storage and access'
        },
        {
          'question':
              'What is a key benefit of virtual reality (VR) in healthcare?',
          'options': [
            'Enhanced physical therapy',
            'Increased use of paper charts',
            'Reduced patient engagement'
          ],
          'answer': 'Enhanced physical therapy'
        },
        {
          'question': 'What does IoT stand for?',
          'options': [
            'Internet of Things',
            'Internal Operation Tools',
            'Integrated Online Technology'
          ],
          'answer': 'Internet of Things'
        },
        {
          'question': 'What is a use of IoT in healthcare?',
          'options': [
            'Connecting medical devices',
            'Increasing paperwork',
            'Manual patient monitoring'
          ],
          'answer': 'Connecting medical devices'
        },
        {
          'question': 'How can big data benefit healthcare?',
          'options': [
            'By reducing data',
            'Through improved insights and decision-making',
            'Increasing manual entry'
          ],
          'answer': 'Through improved insights and decision-making'
        },
        {
          'question': 'What is a challenge of digital health implementation?',
          'options': [
            'Instant success',
            'Data privacy and security',
            'No training needed'
          ],
          'answer': 'Data privacy and security'
        },
        {
          'question': 'What does interoperability refer to in healthcare IT?',
          'options': [
            'Isolation of systems',
            'Ability to work across different systems',
            'Lack of communication'
          ],
          'answer': 'Ability to work across different systems'
        },
        {
          'question': 'How does digital health support personalized medicine?',
          'options': [
            'By treating all patients the same',
            'Through data-driven personalized treatment plans',
            'By ignoring patient data'
          ],
          'answer': 'Through data-driven personalized treatment plans'
        },
        {
          'question': 'What is the role of 3D printing in healthcare?',
          'options': [
            'Creating physical therapy plans',
            'Producing custom prosthetics and implants',
            'Increasing surgery time'
          ],
          'answer': 'Producing custom prosthetics and implants'
        },
        {
          'question': 'What is a benefit of using digital health records?',
          'options': [
            'Easier to lose',
            'Improved access and sharing of information',
            'Increased error rates'
          ],
          'answer': 'Improved access and sharing of information'
        },
        {
          'question':
              'How can digital health tools improve chronic disease management?',
          'options': [
            'By reducing patient monitoring',
            'By providing continuous monitoring and feedback',
            'By ignoring patient data'
          ],
          'answer': 'By providing continuous monitoring and feedback'
        },
        {
          'question': 'What is an advantage of using patient portals?',
          'options': [
            'Patients remain uninformed',
            'Patients have easy access to their health information',
            'Increased hospital visits'
          ],
          'answer': 'Patients have easy access to their health information'
        },
        {
          'question': 'How does remote patient monitoring benefit healthcare?',
          'options': [
            'Increases in-person visits',
            'Allows for continuous patient data collection',
            'Reduces access to care'
          ],
          'answer': 'Allows for continuous patient data collection'
        },
        {
          'question':
              'What technology can enhance medical training and education?',
          'options': [
            'Virtual reality (VR)',
            'Fax machines',
            'Paper textbooks'
          ],
          'answer': 'Virtual reality (VR)'
        },
        {
          'question':
              'What is a benefit of electronic prescribing (e-prescribing)?',
          'options': [
            'Handwritten errors',
            'Streamlined medication management',
            'Increased paperwork'
          ],
          'answer': 'Streamlined medication management'
        },
        {
          'question': 'How does digital health impact patient engagement?',
          'options': [
            'Reduces engagement',
            'Enhances patient involvement in their care',
            'Eliminates patient communication'
          ],
          'answer': 'Enhances patient involvement in their care'
        },
        {
          'question': 'What is the impact of AI on diagnostic accuracy?',
          'options': ['Decreases accuracy', 'Improves accuracy', 'No impact'],
          'answer': 'Improves accuracy'
        },
        {
          'question': 'What is a common use of digital health apps?',
          'options': [
            'Playing games',
            'Tracking health metrics',
            'Ignoring health data'
          ],
          'answer': 'Tracking health metrics'
        },
        {
          'question':
              'What is a benefit of telehealth for mental health services?',
          'options': [
            'Increased stigma',
            'Improved access to care',
            'Reduced confidentiality'
          ],
          'answer': 'Improved access to care'
        }
      ]
    },
  ];
  for (var module in modules) {
    firestore.collection('learning_modules').add(module).then((docRef) {
      var assignment = assignments.firstWhere(
          (a) => a['moduleId'] == 'module_id_${modules.indexOf(module) + 1}',
          orElse: () => <String, dynamic>{});

      if (assignment.isNotEmpty) {
        for (var question in assignment['questions']) {
          docRef.collection('assignments').add(question);
        }
      }
    });
  }
}

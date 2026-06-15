# Attendance Tracker Project Bootstrap

## Overview
A shell script that automates the creation of a Student Attendance Tracker workspace, configures settings via the command line, and handles system signals gracefully.

## How to Run
1. Clone the repository
2. Navigate to the project directory
3. Run the script:
```bash
bash setup_project.sh
```
4. Enter a project name when prompted (e.g. `test, demo`)
5. Choose whether to update attendance thresholds

## How to Trigger the Archive Feature
While the script is running, press **Ctrl+C** to interrupt it. The script will:
- Catch the interrupt signal (SIGINT)
- Bundle the current project state into a `.tar.gz` archive named `attendance_tracker_{input}_archive.tar.gz`
- Delete the incomplete project directory to keep the workspace clean

## Project Structure Created
```
attendance_tracker_{input}/
├── attendance_checker.py
├── Helpers/
│   ├── assets.csv
│   └── config.json
└── reports/
    └── reports.log
```

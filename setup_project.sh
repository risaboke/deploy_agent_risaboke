#!/bin/bash
cleanup() {
	echo "Interrupted! Archiving current state..."
	tar -czf attendance_tracker_${input}_archive.tar.gz $BASE_DIR
	rm -rf $BASE_DIR
	echo "Archive created and incomplete directory removed."
	exit 1
}

trap 'cleanup' SIGINT

read -p "Enter project name: " input
BASE_DIR="attendance_tracker_$input"
mkdir -p $BASE_DIR/Helpers
mkdir -p $BASE_DIR/reports

touch $BASE_DIR/attendance_checker.py
touch $BASE_DIR/Helpers/assets.csv
cat > $BASE_DIR/Helpers/config.json << 'EOF'
{
"thresholds": {
"warning": 75,
"failure": 50
},
"run_mode": "live",
"total_sessions": 15
}
EOF
touch $BASE_DIR/reports/reports.log

read -p "Do you want to update attendance thresholds? (yes/no): " answer

if [ "$answer" == "yes" ]; then
	read -p "Enter new Warning threshold (default 75): " warning
	read -p "Enter new Failure threshold (default 50): " failure

	if ! [[ "$warning" =~ ^[0-9]+$ ]] || ! [[ "$failure" =~ ^[0-9]+$ ]]; then
		echo "Invalid input! Thresholds must be numbers. Keeping defaults." 
	else
		sed -i "s/\"warning\": [0-9]*/\"warning\": $warning/" $BASE_DIR/Helpers/config.json
		sed -i "s/\"failure\": [0-9]*/\"failure\": $failure/" $BASE_DIR/Helpers/config.json
		echo "Thresholds updated successfully!"
	fi 
fi 

if command -v python3 &>/dev/null; then
	echo "Python3 is installed: $(python3 --version)"
else
	echo "Warning: Python3 is not installed."
fi

echo "Setup complete! Project created at $BASE_DIR"

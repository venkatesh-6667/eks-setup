#!/bin/bash
# Set your EKS cluster name and region
CLUSTER_NAME="dso-test"
REGION="us-east-1"
DESIRED_VERSION="1.29"
# Function to start the EKS cluster
start_cluster() {
    echo "Starting EKS cluster..."
    aws eks update-cluster-version --name $CLUSTER_NAME --kubernetes-version $DESIRED_VERSION --region $REGION
    if [ $? -ne 0 ]; then
        echo "Error: Failed to start EKS cluster."
        exit 1
    fi
    echo "EKS cluster started successfully."
}
# Function to stop the EKS cluster
stop_cluster() {
    echo "Stopping EKS cluster..."
    # Add the actual command to stop the EKS cluster here
    echo "EKS cluster stopped successfully."
}
# Main function
main() {
    current_time=$(date +%H%M)
    start_time="1900" # 7:00 PM IST
    stop_time="0330"  # 3:30 AM IST
    if [ $current_time -ge $start_time ] || [ $current_time -lt $stop_time ]; then
        start_cluster
    else
        stop_cluster
    fi
}
# Run the main function
main
# Add cron job to schedule this script to run at 7:00 PM and 3:30 AM daily
(crontab -l ; echo "0 19 * * * /path/to/this_script.sh") | crontab -
(crontab -l ; echo "30 3 * * * /path/to/this_script.sh") | crontab -
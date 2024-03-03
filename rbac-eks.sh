#!/bin/bash
# Set variables
NAMESPACE="dsolab"
SERVICE_ACCOUNT_NAME="dsolab-sa"
USERS=(
    "user1"
    "user2"
    "user3"
)
ROLES=(
    "read-only"
    "pod-creator"
    "namespace-admin"
)
VERBS=(
    "get,list,watch"
    "create"
    "get,list,create,delete"
)
RESOURCES=(
    "pods"
    "pods"
    "pods,services,deployments"
)
# Function to create service account, roles, and role bindings
create_rbac_resources() {
    # Create service account
    kubectl create serviceaccount "$SERVICE_ACCOUNT_NAME" -n "$NAMESPACE"
    # Create roles and role bindings for each user
    for ((i=0; i<${#USERS[@]}; i++)); do
        local user="${USERS[i]}"
        local role="${ROLES[i]}"
        local verb="${VERBS[i]}"
        local resource="${RESOURCES[i]}"
        # Create role
        kubectl create role "$role" --verb="$verb" --resource="$resource" -n "$NAMESPACE"
        # Create role binding
        kubectl create rolebinding "${role}-binding" --role="$role" --serviceaccount="$NAMESPACE":"$SERVICE_ACCOUNT_NAME" --user="$user" -n "$NAMESPACE"
        echo "Role '$role' and role binding '${role}-binding' created for user '$user'"
    done
}
# Main function
main() {
    echo "Creating RBAC resources..."
    create_rbac_resources
    echo "RBAC resources created successfully."
}
# Execute main function
main
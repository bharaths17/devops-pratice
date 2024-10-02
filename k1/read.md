# Kubernetes Architecture Overview

In Kubernetes, the architecture is divided into two main planes: the **Control Plane** (Master Node) and the **Data Plane** (Worker Node). This structure allows for efficient management and operation of containerized applications.

## Key Components

### Control Plane (Master Node Components)
1. **API Server**
   - Acts as the central management interface for Kubernetes, exposing the API to external clients.
   - Serves as the core component that facilitates communication between different parts of the system.

2. **Etcd**
   - A distributed key-value store that holds all cluster-related data.
   - Functions as the source of truth for the cluster's state and configuration.

3. **Scheduler**
   - Receives information from the API server to allocate resources and schedule pods onto worker nodes based on available resources and policies.

4. **Controller Manager**
   - Responsible for regulating the state of the system and ensuring that desired states (e.g., pod replicas) are maintained.
   - Manages various controllers, such as the ReplicaSet controller.

### Data Plane (Worker Node Components)
5. **Kubelet**
   - Ensures that containers are running in a pod and handles the lifecycle of pods.
   - Communicates with the API server to report the status of the node and the pods it manages.    

6. **Kube-Proxy**
   - Manages network communication and routing between services and pods.
   - Provides load balancing and service discovery by managing IP addresses for services.

7. **Container Runtime**
   - Responsible for pulling container images from repositories and running containers.
   - Supports various container formats, enabling the execution of application containers within the cluster.

## Summary
Kubernetes is built on a robust architecture that separates control and data planes, consisting of essential components that work together to orchestrate containerized applications efficiently. Understanding these components is crucial for managing and scaling applications effectively within a Kubernetes cluster.

![image](https://github.com/user-attachments/assets/b1384bf1-68ea-4fa0-9f13-d9838f358b2e)


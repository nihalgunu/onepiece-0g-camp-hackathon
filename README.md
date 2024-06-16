# OnePieceLabs-OG-CAMP-Hackathon

# Usopp LLM Chatbot dApp using Federated Learning on 0p.ai

## Overview

This application is designed to manage user feedback efficiently by leveraging blockchain technology. The architecture includes an iOS app that captures user feedback, an Express server that processes the feedback, and a smart contract system that ensures secure and decentralized storage and handling.

## Architecture Components

1. **iOS App**: Captures user feedback and uploads it to the Express server.
2. **Express Server**: Receives the feedback from the iOS app and processes it before interacting with the smart contract.
3. **Smart Contract**: Secures and stores the feedback on the blockchain, enforcing predefined rules and conditions.
4. **Flow Contract**: Manages the flow and handling of feedback within the blockchain system.

## Key Variables Addressed

- **Feedback Capture**: The iOS app ensures that user feedback is captured accurately and efficiently.
- **Data Processing**: The Express server processes the feedback and prepares it for blockchain storage.
- **Blockchain Security**: The smart contract guarantees the security and immutability of the feedback data.
- **Flow Management**: The flow contract ensures that the feedback is handled according to predefined rules and conditions within the blockchain.

## Technologies Used

- **iOS**: Swift-based app for capturing and uploading user feedback.
- **Express Server**: Node.js server for processing feedback data.
- **Blockchain**: Utilizes smart contracts and flow contracts for secure and decentralized feedback management.
- **AWS Bedrock**: Utilized to host the llm model.

## Installation and Setup

### iOS App

1. **Clone the Repository**:
    ```bash
    git clone <repository-url>
    ```
2. **Open in Xcode**:
    Open the project in Xcode and configure the necessary settings.

3. **Install Dependencies**:
    Use CocoaPods or Swift Package Manager to install any required dependencies.

4. **Run the App**:
    Build and run the app on your iOS device or simulator.

### Express Server

1. **Clone the Repository**:
    ```bash
    git clone <repository-url>
    ```
2. **Install Dependencies**:
    ```bash
    cd server
    npm install
    ```
3. **Start the Server**:
    ```bash
    npm start
    ```

### Smart Contract

1. **Deploy Smart Contract**:
    Follow the instructions to deploy the smart contract to 0J.

2. **Configure Contracts**:
    Update the Express server configuration with the deployed smart contract address and network details.

## Usage

1. **Submit Feedback**:
    Open the iOS app and submit your feedback through the provided form.
2. **Process Feedback**:
    The feedback is sent to the Express server for processing.
3. **Store Feedback**:
    The processed feedback is stored on the blockchain via the smart contract.
4. **Manage Flow**:
    The flow contract ensures the feedback is handled according to the predefined rules and conditions.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

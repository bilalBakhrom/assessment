# My Weather App

## Project Overview

### Architecture
The app is built using the MVVM-C (Model-View-ViewModel-Coordinator) architecture, providing a clear separation of concerns, enhanced testability, and improved manageability of the codebase.

### UI Frameworks
Used SwiftUI and UIKit.

### API Source
The weather data is sourced from the OpenWeatherMap API, accessible at [OpenWeatherMap API](https://openweathermap.org/api). This robust API provides comprehensive weather data, ensuring our app delivers accurate and up-to-date weather information.

## Project Structure

The project's core is an Xcode project complemented by several local Swift packages. These packages are strategically designed to encapsulate specific functionalities and concerns within the app, including:

- **Network**: Manages all network communications, including API requests and responses, leveraging modern Swift networking paradigms for efficient and reliable data fetching.
- **UI Components**: Houses reusable UI elements and views, crafted with both SwiftUI and UIKit, to ensure a consistent and dynamic user interface across the app.
- **Assets**: Contains all the visual assets, such as images and icons, used within the app, organized for easy access and modification.
- **Settings**: Manages app settings and configurations, allowing for flexible adjustments and customization of app behavior.

This structured approach promotes modularity and reusability and streamlines the development process, making it easier to maintain and expand the app’s capabilities.

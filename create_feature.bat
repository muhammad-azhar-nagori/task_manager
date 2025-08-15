@echo off
setlocal enabledelayedexpansion

:: Ask for feature name
set /p featureName=Enter feature name (e.g., auth): 

:: Base folder path
set basePath=lib\features\%featureName%

:: Create folder structure
mkdir %basePath%\data\datasources
mkdir %basePath%\data\models
mkdir %basePath%\data\repositories
mkdir %basePath%\domain\entities
mkdir %basePath%\domain\repositories
mkdir %basePath%\domain\usecases
mkdir %basePath%\presentation\cubit
mkdir %basePath%\presentation\view
mkdir %basePath%\presentation\widgets

:: Create Dart files
:: Data layer
echo // Remote and Local data sources for %featureName% > %basePath%\data\datasources\%featureName%_remote_data_source.dart
echo // Local data source for %featureName% >> %basePath%\data\datasources\%featureName%_local_data_source.dart
echo // Model class for %featureName% > %basePath%\data\models\%featureName%_model.dart
echo // Repository implementation for %featureName% > %basePath%\data\repositories\%featureName%_repository_impl.dart

:: Domain layer
echo // Entity for %featureName% > %basePath%\domain\entities\%featureName%_entity.dart
echo // Repository interface for %featureName% > %basePath%\domain\repositories\%featureName%_repository.dart
echo // Use case for %featureName% > %basePath%\domain\usecases\example_usecase.dart

:: Presentation layer
echo // Cubit for %featureName% feature > %basePath%\presentation\cubit\%featureName%_cubit.dart
echo // States for %featureName% feature > %basePath%\presentation\cubit\%featureName%_state.dart
echo // View for %featureName% feature > %basePath%\presentation\view\%featureName%_view.dart
echo // Widget for %featureName% feature > %basePath%\presentation\widgets\%featureName%_widget.dart

echo Feature '%featureName%' structure created successfully!
pause

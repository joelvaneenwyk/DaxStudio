# DAX Studio

## Building DAX Studio

All of the dependencies for DAX Studio are available as nuget packages, so doing a nuget restore should be enough to build this solution in Visual Studio 2022.

When preparing to make changes in order to submit a pull request you should create a feature branch off the `develop` branch. The develop branch contains the current development build of the code including any new features. The master branch only contains the code for the last stable release.

We merge from develop to master when doing a public release.

See the following for details about [debugging](./docs/debugging.md) DAX Studio.

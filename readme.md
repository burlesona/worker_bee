# Worker Bee

A simple CoffeeScript App to demonstrate interaction with the AgileZen API.

## Installation / Testing

The app is just an HTML page that load javascript. Clone the repo anywhere and open `index.html` in a modern browser.

To test, use the API key provided on the login screen.

Alternatively, load the demo here: http://eighty-b.com/worker-bee/

## Concept

The Kanban Board on AgileZen is a great way to get an overview of what's going on in a project. But, what if you're not a project manager? For individual team members, seeing the whole Kanban Board and figuring out what to do next could be overwhelming.

Worker Bee presents a project as a stack of to-do lists. Each story that is either "Ready" or "Working" is presented to the user, and the user can check off tasks as they are complete. When all the tasks are complete, the story is marked as "ready to pull" so the project manager knows to advance it on the board.

## Overview

A basic overview of how the app functions is as follows:

1. The app uses localStorage to persist an API key. If one is stored, it resumes where you last were. If one is not found, it presents a login handler. The login handler accepts an API key and tries to use it in a request to `get /me`. If this request is successfull, the login handler persists the current user's information and restarts the app.

2. The app checks if a project is loaded, and if not it presents a project selector for the user to select a project.

3. When a project is selected the app sets the projectID in localStorage and shows the story/task view for that project.

That's it, pretty simple.

## Layout

The app is structured as a simple HTML page with three UI viewports: `main`, `toolbar`, and `session`.

## Code Structure

The app is structured as a microframework with the following key classes:

1. Hive.Core (application.js): This object literal links together the app's other classes and handles routing of key events.

2. Hive.Controller (controller.js): This object loads resources and renders UI objects to viewports.

3. Hive.Views (views.js): This object holds templates for each UiObject.

4. Hive.UiObject (ui.js): This is a superclass for all UI elements. It defines a basic pattern for loading data into UI objects from the API and rendering them to a viewport or parent object.

The above classes define a loosely MVC-like pattern to keep the code orderly.

## Libraries

The app includes and uses requireJS and jQuery.
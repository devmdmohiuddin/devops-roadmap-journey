# Day 3: Hello World App with Unit Test

## Overview

This project is part of my **DevOps Roadmap Journey**.

It contains a simple JavaScript `add()` function and a unit test written with **Jest**. The goal is to learn the fundamentals of unit testing before moving on to more advanced DevOps topics.

Although the project is intentionally small, it will be reused later in the roadmap:

* **Day 19:** Containerize the application with Docker.
* **Days 27–30:** Build a complete CI/CD pipeline to automatically build and test the application.

## Project Structure

```text
.
├── app.js
├── app.test.js
├── package.json
└── README.md
```

## Getting Started

### Install dependencies

```bash
npm install
```

### Run the tests

```bash
npm test
```

If everything is working correctly, Jest will report that all tests have passed.

## Technologies

* JavaScript
* Node.js
* Jest

## Learning Objectives

* Export and import JavaScript modules
* Write basic unit tests with Jest
* Run tests using `npm test`
* Build a foundation for future Docker and CI/CD exercises

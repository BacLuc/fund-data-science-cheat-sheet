# Cheat sheet for the lecture "Foundations of Data Science"

For the fall semester of 2022.
Course
catalogue: [Link](https://studentservices.uzh.ch/uzh/anonym/vvz/?sap-language=DE&sap-ui-language=DE#/details/2022/003/SM/51110712)  
Website of the department: [Link](https://www.ifi.uzh.ch/en/dast/teaching/FDS.html)

## Usage

It is a cheat sheet PDF generated with LaTex.
You can download the latest release
here: [latest](https://github.com/BacLuc/fund-data-science-cheat-sheet/releases/latest)  
For the latest commit on the main branch,
the [nightly](https://github.com/BacLuc/fund-data-science-cheat-sheet/releases/nightly) release is updated.

## Contributing

The PDF is created with latex using the [cheatsheet document class](https://ctan.org/pkg/cheatsheet).  
This also needs additional dependencies, they are documented in the [image/Dockerfile](image/Dockerfile).  
For local development, you can use the [docker-compose.yml](docker-compose.yml).  
To generate the PDF, run `docker-compose up` or `docker-compose run --rm cheat-sheet-tex`.  
To format the LaTex files, run `docker-compose run --rm cheat-sheet-tex format`.  
For fast iteration, auto completion and syntax highlighting, i am
using [TeXiFy IDEA](https://plugins.jetbrains.com/plugin/9473-texify-idea).  
(With the dependencies locally installed)
The formatter used is [prettier-plugin-latex](https://www.npmjs.com/package/prettier-plugin-latex), as you can
see its not perfect, but then the formatting is not up for discussion.

### Outsource: Create Distributed Coding Tasks More Easily

[![GPL-3.0](http://img.shields.io/:license-gpl-blue.svg)](http://opensource.org/licenses/GPL-3.0)
[![Build Status](https://travis-ci.org/soodoku/abbyyR.svg?branch=master)](https://travis-ci.org/soodoku/outsource)

### The Goal

The goal is to make it easier to produce distributed Human Intelligence Tasks (HIT, nomenclature courtesy Amazon). Uses include: production of training data, general class of recognition problems such as image recognition tasks that humans do with very little error and which machines are still somewhat bad at, surveys (where the source of data is the human being surveyed) etc.

The general idea traces its ancestry to CAPTCHA, which was developed to solve two problems at the same time --- provide a way to websites to distinguish between humans and bots, and help OCR written (or heard) material. But the current technology differs from CAPTCHA in three ways. First, our goal is to not try to solve two problems at once. Thus, instead of current CAPTCHA systems, which make it as hard as possible for humans to get the answer right, we want to invert that logic -- make it as easy for humans to get the answer right. Second, we want to build it for tasks other than recognition tasks. Third, we want to attach it to a payment architecture -- a micro-task market like Amazon-M-turk or a barter system where people do a small task for free access to content, e.g. Google Consumer Surveys.

#### The MVP

To start with, the tool will be greared towards making it easy to convert a large project into tasks that can be posted 'micro-task' markets like Amazon M-Turk and Crowdflower. And initially, we limit the tool to coding of texts. The tool would take a directory of text files and create tasks as suggested by the user and spit out tasks. The general architecture of coding text is as follows:

* Each person codes multiple stories
* Each story is coded by multiple people.
* A person doesn't code the same story more than once.
* Thus each worker would see a version of a survey -- each screen will have some text and a form beneath it. No. of questions per user and no. of people who should code a story can be set by the user. And for now the HTML form can be designed by the user.

Specifically, the tool will take: 

* Path to directory with input text files
* Path to basic HTML form
* Path to output directory where surveys will be ouput
* No. of times each story needs to be coded (*n*)
* No. of stories per worker (*m*)

If there are a total of *k* stories, there will be *kn* times number of tasks and each worker will get *(kn)/m*. We will take the floor of the number and assign new stories to one more worker, who will get less than m. The tool will produce survey with one story and one html form per page and the name of the field would be the name of the story file. Each worker's survey will also have a worker ID and unique job completion ID that can be used to redeem credit.

### Installation

To get the current development version from github:

```{r install}
# install.packages("devtools")
devtools::install_github("soodoku/outsource")
```

### Usage

```{r}
creator(input_file_dir, output_file_dir, n_per_worker, n_per_story)
```

#### License
Scripts are released under [GNU V3](http://www.gnu.org/licenses/gpl-3.0.en.html).
[![Build Status](https://travis-ci.org/sul-dlss/was-registrar.svg?branch=master)](https://travis-ci.org/sul-dlss/was-registrar) [![Coverage Status](https://coveralls.io/repos/github/sul-dlss/was-registrar/badge.svg?branch=master)](https://coveralls.io/github/sul-dlss/was-registrar?branch=master)

[![GitHub version](https://badge.fury.io/gh/sul-dlss%2Fwas-registrar.svg)](https://badge.fury.io/gh/sul-dlss%2Fwas-registrar)

# was-registrar

Rails app for registering web archiving service (was) objects, seeds and crawls, in the Stanford Digital Repository.

Web Crawl objects are single objects in the Stanford Digital Repository that represent a capture of web content associated with a url.  They provide a wrapper around a set of 'WARC' files that pertain to a particular url.

Web seed objects are simple Stanford Digital Repository objects meant to be exposed in discovery systems such as SearchWorks to allow users to interact with our preserved crawl objects.

## Web Crawl object registration

While the Rails GUI is not currently used (and has been commented out in the code), the actual service code is still used.  

Crawls are registered from an included rake task, which uses code in this repo.

The original GUI code was designed to read the available crawl jobs, allowing the service manager to register the crawl job as an SDR object.

## Web Seed object registration

The Rails GUI is used as follows to register web archival seed objects:

- Seed information is imported into was-registrar
  - a tsv file containing a seed URI list (and some other info in columns)
  - optionally, an XML file containing descriptive metadata about seeds indicated in the tsv file.

- Once a seed is imported into was-registrar, it is then selected for 'registration', which calls out to the dor-services-app to register the object in DOR and get a druid.

## Operation
Operations information for the service manager is available on SUL's Consul wiki.

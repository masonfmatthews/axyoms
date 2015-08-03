Mental Mapper
======

Mental Mapper is a Rails app with a long-term goal of serving as a digital
representation of mental maps.  Currently, it is acting as a repository
for one body of knowledge, and assists in the teaching and evaluation of
students of that body of knowledge.

Technologies used:

* Ruby
* Rails
* PostgreSQL
* Bootstrap
* d3.js

Contributing to Mental Mapper
-------

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Next Steps for Mental Mapper
-------

Fixes/Improvements:

* Allow instructors to give a +1 or -1 to any concept on any assignment.
* Better name!
* Validation at grading time is not tight.  Malicious or sloppy users could potentially introduce problematic data that does not fall between 1 and 6.
* Redirection after adding or editing assignments or references is not intuitive.  You always go to the respective list page, but it would be nicer to go to the concept map with the referring concept selected.

Feature Roadmap:

* Allow students to log in and see their scores.
* Allow student feedback scores for units.
* Allow users to edit the concept graph via the UI.  This is currently tricky due to graph caching.
* Multi-tenancy.

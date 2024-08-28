# README

I created a kanban with github project to detail and manage the work load. you can access [here](https://github.com/users/yurimello/projects/4/views/1)
I added a CI with github action to ensure tests are passing before any merge

Some decisions i made:
- i choose to generate states using sidekiq, because any calculation process can largely increase the response time
- Because sidekiq most of the comunications between grid board(made with react) is made over action cable
- i tried to cover most of the backend code with tests

---

* Ruby version
3.2.2

* System dependencies
redis
postgresql

* Database creation
rails db:create

* Database initialization
rails db:migrate

* How to run the test suite
rspec

* Services (job queues, cache servers, search engines, etc.)
it uses sidekiq to generate next states and action cable to update frontend state



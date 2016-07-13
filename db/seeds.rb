# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

roles = Role.create([
  { key: 'master.role.owner', level: 0 },
  { key: 'master.role.manager', level: 0 },
  { key: 'master.role.analyst', level: 1 },
  { key: 'master.role.dba', level: 1 },
  { key: 'master.role.qa', level: 2 },
  { key: 'master.role.developer', level: 3 },
])

job_status = JobStatus.create([
  { key: 'master.job_status.initialize' },
  { key: 'master.job_status.started' },
  { key: 'master.job_status.finished' },
  { key: 'master.job_status.delivered' },
  { key: 'master.job_status.accepted' },
  { key: 'master.job_status.restart' }
])

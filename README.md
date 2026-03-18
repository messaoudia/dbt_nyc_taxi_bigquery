# dbt
This project will help you have an overview on my knowledge on DBT
The data modelization part of the project is still in progress but I will try to update it as much as possible in the next weeks, so stay tuned :)

The data we will use is NYC Taxi Data extracted through an IaC pipeline on GCP that I built and that you can find here :
[messaoudia/nyc-taxi-gcp-pipeline](https://github.com/messaoudia/nyc-taxi-gcp-pipeline)

## Disclaimers

> [!NOTE]
> DISCLAIMER #1: this project is in work in progress 🏗️


> [!IMPORTANT]
> DISCLAIMER #2:
> - This is NOT Vibe Coding at all !! A good developer keeps control of the code always of course IA was used and should be used to ease productivity but not to just code instead of the developer
> - This is handwritting code by myself that I can explain 100%

## What is dbt ? my understanding
DBT stands for Data Build Tool ;) and is an opensource data transformation tool (the T in ELT)
It is meant to be used for ease the usage of raw data wharehouses.
It helps data teams to connect and easily have a builtin modelization system inside of their raw data wharehouses. This avoids boilerplates SQL queries that are hardly maintenable to modelize data when data is becoming huge !

Also it has a versionning system that helps data teams to track their evolution + test them making it easier to maintain + allows CI/CD.

## DBT when to use it .. or not use it ?
| Context | Use | Do Not |
|---|---|---|
| Tech stack | Cloud data warehouse (GCP BQ, Databricks, AWS Redshift, DuckDB for ex.) | All your data is in OLTP database like PSQL, MySQL, Oracle and is already "modelized"
| Data volume | Large datasets to transform regularly | One-shot transformation, small scripts
| Team | Data team with several skills/contributors (code review) | Solo work but who does that ? :D
| Quality / CI/CD | Follow quality in time, versionning of transformations | No need of versionning + data testing ... bad practice !

## Main commands
> Init a project using dbt core (local only) https://docs.getdbt.com/reference/commands/init

`dbt init`

> Debug project configuration

`dbt debug`

> Run all models

`dbt run`

## Sources
- https://docs.getdbt.com/docs/introduction
- https://docs.getdbt.com/best-practices/how-we-structure/1-guide-overview?version=1.12
- https://docs.getdbt.com/best-practices/how-we-structure/2-staging?version=1.12
- And a little bit of AI of course :)

## Other Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
# blog-backend

---
This project has been developed to provide assistance to participants in completing the Angular final project of the GeleceğimAll program, which is conducted through a partnership between Allianz Turkiye and Patika.dev.

## Entity Table

![entity](https://github.com/yamacbayin/blog-backend/assets/45321194/a55ef79b-6fed-4877-9f5f-da9b81777989)

## DTOs
GET endpoints that return multiple data utilize native PostgreSQL queries to enrich the returned JSON by including additional information.

The added fields are as follows:
- User
  - post_count
  - comment_count
- Post
  - username
  - category_name
  - comment_count
- Category
  - post_count
- Comment
  - username
  - post_title

## Endpoints
All endpoint paths are the plural forms of entity names such as /posts or /users.

### GET (find all), POST, PUT endpoints

- /users
- /posts
- /categories
- /comments

> **WARNING:**
> 
> POST, PUT, and also DELETE responses are in the format of the respective endpoint's entity, not the modified type.

### GET by id, DELETE endpoints 
GET by id and DLETE endpoints require an additional path which specifies the id.

```
/path/id={id]
```

Examples:

> /users/id=1

> /posts/id=23

## PostgreSQL Scripts

Scripts for creating entity tables and generating mock data can be found in the file `blog_db_create_and_mock_scripts.sql`. These scripts are used to set up a programming blog environment, with the mock data generated by ChatGPT.

The file includes the following:

- 30 insertions for users.
- 15 category insertions covering programming topics such as Java and Angular.
- **37 actual programming blog post insertions with code examples.**
- Additionally, there are 204 comment insertions, which are related to programming but unfortunately not specifically related to the topics of the posts.

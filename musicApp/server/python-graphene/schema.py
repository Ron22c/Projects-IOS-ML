import graphene
import json
from datetime import datetime

class User(graphene.ObjectType):
    id = graphene.ID()
    user_name = graphene.String()
    created_at = graphene.DateTime()
    avatar_url = graphene.String()

    def resolve_avatar_url(self, info):
        return 'http://localhost:4000/{}/{}'.format(self.id, self.user_name)


class Post(graphene.ObjectType):
    title= graphene.String()
    content= graphene.String()


class Query(graphene.ObjectType):
    hello = graphene.String()
    users = graphene.List(User, limit= graphene.Int())
    posts = graphene.List(Post)


    def resolve_hello(self, info):
        return 'world'


    def resolve_posts(self, info):
        return[
            Post(title='Hey this is first post', content='this is first posts content'),
            Post(title='Hey this is second post', content='this is second posts content'),
        ]


    def resolve_users(self, info, limit=None):
        return[
            User(id='1', user_name='Ranajit', created_at=datetime.now()),
            User(id='2', user_name='chandra', created_at=datetime.now())
        ][:limit]


class CreateUser(graphene.Mutation):
    user = graphene.Field(User)


    class Arguments:
        user_name = graphene.String()


    def mutate(self, info, user_name):
        user = User(id="3", user_name=user_name, created_at=datetime.now())
        return CreateUser(user = user)


class CreatePost(graphene.Mutation):
    post = graphene.Field(Post)


    class Arguments:
        title= graphene.String()
        content= graphene.String()


    def mutate(self, info, title, content):
        print(info.context.get('check_list'))
        post = Post(title=title, content=content)
        return CreatePost(post=post)


class Mutation(graphene.ObjectType):
    create_user = CreateUser.Field()
    create_post = CreatePost.Field()


schema = graphene.Schema(query=Query, mutation=Mutation)
result = schema.execute(

# Post QUERY
# '''
#     mutation($title:String, $content:String){
#         createPost(title:$title, content:$content){
#             post{
#                 title
#                 content
#             }
#         }
#     }
# ''',
# context={
#     'check_list':'this is the value'
# },
# variable_values ={
#     'title': 'This is a new post',
#     'content': 'HAHAHAHAHAHAH'
# }

# Normal QUERY
# '''
# {
#     users{
#         id
#         userName
#         createdAt
#         avatarUrl
#     }
# }
# '''


'''
{
    posts{
        title
        content
    }
}
'''

# Mutation QUERY
# '''
# mutation($name: String){
#     createUser(userName:$name){
#         user{
#             id
#             userName
#             createdAt
#         }
#     }
# }
# ''',
# variable_values={
#     'name':'JOHN'
# }

# Variable QUERY
# '''query getuserName($limit:Int){
#     users(limit:$limit){
#         userName
#         id
#         createdAt
#     }
# }
# ''',
# variable_values={
#     'limit':1
# }
)
dict_result = dict(result.data.items())
print(json.dumps(dict_result, indent=2))

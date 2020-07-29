const graphql = require('graphql')
const book = require('../models/book')
const author = require('../models/author')

const{GraphQLObjectType,
  GraphQLString,
  GraphQLSchema,
  GraphQLID,
  GraphQLInt,
  GraphQLList,
  GraphQLNonNull} = graphql

const BookType = new GraphQLObjectType({
  name: 'Book',
  fields:()=>({
    id: {type: GraphQLID},
    name: {type: GraphQLString},
    genre: {type: GraphQLString},
    author:{
      type: AuthorType,
      resolve(parent, args){
        return author.findById(parent.authorId)
      }
    }
  })
})

const AuthorType = new GraphQLObjectType({
  name: 'Author',
  fields:()=>({
    id:{type: GraphQLID},
    name:{type:GraphQLString},
    age:{type:GraphQLInt},
    books:{
      type: new GraphQLList(BookType),
      resolve(parent, args){
        return book.find({authorId: parent.id})
      }
    }
  })
})

const RootQueryType = new GraphQLObjectType({
  name: 'RootQueryType',
  fields:{
    book:{
      type: BookType,
      args:{id:{type:GraphQLID}},
      resolve(parent, args){
        return book.findById(args.id)
      }
    },
    author:{
      type: AuthorType,
      args:{id:{type:GraphQLID}},
      resolve(parent, args){
        return author.findById(args.id)
      }
    },
    books:{
      type: new GraphQLList(BookType),
      resolve(parent, args){
        return book.find({})
      }
    },
    authors:{
      type: new GraphQLList(AuthorType),
      resolve(parent, args){
        return author.find({})
      }
    }
  }
})

const Mutation = new GraphQLObjectType({
  name:'mutation',
  fields:{
    addAuthor:{
      type:AuthorType,
      args:{
        name: {type:new GraphQLNonNull(GraphQLString)},
        age: {type: GraphQLNonNull(GraphQLInt)}
      },
      resolve(parent, args){
        const Author = new author({
          name: args.name,
          age: args.age
        })
        return Author.save()
      }
    },
    addBooks:{
      type:BookType,
      args:{
        name:{type: new GraphQLNonNull(GraphQLString)},
        genre:{type: new GraphQLNonNull(GraphQLString)},
        authorId: {type: new GraphQLNonNull(GraphQLID)}
      },
      resolve(parent, args){
        const Book = new book({
          name: args.name,
          genre: args.genre,
          authorId: args.authorId
        })
        return Book.save()
      }
    }
  }
})

module.exports= new GraphQLSchema({
  query: RootQueryType,
  mutation: Mutation
})

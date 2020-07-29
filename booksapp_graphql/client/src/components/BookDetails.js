import React, {Component} from 'react'
import {graphql} from 'react-apollo'
import {flowRight as compose} from 'lodash';
import {getBookQuery} from '../queries/queries'

class BookDetails extends Component {

  displayBookDetails(){
    const book= this.props.data.book;
    if(book){
      return(
        <div>
          <h2>{book.name}</h2>
          <p>{book.genre}</p>
          <p>{book.author.name}</p>
          <p>All other books by author</p>
          <ul className="otherbooks">
            {book.author.books.map(item=>{
              return(<li key={item.id}> {item.name}</li>)
            })}
          </ul>
        </div>
      )
    }
    else{
      return(
        <div> No books Selected .....</div>
      )
    }
  }

  render(){
    console.log(this.props.data.book);
    return (
      <div id='book-details'>
        {this.displayBookDetails()}
      </div>
    );
  }
}

export default graphql(getBookQuery,{
  options:(props)=>{
    return{
      variables:{
        id: props.bookId
      }
    }
  }
})(BookDetails);

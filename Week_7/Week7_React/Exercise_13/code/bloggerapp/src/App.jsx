import React, { useState } from 'react';
import BookDetails from './BookDetails';
import BlogDetails from './BlogDetails';
import CourseDetails from './CourseDetails';
import './App.css';

function App() {
  const [selected, setSelected] = useState("book");

  // Using if statement
  let componentToRender;
  if (selected === "book") {
    componentToRender = <BookDetails />;
  } else if (selected === "blog") {
    componentToRender = <BlogDetails />;
  } else if (selected === "course") {
    componentToRender = <CourseDetails />;
  }

  return (
    <div className="App">
      <h1>Blogger App</h1>

      <div>
        <button onClick={() => setSelected("book")}>Book</button>
        <button onClick={() => setSelected("blog")}>Blog</button>
        <button onClick={() => setSelected("course")}>Course</button>
      </div>

      <div style={{ marginTop: "20px" }}>
        {/* Method 1: Using if-else (stored in a variable) */}
        {componentToRender}

        {/* Method 2: Ternary */}
        {/* {selected === "book" ? <BookDetails /> : selected === "blog" ? <BlogDetails /> : <CourseDetails />} */}

        {/* Method 3: AND operator */}
        {/* {selected === "book" && <BookDetails />}
            {selected === "blog" && <BlogDetails />}
            {selected === "course" && <CourseDetails />} */}
      </div>
    </div>
  );
}

export default App;

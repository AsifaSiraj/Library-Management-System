<?php
$servername = "localhost";
$username = "your_username"; // Replace with your database username
$password = "your_password"; // Replace with your database password
$dbname = "test"; // Database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

// Get form data
$book_id = $_POST['book_id'];
$book_title = $_POST['book_title'];
$author_name = $_POST['author_name'];
$book_price = $_POST['book_price'];
$action = $_POST['action'];

if ($action == 'insert') {
  $sql = "INSERT INTO books (book_id, book_title, author_name, book_price) VALUES ('$book_id', '$book_title', '$author_name', '$book_price')";
} elseif ($action == 'select') {
  $sql = "SELECT * FROM books WHERE book_id='$book_id'";
  $result = $conn->query($sql);

  if ($result->num_rows > 0) {
    // Output data of each row
    while($row = $result->fetch_assoc()) {
      echo "id: " . $row["book_id"]. " - Title: " . $row["book_title"]. " - Author: " . $row["author_name"]. " - Price: " . $row["book_price"]. "<br>";
    }
  } else {
    echo "0 results";
  }
  $conn->close();
  exit();
} elseif ($action == 'update') {
  $sql = "UPDATE books SET book_title='$book_title', author_name='$author_name', book_price='$book_price' WHERE book_id='$book_id'";
} elseif ($action == 'delete') {
  $sql = "DELETE FROM books WHERE book_id='$book_id'";
}

if ($conn->query($sql) === TRUE) {
  echo "Record successfully $action";
} else {
  echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
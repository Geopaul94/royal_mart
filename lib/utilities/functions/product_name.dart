String truncateProductTitle(String title) {
  if (title.length <= 18) {
    return title; // Return the title as is if it's 14 characters or less
  } else {
    return title.substring(0, 19) + '...'; // Truncate and add dots
  }
}
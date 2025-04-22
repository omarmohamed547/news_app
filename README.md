
# news_app

A simple Flutter News App with a single screen that provides real-time news articles from an API. The app supports theme switching (dark/light mode), category-based filtering, source-based filtering, and search functionality. It also stores fetched news locally using Hive for offline access.

## Features

- **Single Screen UI**: Clean and responsive layout that displays all the content in one main screen.
- **Theme Switching**: Choose between light and dark themes using a drawer menu, implemented using the `Provider` package.
- **HTTP Integration**: Fetch real-time data from a public News API using the `http` package.
- **Category Filtering**: Users can view different categories (e.g., General, Sports, Business) and fetch news related to the selected category.
- **Source Filtering**: On selecting a category, sources related to that category are displayed. Clicking on a source fetches news specifically from that source.
- **Search News**: Users can search for news articles using keywords with the help of `SearchAnchor` class.
- **Local Caching**: All fetched articles are stored locally using Hive for quick access and offline viewing.

## Technologies Used

- **Flutter**
- **Provider** for state and theme management
- **http** for API requests
- **Hive** for local storage
- **SearchAnchor** for in-app search
- **Drawer** widget for navigation and theme toggling

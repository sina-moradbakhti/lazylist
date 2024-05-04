# LazyList

A Flutter package that provides a lazy-loading list view with customizable features and a controller for external control over list behavior.

## Features
- **Lazy Loading:** Loads items dynamically as the user scrolls through the list.
- **Customizable:** Customize list behavior with various parameters like padding, scroll direction, and loading indicators.
- **Supports Separators:** Optionally add separators between list items.
- **External Control with Controller:** Use a controller to manage item list, loading state, and implement custom actions.



## Installation
Add `lazylist` to your `pubspec.yaml` file:
```yaml
dependencies:
  lazylist: ^0.0.1
```

Then import it in your Dart code:
```yaml
import 'package:lazylist/lazylist.dart';
```


## Usage
### LazyList Widget

```dart
LazyList(
  controller: myLazyListController,
  itemBuilder: (context, index, item) {
    return ListTile(
      title: Text('Item $index'),
    );
    },
    separatorBuilder: (context, index) {
        return Divider();
    },
    onInit: () {
        // Perform initialization tasks
    },
    onLoadMore: (currentPage) {
        // Handle loading more items
        myLazyListController.nextPage(); // Increment page
    },
    loadingWidget: CircularProgressIndicator(), // Custom loading widget
    loadingEnabled: true, // Enable/disable loading indicator
);
```

### LazyListController

```dart
final myLazyListController = LazyListController<int>(
  items: [1, 2, 3, 4, 5],
);

// Add more items
myLazyListController.addItems([6, 7, 8]);

// Listen to item count changes
myLazyListController.addListener(() {
  // Handle changes
});
```

### Controller Methods

- **addItems(List<T> newItems):** Add a list of items to the current item list.
- **addItem(T newItem):** Add a single item to the current item list.
- **clear():** Clear all items from the list.
- **nextPage():** Increment the current page for pagination.
- **previousPage():** Decrement the current page for pagination.
- **startLoading():** Set loading state to true.
- **stopLoading():** Set loading state to false.
- **refresh():** Notify listeners to refresh the list.

`For more detailed usage and customization options, refer to the API documentation.`

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) - see the [LICENSE](LICENSE) file for details.







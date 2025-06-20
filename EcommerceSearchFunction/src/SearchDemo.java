import java.util.Arrays;
import java.util.Comparator;

public class SearchDemo {

    public static Product linearSearch(Product[] products, int id) {
        for (Product p : products) {
            if (p.productId == id) {
                return p;
            }
        }
        return null;
    }

    public static Product binarySearch(Product[] products, int id) {
        int left = 0, right = products.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (products[mid].productId == id) {
                return products[mid];
            } else if (products[mid].productId < id) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(1, "Laptop", "Electronics"),
            new Product(3, "Shirt", "Clothing"),
            new Product(2, "Book", "Education"),
            new Product(5, "Shoes", "Footwear"),
            new Product(4, "Smartphone", "Electronics")
        };

        // For binary search, we need sorted array
        Arrays.sort(products, Comparator.comparingInt(p -> p.productId));

        System.out.println("Linear Search: " + linearSearch(products, 4));
        System.out.println("Binary Search: " + binarySearch(products, 4));
    }
}

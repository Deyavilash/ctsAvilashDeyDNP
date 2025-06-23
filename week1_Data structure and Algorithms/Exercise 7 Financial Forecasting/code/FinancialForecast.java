public class FinancialForecast {

    // Recursive function to calculate future value
    public static double predictFutureValue(double currentValue, double rate, int years) {
        if (years == 0) return currentValue;
        return predictFutureValue(currentValue * (1 + rate), rate, years - 1);
    }

    // Optimized using iteration
    public static double predictFutureValueIterative(double currentValue, double rate, int years) {
        for (int i = 0; i < years; i++) {
            currentValue *= (1 + rate);
        }
        return currentValue;
    }

    public static void main(String[] args) {
        double current = 10000;
        double rate = 0.05;
        int years = 5;

        System.out.println("Recursive Prediction: " + predictFutureValue(current, rate, years));
        System.out.println("Iterative Prediction: " + predictFutureValueIterative(current, rate, years));
    }
}

using Microsoft.Data.SqlClient;

public class Program
{
    public static void Main()
    {
        //CreateTable();
        //UpdateData();
        DeleteData();

    }

    static void CreateTable()
    {
        var connectionString = @"Data Source=WIN-NK524IJNHU6;Initial Catalog=SportsShop;Integrated Security=True;Connect Timeout=30;Encrypt=True;Trust Server Certificate=True;Application Intent=ReadWrite;Multi Subnet Failover=False";
        using(var connection = new SqlConnection(connectionString))
        {
            connection.Open();

            var query = @"CREATE TABLE WareHouse
                          (Id INT PRIMARY KEY IDENTITY(1,1),
                          ProductName NVARCHAR(50),
                          Quantity INT,
                          PRICE Money);";
            var cmd= new SqlCommand(query, connection);
            var result= cmd.ExecuteNonQuery();
            Console.WriteLine(result);
        }
    }

    static void UpdateData()
    {
        var connectionString = @"Data Source=WIN-NK524IJNHU6;Initial Catalog=SportsShop;Integrated Security=True;Connect Timeout=30;Encrypt=True;Trust Server Certificate=True;Application Intent=ReadWrite;Multi Subnet Failover=False";
        using (var connection = new SqlConnection(connectionString))
        {
            connection.Open();

            var query = @"UPDATE WareHouse
                          SET Quantity=Quantity+1
                          WHERE Id=6;";

            var cmd = new SqlCommand(query, connection);
            var result = cmd.ExecuteNonQuery();
            Console.WriteLine(result);
        }


    }

    static void DeleteData()
    {
        var connectionString = @"Data Source=WIN-NK524IJNHU6;Initial Catalog=SportsShop;Integrated Security=True;Connect Timeout=30;Encrypt=True;Trust Server Certificate=True;Application Intent=ReadWrite;Multi Subnet Failover=False";
        using (var connection = new SqlConnection(connectionString))
        {
            connection.Open();

            var query = @"DELETE 
                         FROM WareHouse
                         WHERE WareHouse.ProductName='Training Hat';";

            var cmd = new SqlCommand(query, connection);
            var result = cmd.ExecuteNonQuery();
            Console.WriteLine(result);
        }

    }
}

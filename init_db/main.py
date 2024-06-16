import yaml
import mysql.connector
from typing import Dict, Any

def initialize_database():
    # Load the configuration from the YAML file
    try:
        with open('..\\config.yaml', 'r') as f:
            config: Dict[str, Any] = yaml.safe_load(f)
    except FileNotFoundError:
        print("Error: Configuration file 'config.yaml' not found.")
        exit(1)
    except yaml.YAMLError as e:
        print(f"Error: Invalid YAML configuration: {e}")
        exit(1)

    # Connect to the MySQL database
    try:
        mydb: mysql.connector.connection.MySQLConnection = mysql.connector.connect(
            host=config['mysql']['host'],
            user=config['mysql']['user'],
            password=config['mysql']['password'],
            database=config['mysql']['database']
        )
    except mysql.connector.errors.InterfaceError as e:
        print(f"Error: Could not connect to MySQL database: {e}")
        exit(1)
    except mysql.connector.errors.ProgrammingError as e:
        print(f"Error: Invalid database credentials or database does not exist: {e}")
        exit(1)

    # Create a cursor object
    mycursor: mysql.connector.cursor.MySQLCursor = mydb.cursor()

    #execute init.sql
    try:
        with open('init.sql', 'r') as f:
            sql: str = f.read()
            mycursor.execute(sql)
    except FileNotFoundError:
        print("Error: Initialization script 'init.sql' not found.")
        exit(1)
    except mysql.connector.errors.ProgrammingError as e:
        print(f"Error: Error executing SQL script: {e}")
        exit(1)

    # Commit the changes to the database
    try:
        mydb.commit()
    except mysql.connector.errors.Error as e:
        print(f"Error: Could not commit changes to database: {e}")
        exit(1)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    print("Database initialized successfully!")

if __name__ == "__main__":
    initialize_database()

#include <iostream>
#include <occi.h>
#include <iomanip> 

using oracle::occi::Environment;
using oracle::occi::Connection;
using namespace oracle::occi;
using namespace std;

int main(void)
{
   /* OCCI Variables */
   Environment* env = nullptr;
   Connection* conn = nullptr;
   Statement* stmt = nullptr;
   ResultSet* rs = nullptr;

   /* Used Variables */
   string user = "dbs211_231ncc26";
   string pass = "474811";
   string constr = "myoracle12c.senecacollege.ca:1521/oracle12c";

   try {
      env = Environment::createEnvironment(Environment::DEFAULT);

      //step 1 - Opening connection
      conn = env->createConnection(user, pass, constr);
      //cout << "Connection is Successful!" << endl;
  

      //step 2 - Creating Statement
      stmt = conn->createStatement("SELECT e.employeenumber, e.firstname, e.lastname, o.phone, e.extension FROM employees e JOIN offices o ON e.officecode = o.officecode WHERE o.city = 'San Francisco' ORDER BY e.employeenumber");


      //step 3 - Executing Statement and Store Query Result into rs (Result Set)
      rs = stmt->executeQuery();


      //step 4 Fetching data
      if (!rs->next()) 
      { 
         cout << "ResultSet is empty." << endl;
      }
      else  // if the result set in not empty
      {        
         //cout << "ResultSet is not empty." << endl;

         cout << endl;
         cout << "---------------------------";
         cout << " Report 1 (Employee Report)";
         cout << "---------------------------------" << endl;

         cout.fill(' ');
         cout << std::setw(14) << std::left << "Employee ID";
         cout << std::setw(19) << std::left << "First Name";
         cout << std::setw(19) << std::left << "Last Name";
         cout << std::setw(17) << std::left << "Phone";
         cout << std::setw(14) << std::left << "Extension" << endl;

         cout.fill('-');
         cout << std::setw(14) << std::right << "  ";
         cout << std::setw(19) << std::right << "  ";
         cout << std::setw(19) << std::right << "  ";
         cout << std::setw(17) << std::right << "  ";
         cout << std::setw(11) << std::right << "  " << endl;
         do 
         {
            cout.fill(' ');
            cout << std::setw(13) << std::left << rs->getInt(1) << " ";
            cout << std::setw(18) << std::left << rs->getString(2) << " ";
            cout << std::setw(18) << std::left << rs->getString(3) << " ";
            cout << std::setw(16) << std::left << rs->getString(4) << " ";
            cout << std::setw(13) << std::left << rs->getString(5) << endl;
         } while (rs->next()); //if there is more rows, iterate
      }


      conn->terminateStatement(stmt);//step 2 - Terminate Statement before closing connection
      env->terminateConnection(conn); //step 1 - Closing connection
      Environment::terminateEnvironment(env); //step 1 - Closing environment

   }
   catch (SQLException& sqlExcp) {
      cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
   }







   try {
      env = Environment::createEnvironment(Environment::DEFAULT);

      //step 1 - Opening connection
      conn = env->createConnection(user, pass, constr);
      //cout << "Connection is Successful!" << endl;


      //step 2 - Creating Statement
      stmt = conn->createStatement();


      //step 3 - Executing Statement and Store Query Result into rs (Result Set)
      rs = stmt->executeQuery("SELECT e.employeenumber, e.firstname, e.lastname,o.phone , e.extension, e.jobtitle, e.reportsto FROM employees e LEFT JOIN offices o ON e.officecode = o.officecode WHERE reportsto IS NULL OR reportsto = 1056 OR jobtitle = 'VP Sales' ORDER BY e.employeenumber");


      //step 4 Fetching data
      if (!rs->next())
      {
         cout << "ResultSet is empty." << endl;
      }
      else  // if the result set in not empty
      {
         //cout << "ResultSet is not empty." << endl;
         cout << endl;
         cout << "---------------------------";
         cout << " Report 2 (Manager Report)";
         cout << "---------------------------------" << endl;

         cout.fill(' ');
         cout << std::setw(14) << std::left << "Employee ID";
         cout << std::setw(19) << std::left << "First Name";
         cout << std::setw(19) << std::left << "Last Name";
         cout << std::setw(17) << std::left << "Phone";
         cout << std::setw(14) << std::left << "Extension" << endl;

         cout.fill('-');
         cout << std::setw(14) << std::right << "  ";
         cout << std::setw(19) << std::right << "  ";
         cout << std::setw(19) << std::right << "  ";
         cout << std::setw(17) << std::right << "  ";
         cout << std::setw(11) << std::right << "  " << endl;
         do
         {
            cout.fill(' ');
            cout << std::setw(13) << std::left << rs->getInt(1) << " ";
            cout << std::setw(18) << std::left << rs->getString(2) << " ";
            cout << std::setw(18) << std::left << rs->getString(3) << " ";
            cout << std::setw(16) << std::left << rs->getString(4) << " ";
            cout << std::setw(13) << std::left << rs->getString(5) << endl;
         } while (rs->next()); //if there is more rows, iterate
      }


      conn->terminateStatement(stmt);//step 2 - Terminate Statement before closing connection
      env->terminateConnection(conn); //step 1 - Closing connection
      Environment::terminateEnvironment(env); //step 1 

   }
   catch (SQLException& sqlExcp) {
      cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
   }
   return 0;
}

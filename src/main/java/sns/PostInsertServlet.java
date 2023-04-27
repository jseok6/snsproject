package sns;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/sns/PostInsertServlet")
public class PostInsertServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Read the JSON data from the request body
        BufferedReader reader = new BufferedReader(new InputStreamReader(request.getInputStream()));
        String json = "";
        if (reader != null) {
            json = reader.readLine();
        }

        // Process the JSON data (e.g., save the image URL to a database)
        // Replace this with your own logic
        System.out.println("Received JSON data: " + json);

        // Send a response back to the client
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"message\": \"Post created successfully.\"}");
	}

}

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <strings.h>
#include <sys/socket.h>
#include <resolv.h>
#include <arpa/inet.h>
#include <errno.h>


#define MY_PORT		332
#define MAX_BUF		1024

//since like 2013

int main()
{   
    int sockfd;
	struct sockaddr_in self;
	char buffer[MAX_BUF];

	/** Create streaming socket */
    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
	{
		perror("Socket");
		exit(errno);
	}

	/** Initialize address/port structure */
	bzero(&self, sizeof(self));
	self.sin_family = AF_INET;
	self.sin_port = htons(MY_PORT);
	self.sin_addr.s_addr = INADDR_ANY;

	/** Assign a port number to the socket */
    if (bind(sockfd, (struct sockaddr*)&self, sizeof(self)) != 0)
	{
		perror("socket:bind()");
		exit(errno);
	}

	/** Make it a "listening socket". Limit to 20 connections */
	if (listen(sockfd, 20) != 0)
	{
		perror("socket:listen()");
		exit(errno);
	}

	/** Server run continuously */
	while (1)
	{	int clientfd;
		struct sockaddr_in client_addr;
		int addrlen=sizeof(client_addr);

		/** accept an incomming connection  */
		clientfd = accept(sockfd, (struct sockaddr*)&client_addr, &addrlen); //accept4(sockfd, (struct sockaddr*)&client_addr, &addrlen, SOCK_NONBLOCK);
		printf("%s:%d connected\n", inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));

		/** Echo back the received data to the client */

		// im trying to enable live buffer reading for keypress (keystroke)
        char r;
        // while(r = read(clientfd, buffer, 1)) {
        //     printf("lul %c\r\n", r);
        //     printf("testing %c\r\n", buffer);
        //     printf("working %s\r\n", buffer);
        // }
		int skid;
		while(skid = recv(clientfd, buffer, sizeof(buffer), MSG_WAITALL) /*read(clientfd, buffer, 1)*/) {
			// i need a replace function to remove \r\n. 
			// read(clientfd, buffer, 1);
			printf("Full buffer: %s\r\n\r\n", buffer);
			if(strlen(buffer) > 6) {
				printf("Full buffer: %s\r\n\r\n", buffer);
				if(strlen(buffer) > 15) {
					memset(buffer, 0, sizeof(buffer));
				}
			}
			
			if(strlen(buffer) > 5)  {
				memset(buffer, 0, sizeof(buffer));
			}
			
			printf("Current Buffer: %s\r\n", buffer); 
		}

		// send(clientfd, buffer, read(clientfd, buffer, 0), 0);

		/** Close data connection */
		// close(clientfd);
	}

	/** Clean up */
	close(sockfd);
	return 0;
}

Purpose:

	- In this demo, you will create and manage configuration data using Parameter Store within Amazon Web Services Systems Manager.

	- Parameter Store is a feature of Amazon Web Services Systems Manager that allows you to store:

	- Configuration data (e.g., database endpoints)
	- Secrets (e.g., passwords)

	- It supports:

	- Hierarchical structure using paths
	- Encryption via AWS KMS
	- Fine-grained access control via IAM


Creating Parameters:

	We will create the following parameters:

	/my-cat-app/dbstring        db.allthecats.com:3306
	/my-cat-app/dbuser          bosscat
	/my-cat-app/dbpassword      amazingsecretpassword1337 (encrypted)
	/my-dog-app/dbstring        db.ifwereallymusthavedogs.com:3306
	/rate-my-lizard/dbstring    db.thisisprettyrandom.com:3306



Key Concepts: 

	Parameters are stored in a path-like format:
		/application/environment/config

	SecureString vs String:
	
		String → Plain text values
		SecureString → Encrypted using AWS KMS
	
	Path-Based Queries:

		Using paths allows you to:

		Group related parameters
		Retrieve multiple values efficiently



Why Use Parameter Store?

	Advantages:

		Centralized configuration management
		Built-in encryption
		Seamless integration with AWS services

	Tradeoffs:

		Simpler than Secrets Manager (but fewer advanced features)
		Slight latency when fetching values at runtime






Implementation Steps:


	Linux Commands:
		
		/my-cat-app/dbstring        db.allthecats.com:3306
		/my-cat-app/dbuser          bosscat
		/my-cat-app/dbpassword      amazingsecretpassword1337 (encrypted)
		/my-dog-app/dbstring        db.ifwereallymusthavedogs.com:3306
		/rate-my-lizard/dbstring    db.thisisprettyrandom.com:3306

		# GET PARAMETERS (if using cloudshell)
		aws ssm get-parameters --names /rate-my-lizard/dbstring
		aws ssm get-parameters --names /my-dog-app/dbstring
		aws ssm get-parameters --names /my-cat-app/dbstring
		aws ssm get-parameters-by-path --path /my-cat-app/
		aws ssm get-parameters-by-path --path /my-cat-app/ --with-decryption



	*** Refer to screenshot 1 ***

		- We started by going to Systems Manager → Parameter Store


	*** Refer to screenshot 2 ***

		- An example using the first Parameter
		- You can kind of see what it does. You can call this single string that points to this value.
		- String is a singular string, StringList is basically a CSV and SecureString is encrypted through KMS


	*** Refer to screenshot 3 ***

		- Notice how when we go to create new parameters, there is a hierarchy “file structure”
		- Look at the attached lessoncommands.txt and create the rest of the parameters


	*** Refer to screenshot 4 ***

		- Example of the password parameter being a SecureString

	*** Refer to screenshot 5 ***

		- Our 5 Parameters

	*** Refer to screenshot 6 ***

		- Bringing up Cloudshell

	*** Refer to screenshot 7 ***


		- Example output of the gets. If you don’t put —decryption you’ll see the ecrypted value
		- Also notice that you can get everything from a certain path


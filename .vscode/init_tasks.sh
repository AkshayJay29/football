echo "Setting the greeting"
sed -i "s/USER_NAME/$GITPOD_GIT_USER_NAME/g" ${GITPOD_REPO_ROOT}/README.md
echo "Creating the gitpod user in MySQL"
RESULT="$(mysql -sse "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = 'gitpod')")"
if [ "$RESULT" = 1 ]; then
  echo "gitpod already exists"
else
  mysql -e "CREATE USER 'gitpod'@'%' IDENTIFIED BY '';" -u root
  echo "Granting privileges"
  mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'gitpod'@'%' WITH GRANT OPTION;" -u root
fi
echo "Creating .sqliterc file"
echo ".headers on" > ~/.sqliterc
echo ".mode column" >> ~/.sqliterc
echo "Your workspace is ready to use. Happy coding!"

# Open README.md file
code README.md
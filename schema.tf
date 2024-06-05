resource "null_resource" "schema" {
  provisioner "local-exec" {
    command = <<EOT
      cd /tmp
      curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
      unzip -o mongodb.zip
      cd mongodb-main
      wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

      # Ensure the file was downloaded successfully
      if [ -f "global-bundle.pem" ]; then
        mongo --tls --host roboshop-dev-docdb.cluster-ctay6m2mm9l4.us-east-1.docdb.amazonaws.com:27017 --tlsCAFile global-bundle.pem --username admin1 --password roboshop1 < catalogue.js
        mongo --tls --host roboshop-dev-docdb.cluster-ctay6m2mm9l4.us-east-1.docdb.amazonaws.com:27017 --tlsCAFile global-bundle.pem --username admin1 --password roboshop1 < users.js
      else
        echo "Failed to download the global-bundle.pem file"
        exit 1
      fi
      EOT
  }
}

# resource "null_resource" "schema" {

#     depends_on = [aws_docdb_cluster.docdb]

#   provisioner "local-exec" {
#     command = <<EOF
#     cd /tmp
#     wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

#     curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
#     unzip -o mongodb.zip
#     cd mongodb-main
#     mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint} --sslCAFile global-bundle.pem --username admin1 --password roboshop1 < catalogue.js
#     mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint} --sslCAFile global-bundle.pem --username admin1 --password roboshop1 < users.js
#     EOF
#   }
# }
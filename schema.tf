resource "null_resource" "schema" {

    depends_on = [aws_docdb_cluster.docdb]

  provisioner "local-exec" {
    command = <<EOF
    cd /tmp
    wget https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
    
    curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
    unzip -o mongodb.zip
    cd mongodb-main
    mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint} --tlsCAFile global-bundle.pem --username admin1 --password roboshop1 < catalogue.js
    mongo --ssl --host ${aws_docdb_cluster.docdb.endpoint} --sslCAFile global-bundle.pem --username admin1 --password roboshop1 < users.js
    EOF
  }
}
terraform {
  backend "gcs" {
    bucket = "tfavlidator-remotestate-01"
    prefix = "env/test"
  }
}

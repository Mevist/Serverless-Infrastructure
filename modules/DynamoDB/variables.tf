variable config {
    description = "The default configuration for dynamoDB"
    type = map(any)
    default = {
        "billing_mode"   = "PROVISIONED",
        "read_capacity"  = 5,
        "write_capacity" = 5
    }
}
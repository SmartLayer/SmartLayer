
## Get public key from a private key

````
$ openssl pkey -pubout -in /var/local/htdocs/certs/privkey.pem 
-----BEGIN PUBLIC KEY-----
MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAE5rbbvxOTt7YLZrtxo5gprf7Uwb8sdBRj
YnLy6k65eSsykjarNg/KI/nNXGbgvhp6XV77IvCLXZueW1qL2AdUZ1XlFcwA0z7d
cbxMuP/Rw4GFl4jot3ye8MfIwaP4M1hc
-----END PUBLIC KEY-----
````

## Get human readable information from a private key

````
$ openssl ec -in /var/local/htdocs/certs/privkey.pem  -text -noout
read EC key
Private-Key: (384 bit)
priv:
    [snip]
pub:
    04:e6:b6:db:bf:13:93:b7:b6:0b:66:bb:71:a3:98:
    29:ad:fe:d4:c1:bf:2c:74:14:63:62:72:f2:ea:4e:
    b9:79:2b:32:92:36:ab:36:0f:ca:23:f9:cd:5c:66:
    e0:be:1a:7a:5d:5e:fb:22:f0:8b:5d:9b:9e:5b:5a:
    8b:d8:07:54:67:55:e5:15:cc:00:d3:3e:dd:71:bc:
    4c:b8:ff:d1:c3:81:85:97:88:e8:b7:7c:9e:f0:c7:
    c8:c1:a3:f8:33:58:5c
ASN1 OID: secp384r1
NIST CURVE: P-384
````

## Get human readable information from a certificate

````
$ openssl x509 -in /var/local/htdocs/certs/*.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            6c:2c:1b:e5:de:13:ef:d2:6a:e1:cc:c9:e5:bf:fd:b3
        Signature Algorithm: ecdsa-with-SHA256
        Issuer: C = GB, ST = Greater Manchester, L = Salford, O = Sectigo Limited, CN = Sectigo ECC Domain Validation Secure Server CA
        Validity
            Not Before: Aug 19 00:00:00 2021 GMT
            Not After : Sep 19 23:59:59 2022 GMT
        Subject Public Key Info:
            Public Key Algorithm: id-ecPublicKey
                Public-Key: (384 bit)
                pub:
                    04:e6:b6:db:bf:13:93:b7:b6:0b:66:bb:71:a3:98:
                    29:ad:fe:d4:c1:bf:2c:74:14:63:62:72:f2:ea:4e:
                    b9:79:2b:32:92:36:ab:36:0f:ca:23:f9:cd:5c:66:
                    e0:be:1a:7a:5d:5e:fb:22:f0:8b:5d:9b:9e:5b:5a:
                    8b:d8:07:54:67:55:e5:15:cc:00:d3:3e:dd:71:bc:
                    4c:b8:ff:d1:c3:81:85:97:88:e8:b7:7c:9e:f0:c7:
                    c8:c1:a3:f8:33:58:5c
                ASN1 OID: secp384r1
                NIST CURVE: P-384
````

Return-Path: <akuster@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11333C6FD1D
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 20:43:14 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.web11.113799.1680640984247882866
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Apr 2023 13:43:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=SQVVDyES;
 spf=pass (domain: mvista.com, ip: 209.85.128.179, mailfrom: akuster@mvista.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5416698e889so639661287b3.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1680640983;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aeAbgl3+AM/klnCnfeIL3T0hjBLWtUJ4ISxBLDxqYps=;
        b=SQVVDyESkmiQFj/7sk2YTM+mB8mBW1LHsss0frWaCvnsazh5k6FiC/ZYdknLKNR8Ps
         s/Z4hr4JAIRlP2LI09/1q4/3MO9BNDqb6aqIVb1s614w9ESw/eC6pcBTj8EUhcJn4ecJ
         7TI57lzOwCkYx5FujQF9Jb/+5JyYEhYfItSw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680640983;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeAbgl3+AM/klnCnfeIL3T0hjBLWtUJ4ISxBLDxqYps=;
        b=YsMthNVbJiOPu7tefHzmW+JaiyWt9NsyPeVJYIAqvj6G0jFAJj5MCf/BoAialFOkIB
         XT8zZhOL4yFG1QGU6gVJGbxWe12pyECKOLFD1vXT5T84qysN/hAs1A8Ef7W0yAp6X9D9
         fkBw/T2lwSrkEYZX6CPZworCRNrhJDmcbfOlB9Rxz3TsThOKd7TSrgG370U0ChHE8la4
         n27PUv2xMchcKXr8xMV7fgPVj6eS27lcDjrnSAT7yoO3vcrUC4UwdVJfRZwhwkFnc5qJ
         MZpizTdASu40goHec+ik2NxyWrwzaUz6B2YeuvfiUs9xqy3FUeeXlPebFBtoVQB1mqfy
         PahQ==
X-Gm-Message-State: AAQBX9dXQehLCgxV4jSYTzAF/ZcmXpI0Hy56erBINaGCi9IJzh8dfRXU
	YLxkK3T5+sxQxaV0vyvId3B6gw==
X-Google-Smtp-Source: AKy350ZVTl8K8O6I+d+Kj6MHbGvXYZimTWSsp4Zr0ivu7ryGQei3Q3uk1lyScJqgBY2Rqk/sXSXymQ==
X-Received: by 2002:a0d:e689:0:b0:52e:c985:f70d with SMTP id p131-20020a0de689000000b0052ec985f70dmr435460ywe.7.1680640983373;
        Tue, 04 Apr 2023 13:43:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:9190:ba10:36f6:c20d:238e:7162? ([2600:1700:9190:ba10:36f6:c20d:238e:7162])
        by smtp.gmail.com with ESMTPSA id ck24-20020a05690c0b9800b00549143fb1a5sm2114724ywb.92.2023.04.04.13.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 13:43:02 -0700 (PDT)
Message-ID: <fc8a7686-5c56-c605-2d69-8afbb8b477d2@mvista.com>
Date: Tue, 4 Apr 2023 16:43:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at
 once
To: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, martin.jansa@gmail.com
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
 <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com>
 <CA+cAkepKcDJSYMq7tbY=27QTaMq8AQXHqevfmux4ka43A4htQQ@mail.gmail.com>
From: akuster <akuster@mvista.com>
In-Reply-To: <CA+cAkepKcDJSYMq7tbY=27QTaMq8AQXHqevfmux4ka43A4htQQ@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d3d73505f888b8a7"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 20:43:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14635

--000000000000d3d73505f888b8a7
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/4/23 1:07 PM, Frédéric Martinsons wrote:
>
>
> On Tue, 4 Apr 2023 at 18:50, akuster <akuster@mvista.com> wrote:
>
>
>
>     On 4/1/23 11:21 AM, Frederic Martinsons wrote:
>     > From: Frederic Martinsons <frederic.martinsons@gmail.com>
>     >
>     > Instead of only display the first and stop.
>     > For recipe (crago based) that can contains several artifacts
>     > to fetch with their checksum, it will particularly handy
>     > to display all of missing one.
>     >
>     > An example of error message would be
>
>     I am confused. Is this patch supposed to add the pkg version or
>     not?  I
>     am not seeing any. Any ideas?
>
>     I will be holding off branching meta-security until my 4 rust recipes
>     can build again.
>
>     -armin
>
>
> Hello,
>
> This patch is only for showing all missing checksum on crates for a 
> recipe.
> To build the checskum list (with the version), you can use bitbake -c 
> update_crates <your recipe>

update_crates fails when it starts to traverse  into the vendor dir. It 
can't parse the Cargo.toml files correctly.


> and if you start from a pristine, you should have an error which will 
> contain
> all the data you want to copy/paste (if you have this present patch in 
> bitbake)
>
> The naming for pkg and version is already included in 
> cargo-update-recipe-crates.bbclass 
> <https://git.openembedded.org/openembedded-core/tree/meta/classes-recipe/cargo-update-recipe-crates.bbclass?id=1795e98a04ad09b011afcc7cc3bf6dc49475b19a> from oe-core 
> master:
> see 
> https://git.openembedded.org/openembedded-core/commit/?id=1795e98a04ad09b011afcc7cc3bf6dc49475b19a
>


--000000000000d3d73505f888b8a7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIR4QYJKoZIhvcNAQcCoIIR0jCCEc4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg8qMIIGTjCCBTagAwIBAgIQBK55YGZmkBq5xX+mbFvczTANBgkqhkiG9w0BAQsFADBlMQswCQYD
VQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29t
MSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgQ0EwHhcNMTMxMTA1MTIwMDAwWhcN
MjgxMTA1MTIwMDAwWjBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYD
VQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDc+BEjP2q178AneRstBYeiEEMx3w7U
FRtPd6Qizj6McPC+B47dJyq8AR22LArK3WlYH0HtagUf2mN4WR4iLCv4un7JNTtW8R98Qn4lsCMZ
xkU41z1E+SB8YK4csFoYBL6PO/ep8JSapgxjSbZBF1NAMr1P5lB6UB8lRejxia/N/17/UPPwFxH/
vcWJ9b1iudj7jkUEhW2ZzcVITf0mqwI2Reo2119q4hqCQQrc6dn1kReOxiGtODwT5h5/ZpzVTdlG
2vbPUqd9OyTDtMFRNcab69TvfuR7A+FEvXoLN+BPy4KKDXEY5KbgiSwb87JzPMGwkp4Yfb2rfcV9
CKEswp9zAgMBAAGjggL4MIIC9DASBgNVHRMBAf8ECDAGAQH/AgEAMA4GA1UdDwEB/wQEAwIBhjA0
BggrBgEFBQcBAQQoMCYwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTCBgQYD
VR0fBHoweDA6oDigNoY0aHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElE
Um9vdENBLmNybDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJl
ZElEUm9vdENBLmNybDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwggGzBgNVHSAEggGq
MIIBpjCCAaIGCmCGSAGG/WwAAgQwggGSMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdpY2Vy
dC5jb20vQ1BTMIIBZAYIKwYBBQUHAgIwggFWHoIBUgBBAG4AeQAgAHUAcwBlACAAbwBmACAAdABo
AGkAcwAgAEMAZQByAHQAaQBmAGkAYwBhAHQAZQAgAGMAbwBuAHMAdABpAHQAdQB0AGUAcwAgAGEA
YwBjAGUAcAB0AGEAbgBjAGUAIABvAGYAIAB0AGgAZQAgAEQAaQBnAGkAQwBlAHIAdAAgAEMAUAAv
AEMAUABTACAAYQBuAGQAIAB0AGgAZQAgAFIAZQBsAHkAaQBuAGcAIABQAGEAcgB0AHkAIABBAGcA
cgBlAGUAbQBlAG4AdAAgAHcAaABpAGMAaAAgAGwAaQBtAGkAdAAgAGwAaQBhAGIAaQBsAGkAdAB5
ACAAYQBuAGQAIABhAHIAZQAgAGkAbgBjAG8AcgBwAG8AcgBhAHQAZQBkACAAaABlAHIAZQBpAG4A
IABiAHkAIAByAGUAZgBlAHIAZQBuAGMAZQAuMB0GA1UdDgQWBBTnAiOAAE/Y17yUC9k/dDlJMjyK
eTAfBgNVHSMEGDAWgBRF66Kv9JLLgjEtUYunpyGd823IDzANBgkqhkiG9w0BAQsFAAOCAQEATtSJ
J7n9HYd3fg8oBZDxCi/JOz69k5yQxq/6kVGHMlRr6MrBcVFcmY61+uBiGZmmB5p8Eyfb5QKihBLZ
FfYKRFfENI9tcx861qABPd7jguRFa7LrJf2AXh05kL5bQvbOkWDj+aBWDEgQzjNoe82Tq/Bqy09Y
D7l7XRsEgZ6nIuJXSSfukpMIvmkIUwI6Ll3IGfRQgE4C2bBdkbSTh/mWloFVQI5m7YLYuyhf7Uxh
7QZYKBlTEUS8RyApsgRs2IlUmTt122d4LB6SeMZVPVgSETJuvUMMTTTbe8ZC2+y+q5thTAaS447f
ISpQVwTAYKI11SSeZjcJSc/V+GWz4OJuwjCCA7cwggKfoAMCAQICEAzn4OUX2Eb+j+Vg/BvwMDkw
DQYJKoZIhvcNAQEFBQAwZTELMAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcG
A1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTEkMCIGA1UEAxMbRGlnaUNlcnQgQXNzdXJlZCBJRCBSb290
IENBMB4XDTA2MTExMDAwMDAwMFoXDTMxMTExMDAwMDAwMFowZTELMAkGA1UEBhMCVVMxFTATBgNV
BAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTEkMCIGA1UEAxMbRGln
aUNlcnQgQXNzdXJlZCBJRCBSb290IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
rQ4VzuRDgFyxh/O3YPlxEqWu3CaUiKr0zvUgOShYYAz4gNqpFZUyYTy1sSiEiorcnwoMgxd6j5Cs
iud5U1wxhCr2D5gyNnbM3t08qKLvavsh8lJh358g1x/isdn+GGTSEltf+VgYNbxHzaE2+Wt/1LA4
PsEbw4wz2dgvGP4oD7Ong9bDbkTAYTWWFv5ZnIt2bdfxoksNK/8LctqeYNCOkDXGeFWHIKHP5W0K
yEl8MZgzbCLph9AyWqK6E4IR7TkXnZk6cqHm+qTZ1Rcxda6FfSKuPwFGhvYoecix2uRXF8R+HA6w
tJKmVrO9spftqqfwt8WoP5UW0P+hlusIXxh3TwIDAQABo2MwYTAOBgNVHQ8BAf8EBAMCAYYwDwYD
VR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUReuir/SSy4IxLVGLp6chnfNtyA8wHwYDVR0jBBgwFoAU
Reuir/SSy4IxLVGLp6chnfNtyA8wDQYJKoZIhvcNAQEFBQADggEBAKIOvN/i7fDjcnN6ZJS/93Jm
2DLkQnVirofr8tXZ3lazn8zOFCi5DZdgXBJMWOTTPYNJRViXNWkaqEfqVsZ5qxLYZ4GE338JPJTm
uCYsIL09syiJ91//IuKXhB/pZe+H4N/BZ0mzXeuyCSrrJu14vn0/K/O3JjVtX4kBtklbnwEFm6s9
JcHMtn/C8W+GxvpkaOuBLZTrQrf6jB7dYvG+UGe3bL3z8R9rDDYHFn83fKlbbXrxEkZgg9cnBL5L
zpe+w2cqaBHfgOcMM2a/Ew0UbvN/H2MQHvqNGyVtbI+lt2EBsdKjJqEQcZ2t4sP5w5lRtysHCM4u
5lCyp/oKRS+i8PIwggUZMIIEAaADAgECAhABmeiIGxb92d1jHUeNPLJ7MA0GCSqGSIb3DQEBCwUA
MGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdp
Y2VydC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBDQTAeFw0yMTEwMjkw
MDAwMDBaFw0yMzEwMjcyMzU5NTlaMEAxGzAZBgNVBAMMEmFrdXN0ZXJAbXZpc3RhLmNvbTEhMB8G
CSqGSIb3DQEJARYSYWt1c3RlckBtdmlzdGEuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA60Rtp117FyjzKFRYeZrx5QdhlSA7VUEQxYtnCtN656+u6Vjq/R0I4KAIMaAEOlS3Purp
DrHBMf1gqCKZHdzCkmj5L8GtBkB6yT1NoJnBTH83TgLbRFPB3WnTFmWTSnBkFyyrkoc8JKIzu/p0
CM/+pHHH9IR5lmzdraoKnHx9ZUwaNltEPZpDWo7zxqQXS+uToztNNuhYPOZhMQmGBVOzczliElcm
+DOgmn89Va8QVYqzPglbvjsYSIk2kzaKVffLxyY2p0yvWY8w7CAEYk2gLfPuZiqIdXGYmEyKH86H
27AP1uMrYQjEw1R9VY4JrpDLehuUs/RGYWyMAjfo1NDh0QIDAQABo4IB6DCCAeQwHwYDVR0jBBgw
FoAU5wIjgABP2Ne8lAvZP3Q5STI8inkwHQYDVR0OBBYEFL0akMb3LmLy7bKAAO6QDtKy8WI7MAwG
A1UdEwEB/wQCMAAwHQYDVR0RBBYwFIESYWt1c3RlckBtdmlzdGEuY29tMA4GA1UdDwEB/wQEAwIF
oDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQwYDVR0gBDwwOjA4BgpghkgBhv1sBAEB
MCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYUGA1UdHwR+MHww
PKA6oDiGNmh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFNIQTJBc3N1cmVkSURDQS0x
LmNybDA8oDqgOIY2aHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0U0hBMkFzc3VyZWRJ
RENBLTEuY3JsMHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNl
cnQuY29tMEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRT
SEEyQXNzdXJlZElEQ0EuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQCUY9qc+vTg/KOKUB9htYLvs1km
5XF3yyLnIoMBvbmx4zatz0YddFP7UT0esHLGDEW2suAlq44A6SRd2fTUe0tyjGAxsblGwxKp0ypw
p6xjYeJAkp0nEemsYGxGSOf1HP9BIT1bFT9CHHCoX26wxtf7RF2fePncJ4wPBxFzJdecBcKgL8uN
yQnDtPyJ0DC4bVz9Z67nEFJcFTyrzbvo4sk9A8QKYANnjmCYPSEIlis8o7zERwxC/xNTgzAXzlDS
8mJM7ja9otySdENt1tyty90IOWryaSvfeHDffO0YCDvbAVCcisvjni5esAu0sDrJr+ODF4laEVBF
z4PNrDvNN2gGMYICezCCAncCAQEweTBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQg
SW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBTSEEyIEFz
c3VyZWQgSUQgQ0ECEAGZ6IgbFv3Z3WMdR408snswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIEB/DfIoN2qWqHElTsQ1N2sSW+Q0U98tiIoOSdSBC89BMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDQwNDIwNDMwM1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC0EVp70Bxd
jEAfm94ihEX8J1WSCkmQVfIBk2sP5Xoig0YLumNZMvL1HZGmHapWpQFQImam7lKwhUWP+j7Xf47i
l0UZIbC2igQ7JIbhWOz9fw2OFJZdbWr6rwdwUA6nMEEuSRnNEAnnLCwzK6aymjk731pnwb4s4EgZ
lWHG/98JOe8thsQLCujxzqIworKyrH4h5CnGAxFuwvorgn5ZqRt2W0yXu22avk43QUBbdw4rWKX2
RWSTAObJedDHlV//WHoeAVBk/hvDCpvcYCdYxJcvHkg1l7qYkhXomSAH+Pdnz5WwUS3hNAMsJ5xP
Rts5nMuU8hmok5Ljq691q+LUDpXg
--000000000000d3d73505f888b8a7--


Return-Path: <akuster@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2039FC761A6
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 11:38:18 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web11.127635.1680694695189790528
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 04:38:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=IbbPJ2vb;
 spf=pass (domain: mvista.com, ip: 209.85.210.53, mailfrom: akuster@mvista.com)
Received: by mail-ot1-f53.google.com with SMTP id r17-20020a05683002f100b006a131458abfso16270348ote.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1680694694;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U2AMd4sZCYiMPRnKDy3/vHNaShi04shioTAy3tO1oi0=;
        b=IbbPJ2vbxndXH4s84ylHZXq4ZUfPixIXJzdUeByE1fMbI1yNo7GSkbZWtBexMNPDST
         Jh+3dxkhabQ12OsMcpkJxuFopPLIIhWkgK7jys57RIpe+i2ECIZK4umXmvbUvXXikXui
         2MfOjgLes7WDL48Gc9RHw+y5zpCmj1ulZlqS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694694;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2AMd4sZCYiMPRnKDy3/vHNaShi04shioTAy3tO1oi0=;
        b=uZ7DS9oec48+R6l9ZhFLB52C62jvdxZdS3aAq6MM8wW0tl0kDldIlWmPOh0XhCujlq
         V/2KeLYQpJKcQZ+j6IsGuU0wRZW7af7wO4UpRMeExb8pGdb9Kn8MbktKrFVhC/beXWgQ
         j4LtcCPiA7lYkG+LsDba2B5OzCJoC11wFtDp9YuIYB8iGchFzp8c9KSJPxw67aKqoZyU
         ZypofI7BLwnVcfVMtnnODFrcTcFbaf0ULo8uxh4XrVgvDDa9N/uWqt+T3TEowTo3wBUW
         L6H/db5rhbYZ037ZLrThUGf6UjUtBi2dda2hQpXL6EpQk7O5zp0XRIGDivNZfW99Ppq9
         0eQw==
X-Gm-Message-State: AAQBX9fXq+rDGY67+kaj6Ea0UtgWrKLm0WayJGglLTjpaIO3XFWaTpVD
	Vkw/BvNOulXYZKfxHuccTEBQlA==
X-Google-Smtp-Source: AKy350ZmmlaAB3/YOZ+VCTCX+fxZPTL+aoMZ2S7cK81VWwNjq2xuRm+IKCyM5GJHT9sxKZcqRBpXGA==
X-Received: by 2002:a05:6830:1e24:b0:696:4ef5:e6ce with SMTP id t4-20020a0568301e2400b006964ef5e6cemr2363721otr.19.1680694694431;
        Wed, 05 Apr 2023 04:38:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:9190:ba10:36f6:c20d:238e:7162? ([2600:1700:9190:ba10:36f6:c20d:238e:7162])
        by smtp.gmail.com with ESMTPSA id c15-20020a9d6c8f000000b00690e21a46e1sm6618123otr.56.2023.04.05.04.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 04:38:14 -0700 (PDT)
Message-ID: <dc11468e-92b7-ad73-bd88-bbf60e6a42b1@mvista.com>
Date: Wed, 5 Apr 2023 07:38:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at
 once
To: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>,
 Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
 <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com>
 <CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
 <68045681-5481-80f5-30f4-e15616503dcd@mvista.com>
 <CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
 <CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com>
From: akuster <akuster@mvista.com>
In-Reply-To: <CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004082d405f8953a7c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 11:38:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14649

--0000000000004082d405f8953a7c
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/5/23 1:20 AM, Frédéric Martinsons wrote:
> I looked at the suricata recipe in meta-security and it didn't use 
> cargo-update-recipes.bbclass

Right as the recipes existed long before this new class.

>
> You should modify your rust recipes to use this class and have access 
> to "bitbake -c update_crates" .
>
> You can take some examples from , i.e python3-cryptography in 
> openembedded-core or python3-pyruvate
> in meta-python.
>
> The first issue you'll encounter is some kind of bootstrapping (since 
> update_crates needs to fetch
> to be able to write checksum but the fetcher needs the checksum ...). 
> With this error , you'll
> see all the data you need to add to the suricata-crates.inc.
>
> For curiosity, I tested locally the modification of suricata and it 
> seems that this package embeds
> unexpected Cargo.lock format (in 
> rust/vendor/alloc-no-stdlib/Cargo.lock) which doesn't contain
> a source entry (the package doesn't have any dependency).

This is exactly where things stop for me and I start trying to work 
around it.  Suricata is working on .11 and it looks better in the Crate 
department. There git sources require bootstrapping which posses it own 
challenges

> I don't know how to handle such a file (simply ignore it in the class 
> instead of raising an error ?)

There are mechanisms being used in other areas that allow for a recipe 
to skip or ignore a condition.

Thanks for taking a look, appreciate the support.

BR,
Armin
>
>
> On Tue, 4 Apr 2023 at 23:35, Martin Jansa <martin.jansa@gmail.com> wrote:
>
>     On Tue, Apr 4, 2023 at 11:08 PM akuster <akuster@mvista.com> wrote:
>
>
>
>         On 4/4/23 1:07 PM, Martin Jansa wrote:
>         > On Tue, Apr 4, 2023 at 6:50 PM akuster <akuster@mvista.com>
>         wrote:
>         >
>         >
>         >
>         >     On 4/1/23 11:21 AM, Frederic Martinsons wrote:
>         >     > From: Frederic Martinsons <frederic.martinsons@gmail.com>
>         >     >
>         >     > Instead of only display the first and stop.
>         >     > For recipe (crago based) that can contains several
>         artifacts
>         >     > to fetch with their checksum, it will particularly handy
>         >     > to display all of missing one.
>         >     >
>         >     > An example of error message would be
>         >
>         >     I am confused. Is this patch supposed to add the pkg
>         version or
>         >     not?  I
>         >     am not seeing any. Any ideas?
>         >
>         >
>         > name parameter with pkg version was added to bbclass in:
>         >
>         https://git.openembedded.org/openembedded-core/commit/?id=1795e98a04ad09b011afcc7cc3bf6dc49475b19a
>         >
>         > this change only allows all missing/incorrect checksums to
>         be showsn
>         > at the same time, instead of one checksum per do_fetch failure.
>
>         I get multiple hashes for the same package.
>
>         SRC_URI[wasi.sha256sum] =
>         "1a143597ca7c7793eff794def352d41792a93c481eb1042423ff7ff72ba2c31f"
>         SRC_URI[wasi.sha256sum] =
>         "cccddf32554fecc6acb585f82a32a72e28b48f8c4c1883ddfeeeaa96f7d8e519"
>
>         so why no version info after the pkg name?
>
>
>     Did you regenerate the SRC_URIs with updated bbclass? It works for
>     me as in:
>     https://github.com/shr-project/meta-webosose/commit/84dc9f3cc3dd85facde07ccddce0b9f2bcd90d39
>


--0000000000004082d405f8953a7c
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
AQkEMSIEIG8x6ecSOm3hNC/M5HdSrr1y8fku/LMvOndBI88Q94PqMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDQwNTExMzgxNFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCVyEVrBSlL
tUenTKISXH8eIp6u/Qht3FEo9cRUPHK+Cwqa8xMkS26PLrnM7dC+n4FuBb+vPlCKGmbIHgj0qGOM
7c6dA8a3pxWFtR0OZ92Oqa8zbI/29qQ7lObcUFxxWsEhjK+xqVa7oCpv2dZYmL8+RYz0igMSeQ4Q
NVVcl1RZbJMiSu9B08UFHtWLqGbL7Jo6AxOUOM80Ts+yNvaz49vHsOGZby/6f8X3N3BajDfmQUBW
OPfjoKzOGCWN6eTzujsg7W1By3vAvlC3/1yv6GVW/oJxtreMF1RpnpkykGp6OlLr6EVzYcfBPx5o
E6HZjwhmYjXhQAYnCsJaFxGaYBkQ
--0000000000004082d405f8953a7c--


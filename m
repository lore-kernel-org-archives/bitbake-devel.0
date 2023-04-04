Return-Path: <akuster@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE6C77B62
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 16:50:13 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web11.107417.1680627002503216219
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Apr 2023 09:50:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=YDwMkUrX;
 spf=pass (domain: mvista.com, ip: 209.85.161.41, mailfrom: akuster@mvista.com)
Received: by mail-oo1-f41.google.com with SMTP id g21-20020a4ad855000000b0053e563c2f72so4053535oov.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1680627001;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rf4y7XZNx4OLtKoJZZEGu0NpkneX8i0zSN+9HSJw4yY=;
        b=YDwMkUrX9tZgOgPDh0auxxU35VywudkWp1L+/Mb/+nNCmKYCtCyTtO/BtVMxLCYlx4
         KgzuGpkHRsn0lcnWZpIAD2zMoQVT+vIqStqUPq7ccs78bJVM7QODnhzc+XmsgE0CzCKN
         VuRTqqSNGtg5D/jYg0HVdYXDdpQJ0lMmNx2I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680627001;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rf4y7XZNx4OLtKoJZZEGu0NpkneX8i0zSN+9HSJw4yY=;
        b=R+JTvM/NHChbll4ynA5oEtx81ysai+m4sqpVXlxpAWe/LfPbGhY6sdEGG1p4KPw73j
         W6+GMrjzJKGvhtmJMUSe0HH1FcrJsp3cRLN2/QZ0zGadE21/NXZE/G/2m4crHrZvvWz9
         T5sr1eGQkK7xwGFjEmYwjLuxjhtfz+zTifcCKHBv+dVSRo3FNOtAs9h8K2SljT/dgSWM
         irKlM7N7yHLAmdu218BQgmMNfUaVko+BfkqV+rnaviKNC65Noy/PyjT9Uk5vZaRQhiKq
         3vlxo0oZQ9DK7iSL/aEnZq4wZJw1hT46Bhm8eAjHlvYAm5SqVFWmsdW+QFCDufCs9wup
         eopw==
X-Gm-Message-State: AAQBX9c0cQcdHURj8duceUP1VNhHbYu51r6hzVm25UY/DG2w1OmQoTa9
	jFg3SUWdRuIR3xfAvxZJFBTBFA==
X-Google-Smtp-Source: AKy350ZmRsp3ARsOcg7RJ9X3+aebf0dTTbZpUW3/sGhT43EOisxupLozbvPua24yLYrbCVsi/2xh0Q==
X-Received: by 2002:a4a:ab85:0:b0:53b:8b5:48d0 with SMTP id m5-20020a4aab85000000b0053b08b548d0mr1668573oon.1.1680627001647;
        Tue, 04 Apr 2023 09:50:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:9190:ba10:36a4:266a:a865:5f55? ([2600:1700:9190:ba10:36a4:266a:a865:5f55])
        by smtp.gmail.com with ESMTPSA id c192-20020a4a4fc9000000b0053b88b03e24sm5649986oob.18.2023.04.04.09.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 09:50:00 -0700 (PDT)
Message-ID: <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com>
Date: Tue, 4 Apr 2023 12:49:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at
 once
To: Frederic Martinsons <frederic.martinsons@gmail.com>,
 bitbake-devel@lists.openembedded.org
Cc: martin.jansa@gmail.com
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
From: akuster <akuster@mvista.com>
In-Reply-To: <20230401152101.19037-1-frederic.martinsons@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000073968305f885774b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 16:50:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14631

--00000000000073968305f885774b
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/1/23 11:21 AM, Frederic Martinsons wrote:
> From: Frederic Martinsons <frederic.martinsons@gmail.com>
>
> Instead of only display the first and stop.
> For recipe (crago based) that can contains several artifacts
> to fetch with their checksum, it will particularly handy
> to display all of missing one.
>
> An example of error message would be

I am confused. Is this patch supposed to add the pkg version or not?  I 
am not seeing any. Any ideas?

I will be holding off branching meta-security until my 4 rust recipes 
can build again.

-armin


>
> NOTE: Executing Tasks
> ERROR: zvariant-3.12.0-r0 do_fetch: Missing SRC_URI checksum, please add those to the recipe:
> SRC_URI[anyhow-1.0.70.sha256sum] = "7de8ce5e0f9f8d88245311066a578d72b7af3e7088f32783804676302df237e4"
> SRC_URI[chrono-0.4.24.sha256sum] = "4e3c5919066adf22df73762e50cffcde3a758f2a848b113b586d1f86728b673b"
> SRC_URI[serde-1.0.158.sha256sum] = "771d4d9c4163ee138805e12c710dd365e4f44be8be0503cb1bb9eb989425d9c9"
> SRC_URI[system-deps-1.3.2.sha256sum] = "0f3ecc17269a19353b3558b313bba738b25d82993e30d62a18406a24aba4649b"
> ERROR: zvariant-3.12.0-r0 do_fetch: Bitbake Fetcher Error: BBFetchException('There was some missing checksums in the recipe')
> ERROR: Logfile of failure stored in: /home/jenkins/yocto-poky-master/poky/build/tmp/work/core2-64-poky-linux/zvariant/3.12.0-r0/temp/log.do_fetch.1025
> ERROR: Task (/home/jenkins/yocto-poky-master/poky/meta-selftest/recipes-extended/zvariant/zvariant_3.12.0.bb:do_fetch) failed with exit code '1'
>
> Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
> ---
>   lib/bb/fetch2/__init__.py | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 31729885..1a86d8fd 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -560,7 +560,6 @@ def verify_checksum(ud, d, precomputed={}, localpath=None, fatal_nochecksum=True
>       file against those in the recipe each time, rather than only after
>       downloading. See https://bugzilla.yoctoproject.org/show_bug.cgi?id=5571.
>       """
> -
>       if ud.ignore_checksums or not ud.method.supports_checksum(ud):
>           return {}
>   
> @@ -605,11 +604,7 @@ def verify_checksum(ud, d, precomputed={}, localpath=None, fatal_nochecksum=True
>   
>           # If strict checking enabled and neither sum defined, raise error
>           if strict == "1":
> -            messages.append("No checksum specified for '%s', please add at " \
> -                            "least one to the recipe:" % ud.localpath)
> -            messages.extend(checksum_lines)
> -            logger.error("\n".join(messages))
> -            raise NoChecksumError("Missing SRC_URI checksum", ud.url)
> +            raise NoChecksumError("\n".join(checksum_lines))
>   
>           bb.event.fire(MissingChecksumEvent(ud.url, **checksum_event), d)
>   
> @@ -1728,6 +1723,7 @@ class Fetch(object):
>           network = self.d.getVar("BB_NO_NETWORK")
>           premirroronly = bb.utils.to_boolean(self.d.getVar("BB_FETCH_PREMIRRORONLY"))
>   
> +        checksum_missing_messages = []
>           for u in urls:
>               ud = self.ud[u]
>               ud.setup_localpath(self.d)
> @@ -1739,7 +1735,6 @@ class Fetch(object):
>   
>               try:
>                   self.d.setVar("BB_NO_NETWORK", network)
> -
>                   if m.verify_donestamp(ud, self.d) and not m.need_update(ud, self.d):
>                       done = True
>                   elif m.try_premirror(ud, self.d):
> @@ -1811,13 +1806,20 @@ class Fetch(object):
>                       raise ChecksumError("Stale Error Detected")
>   
>               except BBFetchException as e:
> -                if isinstance(e, ChecksumError):
> +                if isinstance(e, NoChecksumError):
> +                    (message, _) = e.args
> +                    checksum_missing_messages.append(message)
> +                    continue
> +                elif isinstance(e, ChecksumError):
>                       logger.error("Checksum failure fetching %s" % u)
>                   raise
>   
>               finally:
>                   if ud.lockfile:
>                       bb.utils.unlockfile(lf)
> +        if checksum_missing_messages:
> +            logger.error("Missing SRC_URI checksum, please add those to the recipe: \n%s", "\n".join(checksum_missing_messages))
> +            raise BBFetchException("There was some missing checksums in the recipe")
>   
>       def checkstatus(self, urls=None):
>           """
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14629): https://lists.openembedded.org/g/bitbake-devel/message/14629
> Mute This Topic: https://lists.openembedded.org/mt/97996454/1024635
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [akuster@mvista.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


--00000000000073968305f885774b
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
AQkEMSIEIOzKAnesSpNbcZsiHWYumcZuIlN1KUI3f301sNZdIzPLMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDQwNDE2NTAwMVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQACQOWrjirh
FV1m/fzBWbPqb5TyY0WWkeNfl10zxjOo4U4Flhj1mhkwlWSMNR2bPoN3lPKf9b4P6QtCewUEYmec
3FVF9HnCT6OXWp9pfhLLjAMS6IPH1evJoU8FuFZNtL6pd2s+It5wbJXKFfaJzN3kn+FXlLvhvmk7
8B1pldJTRIR34jpbJt2st7vNiU/wc9pFuHlKUohxwIrYW2CVoAv3wpG3rbrE1ShyPG4ImhYV2L5A
bT3fojOpcBOhOYuNVqxNCGicjF5stZpFz/2+5tXp4xlZkmJSZZUR3w3DpSN/ZPbxm2Q5UKgQgL+P
yVEKXkcUCrUGyXvqGa9HMSWZ5fup
--00000000000073968305f885774b--


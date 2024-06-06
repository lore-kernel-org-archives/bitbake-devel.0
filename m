Return-Path: <rudolf.streif@ibeeto.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE72C25B76
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 01:54:58 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.3895.1717638895797549891
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Jun 2024 18:54:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ibeeto-com.20230601.gappssmtp.com header.s=20230601 header.b=VdIL0z5a;
 spf=pass (domain: ibeeto.com, ip: 209.85.210.174, mailfrom: rudolf.streif@ibeeto.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7025b84c0daso358770b3a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Jun 2024 18:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ibeeto-com.20230601.gappssmtp.com; s=20230601; t=1717638894; x=1718243694; darn=lists.openembedded.org;
        h=autocrypt:subject:from:to:content-language:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7HzOu93g1bali4fum+Ylq85Zx1o0S89zpl2lPGq5HU=;
        b=VdIL0z5arT06aca4thA/aC4Db9mkFPdC0R2mV7CHJ3YCOxNF926RxUopidHrWz/Kmr
         mURh1WAZkgmKvamGRfg6W6/C9cks3RWW+hF9ZHpQonp6LIsUqU5TsNAG9ixdPnlR/2Br
         Z2WB9BR5z9bs0aIK2zrtcpnRTccwfqNK1fsPLwPBynjbi3lDkEzh/pcAFDnpdcQlBW+O
         tSZVJOIEXLFnsGb9a7UKgJzlG4Ojv/7GiylDhQaFzjMapA4uLKIwa3NMDFlNlUAoFQjM
         drh7NAijJflLZEulnWaH7hgOUtw5K5tZ94sfz2TSDmMBwWv81Ado/UGOGHXGQ7+8QmsX
         32aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717638894; x=1718243694;
        h=autocrypt:subject:from:to:content-language:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7HzOu93g1bali4fum+Ylq85Zx1o0S89zpl2lPGq5HU=;
        b=GKM3J+coP7L0XprBYWNwWhgNFIRAI2x4lBBumzm+7oz8SW2L02BzdQrA6A40rjueCv
         wSiq+QEHal2u9SdOHcCytsQ7SAh2gnGr53z6+ZRKWPqj+DQ3r7w+pcUNIbS6EZ3FeQW3
         uGDbVu/CTTR9VCWvbXSXyhhkHT3ZHhmoNlDm7hGItfhs79CJ+QU8FTvIKuMQRrov2Sf0
         zYd8Vr76X8ipGlJZff/3LM6rYEWIk7SU2K98rhekf3VlPPYxekmcP6TPsW8HhzW57nCX
         Vr77LYAVVmvlGLVycbb6jVwPZn8FgBNC+Jyjr/NrF6zuEZc4jc6tKF/Ms6DKhMQbx4PA
         EQ2Q==
X-Gm-Message-State: AOJu0YwQVBS7CXlsvE8nnoGzTI2glQJ6c4X5raknbdDAC6zr6eRlkRWg
	uisO03KsdOn9MfksB7QdRgxeydO8r9Pe64wO3HHOHg5OfjGk+vBcBdyLXGMIQwlZVck4FOQxXKk
	p
X-Google-Smtp-Source: AGHT+IGYlzkgPYG2GzgzIXrEvvKewiAV8HTzM9wB9rC/OIrcdCC6VugKG06H3KPhxMkprbe4yO1YAg==
X-Received: by 2002:a05:6a00:1d92:b0:6ec:db05:36c3 with SMTP id d2e1a72fcca58-703e594b158mr4193014b3a.4.1717638893652;
        Wed, 05 Jun 2024 18:54:53 -0700 (PDT)
Received: from ?IPV6:2600:8801:8d00:d804:cd39:5769:28bb:21e2? ([2600:8801:8d00:d804:cd39:5769:28bb:21e2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4dbab6sm149163b3a.150.2024.06.05.18.54.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 18:54:53 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------18wU4XrBlMwkQFxDebnnrwme"
Message-ID: <234ddf00-756c-4863-a508-6a0ec75558ea@ibeeto.com>
Date: Wed, 5 Jun 2024 18:54:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
From: Rudolf J Streif <rudolf.streif@ibeeto.com>
Subject: wget2
Autocrypt: addr=rudolf.streif@ibeeto.com; keydata=
 xsBNBFhQFAQBCACa5/X8dcYC25ELsL2exFTaf9QV24fFIn64+rXFqDNKuk7xed5kafscejvD
 Qpe+Co1EPSU4ybklzYlvbMvzxKfwLDADKh+HsqmUYrd/l43hbqrPLxfDUhg87WVEhjm0qyYQ
 /Qymy+7Cbh+pVNNlHULUQttkXPl3D+UOMz9se0Ook/HngDIOCyQF4rTyPnGNvd8NJmAng969
 cQD/S9LNndnK5GGrmDDOuMYwoG4qDqWvWEChncgqHfmWK/Z1AvYKdYWe9uh1N4Qb/P5AZxTM
 3sPiHrF+Y2HTdK7j7lWgtu8YzluBHdvzhC+4jUnAKjh8P/N/H6JlE3UC3dwHPOaRsnXBABEB
 AAHNKlJ1ZG9sZiBKIFN0cmVpZiA8cnVkb2xmLnN0cmVpZkBpYmVldG8uY29tPsLAdwQTAQgA
 IQUCWFAUBAIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRCNjKgpJzObdabzB/4lFMf0
 3GsVMG6C5QOLaPx6rOgj5qexCH3rfYeI3xkbGuR0a+YByzvSiCc6Ukh7YNn4UwRs6cY0fYBk
 txioE384/51QTIfCmW8ZG5X0cMC5d38LFvd/dj3KBA74HW4GoLt0cIyzy38CCOFmClTNE8xl
 lpeOfKQD3wn99w5dzXYhvajXCWwAjjpWrR84ww6xromQCDj0AubLA6xyk3t8bzFNsRCCFx+w
 Xl7keSggn6ld3f3ySIQyEK2GgZDdw+zQmgVMq4x5LZhUhGYoqbYwNy9imoBkUAZkbbViNOtX
 zaTHX/RzRHErvq56HOVqceJZIpkDnfvB1aXvfvmBhjVLmLHvzsBNBFhQFAQBCADXoLKCuF48
 5eCWhnty44o9IZJuOSiX+uVJTgVGNWkZOF61Hs2pieIOmTqk3fb9+Ao6C6IliC9ZRXyAVLD/
 RSGoLiTnWLc1uaK4P/XCM3HZfsi9ueBuNufR8yMy8/8ZqbFwRIFpPBpxHRrZnDdEd5IKsy+z
 w6QChvhpmssZy+UaKfWHILroAoS/7bKGzHo5F/dEJhxVDjgxDUDspJSHWMBh0OMKDeBik5wl
 svtV2yw7ezwWJLRsbaa8TUXd79ZJYYc3FIi0K5aXkMySh+QaQ/bE2Y5A/mCBCZ+IKhBQR36v
 tUAsTCuUAOREwSdPDVwfuoI5gfVxGyz/zrERfnXF4viHABEBAAHCwF8EGAEIAAkFAlhQFAQC
 GwwACgkQjYyoKSczm3W3fgf+NSdojthWWEqfWwym3VHK8955SeOy12xQA4ird2Ca2LYUpLNj
 s4qVFEqXSXZk4rmpGCFlMWwOjcCJOXJLR0ATfmWlvZxp1QL4res/R+SPFEyheu7TTpJ9MbyE
 fxaMSn2xRMA1V2KVJSfDoMacImVRchFclaNU31cEu6tEnNRwVcsWdTlGdA5a1ASGl4CiP8Tz
 Yf9m2KOWGjOmVgGFcIJ2QfIlMglU875YHE3W4u3YOWwUbPEr2Seyb176MvO74CUL/Nlouvce
 P41tsC5daxZnrLBQ3nw4xe4RJSzdPPkY7iF0N5R9NvBJ7WX3dwjMO4EMvdlFuNCQ2ALli/AN
 ROZj4g==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Jun 2024 01:54:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16321

This is a multi-part message in MIME format.
--------------18wU4XrBlMwkQFxDebnnrwme
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I have been using YP/OE for the longest time with Fedora. I most 
recently upgraded my build system to FC40. FC40 replaces wget with 
wget2. FTP support was removed from wget2 for good reasons.

YP versions before Scarthgap used the flag --passive-ftp by default even 
if the protocol used was not ftp. Since wget2 does not support ftp it 
also does not support (or ignore, for that matter) this option. It 
fails. From Scarthgap on the --passive-ftp is only added if the protocol 
is indeed ftp or ftps.

So far so good. However, there is another subtle issue with wget2: it 
does not like relative path components in paths provided with the -P 
option. It normalizes paths if there's one and only one relative path 
component at the beginning of the path:

  * -P ./downloads    works
  * -P ../downloads   works
  * -P ../../downloads does not work (Internal error: Unexpected
    relative path: '../..')
  * -P ./../downloads does not work (Internal error: Unexpected relative
    path: './..')
  * -P /home/user/downloads/../downloads does not work (Internal error:
    Unexpected relative path: '/home/user/downloads/..')

I am commonly using DL_DIR = "${TOPDIR}/../../downloads" to set a shared 
download directory for different projects. Of course I could replace the 
relative path with an absolute one.

The culprit is the function mkdir_path in utils.c which attempts to 
create the path components to download the files to. This would make 
sense when wget2 needs to download a directory structure from a server 
but technically it should only create the path components relative to -P.

Of course, this is not the right mailing list to complain about wget2. I 
have submitted a ticket: https://gitlab.com/gnuwget/wget2/-/issues/667. 
However, it might be of interest to the YP community since other distros 
might have already or might be in the future moving to wget2.

A Bitbake solution would be to normalize the path in the fetcher.

Thanks,
Rudi

--------------18wU4XrBlMwkQFxDebnnrwme
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>I have been using YP/OE for the longest time with Fedora. I most
      recently upgraded my build system to FC40. FC40 replaces wget with
      wget2. FTP support was removed from wget2 for good reasons.</p>
    <p>YP versions before Scarthgap used the flag --passive-ftp by
      default even if the protocol used was not ftp. Since wget2 does
      not support ftp it also does not support (or ignore, for that
      matter) this option. It fails. From Scarthgap on the --passive-ftp
      is only added if the protocol is indeed ftp or ftps.</p>
    <p>So far so good. However, there is another subtle issue with
      wget2: it does not like relative path components in paths provided
      with the -P option. It normalizes paths if there's one and only
      one relative path component at the beginning of the path:</p>
    <ul>
      <li>-P ./downloads    works</li>
      <li>-P ../downloads   works</li>
      <li>-P ../../downloads does not work (Internal error: Unexpected
        relative path: '../..')</li>
      <li>-P ./../downloads does not work (Internal error: Unexpected
        relative path: './..')</li>
      <li>-P /home/user/downloads/../downloads does not work (Internal
        error: Unexpected relative path: '/home/user/downloads/..')</li>
    </ul>
    <p>I am commonly using DL_DIR = "${TOPDIR}/../../downloads" to set a
      shared download directory for different projects. Of course I
      could replace the relative path with an absolute one.</p>
    <p>The culprit is the function mkdir_path in utils.c which attempts
      to create the path components to download the files to. This would
      make sense when wget2 needs to download a directory structure from
      a server but technically it should only create the path components
      relative to -P.</p>
    <p>Of course, this is not the right mailing list to complain about
      wget2. I have submitted a ticket:
      <a class="moz-txt-link-freetext" href="https://gitlab.com/gnuwget/wget2/-/issues/667">https://gitlab.com/gnuwget/wget2/-/issues/667</a>. However, it might
      be of interest to the YP community since other distros might have
      already or might be in the future moving to wget2.</p>
    <p>A Bitbake solution would be to normalize the path in the fetcher.</p>
    <p>Thanks,<br>
      Rudi<br>
    </p>
  </body>
</html>

--------------18wU4XrBlMwkQFxDebnnrwme--


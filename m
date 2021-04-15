Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web09.68.1618505321515729826
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Apr 2021 09:48:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QZhg3kca;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id p19so12834831wmq.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Apr 2021 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=Q0VIG2sqeXiXknncagaC9Rtk+AYI34uslVFpouxh2sU=;
        b=QZhg3kcaaeAQnuD3EdyWD1ID0vyNbyW3MH4GSxoNCa6VaYM5rGKgywH7dFj7zVzvtC
         U8V7bD6G7BAP/RY8QqNYuy72O9ody6X5HHvliMb8EHzJzYy9/FjEl8xUOjtYmty3eYIq
         FbBMizwhL1ErKbdVhNgHX067ilxcuqSLonHYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Q0VIG2sqeXiXknncagaC9Rtk+AYI34uslVFpouxh2sU=;
        b=LEZA4hBhjRm9gxnfqa2qoqCZm0NITldztNs3ful/ypwinu3+vogujYRQ4Cmk401n91
         ALnmz9BcXjn/bBs14ZWnvbRwylFdd/KDhM+s6NsA7JK8RfB+kj1Q2ZE8bY6H+005FnRz
         n/SYNDdQTQmPjKj0k6JM40MkVqHxTak1xkqNzXYAnIKIIfvJMVIQNh8ftSDq1qPr4rSB
         9176RDRG9gNWkE8iIJd0ZDAgg3TZlaNY06M9GEG7L+eaBbnc1bMYniOq9wY8jUAM0tCc
         nmVrwbWlK11B087NngWLzBim3mVBsuon2IRfpuSyiBCRfjCPK3doEZ/cUKElMUManJdR
         +/sw==
X-Gm-Message-State: AOAM532LEomshkKP4Ejb4cuchIBsUhJ4YtjeCRB9dwDUmgCUH6z1hW+W
	4ZnVuknALqQ+SNGK5wp0r0SLng==
X-Google-Smtp-Source: ABdhPJwVyN2qBW8PdecQSVc7WlrKl2EYitUoiG3E/z36EbT5Pdt3Zbrls1SJn+XEt0QL+Bf8fAC2TQ==
X-Received: by 2002:a05:600c:4f4f:: with SMTP id m15mr4030680wmq.29.1618505319946;
        Thu, 15 Apr 2021 09:48:39 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:b9e0:fe1a:1091:177b? ([2001:8b0:aba:5f3c:b9e0:fe1a:1091:177b])
        by smtp.gmail.com with ESMTPSA id b14sm4497085wrf.75.2021.04.15.09.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 09:48:39 -0700 (PDT)
Message-ID: <0420d0fbac5ddd0201a24905f7e9371df6e7e055.camel@linuxfoundation.org>
Subject: Re: [RFC PATCH 00/11] Modernise prserv
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Paul Barker <pbarker@konsulko.com>,
 bitbake-devel@lists.openembedded.org,  Joshua Watt <JPEWhacker@gmail.com>
Date: Thu, 15 Apr 2021 17:48:29 +0100
In-Reply-To: <20210412114149.4750-1-pbarker@konsulko.com>
References: <20210412114149.4750-1-pbarker@konsulko.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-04-12 at 12:41 +0100, Paul Barker wrote:
> The prserv module is converted from the old XML RPC mechinism to the more
> modern json + asyncio RPC system used by hashserv. The common code now
> shared between hashserv and prserv is moved to a new asyncrpc module. The
> startup and shutdown code within prserv is also refactored and modernised,
> using the Python multiprocessing module where possible.
> 
> These changes are not expected to land in the upcoming 3.3 release, they're
> currently submitted as an RFC to get some early review.
> 
> The following change is needed in oe-core when testing these patches, this
> can be submitted separately once these changes are past the RFC stage:
> 
>     diff --git a/meta/lib/oe/prservice.py b/meta/lib/oe/prservice.py
>     index fcdbe66c19..15ce060ff6 100644
>     --- a/meta/lib/oe/prservice.py
>     +++ b/meta/lib/oe/prservice.py
>     @@ -7,7 +7,7 @@ def prserv_make_conn(d, check = False):
>         host_params = list([_f for _f in (d.getVar("PRSERV_HOST") or '').split(':') if _f])
>         try:
>             conn = None
>     -        conn = prserv.serv.PRServerConnection(host_params[0], int(host_params[1]))
>     +        conn = prserv.serv.connect(host_params[0], int(host_params[1]))
>             if check:
>                 if not conn.ping():
>                     raise Exception('service not available')
> 
> I'm also currently working on a follow-up patch which will add a read-only
> mode to prserv.
> 
> Let me know if there are any other questions :)

These looked reasonable to me, I thought I'd try some testing. I can't
prove it yet but there were three hanging oe-selftest runs in the build
where these were included:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/2009
https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/1994
https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/2026
(all running for 2+ days)

and one that failed in runtime_test.TestImage.test_testimage_dnf:

https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/2026

I did a process trace on the centos8-ty-2 worker in case it hinted where
it was stuck and I see:

2161691 ?        S      0:00 bash /home/pokybuild/yocto-worker/oe-selftest-centos/build/scripts/bitbake-prserv-tool export /home/pokybuild/yocto-worker/oe-selftest-centos/build/build-st-1454506/export.inc
2167336 ?        Sl     0:37 python3 /home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/bin/bitbake -R conf/prexport.conf -p

the other things I could see in ps, I'd have expected. On fedora, I
saw:

2676512 ?        S      0:00 bash /home/pokybuild/yocto-worker/oe-selftest-fedora/build/scripts/bitbake-prserv-tool export /home/pokybuild/yocto-worker/oe-selftest-fedora/build/build-st-765595/export.inc
2679599 ?        Sl     0:19 python3 /home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/bin/bitbake -R conf/prexport.conf -p

and on ubuntu too:

 743847 ?        S      0:00 /bin/sh -c bitbake-prserv-tool export /home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/build-st-3944061/export.inc
 743851 ?        S      0:00 bash /home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/scripts/bitbake-prserv-tool export /home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/build-st-3944061/export.inc
 748863 ?        Sl     0:46 python3 /home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/bitbake/bin/bitbake -R conf/prexport.conf -p

For 'fun' I killed the above ubuntu processes which leads to the log output in:

https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/2026/steps/14/logs/stdio

which shows it was in prservice.BitbakePrTests.test_import_export_replace_db
and the build has now made more progress failing a few other tests. Not quite
sure what it will do from here but it seems related to this series.

Cheers,

Richard









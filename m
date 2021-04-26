Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web12.3906.1619423677097830319
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 00:54:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pyxxaCTV;
 spf=pass (domain: konsulko.com, ip: 209.85.210.44, mailfrom: paul.barker@konsulko.com)
Received: by mail-ot1-f44.google.com with SMTP id y14-20020a056830208eb02902a1c9fa4c64so14815660otq.9
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Apr 2021 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxID6gijdgNACr784HhZE/k5PNOihSwvauWs/lXaqbI=;
        b=pyxxaCTVzJgxS9t5Z5mGyVBkzUcvlGamkH+fz1M3tK6GlVkh1PLTXD3BVdDx7Wf80n
         OI1PCooaoUuds2ISrJYJt/s/Ytjl4nD8KwLd234g4DrvkV+0kKYOJm37liFDkkAaBHy2
         6gHqU+7o1imNM9fy9a1OhH9YG428SZcIjcoKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxID6gijdgNACr784HhZE/k5PNOihSwvauWs/lXaqbI=;
        b=NC99dMleuBjen4wYT2Ha5pkF8Z7T45VCVQgM0qOl1fU+m3SDpKn//WCxqdvfk3By4t
         I5qutTLxKU3rzOFUB0dNVrZZb6IemXoDnHM/MSB61EYmWdPDPBawn6pvcPgKxfVo/aQr
         dTIWhw/DKy0mjuTd4PqkRiEvIbNEAKLknvyWxDKLDPp/VGSAzLPIpgFs/SMRHykBhXgB
         QaSVp/aPeAQs5CKBlPiwmHqeR8l/o9Rz69IKiofRbIs/KM/U28pKveBHbKdPXCUuNOUn
         yxMl5pU/l31fXepHQ+DylIUWjY+Xb6YK5HzloFFHMAAGkxUtgziojHGIHFZog3sG8HPN
         PqsQ==
X-Gm-Message-State: AOAM532E8B9Tbtk7klJdNFRV61Uvsge3ssD3HVlU2OouSgyHwkQehjF8
	DeB3/h45Bh6fgd5EBaGPV1gRDK6kIxaXXkgxMtCKAA==
X-Google-Smtp-Source: ABdhPJwwh2WNhY8MPao8Ff+HfuCCRJrI6POFvLHFBVyvsQDOGQXt7z4UbGLPja6THvLvhyWg1zsu7rRspQoagkeyGE0=
X-Received: by 2002:a9d:5f0c:: with SMTP id f12mr13688914oti.258.1619423676427;
 Mon, 26 Apr 2021 00:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210412114149.4750-1-pbarker@konsulko.com> <0420d0fbac5ddd0201a24905f7e9371df6e7e055.camel@linuxfoundation.org>
In-Reply-To: <0420d0fbac5ddd0201a24905f7e9371df6e7e055.camel@linuxfoundation.org>
From: "Paul Barker" <pbarker@konsulko.com>
Date: Mon, 26 Apr 2021 08:54:26 +0100
Message-ID: <CAM9ZRVtmMVFutefCdQQwgU9W9=OgNMPhinRhYOsGdqdbmRNRNA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Modernise prserv
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Apr 2021 at 17:48, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Mon, 2021-04-12 at 12:41 +0100, Paul Barker wrote:
> > The prserv module is converted from the old XML RPC mechinism to the more
> > modern json + asyncio RPC system used by hashserv. The common code now
> > shared between hashserv and prserv is moved to a new asyncrpc module. The
> > startup and shutdown code within prserv is also refactored and modernised,
> > using the Python multiprocessing module where possible.
> >
> > These changes are not expected to land in the upcoming 3.3 release, they're
> > currently submitted as an RFC to get some early review.
> >
> > The following change is needed in oe-core when testing these patches, this
> > can be submitted separately once these changes are past the RFC stage:
> >
> >     diff --git a/meta/lib/oe/prservice.py b/meta/lib/oe/prservice.py
> >     index fcdbe66c19..15ce060ff6 100644
> >     --- a/meta/lib/oe/prservice.py
> >     +++ b/meta/lib/oe/prservice.py
> >     @@ -7,7 +7,7 @@ def prserv_make_conn(d, check = False):
> >         host_params = list([_f for _f in (d.getVar("PRSERV_HOST") or '').split(':') if _f])
> >         try:
> >             conn = None
> >     -        conn = prserv.serv.PRServerConnection(host_params[0], int(host_params[1]))
> >     +        conn = prserv.serv.connect(host_params[0], int(host_params[1]))
> >             if check:
> >                 if not conn.ping():
> >                     raise Exception('service not available')
> >
> > I'm also currently working on a follow-up patch which will add a read-only
> > mode to prserv.
> >
> > Let me know if there are any other questions :)
>
> These looked reasonable to me, I thought I'd try some testing. I can't
> prove it yet but there were three hanging oe-selftest runs in the build
> where these were included:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/2009
> https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/1994
> https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/2026
> (all running for 2+ days)
>
> and one that failed in runtime_test.TestImage.test_testimage_dnf:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/2026
>
> I did a process trace on the centos8-ty-2 worker in case it hinted where
> it was stuck and I see:
>
> 2161691 ?        S      0:00 bash /home/pokybuild/yocto-worker/oe-selftest-centos/build/scripts/bitbake-prserv-tool export /home/pokybuild/yocto-worker/oe-selftest-centos/build/build-st-1454506/export.inc
> 2167336 ?        Sl     0:37 python3 /home/pokybuild/yocto-worker/oe-selftest-centos/build/bitbake/bin/bitbake -R conf/prexport.conf -p
>
> the other things I could see in ps, I'd have expected. On fedora, I
> saw:
>
> 2676512 ?        S      0:00 bash /home/pokybuild/yocto-worker/oe-selftest-fedora/build/scripts/bitbake-prserv-tool export /home/pokybuild/yocto-worker/oe-selftest-fedora/build/build-st-765595/export.inc
> 2679599 ?        Sl     0:19 python3 /home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/bin/bitbake -R conf/prexport.conf -p
>
> and on ubuntu too:
>
>  743847 ?        S      0:00 /bin/sh -c bitbake-prserv-tool export /home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/build-st-3944061/export.inc
>  743851 ?        S      0:00 bash /home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/scripts/bitbake-prserv-tool export /home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/build-st-3944061/export.inc
>  748863 ?        Sl     0:46 python3 /home/pokybuild/yocto-worker/oe-selftest-ubuntu/build/bitbake/bin/bitbake -R conf/prexport.conf -p
>
> For 'fun' I killed the above ubuntu processes which leads to the log output in:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/2026/steps/14/logs/stdio
>
> which shows it was in prservice.BitbakePrTests.test_import_export_replace_db
> and the build has now made more progress failing a few other tests. Not quite
> sure what it will do from here but it seems related to this series.

I've looked into this and tried to reproduce the hang by running the
full oe-selftest suite locally. Unfortunately everything seems to work
for me!

I think the best approach is to break this series apart. I'll send an
initial series today which includes preparation and initial
refactoring but doesn't actually change the prserv start/shutdown
method or the RPC method. These changes should be safe to merge. After
that I'll send a patch series to change the start/shutdown methods for
prserv and finally I'll send a patch series to change the RPC method.

When I get to the 2nd patch series, for the start/shutdown methods I
will add timeouts in case this is hanging when we call .join() on the
prservice process.

Thanks,

-- 
Paul Barker
Konsulko Group

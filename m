Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE0BC4829A
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 08:57:53 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web10.7414.1707814663374847852
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Feb 2024 00:57:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dsZf35dx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.179, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d090c83d45so54174951fa.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 00:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707814661; x=1708419461; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CztBwl74MZOwVUhp51pP3XIqy0I3MoeQB1u9C7MEBd4=;
        b=dsZf35dxxjpMmQuyYkQXE1khC+p22K9hPC4uNS3VG/QGYcam8a3K+h7v2ZGXxUCrBM
         urRUcDDsDUs//U4QOD5AKImfQ+6hHa5OfWzrwpxDMZY46BoDkvcmxUXg4LYHQ5vpEGXL
         wYcT3SOBrNV2Vyd5JZPgHrFwxx3WKr5dkkxXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707814661; x=1708419461;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CztBwl74MZOwVUhp51pP3XIqy0I3MoeQB1u9C7MEBd4=;
        b=uT2cVw0fuvg8phNgDh3gtV14Z6/VWd+451MOPl68gi2Bs2kh8mwv7fsynZ37ERLj9L
         xoZ25qxLCaeyInQcFiMjQv56EOxc1iXA/K/Zdwc8wTYNYib1r/RyjBmeRpK3RBQI6ssz
         JRi8sRxHYdTuwZb936IZOSUFk5L1eEC2RC1Y4IGB79Q+0n1Jm2O6ZZSe3HrOg/F/+L6v
         Mx+O1GLqzTWNNgrG2poNXuCEslAFeWbg7VZKK7WjtqXhCxeFx5U6vrmMxgnsOiwu6j8L
         eAYLqsmk6uwQn5rVT4cKgDf9xXt24/4U0R9qtd6pzaPXUGuEmnDS7zGNqWj5jq2AQKFS
         dG6A==
X-Forwarded-Encrypted: i=1; AJvYcCWf9y560U1s9TssiOFk4H4Z2MinhucIzMn19XtsS0PEqT0g2qG4KIg+sax1XmkwLKucgIWSnfG+zuTI9BXGIkXiueZbjMH3P7+emzfU3ZCvZwsnIcE=
X-Gm-Message-State: AOJu0YxcZRWKBZV/r6YCnkAuneeBG09uBx0lMl9oR4HTlbudvc+X0PeS
	zTf3SCSV6Dafu1fspuGXHqYnfuAXz2ao6Y5/DrRSkSeYKOMouOnhcQ0pvlaTc8U=
X-Google-Smtp-Source: AGHT+IF3J0MsBzMqixlQ2uLRaLn/bfYjjAu11GnkSWvhRkKbrd7WAmpwdH1tVw7oM2ckbMJ8MH2INw==
X-Received: by 2002:a2e:a409:0:b0:2d0:9a6e:106 with SMTP id p9-20020a2ea409000000b002d09a6e0106mr5711983ljn.43.1707814661520;
        Tue, 13 Feb 2024 00:57:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPE2Y3zGn7ux0O8nHHZL2RmC16PKbXm5C98KNKlabisSlgdeyEvSQfoeMLzU0dCAjDrQYOrRNuy1a/EeYmiNgzLdXs4kJ1g34QC7N2b1WFQ3IGNawSYyCukN7WZvcSVGi5lP5OjBntQTHRK++XtIi0diTDKtyyhFvv2/MlyaaNqku45ekao+SLQQ==
Received: from ?IPv6:2001:8b0:aba:5f3c:61a5:11c7:4181:c4a3? ([2001:8b0:aba:5f3c:61a5:11c7:4181:c4a3])
        by smtp.gmail.com with ESMTPSA id bn8-20020a056000060800b0033b198efbedsm9136466wrb.15.2024.02.13.00.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:57:41 -0800 (PST)
Message-ID: <b30b09d3a164e2425c8d0d43df495ea8bcb08679.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] regression of 'world' performance?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>, bitbake-devel
 <bitbake-devel@lists.openembedded.org>, Randy MacLeod
 <rwmacleod@gmail.com>,  Mark Hatle <mark.hatle@kernel.crashing.org>
Date: Tue, 13 Feb 2024 08:57:40 +0000
In-Reply-To: <CANNYZj_gJnswnprhj-bM9fhaJwv4phi-Mi6WJbX90wAw3shZEA@mail.gmail.com>
References: 
	<CANNYZj86b3GMtSVZMn8744HjMSMQVkzuXBTikLf4dFV0ULsvqg@mail.gmail.com>
	 <0186f166a0ded0d97d5e19f64a3dd8e5ad44a92f.camel@linuxfoundation.org>
	 <CANNYZj-cqQVJcs3AUvzE=Lw+mYMUWZO8JW1N-Ukz6BK3H2rchQ@mail.gmail.com>
	 <CAMKF1soqnpKYkcGzkS1A2UGGiy7_Vbzym06rARRTqCnUc7gsCw@mail.gmail.com>
	 <CANNYZj_r2S7b+3r4CEz8cGZSqT_wa785p1BtpZxb60CVvZJcAg@mail.gmail.com>
	 <947006112712dcca07c607eb6b49b7e4e475c3d9.camel@linuxfoundation.org>
	 <CANNYZj-V_bH-uVUBXmER30GxMLrfKN6g=pY-VSsgEfT6Fm7e_g@mail.gmail.com>
	 <829c8fff2e6735297f036fdb878f4d244cf08f91.camel@linuxfoundation.org>
	 <CANNYZj-3QDJMcqaVTSj+XRZo140O-hg5K9kM8e0mtF7yp=P9Tg@mail.gmail.com>
	 <cf9339c32c0923068f0e4ae81fe1ebdb8153b20a.camel@linuxfoundation.org>
	 <17B24084174823DE.15017@lists.openembedded.org>
	 <CANNYZj-gbs6UmzcKaBt4DQ7G08EdJUNXZWWu3W8G=YJUub0gKg@mail.gmail.com>
	 <17B255DB2CE33879.588@lists.openembedded.org>
	 <17B257441406400D.588@lists.openembedded.org>
	 <17B2894C95E031D0.14481@lists.openembedded.org>
	 <17B29B2072FF51A8.14481@lists.openembedded.org>
	 <7bb8798da40488ad8f79f472775e2ee2c2a9c8e2.camel@linuxfoundation.org>
	 <CANNYZj_gJnswnprhj-bM9fhaJwv4phi-Mi6WJbX90wAw3shZEA@mail.gmail.com>
Autocrypt: addr=richard.purdie@linuxfoundation.org; prefer-encrypt=mutual; keydata=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
 YNvg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Feb 2024 08:57:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15882

On Mon, 2024-02-12 at 13:58 +0100, Alexander Kanavin wrote:
> On Sat, 10 Feb 2024 at 21:53, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>=20
> > Looking at the code, people have altered next_buildable_task() to add
> > per task thread limits and pressure regulation and they don't realise
> > how often that function can be called or how fast it really needs to
> > be. Note that the profile above doesn't include pressure regulation but
> > if it did, it would be much worse.
> >=20
> > It can be reworked but it isn't trivial.
>=20
> Thanks for working on this, over the weekend. I just re-run profiling
> with the fix for the mainloop, and here's what I see:
>=20
> 1. There are three performance fixes in master-next. Without any of
> them, profile shows this (pressed ctrl-c while it was still not
> running any tasks):
>=20
> Mon Feb 12 12:32:56 2024    profile-mainloop.log
>=20
>          71983446 function calls (71606940 primitive calls) in 1546.118 s=
econds
>=20
>    Ordered by: internal time
>=20
>    ncalls  tottime  percall  cumtime  percall filename:lineno(function)
>      9448 1461.507    0.155 1491.991    0.158
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2147(execute)
> 9510/9448   14.437    0.002   14.530    0.002
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2672(scenequeue_updatecoun=
ters)
>   5250612    7.414    0.000    7.414    0.000
> /srv/work/alex/poky/bitbake/lib/bb/__init__.py:63(bbdebug)
>   5219489    6.090    0.000   13.472    0.000
> /srv/work/alex/poky/bitbake/lib/bb/__init__.py:57(debug2)
>         1    5.906    5.906   18.979   18.979
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:644(prepare)
> 43827/23463    1.662    0.000    4.198    0.000
> /usr/lib/python3.11/re/_parser.py:507(_parse)
>=20
> So it is indeed the execute() loop itself which is slow. It's only
> logical then that with the first two performance fixes applied,
> nothing changes:
>=20
> Mon Feb 12 13:03:42 2024    profile-mainloop.log
>=20
>          67576990 function calls (67201484 primitive calls) in 1226.143 s=
econds
>=20
>    Ordered by: internal time
>=20
>    ncalls  tottime  percall  cumtime  percall filename:lineno(function)
>      8711 1147.496    0.132 1173.321    0.135
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2149(execute)
> 8773/8711   12.261    0.001   12.347    0.001
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2683(scenequeue_updatecoun=
ters)
>   4498537    6.303    0.000    6.303    0.000
> /srv/work/alex/poky/bitbake/lib/bb/__init__.py:63(bbdebug)
>         1    6.238    6.238   16.135   16.135
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:644(prepare)
>   4467414    5.149    0.000   11.418    0.000
> /srv/work/alex/poky/bitbake/lib/bb/__init__.py:57(debug2)
> 43827/23463    1.662    0.000    4.239    0.000
> /usr/lib/python3.11/re/_parser.py:507(_parse)
>=20
> Do note the quadratic growth in tottime though: 9448/8711 =3D 1.08, but
> 1461/1148 =3D 1.27
>=20
> 2. With the third fix (allow the loop to work through all items), I
> finally didn't have to press ctrl-c, and the dry world run completed,
> with the following picture:
>=20
> Mon Feb 12 13:21:51 2024    profile-mainloop.log
>=20
>          158073071 function calls (157658186 primitive calls) in 972.810 =
seconds
>=20
>    Ordered by: internal time
>=20
>    ncalls  tottime  percall  cumtime  percall filename:lineno(function)
>     35784  307.013    0.009  513.933    0.014
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:225(next_buildable_task)
>     34092  160.895    0.005  168.126    0.005
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2438(build_taskdepdata)
>     35807  118.265    0.003  118.265    0.003 {method 'difference' of
> 'set' objects}
>     71592   54.910    0.001   54.910    0.001 {method
> 'difference_update' of 'set' objects}
>     34096   50.010    0.001   50.010    0.001 {method 'write' of
> '_io.BufferedWriter' objects}
> 17639/15964   48.203    0.003   48.480    0.003
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2685(scenequeue_updatecoun=
ters)
>    298834   45.690    0.000   45.691    0.000 {built-in method _pickle.du=
mps}
>     35827   22.092    0.001   22.092    0.001 {method
> 'intersection_update' of 'set' objects}
>     35783   10.610    0.000   10.610    0.000 {method 'index' of 'list' o=
bjects}
>     35957    9.649    0.000  916.610    0.025
> /srv/work/alex/poky/bitbake/lib/bb/runqueue.py:2149(execute)
>=20
> execute() moves to the 10th place, and the time starts to be dominated
> by other items
>=20
> 3. I'm not seeing anything obviously inefficient in the execute() loop
> itself: it's mostly doing standard data structure lookups.
> So I'd say execute() should be allowed to handle all the items in a
> batch or otherwise make its own decisions about when to return. This
> results in fails elsewhere as you've commented, I didn't yet look into
> that.

I worked out a way to make it work with "continue" however there was
more that was bugging me about the behaviour of this. You can see it in
this profile:

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
    15223  807.225    0.053  838.759    0.055 /media/build/poky/bitbake/lib=
/bb/runqueue.py:2149(execute)
16970/15322   23.029    0.001   23.177    0.002 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:2683(scenequeue_updatecounters)
  5239701    3.361    0.000    3.361    0.000 /media/build/poky/bitbake/lib=
/bb/__init__.py:63(bbdebug)
        1    3.072    3.072    7.529    7.529 /media/build/poky/bitbake/lib=
/bb/runqueue.py:644(prepare)
  5208322    2.964    0.000    6.313    0.000 /media/build/poky/bitbake/lib=
/bb/__init__.py:57(debug2)
       43    1.236    0.029    1.236    0.029 {built-in method select.selec=
t}
 10707192    0.913    0.000    0.913    0.000 {method 'issubset' of 'set' o=
bjects}
24335/13567    0.669    0.000    1.264    0.000 /usr/lib/python3.11/re/_par=
ser.py:509(_parse)
   996792    0.652    0.000    0.742    0.000 /usr/lib/python3.11/glob.py:1=
41(_iterdir)
    41296    0.583    0.000    0.583    0.000 {built-in method posix.write}

Note that whilst they didn't take too long a time, there are 5 million
calls to debug2 (each is a line of log information) and 10 million
calls to issubset().

execute() should only be processing task entries when that entry has
some kind of "progress" that can be made and there is "space" to
execute a new task. The millions of log lines suggest something is
being "processed" multiple times over with no progress. The issubset()
gives a pointer to which code block.

As you've already identified, that points back to the code block:

if nexttask in self.sqdata.sq_harddeps_rev and not self.sqdata.sq_harddeps_=
rev[nexttask].issubset(self.scenequeue_covered | self.scenequeue_notcovered=
):
    logger.debug2("Deferring %s due to hard dependencies" % nexttask)

but I mainly mention this to show how it shows up in the profile.

The key question is why does that block keep getting triggered and how
can we make it only run when it needs to.

The answer is perhaps the patch I sent to the bitbake list a few hours
ago, which runs it once, then skips it until it has progress than can
be made (the harddep dependencies have run).

That change in behaviour is able to change the profile to:

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.069    0.069   62.756   62.756 /media/build/poky/bitbake/lib=
/bb/server/process.py:421(idle_thread_internal)
    15222    0.013    0.000   57.848    0.004 /media/build/poky/bitbake/lib=
/bb/cooker.py:1474(buildTargetsIdle)
    15222    0.012    0.000   57.834    0.004 /media/build/poky/bitbake/lib=
/bb/runqueue.py:1624(execute_runqueue)
    15222    0.057    0.000   57.822    0.004 /media/build/poky/bitbake/lib=
/bb/runqueue.py:1523(_execute_runqueue)
    15222   15.182    0.001   39.881    0.003 /media/build/poky/bitbake/lib=
/bb/runqueue.py:2150(execute)
16970/15322   23.639    0.001   23.775    0.002 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:2686(scenequeue_updatecounters)
16739/15091    0.017    0.000   23.723    0.002 /media/build/poky/bitbake/l=
ib/bb/runqueue.py:2756(sq_task_failoutright)
        1    0.022    0.022    8.504    8.504 /media/build/poky/bitbake/lib=
/bb/runqueue.py:1814(__init__)
        1    2.842    2.842    7.013    7.013 /media/build/poky/bitbake/lib=
/bb/runqueue.py:644(prepare)
    16970    0.044    0.000    4.550    0.000 /media/build/poky/bitbake/lib=
/bb/build.py:855(find_stale_stamps)
    33948    0.032    0.000    4.197    0.000 /usr/lib/python3.11/glob.py:1=
3(glob)

so without profiling enabled, "bitbake world -n --setscene-only" takes
around 30s (60s with profiling) for the workload which previously was
taking 12 minutes.

execute() is 40s of that and of the 40s, 23s is spent in the
scenequeue_updatecounters() accounting function.

The other "performance" changes I sent help the task execution phase
which happens after setscene() so they improve "bitbake world -n" but
not the setscene piece specifically.

The patches fix low hanging issues but I suspect there is more we
could/should do in this code.

Cheers,

Richard



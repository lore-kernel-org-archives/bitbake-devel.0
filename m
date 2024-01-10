Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D57C4725D
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 14:09:59 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.12270.1704895795643627520
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jan 2024 06:09:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=d7LRxSDn;
 spf=pass (domain: snapchat.com, ip: 209.85.218.48, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so13530466b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 06:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1704895794; x=1705500594; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4zOQG9WuQza4gp95xs+EYu4u49xCIx6cJxUNqlC2II8=;
        b=d7LRxSDnCDYpNB+CP4oQnR40bW+RBoRrvqdjHXbDDaHC/yVCOOSPtbuHv45omx3JEI
         CgDeeMKzLQF6yRfgZDIcAUc/UldtgJe2j+wtPmN8GZkAAb4WYIySESg7pe2rX4EqrhhY
         qYdoOtCLVv0+TEEHNeBoKHCsIKeRKHjgMqQ+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704895794; x=1705500594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zOQG9WuQza4gp95xs+EYu4u49xCIx6cJxUNqlC2II8=;
        b=cD0MDIQDScL3FeSIx0gb13Wb58QHrqLkXXalyK+HRlU1l9TbGad53fTE71hMHDZ0o/
         X/kAzDQzl9Y5o5U2ej3yVL6WWfAhnGaBTR2PIokJEZPA6eCYB2DTCVbpuxQ0nOfdmTpm
         pM124E8zgcgKoDzC4fEeXSfpfwc1R/v4DSPe4GgztdRkcyGE0ZSmx2O4OS3mrgFgBaaS
         8zGniU77OMyBwKv4V/2uTY+AMtx81yLZnb/n5j6q6O4UfMmoDJaChtVCjJB7xMuM/yNa
         NZqcWDk6ZBiEX416/2y5HPd+2tJRnZYVWSWzJSQWHkW214vbEmpk96GGTqXtvDcqSYzX
         Bo9g==
X-Gm-Message-State: AOJu0Yymaa+28+NscCFiM0UcfXqhdfefv/CQJnwY13Wyttes3/D6k0i8
	TcjQMpv/s0d6HmfY8GbAMsXGHCF59ieeWOg6wOR1UdO4FRH/7jpyU6al2Mg4FZhRVA==
X-Google-Smtp-Source: AGHT+IGvFZTcrP3WhQUpXQDRudkjkN7agWQshsnWzlK7XjrAro9toYtKc0A9fXltKbs555UfCd4TnRw8WhMGp4AxON8=
X-Received: by 2002:a17:907:590:b0:a28:cc55:30d5 with SMTP id
 vw16-20020a170907059000b00a28cc5530d5mr497367ejb.54.1704895793628; Wed, 10
 Jan 2024 06:09:53 -0800 (PST)
MIME-Version: 1.0
References: <20230713105303.4105584-1-richard.purdie@linuxfoundation.org>
 <CAHUKmYZvYbs236DUrUna_SGRm-9R1SPkDAvZJn+XkrwJri2xNg@mail.gmail.com>
 <15224f4fe986ab3508c1d0dc3d9b33b0b3e2e9c0.camel@linuxfoundation.org>
 <c0a11023-9bc7-40de-9240-0006c98f1607@windriver.com> <c527e73b-7e94-4495-b155-437d48284359@windriver.com>
In-Reply-To: <c527e73b-7e94-4495-b155-437d48284359@windriver.com>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 10 Jan 2024 15:09:42 +0100
Message-ID: <CAHUKmYYtHVt-BNR7et6bLv2bDQLTm0Q+50GLBtzCuukJWhrGZQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Add pressure change logging
To: randy.macleod@windriver.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/related; boundary="00000000000029175a060e97fc93"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 14:09:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15778

--00000000000029175a060e97fc93
Content-Type: multipart/alternative; boundary="000000000000291758060e97fc92"

--000000000000291758060e97fc92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"How many physical/virtual cores are actually available?

Is some other activity doing CPU intensive work on the system?
Is the one task running > 48 compile jobs and causing CPU contention in the
system?"

-> This is a physical PC with 24 physical cores and 48 cores when you take
hyperthreading into account (Intel Xeon Gold 6240R)
-> there is no other activity doing CPU intensive work
-> some bitbake tasks can easily load 48 cores, yes (this is a custom image
with some extra layers added)

Etienne

On Wed, Jan 10, 2024 at 3:20=E2=80=AFAM Randy MacLeod via lists.openembedde=
d.org
<randy.macleod=3Dwindriver.com@lists.openembedded.org> wrote:

> On 2024-01-09 4:49 p.m., Randy MacLeod wrote:
>
> On 2024-01-09 9:12 a.m., Richard Purdie wrote:
>
> On Tue, 2024-01-09 at 15:09 +0100, Etienne Cordonnier wrote:
>
> how much logging is this generating for your local builds? I'm
> using BB_PRESSURE_MAX_CPU=3D"500", and this patch generates hundreds of
> lines of logs during a typical build (on kirkstone 4.0.15). Is that
> the expected behavior? It makes it hard to read other logs.
>
> E.g. this incremental build with 300 tasks printed 280 lines of
> Pressure status change:
>
> ...
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 49=
5.3/500.0, IO: 1723.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 985=
.3/500.0, IO: 2201.8/None, Mem: 176.8/None) - using 1/48 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 42=
0.8/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 404=
9.8/500.0, IO: 14719.7/None, Mem: 0.0/None) - using 1/48 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 0.=
0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 219=
22.9/500.0, IO: 10137.8/None, Mem: 194.8/None) - using 1/48 bitbake threads
>
> In this case, you have up to 48 threads permitted yet the CPU is already
> overloaded
> based on the pressure logs.
>
> How many physical/virtual cores are actually available?
>
> Is some other activity doing CPU intensive work on the system?
> Is the one task running > 48 compile jobs and causing CPU contention in
> the system?
>
>
> I'd expect that for a modest update on a mostly 48 vCPU system, you would
> rarely see any pressure logs but
> I tested on my 24 vCPU system with CPU=3D500 and early in the builds as
> configure runs for various packags there are waves of
> tasks launched and then the system becomes congested:
>
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 8797.1/500.0, IO: 49.8/None, Mem: 0.0/None) - using 23/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 3720.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 3/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 533.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 22/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 19/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 693451.9/500.0, IO: 0.0/None, Mem: 32401.3/None) - using 20/24 bitbake
> threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 39409.4/500.0, IO: 662.6/None, Mem: 155.6/None) - using 23/24 bitbake
> threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 13/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 411246.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 14/24 bitbake thread=
s
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 531.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 7/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 494.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 7/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 514.3/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 497.2/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 501.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 16/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 497.3/500.0, IO: 0.0/None, Mem: 0.0/None) - using 16/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 501.6/500.0, IO: 0.0/None, Mem: 0.0/None) - using 17/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 14/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 36473.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 526.7/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 472.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 502.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 22/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 522.2/500.0, IO: 137.1/None, Mem: 0.0/None) - using 22/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 2192.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 3/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 529.0/500.0, IO: 64.8/None, Mem: 0.0/None) - using 21/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 4/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 2420.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 5/24 bitbake threads
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
> 395.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24 bitbake threads
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 523.4/500.0, IO: 0.0/None, Mem: 0.0/None) - using 6/24 bitbake threads
>
> I've been trying to make time to improve the pressure regulation since we
> neglected
> the kernel devs advice that we should not sample the pressure info more
> than once every 50 ms or so.
>
> I'll try another build with the CPU pressure limit set higher, and I
> suggest you do the same.
>
>
> so with just the default config and
>
> BB_PRESSURE_MAX_CPU =3D "500"
> and
> $ bitbake core-image-minimal
>
> rmacleod@yow-rmacleod-lx3 b-poky/bb-sec $ rg "Pressure status changed "
> tmp/log/cooker/qemux86-64/202* | wc -l
> 2355
>
> NOTE: Tasks Summary: Attempted 4028 tasks of which 187 didn't need to be
> rerun and all succeeded.
>
> so ~1200 times when launching the 4000 tasks, the CPU was congested.
>
> The distribution of the number of tasks  when CPU contention was noticed
> was somewhat higher:
>
> $ rg "Pressure status changed " tmp/log/cooker/qemux86-64/202* | rg True =
|
> rev | cut  -d" " -f -3 | rev | cut -d" " -f1 | sort -n | uniq -c
>
>       4 1/24
>     432 2/24
>     168 3/24
>      84 4/24
>      54 5/24
>      62 6/24
>      65 7/24
>      80 8/24
>      61 9/24
>      49 10/24
>      28 11/24
>      20 12/24
>      15 13/24
>       6 14/24
>      10 15/24
>       2 16/24
>       3 17/24
>       3 18/24
>       3 19/24
>       2 20/24
>       2 21/24
>       6 22/24
>      18 23/24
>
> then when it abated:
>
> $ rg "Pressure status changed " tmp/log/cooker/qemux86-64/202* | rg -v
> True | rev | cut  -d" " -f -3 | rev | cut -d" " -f1 | sort -n | uniq -c
>     592 1/24
>     126 2/24
>      68 3/24
>      45 4/24
>      55 5/24
>      63 6/24
>      65 7/24
>      57 8/24
>      43 9/24
>      27 10/24
>      16 11/24
>       8 12/24
>       3 13/24
>       4 14/24
>       2 15/24
>       1 16/24
>       1 17/24
>       1 18/24
>       1 19/24
>
> Pretty much what I'd expect.
>
>
> If you look at the CPU pressure values, and sort them out
>
> $ rg "Pressure status changed " tmp/log/cooker/qemux86-64/202* \
>
>    | rg True | cut  -d"(" -f 2 |  cut -d":" -f 2 | cut -d"," -f1 | cut
> -d"/" -f1  | sort -n > /tmp/cpu-pressure.dat
>
>  you see this distribution:
>
> Note that there are values over 1M and that's a bug that will be fixed.
>
> Oh and on a linear scale:
>
>
> so a MAX_CPU of say 1000 is probably better.
>
> All of this analysis is fun (for me!) but really, we need to get the job
> server in place
> and improve on the regulation algorithm based on a standardized test usin=
g
> stress-ng most liklely
> and then finally compare it to what happens in real builds and tune more.
>
>
> Thanks for the excuse to analyze some data and make some somewhat
> interesting, maybe useful graphs!
>
> All for tonight,
>
> ../Randy
>
>
> I still think your logs look 'interesting' so I look forward to hearing
> what your system is
> and what it's doing.
>
> Thanks,
>
> ../Randy
>
>
> NOTE: Tasks Summary: Attempted 928 tasks of which 635 didn't need to be r=
erun and all succeeded.
> ...
>
> It does add a lot of logging. I was torn on adding it but we have
> struggled to get the log levels right and this information is useful as
> you often need it to get the pressure values right. I'm torn on it.
>
> Cheers,
>
> Richard
>
>
>
>
> --
> # Randy MacLeod
> # Wind River Linux
>
>
> --
> # Randy MacLeod
> # Wind River Linux
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15776):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_message_15776&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Djt=
fd4DbF9P05O3NOz5OO6LuF-oOhMFw_eih9SszsQQ5hO7GnpymSeSpAcd8lqi_b&s=3D_MFl5ovV=
E_VNDvrcRFWqHsz5dnRMO2KpNiLOCVE5nzA&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_mt_100117828_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Djtfd4DbF9P05O=
3NOz5OO6LuF-oOhMFw_eih9SszsQQ5hO7GnpymSeSpAcd8lqi_b&s=3DaW8uT4CX5OXe4qGNZBl=
8pJfOpMUsywJ1NVZKL71DX4w&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGk=
ICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Djtfd4DbF9P=
05O3NOz5OO6LuF-oOhMFw_eih9SszsQQ5hO7GnpymSeSpAcd8lqi_b&s=3DAhq1wP9wLfH-LXmu=
ndExXCmTp5TlZIpi8LK4ZnXDtfc&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000291758060e97fc92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&quot;How many physical/virtual cores are actually availab=
le?<p>Is some other activity doing CPU intensive work on the system?<br>Is =
the one task running &gt; 48 compile jobs and causing CPU contention in the=
 system?&quot;<br><br>-&gt; This is a physical PC with 24 physical cores an=
d 48 cores when you take hyperthreading into account (Intel Xeon Gold 6240R=
)<br>-&gt; there is no other activity doing CPU intensive work<br>-&gt; som=
e bitbake tasks can easily load 48 cores, yes (this is a custom image with =
some extra layers added)<br><br>Etienne</p></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 10, 2024 at 3:20=E2=
=80=AFAM Randy MacLeod via <a href=3D"http://lists.openembedded.org">lists.=
openembedded.org</a> &lt;randy.macleod=3D<a href=3D"mailto:windriver.com@li=
sts.openembedded.org">windriver.com@lists.openembedded.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

 =20
  <div>
    <div>On 2024-01-09 4:49 p.m., Randy MacLeod
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div>On 2024-01-09 9:12 a.m., Richard
        Purdie wrote:<br>
      </div>
      <blockquote type=3D"cite">
        <pre>On Tue, 2024-01-09 at 15:09 +0100, Etienne Cordonnier wrote:
</pre>
        <blockquote type=3D"cite">
          <pre>how much logging is this generating for your=C2=A0local buil=
ds? I&#39;m
using=C2=A0BB_PRESSURE_MAX_CPU=3D&quot;500&quot;, and this patch generates =
hundreds of
lines of logs during a typical build (on kirkstone 4.0.15). Is that
the expected behavior? It makes it hard to read other logs.

E.g. this incremental build with 300 tasks printed 280 lines of
Pressure status change:

...
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 495.=
3/500.0, IO: 1723.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 985.3=
/500.0, IO: 2201.8/None, Mem: 176.8/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 420.=
8/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 4049.=
8/500.0, IO: 14719.7/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 0.0/=
500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 21922=
.9/500.0, IO: 10137.8/None, Mem: 194.8/None) - using 1/48 bitbake threads</=
pre>
        </blockquote>
      </blockquote>
      <p>In this case, you have up to 48 threads permitted yet the CPU
        is already overloaded<br>
        based on the pressure logs.</p>
      <p>How many physical/virtual cores are actually available?<br>
      </p>
      <p>Is some other activity doing CPU intensive work on the system?<br>
        Is the one task running &gt; 48 compile jobs and causing CPU
        contention in the system?<br>
        <br>
        <br>
      </p>
      <p>I&#39;d expect that for a modest update on a mostly 48 vCPU system=
,
        you would rarely see any pressure logs but<br>
        I tested on my 24 vCPU system with CPU=3D500 and early in the
        builds as configure runs for various packags there are waves of<br>
        tasks launched and then the system becomes congested:</p>
      <p>NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 8797.1/500.0, IO: 49.8/None, Mem: 0.0/None) - using 23/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 3720.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 3/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 533.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 22/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 19/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 693451.9/500.0, IO: 0.0/None, Mem: 32401.3/None) - using
        20/24 bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 39409.4/500.0, IO: 662.6/None, Mem: 155.6/None) - using
        23/24 bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 13/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 411246.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 14/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 531.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 7/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 494.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 7/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 514.3/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 497.2/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 501.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 16/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 497.3/500.0, IO: 0.0/None, Mem: 0.0/None) - using 16/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 501.6/500.0, IO: 0.0/None, Mem: 0.0/None) - using 17/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 14/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 36473.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 526.7/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 472.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 502.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 22/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 522.2/500.0, IO: 137.1/None, Mem: 0.0/None) - using 22/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 2192.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 3/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 529.0/500.0, IO: 64.8/None, Mem: 0.0/None) - using 21/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 4/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 2420.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 5/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
        (CPU: 395.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24
        bitbake threads<br>
        NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
        (CPU: 523.4/500.0, IO: 0.0/None, Mem: 0.0/None) - using 6/24
        bitbake threads<br>
        <br>
      </p>
      <p>I&#39;ve been trying to make time to improve the pressure
        regulation since we neglected<br>
        the kernel devs advice that we should not sample the pressure
        info more<br>
        than once every 50 ms or so. <br>
      </p>
      <p>I&#39;ll try another build with the CPU pressure limit set higher,
        and I suggest you do the same.<br>
      </p>
    </blockquote>
    <p><br>
    </p>
    <p>so with just the default config and <br>
    </p>
    <p>BB_PRESSURE_MAX_CPU =3D &quot;500&quot;<br>
      and<br>
      $ bitbake core-image-minimal<br>
    </p>
    <p>rmacleod@yow-rmacleod-lx3 b-poky/bb-sec $ rg &quot;Pressure status
      changed &quot; tmp/log/cooker/qemux86-64/202* | wc -l<br>
      2355<br>
      <br>
    </p>
    <p>NOTE: Tasks Summary: Attempted 4028 tasks of which 187 didn&#39;t
      need to be rerun and all succeeded.</p>
    <p>so ~1200 times when launching the 4000 tasks, the CPU was
      congested.<br>
    </p>
    <p>The distribution of the number of tasks=C2=A0 when CPU contention wa=
s
      noticed was somewhat higher:<br>
      <br>
      $ rg &quot;Pressure status changed &quot; tmp/log/cooker/qemux86-64/2=
02* |
      rg True | rev | cut=C2=A0 -d&quot; &quot; -f -3 | rev | cut -d&quot; =
&quot; -f1 | sort -n |
      uniq -c</p>
    <p>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4 1/24<br>
      =C2=A0=C2=A0=C2=A0 432 2/24<br>
      =C2=A0=C2=A0=C2=A0 168 3/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 84 4/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 54 5/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 62 6/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 65 7/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 80 8/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 61 9/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 49 10/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 28 11/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 20 12/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 15 13/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6 14/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 10 15/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 16/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 17/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 18/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 19/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 20/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 21/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6 22/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 18 23/24<br>
    </p>
    <p>then when it abated:</p>
    <p>$ rg &quot;Pressure status changed &quot; tmp/log/cooker/qemux86-64/=
202* |
      rg -v True | rev | cut=C2=A0 -d&quot; &quot; -f -3 | rev | cut -d&quo=
t; &quot; -f1 | sort
      -n | uniq -c<br>
      =C2=A0=C2=A0=C2=A0 592 1/24<br>
      =C2=A0=C2=A0=C2=A0 126 2/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 68 3/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 45 4/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 55 5/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 63 6/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 65 7/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 57 8/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 43 9/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 27 10/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0 16 11/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8 12/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 13/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4 14/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 15/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 16/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 17/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 18/24<br>
      =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 19/24</p>
    <p>Pretty much what I&#39;d expect.<br>
    </p>
    <p><br>
    </p>
    <p>If you look at the CPU pressure values, and sort them out</p>
    <p>$ rg &quot;Pressure status changed &quot; tmp/log/cooker/qemux86-64/=
202* \</p>
    <p>=C2=A0=C2=A0 | rg True | cut=C2=A0 -d&quot;(&quot; -f 2 |=C2=A0 cut =
-d&quot;:&quot; -f 2 | cut -d&quot;,&quot; -f1
      | cut -d&quot;/&quot; -f1=C2=A0 | sort -n &gt; /tmp/cpu-pressure.dat<=
br>
    </p>
    <p>=C2=A0you see this distribution:<br>
      <br>
      <img src=3D"cid:ii_18cf3af1a38ab6720271" alt=3D""></p>
    <p>Note that there are values over 1M and that&#39;s a bug that will be
      fixed.<br>
    </p>
    <p>Oh and on a linear scale: <br>
    </p>
    <p><br>
    </p>
    <p><img src=3D"cid:ii_18cf3af1a38aa0aca022" alt=3D""></p>
    <p>so a MAX_CPU of say 1000 is probably better.</p>
    <p>All of this analysis is fun (for me!) but really, we need to get
      the job server in place<br>
      and improve on the regulation algorithm based on a standardized
      test using stress-ng most liklely<br>
      and then finally compare it to what happens in real builds and
      tune more.<br>
    </p>
    <p><br>
    </p>
    <p>Thanks for the excuse to analyze some data and make some somewhat
      interesting, maybe useful graphs!<br>
    </p>
    <p>All for tonight,</p>
    <p>../Randy<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <p>I still think your logs look &#39;interesting&#39; so I look forwa=
rd to
        hearing what your system is<br>
        and what it&#39;s doing.<br>
      </p>
      <p>Thanks,<br>
      </p>
      <p>../Randy</p>
      <p><br>
      </p>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre>NOTE: Tasks Summary: Attempted 928 tasks of which 635 didn&#=
39;t need to be rerun and all succeeded.
...
</pre>
        </blockquote>
        <pre>It does add a lot of logging. I was torn on adding it but we h=
ave
struggled to get the log levels right and this information is useful as
you often need it to get the pressure values right. I&#39;m torn on it.

Cheers,

Richard


</pre>
      </blockquote>
      <p><br>
      </p>
      <pre cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
    </blockquote>
    <p><br>
    </p>
    <pre cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </div>

<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15776): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_15776&a=
mp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Djtfd4DbF9P05O3NOz5OO6LuF=
-oOhMFw_eih9SszsQQ5hO7GnpymSeSpAcd8lqi_b&amp;s=3D_MFl5ovVE_VNDvrcRFWqHsz5dn=
RMO2KpNiLOCVE5nzA&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://ur=
ldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitba=
ke-2Ddevel_message_15776&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHva=
bgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=
=3Djtfd4DbF9P05O3NOz5OO6LuF-oOhMFw_eih9SszsQQ5hO7GnpymSeSpAcd8lqi_b&amp;s=
=3D_MFl5ovVE_VNDvrcRFWqHsz5dnRMO2KpNiLOCVE5nzA&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_100117828_7048771&amp;d=3DDwIFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3Djtfd4DbF9P05O3NOz5OO6LuF-oOhMFw_eih9SszsQQ5hO7=
GnpymSeSpAcd8lqi_b&amp;s=3DaW8uT4CX5OXe4qGNZBl8pJfOpMUsywJ1NVZKL71DX4w&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.openembedded.org_mt_100117828_7048771&amp;d=3D=
DwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Djtfd4DbF9P05O3NOz5OO6LuF-oOhMFw=
_eih9SszsQQ5hO7GnpymSeSpAcd8lqi_b&amp;s=3DaW8uT4CX5OXe4qGNZBl8pJfOpMUsywJ1N=
VZKL71DX4w&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwIFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3Djtfd4DbF9P05O3NOz5OO6LuF-oOhMFw_eih9SszsQQ5hO7G=
npymSeSpAcd8lqi_b&amp;s=3DAhq1wP9wLfH-LXmundExXCmTp5TlZIpi8LK4ZnXDtfc&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=
=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Djtfd4DbF9P05O3NOz5OO6LuF-oOh=
MFw_eih9SszsQQ5hO7GnpymSeSpAcd8lqi_b&amp;s=3DAhq1wP9wLfH-LXmundExXCmTp5TlZI=
pi8LK4ZnXDtfc&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000291758060e97fc92--

--00000000000029175a060e97fc93
Content-Type: image/png; name="H8rUt1BvDQWw7iKt.png"
Content-Disposition: inline; filename="H8rUt1BvDQWw7iKt.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_18cf3af1a38ab6720271>
X-Attachment-Id: ii_18cf3af1a38ab6720271

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
e658ufLO39P3/aQscd/5cUMIk/3qus7uM6+TePyl+npkPSxJy5P7/Nz+t+oolmNevrhvXdeTus7F
0Lyd+r7/cZ7zeknrJlfudN943mvlzmOpznLtvhQPufNO26Tv+0u54/a4z3z7vN3TeIj/zo99Tx3F
Nkjfn7YRAM/hGxdgJ9KL79+YJ2+pXDITP2++fakMuX3TpGW+b+796b65hDZNBG+VZ+m1R9fDknly
dy1ZX0rmc5+5VL6lY+RuKqTHnm9fSmCXyrL0eWtuMOSOkX7+PXF07/bcsedJcbp9XuZr29PPvaeO
5jcacvEPwON4jByAVbquW3z8vK7rxUec75mAar5v/D097tKjvE3T/Nh3/vsWk2E9ox5yyrIM5/P5
cp4h/BkWkHvU+Defde97bk08lvv91uPguUne4lCG346rT+ceeOTyWrn6W4qVpXOZ75sO44jl/k0d
xUfqy7I0vh/gif57dQEAeH+3xk+XZXlJMv8lqTydTjeTgWEYQl3X2TI1TfNjlumu68LhcLgkHP+S
bDyrHq45Ho/heDxOlriaL2FVluWPJbVeuZZ0nC39Wr1cu6GS3mD4jfP5fKmvqqo+ajm7tO5SW9cR
ANuTbAPs0COTwX+VK1v6e0ww5+tNz8Xly6qqCl3XhaIovmod4/P5PJngLZdExomxQviTpL/z8mBp
MvmINjqfz5e1vdObL5/k0XUEwLY8Rg6wE7lHUu/1qEdwQ/g7m3acETz+pD2294oJd3yM+HQ6bTIb
8yPr4Z7PK8ty0qOZ9nbG2bNjTzh/Yyw+7QAAjyTZBtiRNOm8R/pI9pr9fiOOrS3L8pJon8/nVY8d
57bHf+NY5zTR+u0j1c+oh5xra0XnEulhGFY9kv9sa8pz7UbGv97kiDdfQvj9GPBXWTv2/dk3ggBY
JtkG2JE02VnTsxd7mdNJpnLvO51Ol0T5t9Je2Gu9sbEnd2ld7bg9fYQ6hJ+9wL/xjHpYsqa9chPK
vYNYL9ekk3zlyr9VT3Tahp8gzlGQTm726DoCYBvGbAPsyHwc8+FwCMfj8UdyGJPW9LXj8Ri6rvsx
AVhMbv+1F3UpUS3LcrItjj2O5U9fO51Ok3HL84nD0mPOxXOK573k0fWQEyfJyo01jglWru7atl2c
0X1er1uZlzGWb029xPOsqmpyYyTW85ryrrnRkE6YNhdnlJ/H1rwszzAMQ+i67tIbH8I2dQTAk7x2
5TEAXiVdwzf8fz3ldL3e+frA45hf6zm3b+7Y4zhO3jt/3/y4889YU45cGeq6npzbtXWgY5nmx4/H
eEY9LLVV0zSX98XyzI+bmn/GfFtcczl3jkvlXtp/HKdrOsf35M7vVt3OPzvXZjm54956X+4yKI2H
tO7mZZ1/XtM0i7GT2x73n7dXbOvY3rlzuFVHt+oYgOcoxvGD1r8A4CFir+wre8au9bKnM2rv0bw3
NdbJO/Vkxpm+P+my4p1n5Qfg80m2AXi5+KjxteWYbj3ezWt9YrINAI9kzDYAL9W27c2ZoT91XWQA
YL8k2wC8VPoYb1EUk4m+chNEAQB8Akt/AfBScYb0OLNy13XhdDpdxtOO42hc7RsbhmGy5NThcPj1
OuYA8E2M2QYAAICN6dkGAACAjUm2AQAAYGOSbQAAANiYZBsAAAA2JtkGAACAjUm2AQAAYGOSbQAA
ANiYZBsAAAA2JtkGAACAjUm2AQAAYGOSbQAAANiYZBsAAAA2JtkGAACAjUm2AQAAYGOSbQAAANiY
ZBsAAAA2JtkGAACAjUm2AQAAYGOSbQAAANiYZBsAAAA2JtkGAACAjUm2AQAAYGOSbQAAANiYZBsA
AAA2JtkGAACAjUm2AQAAYGOSbQAAANjY/wAsfojWx+ZzaAAAAABJRU5ErkJggg==
--00000000000029175a060e97fc93
Content-Type: image/png; name="265SFj030GaG0S7u.png"
Content-Disposition: inline; filename="265SFj030GaG0S7u.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_18cf3af1a38aa0aca022>
X-Attachment-Id: ii_18cf3af1a38aa0aca022

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
YGX/A1MwTs3uaTvAAAAAAElFTkSuQmCC
--00000000000029175a060e97fc93--


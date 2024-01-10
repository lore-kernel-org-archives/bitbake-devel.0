Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B6C4707B
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 16:47:10 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.16630.1704905220665923149
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jan 2024 08:47:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mXFbBlsi;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3373a30af67so4019340f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 08:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704905219; x=1705510019; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xQId8xG7MGk1NIUatl24ULZdsC9p8DWduKD/mv1CHGI=;
        b=mXFbBlsiPhCfnElqBRIASfulSFNydj6jzd+AqaRLuwLC7xUdu/Zp1q2N4JaxfsaGVl
         A1wu8lXUfFMoXAxyo+5Mre5FjzfZCHue+7bWqzvcfAez/0RDmydTNkoAK1HVlaAhbUHR
         gx1uIOX5uhWat2U8mtJTl24wdSoMK1lWsyApOWd4Cf8qy2t52t4pw9K+4+0R548uWyoz
         uzMGzSU1xz9ksH65e3QgzipfoFtVXrfRNJ/V0trVDPxgjYtds8CtytHkEBFuEhO9/zrS
         HDnB7TbX2wDquEHmbS4ct/xv+cv4c7JhulJJXLUHIZrv+5wK55P2fXgvCcYFUxPw9rqT
         FOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704905219; x=1705510019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQId8xG7MGk1NIUatl24ULZdsC9p8DWduKD/mv1CHGI=;
        b=qDnxF9s3MFeeEC53zGWDBm240zX7myRXjPDYAxwgvgqayqNOu+EnjXkem7sopEE1la
         kN/rMP5XEAn35oRlbaKAN4bP29h4w3fDxNJOxXYZMDsePVQ934tC3ZEw7lyviiHAxI1S
         8ux3n45+iOj9xy2aN5dVMABGqss2t5ZhjCi5/4H2KwP84f5ik7pp8dcdITRMZ0dcEsBR
         XuyopR6nAUUuMYGSnATyvFr17X7mlo3DYhCysRaI1WidUYRSS1jubdgYjwc3vvRoM2qq
         vA7/t04XdeWHtdF0Aeywnho6oJfkeOsTPdGfpd8IKZVSCvq29IqhS6ULn1jeILOYgrkO
         Ts6w==
X-Gm-Message-State: AOJu0YyohKl/8aDGM+u9Abe04xVASwYyLCOvbGA9supbrKfZhtWq/KLC
	2nbt0IzeRj+bUKWrTuSiYFIIOvYWrefqwXW5cxE=
X-Google-Smtp-Source: AGHT+IERBs4CTH1lRQRpshx2L9ClkTSuTGgaSql449E0AABf3Rhbk0rzwJPcHJPSrEIduAOPxj7bmEMcTRRhbUl6RSM=
X-Received: by 2002:a5d:4010:0:b0:336:e646:32d4 with SMTP id
 n16-20020a5d4010000000b00336e64632d4mr574465wrp.135.1704905218660; Wed, 10
 Jan 2024 08:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20230713105303.4105584-1-richard.purdie@linuxfoundation.org>
 <CAHUKmYZvYbs236DUrUna_SGRm-9R1SPkDAvZJn+XkrwJri2xNg@mail.gmail.com>
 <15224f4fe986ab3508c1d0dc3d9b33b0b3e2e9c0.camel@linuxfoundation.org>
 <c0a11023-9bc7-40de-9240-0006c98f1607@windriver.com> <c527e73b-7e94-4495-b155-437d48284359@windriver.com>
 <CAHUKmYYtHVt-BNR7et6bLv2bDQLTm0Q+50GLBtzCuukJWhrGZQ@mail.gmail.com> <aab3f796-728e-4716-b094-daee2e822612@windriver.com>
In-Reply-To: <aab3f796-728e-4716-b094-daee2e822612@windriver.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 10 Jan 2024 17:46:47 +0100
Message-ID: <CA+chaQfuyyOACJ1SL6gu=0ASnzqgD++Q73H2+ibbZRA4YsLBwg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Add pressure change logging
To: randy.macleod@windriver.com
Cc: Etienne Cordonnier <ecordonnier@snap.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ef217b060e9a2d5f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 16:47:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15780

--000000000000ef217b060e9a2d5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think your limit 500 is just too low after:
https://lists.openembedded.org/g/bitbake-devel/message/15499
was backported (already included in kirkstone-4.0.15).

FWIW: on 64 thread AMD Threadripper 3970X I'm using much higher CPU_MAX
limit and much lower bitbake thread count and still trigger these messages
(but I still find them useful).

This was just "small incremental build" of "bitbake -k lib32-kmscube
lib32-wavpack":

Sstate summary: Wanted 62 Local 0 Mirrors 0 Missed 62 Current 431 (0%
match, 87% complete)
Removing 48 stale sstate objects for arch mach: 100%
Removing 1 stale sstate objects for arch x86_64: 100%
NOTE: Executing Tasks
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
533768.7/200000.0, IO: 3306.5/None, Mem: 2611.1/None) - using 2/8 bitbake
threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
172224.8/200000.0, IO: 9830.9/None, Mem: 0.0/None) - using 2/8 bitbake
threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
426774.0/200000.0, IO: 3229.3/None, Mem: 0.0/None) - using 2/8 bitbake
threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
170159.7/200000.0, IO: 798.0/None, Mem: 0.0/None) - using 2/8 bitbake
threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
201391.4/200000.0, IO: 132.8/None, Mem: 0.0/None) - using 2/8 bitbake
threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
159116.4/200000.0, IO: 0.0/None, Mem: 0.0/None) - using 2/8 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
210248.5/200000.0, IO: 270.8/None, Mem: 0.0/None) - using 3/8 bitbake
threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
198485.4/200000.0, IO: 1577.3/None, Mem: 0.0/None) - using 3/8 bitbake
threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
219595.7/200000.0, IO: 3824.7/None, Mem: 0.0/None) - using 3/8 bitbake
threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
199729.1/200000.0, IO: 1121.1/None, Mem: 0.0/None) - using 3/8 bitbake
threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
304074.6/200000.0, IO: 5498.7/None, Mem: 44.2/None) - using 3/8 bitbake
threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
194765.9/200000.0, IO: 2600.7/None, Mem: 0.0/None) - using 3/8 bitbake
threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
201263.5/200000.0, IO: 2437.4/None, Mem: 0.0/None) - using 4/8 bitbake
threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:
195733.7/200000.0, IO: 2454.0/None, Mem: 0.0/None) - using 4/8 bitbake
threads
NOTE: Tasks Summary: Attempted 1473 tasks of which 1335 didn't need to be
rerun and all succeeded.

On Wed, Jan 10, 2024 at 4:28=E2=80=AFPM Randy MacLeod via lists.openembedde=
d.org
<randy.macleod=3Dwindriver.com@lists.openembedded.org> wrote:

> Hi Etienne,
>
> On 2024-01-10 9:09 a.m., Etienne Cordonnier wrote:
>
> "How many physical/virtual cores are actually available?
>
> Is some other activity doing CPU intensive work on the system?
> Is the one task running > 48 compile jobs and causing CPU contention in
> the system?"
>
> -> This is a physical PC with 24 physical cores and 48 cores when you tak=
e
> hyperthreading into account (Intel Xeon Gold 6240R)
>
> Thanks.
>
> -> there is no other activity doing CPU intensive work
> -> some bitbake tasks can easily load 48 cores, yes (this is a custom
> image with some extra layers added)
>
>
> I see, then other than deferring new tasks, there's not much that pressur=
e
> regulation can do to help once one of these
> CPU intensive tasks is started.
>
> Other than the log verbosity which we likely won't change for a while, di=
d
> you have any PSI-related concerns?
>
> I did notice that your last log was:
> > NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:
> 21922.9/500.0, IO: 10137.8/None, Mem: 194.8/None) - using 1/48 bitbake
> threads
>
> When there's memory pressure, that's usually an indication that the syste=
m
> is paging to disk.
>
>
> Also, despite the logs, do you find that pressure regulation is useful fo=
r
> you?
> You can always leave it turned off and only rely on the task and job
> limits.
>
> Thanks,
>
> ../Randy
>
>
>
> Etienne
>
>
> --
> # Randy MacLeod
> # Wind River Linux
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15779):
> https://lists.openembedded.org/g/bitbake-devel/message/15779
> Mute This Topic: https://lists.openembedded.org/mt/100117828/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000ef217b060e9a2d5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>I think your limit 500 is just too l=
ow after:</div><div><a href=3D"https://lists.openembedded.org/g/bitbake-dev=
el/message/15499">https://lists.openembedded.org/g/bitbake-devel/message/15=
499</a><br></div><div>was backported (already included in=C2=A0kirkstone-4.=
0.15).</div><div><br></div></div><div dir=3D"ltr">FWIW: on 64 thread AMD Th=
readripper 3970X I&#39;m using much higher CPU_MAX limit and much lower bit=
bake thread count and still trigger these messages (but I still find them u=
seful).<div><br></div><div>This was just &quot;small incremental build&quot=
; of &quot;bitbake -k lib32-kmscube lib32-wavpack&quot;:<br></div><div><br>=
</div><div>Sstate summary: Wanted 62 Local 0 Mirrors 0 Missed 62 Current 43=
1 (0% match, 87% complete)<br>Removing 48 stale sstate objects for arch mac=
h: 100%=C2=A0<br>Removing 1 stale sstate objects for arch x86_64: 100%=C2=
=A0<br>NOTE: Executing Tasks<br>NOTE: Pressure status changed to CPU: True,=
 IO: None, Mem: None (CPU: 533768.7/200000.0, IO: 3306.5/None, Mem: 2611.1/=
None) - using 2/8 bitbake threads<br>NOTE: Pressure status changed to CPU: =
False, IO: None, Mem: None (CPU: 172224.8/200000.0, IO: 9830.9/None, Mem: 0=
.0/None) - using 2/8 bitbake threads<br>NOTE: Pressure status changed to CP=
U: True, IO: None, Mem: None (CPU: 426774.0/200000.0, IO: 3229.3/None, Mem:=
 0.0/None) - using 2/8 bitbake threads<br>NOTE: Pressure status changed to =
CPU: False, IO: None, Mem: None (CPU: 170159.7/200000.0, IO: 798.0/None, Me=
m: 0.0/None) - using 2/8 bitbake threads<br>NOTE: Pressure status changed t=
o CPU: True, IO: None, Mem: None (CPU: 201391.4/200000.0, IO: 132.8/None, M=
em: 0.0/None) - using 2/8 bitbake threads<br>NOTE: Pressure status changed =
to CPU: False, IO: None, Mem: None (CPU: 159116.4/200000.0, IO: 0.0/None, M=
em: 0.0/None) - using 2/8 bitbake threads<br>NOTE: Pressure status changed =
to CPU: True, IO: None, Mem: None (CPU: 210248.5/200000.0, IO: 270.8/None, =
Mem: 0.0/None) - using 3/8 bitbake threads<br>NOTE: Pressure status changed=
 to CPU: False, IO: None, Mem: None (CPU: 198485.4/200000.0, IO: 1577.3/Non=
e, Mem: 0.0/None) - using 3/8 bitbake threads<br>NOTE: Pressure status chan=
ged to CPU: True, IO: None, Mem: None (CPU: 219595.7/200000.0, IO: 3824.7/N=
one, Mem: 0.0/None) - using 3/8 bitbake threads<br>NOTE: Pressure status ch=
anged to CPU: False, IO: None, Mem: None (CPU: 199729.1/200000.0, IO: 1121.=
1/None, Mem: 0.0/None) - using 3/8 bitbake threads<br>NOTE: Pressure status=
 changed to CPU: True, IO: None, Mem: None (CPU: 304074.6/200000.0, IO: 549=
8.7/None, Mem: 44.2/None) - using 3/8 bitbake threads<br>NOTE: Pressure sta=
tus changed to CPU: False, IO: None, Mem: None (CPU: 194765.9/200000.0, IO:=
 2600.7/None, Mem: 0.0/None) - using 3/8 bitbake threads<br>NOTE: Pressure =
status changed to CPU: True, IO: None, Mem: None (CPU: 201263.5/200000.0, I=
O: 2437.4/None, Mem: 0.0/None) - using 4/8 bitbake threads<br>NOTE: Pressur=
e status changed to CPU: False, IO: None, Mem: None (CPU: 195733.7/200000.0=
, IO: 2454.0/None, Mem: 0.0/None) - using 4/8 bitbake threads<br>NOTE: Task=
s Summary: Attempted 1473 tasks of which 1335 didn&#39;t need to be rerun a=
nd all succeeded.<br></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Wed, Jan 10, 2024 at 4:28=E2=80=AFPM Randy Ma=
cLeod via <a href=3D"http://lists.openembedded.org" target=3D"_blank">lists=
.openembedded.org</a> &lt;randy.macleod=3D<a href=3D"mailto:windriver.com@l=
ists.openembedded.org" target=3D"_blank">windriver.com@lists.openembedded.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><u></u>

 =20
  <div>
    <div>Hi Etienne,</div>
    <div><br>
    </div>
    <div>On 2024-01-10 9:09 a.m., Etienne
      Cordonnier wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">&quot;How many physical/virtual cores are actually
        available?
        <p>Is some other activity doing CPU intensive work on the
          system?<br>
          Is the one task running &gt; 48 compile jobs and causing CPU
          contention in the system?&quot;<br>
          <br>
          -&gt; This is a physical PC with 24 physical cores and 48
          cores when you take hyperthreading into account (Intel Xeon
          Gold 6240R)<br>
        </p>
      </div>
    </blockquote>
    Thanks.<br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <p>-&gt; there is no other activity doing CPU intensive work<br>
          -&gt; some bitbake tasks can easily load 48 cores, yes (this
          is a custom image with some extra layers added)<br>
        </p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I see, then other than deferring new tasks, there&#39;s not much tha=
t
      pressure regulation can do to help once one of these <br>
      CPU intensive tasks is started.</p>
    <p>Other than the log verbosity which we likely won&#39;t change for a
      while, did you have any PSI-related concerns?</p>
    <p>I did notice that your last log was:<br>
      &gt; NOTE: Pressure status changed to CPU: True, IO: None, Mem:
      None (CPU: 21922.9/500.0, IO: 10137.8/None, Mem: 194.8/None) -
      using 1/48 bitbake threads</p>
    <p>When there&#39;s memory pressure, that&#39;s usually an indication t=
hat
      the system is paging to disk.<br>
    </p>
    <p><br>
    </p>
    <p>Also, despite the logs, do you find that pressure regulation is
      useful for you?<br>
      You can always leave it turned off and only rely on the task and
      job limits.<br>
    </p>
    <p>Thanks,<br>
    </p>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <p><br>
          Etienne</p>
      </div>
    </blockquote>
    <br>
    <pre cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </div>

<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15779): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15779" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15779</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/100117828/361=
7156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/100117828/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:martin.jansa@gmail.com" target=3D"=
_blank">martin.jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000ef217b060e9a2d5f--


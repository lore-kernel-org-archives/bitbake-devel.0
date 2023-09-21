Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87BCE7071B
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 11:09:54 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web10.13789.1695294585008391823
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Sep 2023 04:09:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=FAEfAc5H;
 spf=pass (domain: snapchat.com, ip: 209.85.218.52, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9ada609bb62so93257666b.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 04:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1695294583; x=1695899383; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WIeUbsrX1j78qnu73kO38z9sNRR1rXkrvY5Zz/UVLA4=;
        b=FAEfAc5Hgtwa5GhWO5T4UtMOCO62VfOLflsdbksnzWMYwTwO0jSBZ2yP6OAlI6oMuA
         2ZHYwA1zabBbUmIx4MRMIEMA2HFRgJx4GZaWLt5Bc2Zm2Nrc0k7HaHzLzNY4BRfytn5A
         qcd/ldsEfFy/1yQGMrsrqLjQOmqf3BRoxv3EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695294583; x=1695899383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIeUbsrX1j78qnu73kO38z9sNRR1rXkrvY5Zz/UVLA4=;
        b=Ppvteq1BDIsmem1lC2dwF/4+lEzjchNPNCp4SbRnFnd/nuSgtpBofNMC/0JPuJGFDz
         TU0jhpjSs9fqdVi+QJsLp4unEdVhNACumghSUBdhA6kKDZmw5dzCEXF+qjOCibLtstGH
         DL7D9dN9/gRK33xDYLkfE+83T891b5wqcPofapT2nGdABauYh2oIZLKsYjE1juFA7Jot
         alfUSkKzV5YU0zhkRaa6cOyv5fyhERIqmaevBqxsKY2wRAVn28hs/Yodi3DH/jhWsaIb
         zJjx63hI5GHIvyx7hHan35UOGhwjh5o8TJuaWuJ+jPbCwg2jgkrkoyKDVA3kjxEkuqv6
         Xlcg==
X-Gm-Message-State: AOJu0Yz6V8I6brroM2Bu+KN2anM8USiAzvtWL0U0oGXwIx+74evhm2vz
	Ew8WZ1bBZjD/85pRcgkfno5X0AUESxDumRn1gTAVCw==
X-Google-Smtp-Source: AGHT+IFRWhG6qIOVkq7Lu1ikjMDQWD3GTExbo9Vi5G43gtytqdnyXiWJSzoAgdvIhIRATpoEBOS7CAvgU6dqwue6rNs=
X-Received: by 2002:a17:906:53d3:b0:9ae:5898:e278 with SMTP id
 p19-20020a17090653d300b009ae5898e278mr1856895ejo.59.1695294583193; Thu, 21
 Sep 2023 04:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230921075658.509846-1-ecordonnier@snap.com> <0d94ff1c8efe8d37471f3c0bfe09403a7d8c5af8.camel@linuxfoundation.org>
In-Reply-To: <0d94ff1c8efe8d37471f3c0bfe09403a7d8c5af8.camel@linuxfoundation.org>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Thu, 21 Sep 2023 13:09:31 +0200
Message-ID: <CAHUKmYYtZ4_sBMVejOcpoOyFY3HEQ-39NHxCOWrgn02b_CPPPA@mail.gmail.com>
Subject: Re: [docs] [PATCH] bitbake-worker: add header with length of message
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000006c4ca40605dc874c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 11:09:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15102

--0000000000006c4ca40605dc874c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,
we have a use-case similar to the use-case for the externalsrc class, where
we add whole directories containing many source-code files to SRC_URI of
various recipes (instead of pointing to a tarball or to a git repository
like poky recipes do). For that reason, we transmit 180MB of "workerdata"
for one build instead of 18MB of workerdata e.g. for core-image-sato. The
workerdata contains the signatures of many files and is therefore quite big
(the "sigdata" field of the workerdata dictionary).
However with this fix the transmission is quite fast (about 1.5 seconds for
the call to "RunQueue.send_pickled_data(worker, workerdata, "workerdata")",
and could probably be optimized even more by passing the length-header
first in the IPC and doing only one blocking read for all the data).

Here is an analysis of the workerdata payload in my test setup (I dumped
workerdata to a file, then used awk '{ print length }' file.txt to count
each line):
'taskdeps': 16.520.856
'fakerootenv': 10.318.907
'fakerootdirs': 884.364
'fakerootnoenv': 569.865
'sigdata': 160.786.962
'logdefaultlevel': 23
'build_verbose_shell': 30
'build_verbose_stdout': 31
'logdefaultdomain': 24
'prhost': 16
'buildname': 31
'date': 20
'time': 18
'hashservaddr': 22
'umask': 17

Reducing the size of the data is maybe an option (I don't know enough about
bitbake architecture to judge whether it's possible or not), but I would
improve the IPC anyway, since there is no drawback in making it more
efficient.

Etienne

On Thu, Sep 21, 2023 at 10:22=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Thu, 2023-09-21 at 09:56 +0200, Etienne Cordonnier via
> lists.yoctoproject.org wrote:
> > From: Etienne Cordonnier <ecordonnier@snap.com>
> >
> > The IPC mechanism between runqueue.py and bitbake-worker is currently
> > not scalable:
> >
> > The data is sent with the format <tag>pickled-data</tag>, and
> bitbake-worker
> > has no information about the size of the message. Therefore, the
> bitbake-worker
> > is calling select() and read() in a loop, and then calling
> "self.queue.find(b"</" + item + b">")"
> > for each chunk received.
> >
> > This does not scale, because queue.find has a linear complexity relativ=
e
> to the size of the queue,
> > and workerdata messages get very big e.g. for builds which reference a
> lot of files in SRC_URI.
> > The number of chunks varies, but on my test system a lot of chunks of
> 65536 bytes are sent, and each
> > iteration takes 0.1 seconds, making the transfer of the "workerdata"
> data very slow (on my test setup
> > 35 seconds before this fix, and 1.5 seconds after this fix).
> >
> > This commit adds a 4 bytes header after <tag>, so that bitbake-worker
> knows how many bytes need to be
> > received, and does not need to constantly search the whole queue for
> </tag>.
> >
> > Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> > ---
> >  bin/bitbake-worker | 34 +++++++++++++++++++++++-----------
> >  lib/bb/runqueue.py | 34 ++++++++++++++++++++++------------
> >  2 files changed, 45 insertions(+), 23 deletions(-)
>
> This does look interesting. The IPC mechanism was never intended to
> carry large data and it has changed over time in ways it was never
> really designed for.
>
> I'm guessing just one of the objects is particularly large? You mention
> lots of files in SRC_URI causing the issue, I'd like to better
> understand that.
>
> I'm just wondering whether instead of improving the IPC, we could avoid
> some of the data in the first place?
>
> Cheers,
>
> Richard
>

--0000000000006c4ca40605dc874c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<br>we have a use-case similar to the use-case =
for the externalsrc class, where we add whole directories containing many s=
ource-code files to SRC_URI of various recipes (instead of pointing to a ta=
rball or to a git repository like poky recipes do). For that reason, we tra=
nsmit 180MB of &quot;workerdata&quot; for one build instead of 18MB of work=
erdata e.g. for core-image-sato. The workerdata contains the signatures of =
many files and is therefore quite big (the &quot;sigdata&quot; field of the=
 workerdata dictionary).<br>However with this fix the transmission is quite=
 fast (about 1.5 seconds for the call to &quot;RunQueue.send_pickled_data(w=
orker, workerdata, &quot;workerdata&quot;)&quot;, and could probably be opt=
imized even more by passing the length-header first in the IPC and doing on=
ly one blocking read for all the data).<br><br>Here is an analysis of the w=
orkerdata payload in my test setup (I dumped workerdata=C2=A0to a file, the=
n used awk &#39;{ print length }&#39; file.txt to count each line):<br>&#39=
;taskdeps&#39;: 16.520.856<br>&#39;fakerootenv&#39;: 10.318.907<br>&#39;fak=
erootdirs&#39;: 884.364<br>&#39;fakerootnoenv&#39;: 569.865<br>&#39;sigdata=
&#39;: 160.786.962<br>&#39;logdefaultlevel&#39;: 23<br>&#39;build_verbose_s=
hell&#39;: 30<br>&#39;build_verbose_stdout&#39;: 31<br>&#39;logdefaultdomai=
n&#39;: 24<br>&#39;prhost&#39;: 16<br>&#39;buildname&#39;: 31<br>&#39;date&=
#39;: 20<br>&#39;time&#39;: 18<br>&#39;hashservaddr&#39;: 22<br>&#39;umask&=
#39;: 17<br><br>Reducing the size of the data is maybe an option (I don&#39=
;t know enough about bitbake architecture to judge whether it&#39;s possibl=
e or not), but I would improve the IPC anyway, since there is no drawback i=
n making it more efficient.<br><br>Etienne</div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 21, 2023 at 10:22=E2=
=80=AFAM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundatio=
n.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Thu, 2023-09-21 at 09:56 +0200,=
 Etienne Cordonnier via<br>
<a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.yoctoproject.org</a> wrote:<br>
&gt; From: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; <br>
&gt; The IPC mechanism between runqueue.py and bitbake-worker is currently<=
br>
&gt; not scalable:<br>
&gt; <br>
&gt; The data is sent with the format &lt;tag&gt;pickled-data&lt;/tag&gt;, =
and bitbake-worker<br>
&gt; has no information about the size of the message. Therefore, the bitba=
ke-worker<br>
&gt; is calling select() and read() in a loop, and then calling &quot;self.=
queue.find(b&quot;&lt;/&quot; + item + b&quot;&gt;&quot;)&quot;<br>
&gt; for each chunk received.<br>
&gt; <br>
&gt; This does not scale, because queue.find has a linear complexity relati=
ve to the size of the queue,<br>
&gt; and workerdata messages get very big e.g. for builds which reference a=
 lot of files in SRC_URI.<br>
&gt; The number of chunks varies, but on my test system a lot of chunks of =
65536 bytes are sent, and each<br>
&gt; iteration takes 0.1 seconds, making the transfer of the &quot;workerda=
ta&quot; data very slow (on my test setup<br>
&gt; 35 seconds before this fix, and 1.5 seconds after this fix).<br>
&gt; <br>
&gt; This commit adds a 4 bytes header after &lt;tag&gt;, so that bitbake-w=
orker knows how many bytes need to be<br>
&gt; received, and does not need to constantly search the whole queue for &=
lt;/tag&gt;.<br>
&gt; <br>
&gt; Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@sn=
ap.com" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 bin/bitbake-worker | 34 +++++++++++++++++++++++-----------<br>
&gt;=C2=A0 lib/bb/runqueue.py | 34 ++++++++++++++++++++++------------<br>
&gt;=C2=A0 2 files changed, 45 insertions(+), 23 deletions(-)<br>
<br>
This does look interesting. The IPC mechanism was never intended to<br>
carry large data and it has changed over time in ways it was never<br>
really designed for.<br>
<br>
I&#39;m guessing just one of the objects is particularly large? You mention=
<br>
lots of files in SRC_URI causing the issue, I&#39;d like to better<br>
understand that.<br>
<br>
I&#39;m just wondering whether instead of improving the IPC, we could avoid=
<br>
some of the data in the first place?<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--0000000000006c4ca40605dc874c--


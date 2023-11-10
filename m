Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D82FC41535
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 19:17:08 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web10.36173.1699643827121544338
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 11:17:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gilQ/8ji;
 spf=pass (domain: gmail.com, ip: 209.85.128.172, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5afabb23900so28307467b3.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 11:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699643826; x=1700248626; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QdHwyP2LcI1ABqP43nnochQ8uHtDhP2Cg3hvR9pdmyg=;
        b=gilQ/8jiBpjCxGSYxVd4GqvWgj0ww4YeTzBrJYOnzh+AWk08g+qpHY9gdTp4hEA/O8
         xAdLfsASudY08ND6pq43VGmkdhOHPiUL5t6vfV2PBF7QbTAe1dANHbvB7xXiIBSYHY5x
         1vqRUooG3EHPXZkjnx0Nq2YUyBFXv1LPV1FihJdgaFHGlImzdj80nqNsgzweXqDBZqho
         ccNI4mwZYhL5HGreSfirjLaeUzzj9wWSEfxoTJvSprmSwCiIHJhfpQP8nZh2pBc3ueQf
         cYWYVPqqQ3NifXJDCKvU35RQvvqeTwzzSZMbfetWT6DatXknaO1rTDVSj4f21qkio7wU
         XcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699643826; x=1700248626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdHwyP2LcI1ABqP43nnochQ8uHtDhP2Cg3hvR9pdmyg=;
        b=RHXnBP9XWe8aXzyTZUvomoZjGJwpc/+zIjyTpx+Yd6jzTzk8wd8SJbWArFinRdteyq
         Qf7s2ND2nii1W7bE1Qi6NuRCwoy1uwmedDxzbGjYAjSu5yo+wRBggFaEP0eohPEI3xoG
         PgUEOY+awzzemD7Ai1/ZkorvlfpxXcjnl8APqhh+J0lroS3Tfl4cchC5RW3HamTMQtTx
         2kCgMITRMr8li1zoISroUWFtIdiQ+ZP6hIV+TcCoGMFpF/uQqKstSx/aTwqXJ6MCYDds
         Rhxq+ZJvPSPXs2bgfft7VE+Jh8AnP7na2SnQs0UmbNgYkS1v31Sgb4Db4YeY524nbGAN
         skJQ==
X-Gm-Message-State: AOJu0YwM21R4Ykn66DKH/nO6XVGlg1Y/ZJXg2ZV1vQRlBDcP4Nky0Kfw
	ntnEopDSZt82qEfzpo8Y4MZb8rcovAw7L3ZeQ9k=
X-Google-Smtp-Source: AGHT+IGFJnf6hHJ51sHvSXTY40kPj8pBaNReRpH8dKLXJc9WqJfSykgHJUyVKTFnBWySqUJW6G6JrwCw1RVSoyH6ZiU=
X-Received: by 2002:a0d:ea10:0:b0:58e:a9d3:bf98 with SMTP id
 t16-20020a0dea10000000b0058ea9d3bf98mr118511ywe.27.1699643826204; Fri, 10 Nov
 2023 11:17:06 -0800 (PST)
MIME-Version: 1.0
References: <20231110153009.3592572-1-tim.orling@konsulko.com> <85003f99a53c415511aa2c3efa54a32ee1303e13.camel@linuxfoundation.org>
In-Reply-To: <85003f99a53c415511aa2c3efa54a32ee1303e13.camel@linuxfoundation.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 10 Nov 2023 11:16:55 -0800
Message-ID: <CANx9H-Cx-j=kcSOppNiA_B52By0ze9KF8Yi4yGV_b-gjvwC=PQ@mail.gmail.com>
Subject: Re: [Toaster] [PATCH] toaster: log ProcessLookupError in test_runbuilds
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org, 
	Tim Orling <tim.orling@konsulko.com>
Content-Type: multipart/alternative; boundary="00000000000081767d0609d12aa6"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 19:17:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15513

--00000000000081767d0609d12aa6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ignore this patch. More analysis is required.

On Fri, Nov 10, 2023 at 10:01=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2023-11-10 at 07:30 -0800, Tim Orling wrote:
> > This repeatably fails:
> >
> > Exception in thread Thread-2:
> > Traceback (most recent call last):
> >   File "/usr/lib/python3.10/threading.py", line 1016, in _bootstrap_inn=
er
> >     self.run()
> >   File ".../poky/bitbake/lib/toaster/tests/commands/test_runbuilds.py",
> line 39, in run
> >     os.kill(int(pid), signal.SIGTERM)
> > ProcessLookupError: [Errno 3] No such process
> >
> > Rather than have a hard error, add logging and output as a warning.
> >
> > Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> > ---
> >  lib/toaster/tests/commands/test_runbuilds.py | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/toaster/tests/commands/test_runbuilds.py
> b/lib/toaster/tests/commands/test_runbuilds.py
> > index c77d6cf4..14b35764 100644
> > --- a/lib/toaster/tests/commands/test_runbuilds.py
> > +++ b/lib/toaster/tests/commands/test_runbuilds.py
> > @@ -19,6 +19,10 @@ import time
> >  import subprocess
> >  import signal
> >
> > +import logging
> > +
> > +logger =3D logging.getLogger("toaster")
> > +
> >
> >  class KillRunbuilds(threading.Thread):
> >      """ Kill the runbuilds process after an amount of time """
> > @@ -36,8 +40,11 @@ class KillRunbuilds(threading.Thread):
> >
> >          with open(pidfile_path) as pidfile:
> >              pid =3D pidfile.read()
> > -            os.kill(int(pid), signal.SIGTERM)
> > -
> > +            try:
> > +                os.kill(int(pid), signal.SIGTERM)
> > +            except ProcessLookupError as err:
> > +                logger.warning("Failed to kill pid. %s" % err)
> > +                pass
> >
>
> Is this a case of "just ensure bitbake has really exited"? If so we
> perhaps don't need the warning as it is quite likely it has exited?
>
>
When Toaster starts, the .runbuild.pid file is created in the $BUILDDIR.
Manually running 'manage.py runbuilds' should leave a process running.
My suspicion is the path to .runbuilds.pid is somehow getting mangled or
a stale, old .runbuilds.pid is sticking around. Something is wonky in the
test environment.



> Cheers,
>
> Richard
>
>

--00000000000081767d0609d12aa6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Ignore this patch. More analysis is requi=
red.<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Fri, Nov 10, 2023 at 10:01=E2=80=AFAM Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundati=
on.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Fri, 2023-11-10 at 07:30 -0800, Tim Orling wrote:<br>
&gt; This repeatably fails:<br>
&gt; <br>
&gt; Exception in thread Thread-2:<br>
&gt; Traceback (most recent call last):<br>
&gt;=C2=A0 =C2=A0File &quot;/usr/lib/python3.10/threading.py&quot;, line 10=
16, in _bootstrap_inner<br>
&gt;=C2=A0 =C2=A0 =C2=A0self.run()<br>
&gt;=C2=A0 =C2=A0File &quot;.../poky/bitbake/lib/toaster/tests/commands/tes=
t_runbuilds.py&quot;, line 39, in run<br>
&gt;=C2=A0 =C2=A0 =C2=A0os.kill(int(pid), signal.SIGTERM)<br>
&gt; ProcessLookupError: [Errno 3] No such process<br>
&gt; <br>
&gt; Rather than have a hard error, add logging and output as a warning.<br=
>
&gt; <br>
&gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.co=
m" target=3D"_blank">tim.orling@konsulko.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/toaster/tests/commands/test_runbuilds.py | 11 +++++++++--<br=
>
&gt;=C2=A0 1 file changed, 9 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/lib/toaster/tests/commands/test_runbuilds.py b/lib/toaste=
r/tests/commands/test_runbuilds.py<br>
&gt; index c77d6cf4..14b35764 100644<br>
&gt; --- a/lib/toaster/tests/commands/test_runbuilds.py<br>
&gt; +++ b/lib/toaster/tests/commands/test_runbuilds.py<br>
&gt; @@ -19,6 +19,10 @@ import time<br>
&gt;=C2=A0 import subprocess<br>
&gt;=C2=A0 import signal<br>
&gt;=C2=A0 <br>
&gt; +import logging<br>
&gt; +<br>
&gt; +logger =3D logging.getLogger(&quot;toaster&quot;)<br>
&gt; +<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class KillRunbuilds(threading.Thread):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Kill the runbuilds process afte=
r an amount of time &quot;&quot;&quot;<br>
&gt; @@ -36,8 +40,11 @@ class KillRunbuilds(threading.Thread):<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(pidfile_path) as pidfile:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D pidfile.read()=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.kill(int(pid), signal.SI=
GTERM)<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.kill(int(p=
id), signal.SIGTERM)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except ProcessLookupError a=
s err:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.warnin=
g(&quot;Failed to kill pid. %s&quot; % err)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt;=C2=A0 <br>
<br>
Is this a case of &quot;just ensure bitbake has really exited&quot;? If so =
we<br>
perhaps don&#39;t need the warning as it is quite likely it has exited?<br>
<br></blockquote><div><br></div><div>When Toaster starts, the .runbuild.pid=
 file is created in the $BUILDDIR.</div><div>Manually running &#39;manage.p=
y runbuilds&#39; should leave a process running.</div><div>My suspicion is =
the path to .runbuilds.pid is somehow getting mangled or</div><div>a stale,=
 old .runbuilds.pid is sticking around. Something is wonky in the</div><div=
>test environment.</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div></div>

--00000000000081767d0609d12aa6--


Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045E0C4332F
	for <webhook@archiver.kernel.org>; Mon, 14 Nov 2022 13:16:50 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web11.5365.1668431808288645980
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Nov 2022 05:16:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=jRfKOCM9;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: quaresma.jose@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id t10so13155158ljj.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Nov 2022 05:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cQJt7FYILEIV/Lz7SubP7Wy6YK3cVitmPef5KGXBWrg=;
        b=jRfKOCM9PI2Ie2AI11s48J8wLrvNSD3Qlsj4UJ5KiUGiW50gl++AL60hKzPblH2RR7
         ZvlWogY2IJlEGQRzXcFOn4Bzw+14jHPGYTqB06EZN/PTuHexUlHe58t3cAn7ok2OCktv
         d3pmI/cb3AKNefS/DgE06XAZKkz0JSPbknJyoQCkgFscEGPieTEGCKB/5GpAGNhPktqs
         UPUmpdjvnoooPnc2qNVDCtgscGcsJl+q1WbsTythcA0laRhoyIWMOyE3D/T/oCXgqAgS
         dvZfZ3tLQAXDfINJ3Kym/b8v1fBtsy2C5HzkursLe9yDPMBOdqNqTiCXw2IlRAp3qN11
         IGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQJt7FYILEIV/Lz7SubP7Wy6YK3cVitmPef5KGXBWrg=;
        b=DRgN5dM7BD6Vim4Tqfc/htuUFcNFK+GTs8JnrUD9F2LOLDj3QEj2mdmlObFiMc0zMd
         kVC1j8U16o0t0vGjcTK/QBlYKY7vlUJaVEopfdm/b1TENLT7LKahX9V+Yp9nCB2SFQhZ
         /umQsdhdNbOXhlRaCXVmXZZFm3szyx4MnPM1zJt9sYZ8w80BYYC8fidaND191IdNRxyL
         zP8jQW97FKG47Ov9lPLYRoGwuiM0JvL59i7zAF3bTuMtC48i87pLn7ZGSbTpWDjz8AUV
         F6jdRAfAWXuToXn0d/D1AZIm6ymbcVCWaYRDcAKkRouq7ejjzhwVtvn96LaqrmowMvSf
         nnhA==
X-Gm-Message-State: ANoB5pko4Ifm8p3wxpDhKuywVt5k+HmO7Qm3+2HT+dzwDLgSEN1QkoD3
	qIVcXct0Tyclav01TjVvZo9zOK4SH4a8XugMwkA=
X-Google-Smtp-Source: AA0mqf4h0cCh0CYI97c+G7tXjze8/o73CD5oh7hO994Vcd0/xP5EahM3QOTwralKcrZW2ocrylCzVTzWDUi3+kFVOOQ=
X-Received: by 2002:a2e:8706:0:b0:26d:e3ae:886a with SMTP id
 m6-20020a2e8706000000b0026de3ae886amr4439388lji.531.1668431806154; Mon, 14
 Nov 2022 05:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20221111185849.2458457-1-jose.quaresma@foundries.io>
 <20221111185849.2458457-2-jose.quaresma@foundries.io> <2fff136f04c1c9976dc83c3644227d123e3f3068.camel@linuxfoundation.org>
In-Reply-To: <2fff136f04c1c9976dc83c3644227d123e3f3068.camel@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Mon, 14 Nov 2022 13:16:34 +0000
Message-ID: <CANPvuRn0hPzbyPHve=G7EbMHmpy9cH1s6K3qT2Qw3q4=TTKU1g@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH 2/2] build: log when the task is locked
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, ricardo@foundries.io, 
	daiane.angolini@foundries.io, Jose Quaresma <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="000000000000234c6f05ed6e0d95"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Nov 2022 13:16:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14081

--000000000000234c6f05ed6e0d95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia sexta,
11/11/2022 =C3=A0(s) 23:01:

> On Fri, 2022-11-11 at 18:58 +0000, Jose Quaresma wrote:
> > This improve the bitbake UI when there are tasks with
> > lockfiles waiting to run.
> >
> > In such cases one or more tasks are waiting because
> > there is another one with the lock acquired.
> > The bitbake UI shows that all the tasks is running
> > which is not true and can confuse the user.
> >
> > This patch will shows what are the task that have the lock
> > acquired.
> >
> > Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
> > ---
> >  lib/bb/build.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/bb/build.py b/lib/bb/build.py
> > index ae781c8c..6c0b07a1 100644
> > --- a/lib/bb/build.py
> > +++ b/lib/bb/build.py
> > @@ -253,6 +253,9 @@ def exec_func(func, d, dirs =3D None):
> >                  pass
> >
> >      with bb.utils.fileslocked(lockfiles):
> > +        if lockfiles:
> > +            bb.verbnote("Task locked with lockfiles")
> > +
> >          if ispython:
> >              exec_func_python(func, d, runfile, cwd=3Dadir)
> >          else:
>
> Can you show what the console looks like with this active? Whilst I
> understand there is a usability issue here, I'm not sure printing this
> in the task which has the locks is going to be particularly helpful in
> this way. Instead the user really wants to know the other tasks are
> waiting on a lockfile?
>
> Cheers,
>
> Richard
>
>
For instance if we use the lockfiles in do_compile for clang
and rust-native
i.e: do_compile[lockfiles] +=3D "$TMP/mylockfiles"

Running bitbake tasks with the lockfiles
i.e: bitbake clang rust-native -c do_compile -f


The UI will show:

NOTE: Executing Tasks
NOTE: clang-14.0.3-r0 do_compile: Task locked with lockfiles
Setscene tasks: 168 of 168
Currently  2 running tasks (776 of 777)  99%
|################################################### |
0: rust-native-1.59.0-r0 do_compile - 2m22s (pid 48002)
1: clang-14.0.3-r0 do_compile - 2m22s (pid 51040)   8% |########

Where the clang task is running and the rust-native is waiting (what is not
said anywhere, as you noted)
After some time when the clang compile task ends we get:

NOTE: Executing Tasks
NOTE: clang-14.0.3-r0 do_compile: Task locked with lockfiles
NOTE: rust-native-1.59.0-r0 do_compile: Task locked with lockfiles
Setscene tasks: 168 of 168
Currently  1 running tasks (777 of 777)  99%
|################################################### |
0: rust-native-1.59.0-r0 do_compile - 1m30s (pid 48002)   5% |########


But I agree with you that this is not the best approach to fix this UI issu=
e
because we know what is the task that has the lock but not the ones waiting
for it.
Anyway without this change the situation is even worse and this was the
simplest and fastest way I found.

Jose

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000234c6f05ed6e0d95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&=
gt; escreveu no dia sexta, 11/11/2022 =C3=A0(s) 23:01:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">On Fri, 2022-11-11 at 18:58 +0000, J=
ose Quaresma wrote:<br>
&gt; This improve the bitbake UI when there are tasks with<br>
&gt; lockfiles waiting to run.<br>
&gt; <br>
&gt; In such cases one or more tasks are waiting because<br>
&gt; there is another one with the lock acquired.<br>
&gt; The bitbake UI shows that all the tasks is running<br>
&gt; which is not true and can confuse the user.<br>
&gt; <br>
&gt; This patch will shows what are the task that have the lock<br>
&gt; acquired.<br>
&gt; <br>
&gt; Signed-off-by: Jose Quaresma &lt;<a href=3D"mailto:jose.quaresma@found=
ries.io" target=3D"_blank">jose.quaresma@foundries.io</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/build.py | 3 +++<br>
&gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/bb/build.py b/lib/bb/build.py<br>
&gt; index ae781c8c..6c0b07a1 100644<br>
&gt; --- a/lib/bb/build.py<br>
&gt; +++ b/lib/bb/build.py<br>
&gt; @@ -253,6 +253,9 @@ def exec_func(func, d, dirs =3D None):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 with bb.utils.fileslocked(lockfiles):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if lockfiles:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.verbnote(&quot;Task lock=
ed with lockfiles&quot;)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ispython:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exec_func_python(func,=
 d, runfile, cwd=3Dadir)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
<br>
Can you show what the console looks like with this active? Whilst I<br>
understand there is a usability issue here, I&#39;m not sure printing this<=
br>
in the task which has the locks is going to be particularly helpful in<br>
this way. Instead the user really wants to know the other tasks are<br>
waiting on a lockfile?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><br clear=3D"all"><div>For instance if we use the lockfi=
les in do_compile for clang and=C2=A0rust-native=C2=A0</div><div>i.e: do_co=
mpile[lockfiles] +=3D &quot;$TMP/mylockfiles&quot;<br><br>Running bitbake t=
asks with the lockfiles<br>i.e: bitbake clang rust-native -c do_compile -f<=
br><br><br>The UI will show:<br><br>NOTE: Executing Tasks<br>NOTE: clang-14=
.0.3-r0 do_compile: Task locked with lockfiles<br>Setscene tasks: 168 of 16=
8<br>Currently =C2=A02 running tasks (776 of 777) =C2=A099% |##############=
##################################### |<br>0: rust-native-1.59.0-r0 do_comp=
ile - 2m22s (pid 48002)<br>1: clang-14.0.3-r0 do_compile - 2m22s (pid 51040=
) =C2=A0 8% |########<br><br>Where the clang task is running and the rust-n=
ative is waiting (what is not said anywhere, as you noted)</div><div>After =
some time when the clang compile task ends we get:<br><br><div>NOTE: Execut=
ing Tasks<br>NOTE: clang-14.0.3-r0 do_compile: Task locked with lockfiles<b=
r>NOTE: rust-native-1.59.0-r0=C2=A0do_compile: Task locked with lockfiles<b=
r>Setscene tasks: 168 of 168<br>Currently=C2=A0 1 running tasks (777 of 777=
) =C2=A099% |################################################### |<br>0: ru=
st-native-1.59.0-r0 do_compile - 1m30s (pid 48002)=C2=A0=C2=A0 5% |########=
<br></div><div></div><br><br>But I agree with you that this is not the best=
 approach to fix this UI issue</div><div>because we know what is the task t=
hat has the lock but not the ones waiting for it.<br>Anyway=C2=A0without th=
is change the situation is even worse and this was the simplest and fastest=
 way I found.<br><br></div><div>Jose</div><div><br></div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=
=C3=A9 Quaresma</div></div></div></div>

--000000000000234c6f05ed6e0d95--


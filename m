Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web09.12256.1612886075020582623
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Feb 2021 07:54:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=kaUYg2mr;
 spf=pass (domain: gmail.com, ip: 209.85.166.46, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-io1-f46.google.com with SMTP id e133so19206411iof.8
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Feb 2021 07:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1Prnj8eIAuz1MyMwHPdX7XN93SyehyeHwpNzBNfR/g=;
        b=kaUYg2mr4GEcGb7hXIZdybcy2meo3TK4fNq/k9PawOwS3ZPMHKY1+pWxbed3LLCyXP
         H5OWot5kQaHoKflsNM22EZFO7RHORMs3/yRFZquEC+fht2NpnjbU2fTl2rYq1vvKSRjL
         9SRJIFbEoS2er7O0HINfmEPQ/O5iKD9ZUf21+3/ynpgc3v3L4Jjrxn0leHWCbuiak5oj
         ogaAwKZ/Baj63o7WvBJapT7p4n4mlqoYe2nZCZU5WuMPxdrh3wF3ey6CU4GbC+rToKP/
         xXZSmmwmpLlPNhY1dDnjwZVUGJoLwVDkeETasZlapw0tbFsAlOceEVKgn+ZgNHxWPNga
         0wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1Prnj8eIAuz1MyMwHPdX7XN93SyehyeHwpNzBNfR/g=;
        b=pxfD5o/0b/KIFiR8kGiv75SQoyjYXb/WH6AyfnMqzrTTzi67B+fhD+pMJCbLaQ17qg
         bOaXzeW51mvnEN0DAuBGQrmZzhSURtHTDqemethEuot2F8YUF2yiwUo+uGfiBbZwPKQy
         XwobnXD3v7E0k1aXCOxNyeJ8pMolKL5MiEdenhMK0icx57CbR0qOicdvAV0v/UF6L46h
         HFX0ncljUMC8wTxOF9WGc84tcGd4ODQyi/mxmWJMyLpPV7iegc7gqJGzcGRL2j/WW+cU
         Yj2rQDflks7UFy7b3uyUIfbQD1k8JvFI2sa0K6FNxaO4CIhV2I549OX6U9rFEsS5nTog
         aYYg==
X-Gm-Message-State: AOAM5309bOnUXwYQp+2+xW8EqRjUJOemaGwbeOZyq1qfvXXRufxLQivE
	+9jNMYZMCInMHX94TV7w7bGlvyFcDLZisE9EEfU=
X-Google-Smtp-Source: ABdhPJweyhyJ09kAwSAaTXMAAUNMS1LEQ9RmEDwJme7fDnMUucnakR4e6d8IlOH4tbDvORCwVHSkeMlGnNy3YCkYrWs=
X-Received: by 2002:a05:6638:22c5:: with SMTP id j5mr23314676jat.89.1612886074441;
 Tue, 09 Feb 2021 07:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20210207114659.148514-1-tomasz.dziendzielski@gmail.com> <9a9ad16dbe9d6540fb375d8419fbb569334c1757.camel@linuxfoundation.org>
In-Reply-To: <9a9ad16dbe9d6540fb375d8419fbb569334c1757.camel@linuxfoundation.org>
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
Date: Tue, 9 Feb 2021 16:56:00 +0100
Message-ID: <CAJkqNs2nFzTT+7VGhyuLBt6VsNm6DHvpDdsZ1hjefwV5jrK2NA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v4] event: Prevent bitbake from executing event handler for wrong multiconfig target
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000087c23105bae94de0"

--00000000000087c23105bae94de0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>I did also wonder if we should be changing each of the event register
>callers, or doing something inside the event register function instead?
That should be possible. I'll work on that. Thanks and sorry for the
problem.

Best regards,
Tomasz Dziendzielski

wt., 9 lut 2021 o 16:50 Richard Purdie <richard.purdie@linuxfoundation.org>
napisa=C5=82(a):

> On Sun, 2021-02-07 at 12:46 +0100, Tomasz Dziendzielski wrote:
> > When multiconfig is used bitbake might try to run events that don't
> > exist for specific mc target. In cooker.py we pass
> > `self.databuilder.mcdata[mc]` data that contains names of events'
> > handlers per mc target, but fire_class_handlers uses global _handlers
> > variable that is created during parsing of all the targets.
> >
> > This leads to a problem where bitbake runs event handler that don't
> > exist for a target or even overrides them - if multiple targets use
> > event handler with the same name but different code then only one
> > version will be executed for all targets.
> >
> > See [YOCTO #13071] for detailed bug information.
> >
> > Add mc target name as a prefix to event handler name so there
> > won't be two different handlers with the same name.
> >
> > Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> >
> > --- v4 add mc prefix to _bb_diskmonitor event handler to fix build, bot=
h
> build and test_stoptask_behavior should be working now
> > ---
> >  lib/bb/cookerdata.py |  5 ++++-
> >  lib/bb/event.py      |  2 ++
> >  lib/bb/parse/ast.py  |  7 ++++++-
> >  lib/bb/runqueue.py   | 15 +++++++++++++--
> >  4 files changed, 25 insertions(+), 4 deletions(-)
>
> This still isn't right I'm afraid:
>
> https://autobuilder.yoctoproject.org/typhoon/#/builders/39/builds/3057
>
> I did also wonder if we should be changing each of the event register
> callers, or doing something inside the event register function instead?
>
> Cheers,
>
> Richard
>
>

--00000000000087c23105bae94de0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt;I did also wonder if we should be changing each of the=
 event register<br><div>
&gt;callers, or doing something inside the event register function instead?=
</div><div>That should be possible. I&#39;ll work on that. Thanks and sorry=
 for the problem.<br></div><div><br></div><div>Best regards,</div><div>Toma=
sz Dziendzielski<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">wt., 9 lut 2021 o 16:50=C2=A0Richard Purdie &lt;<=
a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfo=
undation.org</a>&gt; napisa=C5=82(a):<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Sun, 2021-02-07 at 12:46 +0100, Tomasz Dziendziels=
ki wrote:<br>
&gt; When multiconfig is used bitbake might try to run events that don&#39;=
t<br>
&gt; exist for specific mc target. In cooker.py we pass<br>
&gt; `self.databuilder.mcdata[mc]` data that contains names of events&#39;<=
br>
&gt; handlers per mc target, but fire_class_handlers uses global _handlers<=
br>
&gt; variable that is created during parsing of all the targets.<br>
&gt; <br>
&gt; This leads to a problem where bitbake runs event handler that don&#39;=
t<br>
&gt; exist for a target or even overrides them - if multiple targets use<br=
>
&gt; event handler with the same name but different code then only one<br>
&gt; version will be executed for all targets.<br>
&gt; <br>
&gt; See [YOCTO #13071] for detailed bug information.<br>
&gt; <br>
&gt; Add mc target name as a prefix to event handler name so there<br>
&gt; won&#39;t be two different handlers with the same name.<br>
&gt; <br>
&gt; Signed-off-by: Tomasz Dziendzielski &lt;<a href=3D"mailto:tomasz.dzien=
dzielski@gmail.com" target=3D"_blank">tomasz.dziendzielski@gmail.com</a>&gt=
;<br>
&gt; <br>
&gt; --- v4 add mc prefix to _bb_diskmonitor event handler to fix build, bo=
th build and test_stoptask_behavior should be working now<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/cookerdata.py |=C2=A0 5 ++++-<br>
&gt; =C2=A0lib/bb/event.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt; =C2=A0lib/bb/parse/ast.py=C2=A0 |=C2=A0 7 ++++++-<br>
&gt; =C2=A0lib/bb/runqueue.py=C2=A0 =C2=A0| 15 +++++++++++++--<br>
&gt; =C2=A04 files changed, 25 insertions(+), 4 deletions(-)<br>
<br>
This still isn&#39;t right I&#39;m afraid:<br>
<br>
<a href=3D"https://autobuilder.yoctoproject.org/typhoon/#/builders/39/build=
s/3057" rel=3D"noreferrer" target=3D"_blank">https://autobuilder.yoctoproje=
ct.org/typhoon/#/builders/39/builds/3057</a><br>
<br>
I did also wonder if we should be changing each of the event register<br>
callers, or doing something inside the event register function instead?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--00000000000087c23105bae94de0--

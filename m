Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5DAC433EF
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 00:18:59 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web08.5095.1642637938230792888
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 16:18:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=l9CTC1kA;
 spf=pass (domain: gmail.com, ip: 209.85.167.51,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id x11so15035101lfa.2
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 16:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoAe7g4heY1KVAHaaxJaK9P6bcgfemQpYOyk7EUpoE4=;
        b=l9CTC1kAvGPr+P1ra333LYORpfnI95nZm/EUi5yQWLr8lM4UW7fCTcIywkvUcYfL3Q
         qKYwYK/3aRJeYWSQx2lZlovl0TqFZsJRW/36c18OJuV4ynw9NfjCWPY+hrN9IXOFriXi
         N41LABjLETpDDGxpjPYgddBe8EZd6PeoU/Q+T3seGxkGFUJVITE0r0K/dBmPAaUyo3HZ
         17IY0f4BxicyItgXbhAuo9ctVPi21xwXhIB1k3WpxX16/vvR4f/4Y4O0+yZGNfQW2pM8
         MyIAW0588+l6Lqf58otB0CtIp8u8LX1rjrOUTTemjo44KUP6K8lh+bWhGo2WEKUI0TLk
         Jl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoAe7g4heY1KVAHaaxJaK9P6bcgfemQpYOyk7EUpoE4=;
        b=KvL7F5s2yuBN4pm7yiSsLcIpMkj3PHpEtfmntvw3KQcunCQ8ERDJbc1MbLFwUH59g/
         /U7SKkmfi8kAjQgVm62x0GCGm9Ys25883xdTgjw9FC2hOVCv6uJuom5K8rWuLKvSYbZJ
         QZrCJcZsVEMcN6J6KTPZYGOoMdsF/FA9hNneMvSe3vyEW59P/fxung4Np50C5bWOSG57
         JzyIVsQh5rrpDdrqNRavWZRqAuWgI69syJpZjQxn9QJKXpaCNM2+ESyYZydhKB2JowpC
         SoC5mXzWq7XedyATvDjpD6agGHuCAyk6IkBLvS3lMteYhmfmeBVxm7jwWZAul84gLMQA
         pzeA==
X-Gm-Message-State: AOAM533Qx02TC/PQbMBoENJGF6Z3ee++C9ggXf7kttWIDoqILxm8wLqK
	5sUp4LkO1PcnzyHURxJBALzh0QjvN3fPpzeW/wQ=
X-Google-Smtp-Source: 
 ABdhPJypnNMJ+3wAz94rZUJzs2SuLQ9HjBJngkiCAZikwK5Jm5VX1tPZvGj1z2DL4CPKOxdZj+T98zBTeo2LaXnqaQk=
X-Received: by 2002:a05:651c:a04:: with SMTP id
 k4mr22722337ljq.278.1642637936424;
 Wed, 19 Jan 2022 16:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20220107231526.1517563-1-richard.purdie@linuxfoundation.org>
 <20220107231526.1517563-2-richard.purdie@linuxfoundation.org>
 <CANPvuRkZj_WKgLzUE8vu-15e8RMXWqLwg=5B3SzYeDhdkj+COw@mail.gmail.com>
 <34c5a34a48c54376f5a181a0c836ddc2be1c1735.camel@linuxfoundation.org>
In-Reply-To: 
 <34c5a34a48c54376f5a181a0c836ddc2be1c1735.camel@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Thu, 20 Jan 2022 00:18:45 +0000
Message-ID: 
 <CANPvuRnENrddHXpasrjEJ1dPmJs6TVmJSv-1k13VBasZjq9duA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-worker: Add/support network
 task flag
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000b1f7b205d5f872ee"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 00:18:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13250

--000000000000b1f7b205d5f872ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia quarta,
19/01/2022 =C3=A0(s) 23:27:

> On Wed, 2022-01-19 at 23:16 +0000, Jose Quaresma wrote:
> > Unfortunately this patch breaks the usage of the icecc.bbclass.
> >
> > Currently I build with icecc inside a container with network isolation
> and
> > my icecc demon runs outside of the container.
> > The only thing I need to do for using the icecc inside my build
> container is
> > mounting the unix /var/run/icecc/iceccd.socket inside the container.
> >
> > I think that we need something like this functionality to have access t=
o
> > some sockets connections inside the tasks with the new namespace.
>
> I'm open to proposals but the unshare functionality is limited so I
> suspect we
> can't just allow/disallow specific sockets unfortunately. We may just nee=
d
> the
> global "allow" flag for the reasons Robert mentioned which would also wor=
k
> here,
> at the code of not showing up other network accesses.
>
> Cheers,
>
> Richard
>
>
I will do some more investigation on that to see how we can use some
pre-existing unix sockets from the old namespace.
I think that the IPC namespace is used for that purpose but I need to
understand more about this subject.

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000b1f7b205d5f872ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Richard Purdie &lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&=
gt; escreveu no dia quarta, 19/01/2022 =C3=A0(s) 23:27:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Wed, 2022-01-19 at 23:16 +0000, =
Jose Quaresma wrote:<br>
&gt; Unfortunately this patch breaks the usage of the icecc.bbclass.<br>
&gt; <br>
&gt; Currently I build with icecc inside a container with network isolation=
 and<br>
&gt; my icecc demon=C2=A0runs outside of the container.<br>
&gt; The only thing I need to do for using the icecc inside my build contai=
ner is<br>
&gt; mounting the unix /var/run/icecc/iceccd.socket inside the container.<b=
r>
&gt; <br>
&gt; I think that we need something like this functionality to have access=
=C2=A0to<br>
&gt; some sockets connections=C2=A0inside the tasks with the new namespace.=
<br>
<br>
I&#39;m open to proposals but the unshare functionality is limited so I sus=
pect we<br>
can&#39;t just allow/disallow specific sockets unfortunately. We may just n=
eed the<br>
global &quot;allow&quot; flag for the reasons Robert mentioned which would =
also work here,<br>
at the code of not showing up other network accesses.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><div><br></div>I will do some more investigation on that=
 to see how we can use some pre-existing unix sockets from the old namespac=
e.<div>I think that the IPC namespace is used for that purpose but I need t=
o understand more about this subject.<br clear=3D"all"><div><br></div>-- <b=
r><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr">Best regards,=
<div><br>Jos=C3=A9 Quaresma</div></div></div></div></div>

--000000000000b1f7b205d5f872ee--


Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D5BC433F5
	for <webhook@archiver.kernel.org>; Wed,  2 Feb 2022 12:39:04 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.63839.1643805543539135377
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Feb 2022 04:39:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Tw481grz;
 spf=pass (domain: gmail.com, ip: 209.85.167.48,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id b9so40347705lfq.6
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Feb 2022 04:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivbh5cKAe9kp8UaFURzLeveSLKdEEZvYn1IHiQHtzSQ=;
        b=Tw481grz0i/7ppfokovVogwZxE5p0P3uoOjM0ZjFdee5DCgoW0ttEARZbsEjUbAVPh
         GXzYf4W2H4u+fXuqLXnBJdkAjqZN/7N2q6naX4+b2lpS3vHHJdBmyDE9QLRG8zEmMsyF
         ZyNHzaIzHMvKFpnO2iyYJSd7j4bE0t7RpDyQeVmTUnAglXZVSkQxDItbGK+LFNRtA165
         znOIJGTaTMEEUqmhGC28dc9MixbMTrYiyZnvlbY5pUg0ym4FdAmhItrVf4xslxd61YGX
         ggVTDKaBm/JDEBp/ykP3qltNS8vy/oO1WWMR9HebVkJmfT6IwrS62a+CjnIBgSFDbDk2
         iGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivbh5cKAe9kp8UaFURzLeveSLKdEEZvYn1IHiQHtzSQ=;
        b=UQ5cvMJxORGzWzUrkvUX4kYFLiTi3sn1Nervm0WwgM4WzyesukL/wlL/x+fR9S+1Fi
         1aEMtT9PBSkQdLM+xUCWy0aNFhBSoOolrCHiG5rgk8Cko0rUYS42IuJO9kQ/6/LuCV6j
         /Y5JMLWcWSQQPPflTzN7rM96HmuzskG3c9eEAT7o+pE/5vUECRp+hg0kiQBwa5JrXyuI
         QT4dSiwmZCA6D0uAl0OEo8MuCwJiqVch07cUeD/WdyhDRJJNtP3J0mBPTyTxq67lNzrk
         vAj4KfXVN9MAV3nyutv/7EeLv/ngIkiSM2lB/R5jgCtkBZBsjzppGlBv2+pz1tr2abiO
         JyKQ==
X-Gm-Message-State: AOAM533glWhNv8QOaBbSITIwJFzc1cAB/chVtRTeEtz18TlLBTQWMI2c
	R1y35yNEB1ryj2sXGVOYKQsz3YUB+oMzmcCovic=
X-Google-Smtp-Source: 
 ABdhPJxSWrpoIuafGUl8HVVbRLHpyrlH9VR+E7ckIAiLQmOhS8kiYIp7YWTRFbq9r6uYbN44Gxx5kM7fcghSGyx5l3k=
X-Received: by 2002:ac2:5c4d:: with SMTP id
 s13mr22657696lfp.324.1643805541438;
 Wed, 02 Feb 2022 04:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20211222231907.1036709-1-richard.purdie@linuxfoundation.org>
 <CANPvuR=EyqMnkSG-niP8GAOnT2jEun63iz4Fpa4RU8isTc-ezg@mail.gmail.com>
 <3a672c37d4cd375fed43b59d887c9dcd17c60ee8.camel@linuxfoundation.org>
In-Reply-To: 
 <3a672c37d4cd375fed43b59d887c9dcd17c60ee8.camel@linuxfoundation.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 2 Feb 2022 12:38:50 +0000
Message-ID: 
 <CANPvuRk3=Hd7tiEy4WFE+GK7x55rKsvrR+yE1NSbSgVUYQUJnw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] utils: Add disable_network function
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000609a0b05d7084df2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Feb 2022 12:39:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13306

--000000000000609a0b05d7084df2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

I think that the usage of the unshare system call can replace the use of
pseudo on bitbake.
If we map the new user namespace to the superuser we can do what is
bean done nowadays
inside the pseudo or not ?

       *-r*, *--map-root-user*
           Run the program only after the current effective user and
           group IDs have been mapped to the superuser UID and GID in
           the newly created user namespace. This makes it possible to
           conveniently gain capabilities needed to manage various
           aspects of the newly created namespaces (such as configuring
           interfaces in the network namespace or mounting filesystems
           in the mount namespace) even when run unprivileged. As a mere
           convenience feature, it does not support more sophisticated
           use cases, such as mapping multiple ranges of UIDs and GIDs.
           This option implies *--setgroups=3Ddeny *and *--user*. This opti=
on
           is equivalent to *--map-user=3D0 --map-group=3D0*.

https://man7.org/linux/man-pages/man1/unshare.1.html

Best regards,
Jose

Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia sexta,
24/12/2021 =C3=A0(s) 15:57:

> On Thu, 2021-12-23 at 15:10 +0000, Jose Quaresma wrote:
> > Hi Richard,
> >
> > First of all, this feature is fantastic.
>
> I'm certainly happy we can now do this, at least for some systems (and th=
e
> situation should improve in the future),
>
> >
> > Richard Purdie <richard.purdie@linuxfoundation.org> escreveu no dia
> quarta,
> > 22/12/2021 =C3=A0(s) 23:19:
> > >
> >
> >
> > try:
> >
> > > +    with open("/proc/self/uid_map", "w") as f:
> > > +        f.write("%s %s 1" % (uid, uid))
> > > +    with open("/proc/self/setgroups", "w") as f:
> > > +        f.write("deny")
> > > +    with open("/proc/self/gid_map", "w") as f:
> > > +        f.write("%s %s 1" % (gid, gid))
> > >
> >
> >
> > except:
> >  print a warning about the fail
> >
> > Without that it can fail silently if the user doesn't have permission t=
o
> write
> > in /proc/self.
> > In general, if it runs all the steps, the function can return true/fals=
e.
>
> The trouble is there are a set of older distros where this definitely
> won't work
> and we can't really afford to print warnings on those. Not sure what the
> best
> way forward is for that...
>
> Cheers,
>
> Richard
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000609a0b05d7084df2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard,</div><div><br></div><div>I think that the=
=C2=A0usage=C2=A0of the unshare system call can replace the use of pseudo o=
n bitbake.</div><div>If we map the new user namespace to the superuser we c=
an do what is bean=C2=A0done nowadays=C2=A0</div><div>inside the=C2=A0pseud=
o=C2=A0or not ?</div><div><pre style=3D"margin-left:8px;font-family:monospa=
ce,courier;color:rgb(24,24,24);font-size:16px">       <b style=3D"color:rgb=
(80,32,0)">-r</b>, <b style=3D"color:rgb(80,32,0)">--map-root-user</b>
           Run the program only after the current effective user and
           group IDs have been mapped to the superuser UID and GID in
           the newly created user namespace. This makes it possible to
           conveniently gain capabilities needed to manage various
           aspects of the newly created namespaces (such as configuring
           interfaces in the network namespace or mounting filesystems
           in the mount namespace) even when run unprivileged. As a mere
           convenience feature, it does not support more sophisticated
           use cases, such as mapping multiple ranges of UIDs and GIDs.
           This option implies <b style=3D"color:rgb(80,32,0)">--setgroups=
=3Ddeny </b>and <b style=3D"color:rgb(80,32,0)">--user</b>. This option
           is equivalent to <b style=3D"color:rgb(80,32,0)">--map-user=3D0 =
--map-group=3D0</b>.</pre></div><div><a href=3D"https://man7.org/linux/man-=
pages/man1/unshare.1.html">https://man7.org/linux/man-pages/man1/unshare.1.=
html</a><br></div><div><br></div><div>Best regards,</div><div>Jose</div><di=
v><br></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">=
richard.purdie@linuxfoundation.org</a>&gt; escreveu no dia sexta, 24/12/202=
1 =C3=A0(s) 15:57:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Thu, 2021-12-23 at 15:10 +0000, Jose Quaresma wrote:<br>
&gt; Hi=C2=A0Richard,<br>
&gt; <br>
&gt; First of all, this feature is fantastic.<br>
<br>
I&#39;m certainly happy we can now do this, at least for some systems (and =
the<br>
situation should improve in the future),<br>
<br>
&gt; <br>
&gt; Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.or=
g" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; escreveu no=
 dia quarta,<br>
&gt; 22/12/2021 =C3=A0(s) 23:19:<br>
&gt; &gt; <br>
&gt; <br>
&gt; <br>
&gt; try:<br>
&gt; =C2=A0<br>
&gt; &gt; +=C2=A0 =C2=A0 with open(&quot;/proc/self/uid_map&quot;, &quot;w&=
quot;) as f:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;%s %s 1&quot; % (uid, =
uid))<br>
&gt; &gt; +=C2=A0 =C2=A0 with open(&quot;/proc/self/setgroups&quot;, &quot;=
w&quot;) as f:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;deny&quot;)<br>
&gt; &gt; +=C2=A0 =C2=A0 with open(&quot;/proc/self/gid_map&quot;, &quot;w&=
quot;) as f:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;%s %s 1&quot; % (gid, =
gid))<br>
&gt; &gt; <br>
&gt; <br>
&gt; <br>
&gt; except:<br>
&gt; =C2=A0print a warning about the fail<br>
&gt; <br>
&gt; Without that it can fail silently if the user doesn&#39;t have permiss=
ion=C2=A0to write<br>
&gt; in /proc/self.<br>
&gt; In general, if it runs all the steps, the function can return true/fal=
se.<br>
<br>
The trouble is there are a set of older distros where this definitely won&#=
39;t work<br>
and we can&#39;t really afford to print warnings on those. Not sure what th=
e best<br>
way forward is for that...<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div></div>

--000000000000609a0b05d7084df2--


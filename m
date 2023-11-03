Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE578C4332F
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 20:32:19 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.63996.1699043530650572037
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 13:32:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AzVW1SUg;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4083f61322fso18403985e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 13:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699043529; x=1699648329; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B40EwuwD86SmMm4IW9XPx3GK6uwibaXiDmF58PFXYK4=;
        b=AzVW1SUgR4gm8l6oV7yGfz7HbJMaGMRONegKmQo5QwK/2HEfGbfREQPkLXfVRf5fyp
         iuBGNWGMzGox3sg3YGhL0mVdzFFWDyH0bS5Y7zhhv/yJpFVj1QyU0/aIVo8ZkM9yWVm5
         Rj3UBEsLnHUgYSFJAb8mR3IT0R7RhJGlDacGWKQNogly+Fj2zWaetXYqSIEPF3cvK68K
         DiDT7Dr/grivbzRfsWMd5DWmZBZmqcfjLjvqLtUuKqpKl6T8dNDO3ole3X5b/z4zbHgt
         IWQLsoCusQVznJDctuXSJUCWCy4h7spW4AmqPTDGbHz/2EahFGB9y8ewBGIkg6V5vN/y
         gxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699043529; x=1699648329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B40EwuwD86SmMm4IW9XPx3GK6uwibaXiDmF58PFXYK4=;
        b=h4ce+LW/gYHtBfUUgjV4IJdDADTLl+F4jX6L2dMRNuMY/KOXes5HNepHAxYkaJU9gs
         Xd8fAElzKNnBYKMpmmTxLKC+3z6c9d7Wfj6l9SCC2AoATyTIy2jg8adul0iJIaPERQDw
         u6SOHKjHyrOIM2YsQIJJpa+uS78bar1fn27m98avsimRNMZSX/lqXYV55ad6/SClGJfA
         UprPAtK0koY8/8uUiLFZe/OSPs2rUuDkZAlNIxYQATDCgLvddvacpHakzBlatzqX6Xn7
         n/Bsqd/dNuqcZFCWJLnEYMOmIRmRDVYNtZLNPizn7/QqwSTEp7FCQY8P/1HSZNhqkh2c
         txBA==
X-Gm-Message-State: AOJu0Yy9Ko+H7HD/1RDQBxt0OTngIq5QAPWTsK1EV3w8dCENDXMe+UHg
	LPWLDv9ITREjs3HXuBWxMbBjs716gXI7KoZzwBM=
X-Google-Smtp-Source: AGHT+IFPOQO/hub/UNbuYpvf4IuWSXEV0y9o5OkXcBAEsl3MMsbx39KeEbQv7ZDywy+VtBCRud1qKwEPT0jv1ysiQ50=
X-Received: by 2002:a05:600c:3d0e:b0:408:3bbd:4a82 with SMTP id
 bh14-20020a05600c3d0e00b004083bbd4a82mr19095673wmb.15.1699043528635; Fri, 03
 Nov 2023 13:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230824083109.1821425-1-Markus.Niebel@ew.tq-group.com>
 <CANPvuR=8-BicdWNHsgmyBAZDHg7Phj9b2vhnzbo_xEaEb09b+Q@mail.gmail.com>
 <CAHUKmYZxyNDG2yPQ3-rphzCjCJ=5mV0gA1avwOzdsy60VhtMQQ@mail.gmail.com> <0487b3b40205fd375fc981bfe9181034c4cb8e6e.camel@linuxfoundation.org>
In-Reply-To: <0487b3b40205fd375fc981bfe9181034c4cb8e6e.camel@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 3 Nov 2023 21:31:55 +0100
Message-ID: <CA+chaQc9rKpo86Gqv=NBtpa16J6dZivdT=mST1WMXyia=J21vQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [kirkstone][2.0][PATCH] bitbake-getvar: Add a
 quiet command line argument
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: ecordonnier@snap.com, Jose Quaresma <quaresma.jose@gmail.com>, 
	Steve Sakoman <steve@sakoman.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
	bitbake-devel@lists.openembedded.org, oss@ew.tq-group.com, 
	Paulo Neves <ptsneves@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Content-Type: multipart/alternative; boundary="000000000000fb7968060945658f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 20:32:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15445

--000000000000fb7968060945658f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does it work with 2.0? With --quiet I'm seeing:

Traceback (most recent call last):
  File "bitbake/bin/bitbake-getvar", line 41, in <module>
    tinfoil.prepare(quiet=3D2)
  File "bitbake/lib/bb/tinfoil.py", line 389, in prepare
    for handler in self.localhandlers:
                   ^^^^^^^^^^^^^^^^^^
AttributeError: 'Tinfoil' object has no attribute 'localhandlers'. Did you
mean: 'oldhandlers'?

So bitbake 2.0 probably needs the fix
https://git.openembedded.org/bitbake/commit/?id=3D71ee69a20f21f3d37f4f060a7=
d8e87d9f1dc6aa1
from master as well.

On Tue, Oct 3, 2023 at 6:35=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2023-10-03 at 18:05 +0200, Etienne Cordonnier via
> lists.openembedded.org wrote:
> > Is there a technical issue preventing a merge of the patch, or is it
> > delayed due to the current workload?
>
> There were recent changes in master in this behaviour and it may make
> sense to fix things together with the recent changes?
>
> You should also copy Steve on LTS patches (added now).
>
> Cheers,
>
> Richard
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15176):
> https://lists.openembedded.org/g/bitbake-devel/message/15176
> Mute This Topic: https://lists.openembedded.org/mt/100931867/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/leave/8021546/3617156/1661=
570722/xyzzy
> [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000fb7968060945658f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Does it work with 2.0? With --quiet I&#39;m seeing:</=
div><div><br></div>Traceback (most recent call last):<br>=C2=A0 File &quot;=
bitbake/bin/bitbake-getvar&quot;, line 41, in &lt;module&gt;<br>=C2=A0 =C2=
=A0 tinfoil.prepare(quiet=3D2)<br>=C2=A0 File &quot;bitbake/lib/bb/tinfoil.=
py&quot;, line 389, in prepare<br>=C2=A0 =C2=A0 for handler in self.localha=
ndlers:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^^^^^^^^^^^^^^^^^^<br>AttributeError: &#39;Tinfoil&#39; object has no=
 attribute &#39;localhandlers&#39;. Did you mean: &#39;oldhandlers&#39;?<br=
><div><br></div><div>So bitbake 2.0 probably needs the fix=C2=A0<a href=3D"=
https://git.openembedded.org/bitbake/commit/?id=3D71ee69a20f21f3d37f4f060a7=
d8e87d9f1dc6aa1">https://git.openembedded.org/bitbake/commit/?id=3D71ee69a2=
0f21f3d37f4f060a7d8e87d9f1dc6aa1</a> from master as well.</div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct =
3, 2023 at 6:35=E2=80=AFPM Richard Purdie &lt;<a href=3D"mailto:richard.pur=
die@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 2023-10-=
03 at 18:05 +0200, Etienne Cordonnier via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a> wrote:<br>
&gt; Is there a technical issue preventing a merge of the patch, or is it<b=
r>
&gt; delayed due to the current workload?<br>
<br>
There were recent changes in master in this behaviour and it may make<br>
sense to fix things together with the recent changes?<br>
<br>
You should also copy Steve on LTS patches (added now).<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15176): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15176" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15176</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/100931867/361=
7156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/100931867/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/leav=
e/8021546/3617156/1661570722/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.openembedded.org/g/bitbake-devel/leave/8021546/3617156/16615707=
22/xyzzy</a> [<a href=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">m=
artin.jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000fb7968060945658f--


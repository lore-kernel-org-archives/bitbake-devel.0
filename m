Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C3DC001DF
	for <webhook@archiver.kernel.org>; Mon, 24 Jul 2023 17:50:48 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web11.923.1690221039515566496
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Jul 2023 10:50:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=HRauYYBf;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fdd515cebcso6965080e87.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Jul 2023 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690221037; x=1690825837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xOj9LEhbOZWN5TyseLSaSPZamX8JqAkm0G/B9R65ers=;
        b=HRauYYBffDNw4/Rcb4yB89xhyWpa/J2Rcxx9SyEgvbhhLwn8LBD6dHo2J2TwvfMKhG
         odpNz4dwhC4cyMhS5q9iET2px5IczSk5AYl3YT3oBXErkNaRzQsLMTtYX3MWeAfnCZiI
         oCmuM2Djs48sVK7PWKehCt+LZsiVxxlBzTB6PJEgTpUvLdqsQUrgsfbLQ/itvmDqB9JC
         6H73I41lp3m+dekwHsX7sKxpIdZyQS+NgldnBqMUmzdow4Kv1ULQiKDiFXm73BXKO8B7
         qcjLrB15jtJXLV8vmjnoEMCLE5q7qNfA8sEyMNnPi5ZXilO69Q7iQ9MUGltiscjOPgt/
         twrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221037; x=1690825837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOj9LEhbOZWN5TyseLSaSPZamX8JqAkm0G/B9R65ers=;
        b=bspwtK+EMFD6GusC31YuniXwyx89EfsWMTdDe4OZmM3NYKcJIpTHqIQo6nSox0QgCT
         Md998w36NqlxvYqOTdlL3KAoXykRatzpZeDOei+8f1TUUK3GrLgi49kfACKoX3rhnFK2
         byEVX9+DCUVy83GP7yo/0JtcYhKeoROgY40Jj+d/Gkjh1+BQZgMpZXJS4CqP8Rwp5WWx
         WqTb2b7Upc0CzVjCBHgSW9rob2YZAbU48ffZ/02xyFz70ddJMcDl3oLsEqPmTxHWwNEw
         KonqhVwEYdz+YKMDdbZ0I/cbT97U3bpfHy/Iv9jC0k9RHa7R9kHYsYmSuRZEOF4K2mgh
         FEgQ==
X-Gm-Message-State: ABy/qLbPUkHOKzuVCw64nEnS+fGM24lJq7BQWGOTc2oEqh6U6UdTYLT8
	CWjYeKc5DhRJ5y2yUysu2GFU+270JxgOqNLJw2A=
X-Google-Smtp-Source: APBJJlGjEJ74aJRkstohS/9+VSaQHX2szVakyMtXdcyo2qwuWATSFjbjg1tZbnhIIPI33ykewXEeJPpCZpp9RUqcEgs=
X-Received: by 2002:a05:651c:102b:b0:2b6:cb55:72cb with SMTP id
 w11-20020a05651c102b00b002b6cb5572cbmr6367635ljm.39.1690221036984; Mon, 24
 Jul 2023 10:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230721234907.220309-1-m.belouarga@technologyandstrategy.com> <0aeb32068dbd46fe0be6d534e9675be603e22efc.camel@linuxfoundation.org>
In-Reply-To: <0aeb32068dbd46fe0be6d534e9675be603e22efc.camel@linuxfoundation.org>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Mon, 24 Jul 2023 19:50:25 +0200
Message-ID: <CA+cAker4N0v7BErjpeOpENg+L8ciDX_PU6i5jSRT-ZfecKFC1A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2:init check if path is none before
 calculating checksums
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: belouargamohamed@gmail.com, bitbake-devel@lists.openembedded.org, 
	BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Content-Type: multipart/alternative; boundary="000000000000805dd406013f40f0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Jul 2023 17:50:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14885

--000000000000805dd406013f40f0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 24 juil. 2023, 15:51, Richard Purdie <
richard.purdie@linuxfoundation.org> a =C3=A9crit :

> On Sat, 2023-07-22 at 01:49 +0200, belouargamohamed@gmail.com wrote:
> > From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
> >
> > Add one more verification that checks if localpath is None, because
> > we can't compute checksum of a None.
> >
> > Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com=
>
> > ---
> >  lib/bb/fetch2/__init__.py | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index 770021de16..f6e5d19627 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -1402,6 +1402,9 @@ class FetchMethod(object):
> >          Is localpath something that can be represented by a checksum?
> >          """
> >
> > +        # We cannot compute checksums for None
> > +        if urldata.localpath is None:
> > +            return False
> >          # We cannot compute checksums for directories
> >          if os.path.isdir(urldata.localpath):
> >              return False
>
> What was the situation which produced this error? I'm wondering if we
> need a new test case in bitbake-selftest (in lib/bb/test/fetch.py)?
>
> Cheers,
>
> Richard
>

A new test for a new condition is always better. Moreover, if None can
happen for urldata.localpath, what about empty string? If it can happen,
you may want to replace the line with a simple "if not urldata.localpath"
which cover both None and empty string.

--000000000000805dd406013f40f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le lun. 24 juil. 2023, 15:51, Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org" rel=3D"noreferrer noreferrer=
" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt; a =C3=A9crit=
=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">On Sat, 2023-07-22 at 01:49=
 +0200, <a href=3D"mailto:belouargamohamed@gmail.com" rel=3D"noreferrer nor=
eferrer noreferrer" target=3D"_blank">belouargamohamed@gmail.com</a> wrote:=
<br>
&gt; From: BELOUARGA Mohamed &lt;<a href=3D"mailto:m.belouarga@technologyan=
dstrategy.com" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">m=
.belouarga@technologyandstrategy.com</a>&gt;<br>
&gt; <br>
&gt; Add one more verification that checks if localpath is None, because<br=
>
&gt; we can&#39;t compute checksum of a None.<br>
&gt; <br>
&gt; Signed-off-by: BELOUARGA Mohamed &lt;<a href=3D"mailto:m.belouarga@tec=
hnologyandstrategy.com" rel=3D"noreferrer noreferrer noreferrer" target=3D"=
_blank">m.belouarga@technologyandstrategy.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 lib/bb/fetch2/__init__.py | 3 +++<br>
&gt;=C2=A0 1 file changed, 3 insertions(+)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
&gt; index 770021de16..f6e5d19627 100644<br>
&gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt; @@ -1402,6 +1402,9 @@ class FetchMethod(object):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Is localpath something that can be r=
epresented by a checksum?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # We cannot compute checksums for None<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if urldata.localpath is None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # We cannot compute checksums for di=
rectories<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.isdir(urldata.localpath):=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
<br>
What was the situation which produced this error? I&#39;m wondering if we<b=
r>
need a new test case in bitbake-selftest (in lib/bb/test/fetch.py)?<br>
<br>
Cheers,<br>
<br>
Richard<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">A new test for a new condition is always better. Moreover, if None c=
an happen for urldata.localpath, what about empty string? If it can happen,=
 you may want to replace the line with a simple &quot;if not urldata.localp=
ath&quot; which cover both None and empty string.=C2=A0</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"></blockquote></div></div></div>

--000000000000805dd406013f40f0--


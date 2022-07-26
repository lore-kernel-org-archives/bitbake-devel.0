Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEB2C43334
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 07:01:51 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com
 [209.85.219.171])
 by mx.groups.io with SMTP id smtpd.web12.3714.1658818903088584249
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Jul 2022 00:01:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=B0MgDYdp;
 spf=pass (domain: gmail.com, ip: 209.85.219.171,
 mailfrom: ptsneves@gmail.com)
Received: by mail-yb1-f171.google.com with SMTP id 75so23846051ybf.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Jul 2022 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhohY429ELgHHn/X0iYK/dwEK8+emPvMyjs9iyVHZcI=;
        b=B0MgDYdpX0Ttd1nCHahrBybmHbWN5HJAcCnayRvt/mJjnI7qj3S30bBiDuMXMWBPTI
         pYqTyqimORd4UT3s6HYMSsBiiw2CBuFaNZ0pe80o1H0YrElqHC074b0ZlYfWz64z6Joz
         XE3jkA2LHSwYWa25CQruVZDj5IIcC/c1tilsBlM/fwh/CTrSJiWHj7V7k0fRjHfzDdBg
         8YWK4inGeD4YZcZ/U1o56123llpZ5gghQAL/ZWzWzjTwJ1Slfr829HE/Dctsu8a/vNZv
         xUNqvdaMKcxW9rcOG/y37j9hso3p0UtQij1SzKfEf0+6c9iMoCUayKx7KZeVD0wJIPEC
         ABew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhohY429ELgHHn/X0iYK/dwEK8+emPvMyjs9iyVHZcI=;
        b=v37Ya8twMO3dXB9VC3urgZjd9QyLTBGuc9kICoR9xP6UXutu24Amil/n5d32kjP1MT
         1g0WH3sOD8rTVvcNkPE+MqzgNR6DAc+u/to2Led3lwZQTug9e6pLFU8r9P7o2tClZkkl
         f57DG9SX/MuFVudlFE0pqs+pKYsnMTueuMllWHVdYgRHtBo6uGliDJcU75FkovStbTWi
         3qu1Jq3zl+jzsmMdKdVyaOLVyVYgfXGDEzbQcpOX9qIpRGgOzyDB/N4ycutHW/V1DGuX
         /sBqfmnM9xfFDhoVgBZrHxc3F2dhHkbxKJ3Y4B7Z7SJTnA/nMikzHEVY2iUSE3g76VGk
         Ze/Q==
X-Gm-Message-State: AJIora9Jjft3crxKo3hxd85tNE8oVp57m2xBHH5hYiStxkdAABvsCMPm
	6br8Azx57OCMWIGCyqgPLMTAvbShKQKnUN662Q==
X-Google-Smtp-Source: 
 AGRyM1uHKu81VxKIjt6NsWJ/JGTJQ29fKQZB2x1h4qd93vl0/KVAQvAMvLVqkPbQou1/pP+xmdqei3IsAX/e45XD7JY=
X-Received: by 2002:a25:946:0:b0:670:ccc5:774a with SMTP id
 u6-20020a250946000000b00670ccc5774amr11686174ybm.381.1658818902178; Tue, 26
 Jul 2022 00:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <20220708205407.1680137-2-ptsneves@gmail.com>
 <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
 <8cbc762227c6c5223004d7e457dff8f3da683a2d.camel@linuxfoundation.org>
In-Reply-To: 
 <8cbc762227c6c5223004d7e457dff8f3da683a2d.camel@linuxfoundation.org>
From: Paulo Neves <ptsneves@gmail.com>
Date: Tue, 26 Jul 2022 09:01:31 +0200
Message-ID: 
 <CAJO0J4g25ypP_RW=pN76suM1z15VEh9cdOsxqfNj9-C_xW5PcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch: bb.fatal when trying to checksum non-existing
 files.
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Patrick Williams <patrick@stwcx.xyz>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000693e8805e4afdf8b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Jul 2022 07:01:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13852

--000000000000693e8805e4afdf8b
Content-Type: text/plain; charset="UTF-8"

That is what I do. If the recipe is machine specific it should be marked as
such.

On Tue, 26 Jul 2022 at 08:39, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2022-07-25 at 23:09 -0500, Patrick Williams wrote:
> > On Fri, Jul 08, 2022 at 10:54:07PM +0200, Paulo Neves wrote:
> > > If the local fetcher was not able to find the file anywhere but it
> > > was included in the SRC_URI for checksumming just make it a fatal
> > > error.
> > > ---
> > >  lib/bb/fetch2/__init__.py | 2 +-
> > >  lib/bb/tests/fetch.py     | 5 +++++
> > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > > index 5f05278a..8184b55e 100644
> > > --- a/lib/bb/fetch2/__init__.py
> > > +++ b/lib/bb/fetch2/__init__.py
> > > @@ -1237,7 +1237,7 @@ def get_checksum_file_list(d):
> > >                              " This means there is no way to get the
> file except for an orphaned copy"
> > >                              " in DL_DIR.") % (d.getVar('PN'),
> os.path.basename(f)))
> > >                      else:
> > > -                        bb.warn("Unable to get checksum for %s
> SRC_URI entry %s: file could not be found" % (d.getVar('PN'),
> os.path.basename(f)))
> > > +                        bb.fatal("Unable to get checksum for %s
> SRC_URI entry %s: file could not be found" % (d.getVar('PN'),
> os.path.basename(f)))
> >
> > Now that we've picked up this change, it seems to have caused a bunch of
> > irritating hard failures where we use to just get irritating warnings.
> > Our recipes probably aren't 100% ideal, but we had a number of recipes
> > which are not pulled into all our machine configs, and could end up with
> > broken SRC_URIs on machine configs they are not intended to be used on.
> >
> > There are some more complex examples, but one easy example is a recipe
> > which had `file://${MACHINE}/eeprom.h` in its SRC_URI[1].  Any machine
> > which didn't provide this file, even if it never intended to use the
> > recipe, now fails when we picked up this change.
> >
> > I know we've been ignoring the warning(s) for a while on these kinds of
> > failures, so it is our own fault, but it is kind of annoying the new
> > behavior.  We now have to make sure every recipe not only parses validly
> > on all machine configs but it also has to have fully populated SRC_URIs
> > even when the recipe is never used on that machine config.
> >
> > 1.
> https://github.com/facebook/openbmc/blob/f0d9511ad2fbd563a6b793093cdac557c5ef2a89/meta-facebook/recipes-utils/mac-util/mac-util_0.1.bb#L12
>
> I'm just going from memory but it might help to set COMPATIBLE_MACHINE
> in the recipe so that it isn't fully parsed for the machines it isn't
> intended for.
>
> Cheers,
>
> Richard
>
>
>

--000000000000693e8805e4afdf8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">That is what I do. If the recipe is machine specific it s=
hould be marked as such.</div><div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, 26 Jul 2022 at 08:39, Richard Purdie =
&lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@li=
nuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Mon, 2022-07-25 at 23:09 -0500, Patrick Williams wrote:<br>
&gt; On Fri, Jul 08, 2022 at 10:54:07PM +0200, Paulo Neves wrote:<br>
&gt; &gt; If the local fetcher was not able to find the file anywhere but i=
t<br>
&gt; &gt; was included in the SRC_URI for checksumming just make it a fatal=
<br>
&gt; &gt; error.<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 lib/bb/fetch2/__init__.py | 2 +-<br>
&gt; &gt;=C2=A0 lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0| 5 +++++<br>
&gt; &gt;=C2=A0 2 files changed, 6 insertions(+), 1 deletion(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.p=
y<br>
&gt; &gt; index 5f05278a..8184b55e 100644<br>
&gt; &gt; --- a/lib/bb/fetch2/__init__.py<br>
&gt; &gt; +++ b/lib/bb/fetch2/__init__.py<br>
&gt; &gt; @@ -1237,7 +1237,7 @@ def get_checksum_file_list(d):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; This means there is no way to=
 get the file except for an orphaned copy&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot; in DL_DIR.&quot;) % (d.getVar=
(&#39;PN&#39;), os.path.basename(f)))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bb.warn(&quot;Unable to get checksum for %s SRC_URI en=
try %s: file could not be found&quot; % (d.getVar(&#39;PN&#39;), os.path.ba=
sename(f)))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bb.fatal(&quot;Unable to get checksum for %s SRC_URI e=
ntry %s: file could not be found&quot; % (d.getVar(&#39;PN&#39;), os.path.b=
asename(f)))<br>
&gt; <br>
&gt; Now that we&#39;ve picked up this change, it seems to have caused a bu=
nch of<br>
&gt; irritating hard failures where we use to just get irritating warnings.=
<br>
&gt; Our recipes probably aren&#39;t 100% ideal, but we had a number of rec=
ipes<br>
&gt; which are not pulled into all our machine configs, and could end up wi=
th<br>
&gt; broken SRC_URIs on machine configs they are not intended to be used on=
.<br>
&gt; <br>
&gt; There are some more complex examples, but one easy example is a recipe=
<br>
&gt; which had `file://${MACHINE}/eeprom.h` in its SRC_URI[1].=C2=A0 Any ma=
chine<br>
&gt; which didn&#39;t provide this file, even if it never intended to use t=
he<br>
&gt; recipe, now fails when we picked up this change.<br>
&gt; <br>
&gt; I know we&#39;ve been ignoring the warning(s) for a while on these kin=
ds of<br>
&gt; failures, so it is our own fault, but it is kind of annoying the new<b=
r>
&gt; behavior.=C2=A0 We now have to make sure every recipe not only parses =
validly<br>
&gt; on all machine configs but it also has to have fully populated SRC_URI=
s<br>
&gt; even when the recipe is never used on that machine config.<br>
&gt; <br>
&gt; 1. <a href=3D"https://github.com/facebook/openbmc/blob/f0d9511ad2fbd56=
3a6b793093cdac557c5ef2a89/meta-facebook/recipes-utils/mac-util/mac-util_0.1=
.bb#L12" rel=3D"noreferrer" target=3D"_blank">https://github.com/facebook/o=
penbmc/blob/f0d9511ad2fbd563a6b793093cdac557c5ef2a89/meta-facebook/recipes-=
utils/mac-util/mac-util_0.1.bb#L12</a><br>
<br>
I&#39;m just going from memory but it might help to set COMPATIBLE_MACHINE<=
br>
in the recipe so that it isn&#39;t fully parsed for the machines it isn&#39=
;t<br>
intended for.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
</blockquote></div></div>

--000000000000693e8805e4afdf8b--


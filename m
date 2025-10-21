Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442A1CCD1A5
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 19:00:07 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web10.21283.1761073197669194381
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Oct 2025 11:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Fio/hG86;
 spf=pass (domain: gmail.com, ip: 209.85.160.51, mailfrom: adam.blank.g@gmail.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3c9789ea2efso1519631fac.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 11:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761073197; x=1761677997; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3H+fYCI3DG3r1Rqpcy7Fpt6FhGRTYgB9jpR0sANdzPw=;
        b=Fio/hG865yrTSgBSc1gjIp9/p5yZTeWiy9p++BatocUzcmBiqeM+h/tsaJHfXPiwq/
         H6F3bVjyf5e9jMNpuytN1aNyZ8xJnMLe01xJLOM9mefKJMPJoGjYm6C1v/LndISL4EH+
         8K/q6flUxFSEadzbaYb05q65qQIX/bSLLAbOXa8+7dZmUmfNFjrYNzDnGpVOe5m6IWZg
         8HW13hcPu5215J43ZsuvSo2gvQhTu2IyNr6tEDBbrK7Fom3V9HxoeHp1MuXgHIwH7fHy
         pOs9O+ERJN1AEstdZX64Pn1bzvA05iphI1waNOuhxIc0FX9zgPxenXikV5PNnWP9XsXI
         uufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073197; x=1761677997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3H+fYCI3DG3r1Rqpcy7Fpt6FhGRTYgB9jpR0sANdzPw=;
        b=C8k9v4rRjYS5I+WKQqXyeK1S+u6b8PKh+0GCd8IIyunmnd+TqAaEDkUQp/sWCW/0Of
         ZYHqw1UK3P9md+jf96pJBLDhWS40LmwtSAW1tK3GwePAOvtK67tXK4wxk2p+jcuxw1bt
         CKwczah5J3AZlutLLx26u9L2jSa21ZKSvBA3r+pRZybyqZdVyyel5Is78OFz/iw//Fn7
         Ft6VhOn553e35uKY3y5FxQK2MnQy1pE35H39QyMBRh60TQYa6CfI//8iNmd+i9OMDu9m
         gzUk2+jW1BzrWXcNJUvD1FGklgALhxVwpS8XmEBz3qVvJhRM9OdTK4q6eM3jj1aRwKdD
         73Dg==
X-Gm-Message-State: AOJu0YxMEl/Fc8nu5TfuXYfbbdAP5FqUvZQfx/3ebMkRiwFRGuBmt+IQ
	tfGUPfaDJnd+RKp7ppgEjzP9TYnLxHpgZj2uhXLyrtatO8Qtbk8xf4GgjomkFPrjnP0FnyjjG2p
	h0vEmRCfxOXc+6FyKNs8KD4IYWTWVbl0=
X-Gm-Gg: ASbGnctgMpodXsZx2gHZxPsazXkXUysYlgPOS9rWqkiVcMZnZsvSrGP94YtGoCsdrfZ
	bp+jSlSteh+1PuaKUpWnqW1lcuZeVs4LfnWFEO9jZnTxxqC6gPgvxV3MYeGFuA+EGZuz5bSJ0p0
	R3aSBl3ckt69L+vsbq95BSWkujEHHRHCPBRacwuT2BBhTNbWwZajF6vGZEuKnJv5ZZOLVpWcX5T
	NstjSjf8ac0qs85Efw3D4nbIwIgDdzQtcY4ugYtyuspoU3RQctkpHvHBalfEuCCyIVO1/HVhDOo
	+GZ/OPTs8Fdrj8geqB+3W0hqo3O/
X-Google-Smtp-Source: AGHT+IEcqqOz7/8GbGB9L9B/EBGRyhiSpvDOboFtn8GCevROGbiojIIi+B4BeM0xXq3EBF8YY6ph5rYBn4fU8wm4J10=
X-Received: by 2002:a05:6870:2409:b0:32d:ecb:51d with SMTP id
 586e51a60fabf-3c98cf519e2mr7292109fac.16.1761073196811; Tue, 21 Oct 2025
 11:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251021182834.11403-1-adam.blank.g@gmail.com>
 <20251021182834.11403-2-adam.blank.g@gmail.com> <CANNYZj89auY9L+aeYNuRpxBqV0kX=3pmDMVx8w8+diAuoQuMMQ@mail.gmail.com>
In-Reply-To: <CANNYZj89auY9L+aeYNuRpxBqV0kX=3pmDMVx8w8+diAuoQuMMQ@mail.gmail.com>
From: Adam Blank <adam.blank.g@gmail.com>
Date: Tue, 21 Oct 2025 20:59:45 +0200
X-Gm-Features: AS18NWAGD5_hO8WcxB4EEud30UyudhHrWpnr4J2wgs9aTWMKCa6B0Mg7ygUUPp0
Message-ID: <CAFAffzy7rhcF5mxRUhX8kyRz3pezVEA9oSAD5Ukt5ax=ZsL=xA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] doc: bitbake-user-manual: describe
 UNPACKDIR in fetching
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000051ca400641afce0d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Oct 2025 19:00:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18202

--00000000000051ca400641afce0d
Content-Type: text/plain; charset="UTF-8"

Yes, of course you are right. That being said, I must say it is truly
difficult to grasp the convention used in Bitbake's manual. One time an
oe-core class is referenced by name in a note, or an example, the other
time the same thing is explicitly discouraged :-) One time an abstract, non
oe-core example is requested, the other time a specific oe-core variable is
used, while an abstract one would fit just as well.

Thanks,
Adam

On Tue, 21 Oct 2025, 20:52 Alexander Kanavin, <alex.kanavin@gmail.com>
wrote:

> On Tue, 21 Oct 2025 at 20:29, Adam Blank via lists.openembedded.org
> <adam.blank.g=gmail.com@lists.openembedded.org> wrote:
>
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > @@ -1697,3 +1697,7 @@ overview of their function and contents.
> >     :term:`TOPDIR`
> >        Points to the build directory. BitBake automatically sets this
> >        variable.
> > +
> > +   :term:`UNPACKDIR`
> > +      The directory into which recipe's downloads are unpacked during
> its
> > +      build process.
>
> Adding this to bitbake manual is incorrect. UNPACKDIR is specific to
> openembedded-core (defined in bitbake.conf and used in base.bbclass if
> memory serves) and is not used anywhere in bitbake.
>
> UNPACKDIR is used in bitbake manual in examples of how to use the
> fecher, but this doesn't mean it is a part of bitbake, and it is
> already documented in yocto's manual in ref-manual/variables.rst.
>
> Alex
>

--00000000000051ca400641afce0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Yes, of course you are right. That being said, I mus=
t say it is truly difficult to grasp the convention used in Bitbake&#39;s m=
anual. One time an oe-core class is referenced by name in a note, or an exa=
mple, the other time the same thing is explicitly discouraged :-) One time =
an abstract, non oe-core example is requested, the other time a specific oe=
-core variable is used, while an abstract one would fit just as well.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto=
">Adam<br><br><div class=3D"gmail_quote gmail_quote_container" dir=3D"auto"=
><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 21 Oct 2025, 20:52 Alexander=
 Kanavin, &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, 21 Oct 2=
025 at 20:29, Adam Blank via <a href=3D"http://lists.openembedded.org" rel=
=3D"noreferrer noreferrer" target=3D"_blank">lists.openembedded.org</a><br>
&lt;adam.blank.g=3D<a href=3D"mailto:gmail.com@lists.openembedded.org" targ=
et=3D"_blank" rel=3D"noreferrer">gmail.com@lists.openembedded.org</a>&gt; w=
rote:<br>
<br>
&gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt; @@ -1697,3 +1697,7 @@ overview of their function and contents.<br>
&gt;=C2=A0 =C2=A0 =C2=A0:term:`TOPDIR`<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Points to the build directory. BitBake auto=
matically sets this<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 variable.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0:term:`UNPACKDIR`<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 The directory into which recipe&#39;s downloads =
are unpacked during its<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 build process.<br>
<br>
Adding this to bitbake manual is incorrect. UNPACKDIR is specific to<br>
openembedded-core (defined in bitbake.conf and used in base.bbclass if<br>
memory serves) and is not used anywhere in bitbake.<br>
<br>
UNPACKDIR is used in bitbake manual in examples of how to use the<br>
fecher, but this doesn&#39;t mean it is a part of bitbake, and it is<br>
already documented in yocto&#39;s manual in ref-manual/variables.rst.<br>
<br>
Alex<br>
</blockquote></div></div></div>

--00000000000051ca400641afce0d--


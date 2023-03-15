Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657B5C6FD1D
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 17:08:14 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.1990.1678900086782465620
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 10:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=mKNFbLjc;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id m35so3502628wms.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678900085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l6zy0ASUFkgN0mP+YLvGIGC9SZV6bkwGKtknvBqWD5U=;
        b=mKNFbLjcU8CkPSdW4/10gENcXdbNhvhvIokhl28i57225Lx4DJNxkQbviqWvDJ5HVe
         L/g58vswUaN8HJuF7HtY+WBlK8zhl500u/n5r5OvwaV9yctJfz5l+FWui/+1P/F4/fwy
         Hgk1sjbHEk2JJ2D4WMusD5Zx7LSMGnH13ymKh1cBXv/fEsFPVFTOvBnGwC0b0SThp+kP
         Ikf6rg+4II/5kzhSchJuQa72vDzE8zqsrh1VbCHFmiR13YEdsDPsHrvTYgxTmMQoGvKm
         1lb37IvAYz3UtB1rQbNS0Shiuf1KWAuKxTsn1o2jGvjB+lgvRX8Jo2orYkL1/Gur7Gd2
         w8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678900085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6zy0ASUFkgN0mP+YLvGIGC9SZV6bkwGKtknvBqWD5U=;
        b=GwQ0xNqsHcO4hWuWFDYfLO5kSHzt0pP5kR91fk/XwPA2JPJ8dasxx3rbxS/7Lej9BG
         e0TYpNK5glNcteDhFOuxw258g8C/dKpH47o/KjXIYxKMuaPeM7Co1xqNCEWuh8rk7EMC
         Y3YPyKUnjoGZwCPBpzs4QjzLg7ntayi1HZY5+OsXApbPy5xC7IpVz6ASLswbD5Kj/6CW
         iAlGjs7Ivk6Af42wXaI/8X2CChQaOZZF5zAsLAHjgoRFmfqPFNyKYFEHihAQ+DdzZ4b2
         47L4g56f2XmbqgEH/MCBgVS9RSaxZdUGNfVXqfjD88e5A6EB1sKgAyVO/rN9R10csPuq
         Lrdw==
X-Gm-Message-State: AO0yUKUxXurJTcXLcmREjlzVMv7Aq80rqSNJhaIT3+vFwwYFoDbSKK2o
	JeigkWUI+P3Lp+CE+Oq50X9MfECVLlCn8gk6zxw=
X-Google-Smtp-Source: AK7set9x8ZGBJAI/qy8lymkqhtrL1BGgus1fB5eekTCOcEX/3MGQ52spn5Hqej0MyfB+jcNC11RZJisuQkPsWX1KO4s=
X-Received: by 2002:a05:600c:a39a:b0:3eb:246d:7ee6 with SMTP id
 hn26-20020a05600ca39a00b003eb246d7ee6mr5274544wmb.3.1678900085056; Wed, 15
 Mar 2023 10:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
 <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com> <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
In-Reply-To: <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 15 Mar 2023 18:07:47 +0100
Message-ID: <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Alex Kiernan <alex.kiernan@gmail.com>, 
	Frederic Martinsons <frederic.martinsons@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000002ee70505f6f36380"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 17:08:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14568

--0000000000002ee70505f6f36380
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2023 at 4:50=E2=80=AFPM Alexander Kanavin <alex.kanavin@gma=
il.com>
wrote:

> On Wed, 15 Mar 2023 at 16:03, Alex Kiernan <alex.kiernan@gmail.com> wrote=
:
> > I really don't think this is the right direction, at least not by
> > default. If a crate is your primary build artefact then this is
> > useful:
> >
> > https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15012
> >
> > But doing this for all the dependency crates we're just repeating
> > what's in the Cargo.lock which should always be part of the primary
> > artefact.
>
> Maybe cargo will verify (some) items against Cargo.lock. Maybe it
> won't. Upstream cargo isn't something we develop, and it may add and
> remove various exceptions and special cases.
>
> Anyway, we cannot actually trust cargo (unlike, say, git), and we need
> to do our own checks, and keep the checksums in files external to the
> source tree. This will free us from worrying about whether cargo
> protects us from supply chain attacks properly or not.
>

Also if bitbake fetcher detects unexpected checksum it can easily rename
the file in DL_DIR and try fetching it again, because that's what fetcher
does for other downloads and fetcher "owns" DL_DIR.

If cargo complains about unexpected checksum, than cargo fails and user
will have to make sure that wrongly fetched crate is removed from DL_DIR.

Regards,

--0000000000002ee70505f6f36380
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Mar 15, 2023 at 4:50=E2=80=AFPM A=
lexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin=
@gmail.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Wed, 15 Mar 2023 at 16:03, Alex Kie=
rnan &lt;<a href=3D"mailto:alex.kiernan@gmail.com" target=3D"_blank">alex.k=
iernan@gmail.com</a>&gt; wrote:<br>
&gt; I really don&#39;t think this is the right direction, at least not by<=
br>
&gt; default. If a crate is your primary build artefact then this is<br>
&gt; useful:<br>
&gt;<br>
&gt; <a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15012" =
rel=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject.org/show=
_bug.cgi?id=3D15012</a><br>
&gt;<br>
&gt; But doing this for all the dependency crates we&#39;re just repeating<=
br>
&gt; what&#39;s in the Cargo.lock which should always be part of the primar=
y<br>
&gt; artefact.<br>
<br>
Maybe cargo will verify (some) items against Cargo.lock. Maybe it<br>
won&#39;t. Upstream cargo isn&#39;t something we develop, and it may add an=
d<br>
remove various exceptions and special cases.<br>
<br>
Anyway, we cannot actually trust cargo (unlike, say, git), and we need<br>
to do our own checks, and keep the checksums in files external to the<br>
source tree. This will free us from worrying about whether cargo<br>
protects us from supply chain attacks properly or not.<br></blockquote><div=
><br></div><div>Also if bitbake fetcher detects unexpected checksum it can =
easily rename the file in DL_DIR and try fetching it again, because that&#3=
9;s what fetcher does for other downloads and fetcher &quot;owns&quot; DL_D=
IR.</div><div><br></div><div>If cargo complains about unexpected checksum, =
than cargo fails and user will have to make sure that wrongly fetched crate=
 is removed from DL_DIR.</div><div><br></div><div>Regards,=C2=A0</div></div=
></div>

--0000000000002ee70505f6f36380--


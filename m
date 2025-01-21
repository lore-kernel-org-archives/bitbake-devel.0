Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D9CC02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 18:08:04 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web10.22546.1737482876540390125
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 10:07:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R9Vp52if;
 spf=pass (domain: gmail.com, ip: 209.85.208.177, mailfrom: ticotimo@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30227ccf803so49708041fa.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 10:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737482874; x=1738087674; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IoJBHbJTaiJ77Wn/pdx++aw204IyMaEj8k1BWStQF/s=;
        b=R9Vp52ifNn/AJM+7yXMJZC+6WZPapK0P5QMiNGNxYxelFH1ktExpb/A1fKquobWa1D
         Mm17JvAMOmSRVhjkEWPSGvXnwOZ6skpxx1NRp4q5h0tXAysw8zHcAmMDbBSzFhIZDvpa
         /d6Cr2NJoQvMFRvyeaen22y4p7jVucgChys9fsA7SErcOYo02ngq9i1oQCT7/LnncJY6
         K5GZvaAFbMSvWJQQDZhPVVZE6xU9726sJMRk6Ln3Ac5v2AMfFnv9oeodwydkwNWjsUXa
         GhJQ9muzhOom0dkQVkOyACFFGI4vQna4v5/RKwg3kmORh2HF6om7ALEthfimRfDn9TPl
         b8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482874; x=1738087674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoJBHbJTaiJ77Wn/pdx++aw204IyMaEj8k1BWStQF/s=;
        b=TyDgnV3oT0Ue+ERY5btpheEKiVIYxAOH++6Wq+6/ZZkggKO6Vm/x9Rhilu4tXZqr8o
         jYCxA5/iCY/83xLBccvAkNtb7iItuewxtrLAuFktH089XKWFLGVbdJQVMjuOROIz1Evm
         9bd/ERNvOnR3sY5AA+/DID2p0+mSsj69TWCa9E5HNc19tbHvjeFJFdtI37EcM3uFYlUT
         JNwiYLQl0h8WK1KZKqIenVLIxbTK76QBMRPj6NsFUsexJ2cHcdLi1P51kGV6u2tNGYmb
         WDlIfoUuInit8jYbmfkL4BdYbJU8N4ZZMusZmOifZ+hhD0gg/R99B/DTa2TUFrAdrDwc
         8glg==
X-Forwarded-Encrypted: i=1; AJvYcCX4ArzuGpPFUGsG4BYZWxthyMJqiK8likd50d41FjEzdfOdk1N2/0pAm6fqjwYkWwGEzlkpUxqSnTPLPFpf@lists.openembedded.org
X-Gm-Message-State: AOJu0YwMto5QiOx9/FgPF/j8RhCKKqNdDgP0q826VUbLiP/wQz4fRIFH
	j5gAf8n/XKi7f7SSZ/UE3KJ37hpJ4U8GXmjSI8DtArnw4NzzR1RgHpe8WGh2FM4NvstQIstFrJ1
	/Fb22hR7ncMBzQCj33PqdUF+t4uM=
X-Gm-Gg: ASbGncs8SD1UAbNOHZa1FV6BRDWjunsTNIhLHTJ7cpmh7bBHPIj+v4wL1dmbOWpRsFR
	dJEGIBeO63lSACtZHgnMP4UkhWuNtb3Eh6bfjz5p4vJu/M/KgpQ==
X-Google-Smtp-Source: AGHT+IFJvYXNbNoEzzrUEsfEWMDiNgEYp2e/8Y7QQPY/DIWPrEpQO1fJXpZjv0EA9gjdpQHwuEftYBgvoGI1YS2nqLI=
X-Received: by 2002:a2e:a4c6:0:b0:302:3261:8e33 with SMTP id
 38308e7fff4ca-3072ca5b498mr56611041fa.4.1737482874182; Tue, 21 Jan 2025
 10:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20241014125406.2322310-1-alex.kanavin@gmail.com>
 <D92E13F2-8973-407A-801E-D743AE755FD9@arm.com> <181CC55DF6F8EBED.28835@lists.openembedded.org>
 <CANNYZj-3mGjhmasOC4ukmA_+POBi_uSfu49hHF=AXHRx_Gn_Zg@mail.gmail.com>
In-Reply-To: <CANNYZj-3mGjhmasOC4ukmA_+POBi_uSfu49hHF=AXHRx_Gn_Zg@mail.gmail.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 21 Jan 2025 10:07:42 -0800
X-Gm-Features: AbW1kvan8Fwx88D1B_zuI9OYvbgbrnJ8t5S4-pzfzYR1xf8ivVTtrnoCgWwTz1U
Message-ID: <CANx9H-Ata2tAXDKH+bf_udc_cPHXMUUEq-pO-T8cV7PXSMw_Tg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget.py: use default wget
 user-agent in upstream version checks
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Ross Burton <ross.burton@arm.com>, 
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000084e5c1062c3b4177"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 18:08:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17048

--00000000000084e5c1062c3b4177
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 9:58=E2=80=AFAM Alexander Kanavin <alex.kanavin@gma=
il.com>
wrote:

> On Tue, 21 Jan 2025 at 18:29, Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
> wrote:
> >
> > This has been discussed before. Taking things from mercurial with wget
> is explicitly disallowed and there=E2=80=99s an official location for tho=
se
> tarballs. I=E2=80=99ll find that thread when I get to a real computer.
>
> Found it:
> https://lists.openembedded.org/g/bitbake-devel/message/16359
>
>
Just to add some more insights for folks unaware, the
https://openjdk-sources.osci.io/openjdk8/openjdk8u272-ga.tar.xz type
tarballs are complete, and include hotspot, corba, jaxp, jaxws, etc.

We do need other download locations for the ports though (aarch64 and
aarch32), at least until we update to a hypothetical release where those
ports are merged into mainline OpenJDK.

In the past, each of the components (jdk, hotspot, corba, jaxp, jaxws,
etc.) had to be tracked (changesets) and downloaded separately. There is a
lot of complicated machinery in meta-java to handle that old model. If
someone is motivated to help simplify and update (for master/walnascar, we
can discuss backport policy once things actually build and merge) that
would be a helpful contribution.


> Alex
>

--00000000000084e5c1062c3b4177
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 21,=
 2025 at 9:58=E2=80=AFAM Alexander Kanavin &lt;<a href=3D"mailto:alex.kanav=
in@gmail.com">alex.kanavin@gmail.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, 21 Jan 2025 at 18:29, Alexander=
 Kanavin via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a> &lt;alex.kanavin=3D<a href=3D"mailto:gmail.c=
om@lists.openembedded.org" target=3D"_blank">gmail.com@lists.openembedded.o=
rg</a>&gt;<br>
wrote:<br>
&gt;<br>
&gt; This has been discussed before. Taking things from mercurial with wget=
 is explicitly disallowed and there=E2=80=99s an official location for thos=
e tarballs. I=E2=80=99ll find that thread when I get to a real computer.<br=
>
<br>
Found it:<br>
<a href=3D"https://lists.openembedded.org/g/bitbake-devel/message/16359" re=
l=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bitbake=
-devel/message/16359</a><br>
<br></blockquote><div><br></div><div>Just to add some more insights for fol=
ks unaware, the=C2=A0<a href=3D"https://openjdk-sources.osci.io/openjdk8/op=
enjdk8u272-ga.tar.xz">https://openjdk-sources.osci.io/openjdk8/openjdk8u272=
-ga.tar.xz</a> type tarballs are complete, and include hotspot, corba, jaxp=
, jaxws, etc.<br><br></div><div>We do need other download locations for the=
 ports though (aarch64 and aarch32), at least until we update to a hypothet=
ical release where those ports are merged into mainline OpenJDK.</div><div>=
<br></div><div>In the past, each of the components (jdk, hotspot, corba, ja=
xp, jaxws, etc.) had to be tracked (changesets) and downloaded separately. =
There is a lot of complicated machinery in meta-java to handle that old mod=
el. If someone is motivated to help simplify and update (for master/walnasc=
ar, we can discuss backport policy once things actually build and merge) th=
at would be a helpful contribution.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Alex<br>
</blockquote></div></div>

--00000000000084e5c1062c3b4177--


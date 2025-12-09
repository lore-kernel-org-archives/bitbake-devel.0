Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF94D1CDC6
	for <webhook@archiver.kernel.org>; Tue,  9 Dec 2025 10:44:11 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4909.1765277046803736900
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Dec 2025 02:44:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=PeHnQdNk;
 spf=pass (domain: smile.fr, ip: 209.85.208.42, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so9352091a12.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Dec 2025 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1765277045; x=1765881845; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gaHAsg8v+jZCdaSMHS8l3PseMB1e3nipqWGB+wuw/Qc=;
        b=PeHnQdNk5DaV78DCQx1sASZAaRHvo3TuI6jqoRTwZOzeSgVbViJDMZfm8iEK4nS6gO
         bPGCDjPacJHBL3svlXCTvEtQdsg6ZgZ1tOZWlRicPH6TkigjBM1lLuD2TOKbdBDb8FoR
         90H+W+60hNnLqwvXL2lfJsw5lCBkIvBQm1nrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765277045; x=1765881845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaHAsg8v+jZCdaSMHS8l3PseMB1e3nipqWGB+wuw/Qc=;
        b=DZiYFeXzRIQMyr9MdbO6I+COAnQ5Xx1hkT9b86rCQcdaVc3JDisqxmVzk45IBhj2IQ
         cPzIakkl0jR/7K2ZWZ4XL6OLROBQzf2WHlLqB/V42O+CLy8Xe4BmogWtleXLcGVWO3Dd
         M2A+RyceBNwa5vxCMi0aVcnsNhYOjBZgjDVSL/HhwRrcK5LChRh4H3QmAIJzFMr9Jx+U
         Hx2nDC9s2KfOKL+Y2/qjPkYpod3RWRbuQ9o/kZP1pGhb7QTTAJQgRnWjx4rQsVP3L3+h
         f/37Z3FYrbf/hMN0O/aC+QqxaljUut3vFyyUSkGEc1jj6Iq06OCbI1Z6WWgcXHULI4l7
         6VOA==
X-Gm-Message-State: AOJu0YziCIDSUgTYsB/pTBN64VS2jxkwU8E9GWv6qU89PcYDtUe0GXci
	4JXH+8CC+mYQdJd2RaZkg9CNnrO/TYSPclN39v2tR4J6oOuKm51VvoFgyowY6+zxGrx6M1My35I
	WM08mt2T/RS8RrNERdL/m+cqDK2M2Utp8HIowO2DfNw==
X-Gm-Gg: ASbGncvypjNrgljMaig2GrLQ6JsbhHsOUrfF8oteXu6YqoOqrIoUR9S1rGejzuLAMTb
	Jb+9bfARMDCvrtFIWXeMpDFhTKrWSXdoi6T+w3Vjy1K1yu3Q/rmBWEf0RSRCkH7XtrgdeCyi2Rl
	FU/VfuJ3/obySKo7uM6PccdKmf5s9UkNOfmKVsc996kOCIxXElvemhwEOXadyenhDGZl7KqjG54
	aqLUf/VhZZWw9TXsVf2QhhuCy6kYxHFZvCfZahqEK7EbdcPDeeDXX13auSRFSutLg8UbAZssEe9
	xGq4vfJRL+Cz3wUa5h2hENmFcg==
X-Google-Smtp-Source: AGHT+IEqpOuZIBo79BiVQ+2rzD2u5DA+Q/PmlUGe+6HCyhuuvBKQKJKOSg/q2kdPZp4+NDLCT/Hc/hA1ANKZF3rjkys=
X-Received: by 2002:a05:6402:4395:b0:649:5aaf:e3de with SMTP id
 4fb4d7f45d1cf-6495aafe4a4mr1880171a12.11.1765277044784; Tue, 09 Dec 2025
 02:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20251208161219.41335-1-corentin.guillevic@smile.fr> <7501fc9f5b22984c6279f56b04f3888b34913d1a.camel@pbarker.dev>
In-Reply-To: <7501fc9f5b22984c6279f56b04f3888b34913d1a.camel@pbarker.dev>
From: Corentin GUILLEVIC <corentin.guillevic@smile.fr>
Date: Tue, 9 Dec 2025 11:43:53 +0100
X-Gm-Features: AQt7F2qFlEPiyvpe0dMLQUwr9vG0rBI6HcLzJnJtCbscRAeNggC5-EPXRUIcw_M
Message-ID: <CAMFqQmq0ZjzyPceUGhH25gVpP8295UBtrHBqKs7rttpCt-ijhg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Skip AUTOREV management if no SCM URI
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000002f4eed06458297d4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Dec 2025 10:44:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18557

--0000000000002f4eed06458297d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Is there any valid case for `SRCREV =3D "${AUTOREV}` when no SCM URI is
given?

No, however this case occurs indirectly with the recipetool command (from
the self-test devtool.DevtoolUpgradeTests). It generates a recipe in which
SRCREV is equal to "${AUTOREV}", even though the URI is not a SCM one. The
issue arose because I used SRCREV in a new "insane" test, see:
https://lists.openembedded.org/g/openembedded-core/topic/116341789

The issue can be reproduced by applying my patches and running the
following command:

$ recipetool --color=3Dauto create --devtool -o /tmp/devtool4819z5wk '
http://downloads.yoctoproject.org/mirror/sources/i2c-tools-3.1.2.tar.bz2'
-x ${BUILDDIR}/workspace/sources/devtoolsrcdcviuvn9

Le lun. 8 d=C3=A9c. 2025 =C3=A0 17:59, Paul Barker <paul@pbarker.dev> a =C3=
=A9crit :

> On Mon, 2025-12-08 at 17:12 +0100, Corentin Guillevic via
> lists.openembedded.org wrote:
> > AUTOREV allows to fetch the latest revision. If no SCM URI is used (e.g=
.
> git://, ...),
> > AUTOREV has no effect. However there is one case in which a recipe with
> AUTOREV
> > but no SCM URI will lead to a parsing error:
> >
> > ERROR:
> /path/to/yocto/builds/build-qemux86-64/workspace/recipes/i2c-tools/
> i2c-tools_3.1.2.bb: AUTOREV/SRCPV set too late for the fetcher to work
> properly, please set the variables earlier in parsing. Erroring instead o=
f
> later obtuse build failures.
> >
> > This error is raised when AUTOREV occurs (__BBAUTOREV_SEEN) but is not
> acted
> > upon (__BBAUTOREV_ACTED_UPON). A recipe with one SCM URI causes the
> > srcrev_internal_helper() function to run, and read the value of SRCREV.
> If
> > SRCREV =3D "${AUTOREV}", then AUTOREV will be acted upon.
> >
> > If the recipe does not have an SCM URI, SRCREV is not parsed and AUTORE=
V
> remains
> > unchanged. However, if SRCREV is expanded during the parsing time in
> Python code
> > (either pure or evaluated from BitBake code), then AUTOREV will be
> expanded too
> > and resulting in the setting of __BBAUTOREV_SEEN. However, as there is
> no SCM
> > URI, the code flow that would act upon AUTOREV is never run.
> >
> > The fix slightly changes the way AUTOREV is handled: if no SCM URI is
> provided,
> > AUTOREV will be considered to have never occurred (__BBAUTOREV_SEEN wil=
l
> not be
> > defined).
>
> It makes more sense to me to throw an error if AUTOREV is seen but no
> SCM URI is provided, rather than silently ignoring AUTOREV. Perhaps we
> just need to improve the error that is raised.
>
> Is there any valid case for `SRCREV =3D "${AUTOREV}` when no SCM URI is
> given?
>
> Thanks,
>
> --
> Paul Barker
>
>
>

--0000000000002f4eed06458297d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div></div><div>&gt;=C2=A0Is there any valid case for `SRC=
REV =3D &quot;${AUTOREV}` when no SCM URI is<br>
given?</div><div><br></div><div>No, however this case occurs indirectly wit=
h the recipetool command (from the self-test=C2=A0devtool.DevtoolUpgradeTes=
ts). It generates a recipe in which SRCREV is equal to &quot;${AUTOREV}&quo=
t;, even though the URI is not a SCM one. The issue arose because I used SR=
CREV in a new &quot;insane&quot; test, see:=C2=A0<a href=3D"https://lists.o=
penembedded.org/g/openembedded-core/topic/116341789" target=3D"_blank">http=
s://lists.openembedded.org/g/openembedded-core/topic/116341789</a></div><di=
v><br></div><div>The issue can be reproduced by applying my patches and run=
ning the following command:</div><div><br></div><div>$ recipetool --color=
=3Dauto create --devtool -o /tmp/devtool4819z5wk &#39;<a href=3D"http://dow=
nloads.yoctoproject.org/mirror/sources/i2c-tools-3.1.2.tar.bz2" target=3D"_=
blank">http://downloads.yoctoproject.org/mirror/sources/i2c-tools-3.1.2.tar=
.bz2</a>&#39; -x ${BUILDDIR}/workspace/sources/devtoolsrcdcviuvn9</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=
=C2=A0lun. 8 d=C3=A9c. 2025 =C3=A0=C2=A017:59, Paul Barker &lt;<a href=3D"m=
ailto:paul@pbarker.dev" target=3D"_blank">paul@pbarker.dev</a>&gt; a =C3=A9=
crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On M=
on, 2025-12-08 at 17:12 +0100, Corentin Guillevic via<br>
<a href=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.openembedded.org</a> wrote:<br>
&gt; AUTOREV allows to fetch the latest revision. If no SCM URI is used (e.=
g. git://, ...),<br>
&gt; AUTOREV has no effect. However there is one case in which a recipe wit=
h AUTOREV<br>
&gt; but no SCM URI will lead to a parsing error:<br>
&gt; <br>
&gt; ERROR: /path/to/yocto/builds/build-qemux86-64/workspace/recipes/i2c-to=
ols/<a href=3D"http://i2c-tools_3.1.2.bb" rel=3D"noreferrer" target=3D"_bla=
nk">i2c-tools_3.1.2.bb</a>: AUTOREV/SRCPV set too late for the fetcher to w=
ork properly, please set the variables earlier in parsing. Erroring instead=
 of later obtuse build failures.<br>
&gt; <br>
&gt; This error is raised when AUTOREV occurs (__BBAUTOREV_SEEN) but is not=
 acted<br>
&gt; upon (__BBAUTOREV_ACTED_UPON). A recipe with one SCM URI causes the<br=
>
&gt; srcrev_internal_helper() function to run, and read the value of SRCREV=
. If<br>
&gt; SRCREV =3D &quot;${AUTOREV}&quot;, then AUTOREV will be acted upon.<br=
>
&gt; <br>
&gt; If the recipe does not have an SCM URI, SRCREV is not parsed and AUTOR=
EV remains<br>
&gt; unchanged. However, if SRCREV is expanded during the parsing time in P=
ython code<br>
&gt; (either pure or evaluated from BitBake code), then AUTOREV will be exp=
anded too<br>
&gt; and resulting in the setting of __BBAUTOREV_SEEN. However, as there is=
 no SCM<br>
&gt; URI, the code flow that would act upon AUTOREV is never run.<br>
&gt; <br>
&gt; The fix slightly changes the way AUTOREV is handled: if no SCM URI is =
provided,<br>
&gt; AUTOREV will be considered to have never occurred (__BBAUTOREV_SEEN wi=
ll not be<br>
&gt; defined).<br>
<br>
It makes more sense to me to throw an error if AUTOREV is seen but no<br>
SCM URI is provided, rather than silently ignoring AUTOREV. Perhaps we<br>
just need to improve the error that is raised.<br>
<br>
Is there any valid case for `SRCREV =3D &quot;${AUTOREV}` when no SCM URI i=
s<br>
given?<br>
<br>
Thanks,<br>
<br>
-- <br>
Paul Barker<br>
<br>
<br>
</blockquote></div>

--0000000000002f4eed06458297d4--


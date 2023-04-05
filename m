Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F72C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 10:50:17 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web11.126931.1680691808311731109
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 03:50:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lEsRTkqk;
 spf=pass (domain: gmail.com, ip: 209.85.208.177, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id q14so36829334ljm.11
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680691806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eUnAiJ4OsKwPuUXv0aYTQqSRKmdI2yNx8y/6CEA0fU8=;
        b=lEsRTkqkYBb6o/SI8JJaXVt4RviL8nBK1EFXdMSOExt2gnNK5h9Z6LiHFj7unOgkHN
         tu/dGGPudBbhaC1Vhq/llj50buNlaxsxvN3kwNtLWG30hs6sCGGMm5MeUgvZ8sHQMPYK
         uWWgtS36yyrlpa6VJdizHjRt4DhK6xXfNbuJCsOkFrh5ZCoY0WKOrVVaFwA9l6IJfseX
         bMo2jVZrAFzVsmNasBcaLc9fkNd0+stthN0abhgYruPutzGyHzNaEzhwSVTn7EEHEMg+
         4tipVpwsfl/d7Qg58HtJ5S23oIsa0K3JVK9Rm/dscA55m6sp1H4NsXXGYBe445KySAg7
         WmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680691806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eUnAiJ4OsKwPuUXv0aYTQqSRKmdI2yNx8y/6CEA0fU8=;
        b=ar1coDUaG2VxPuzAsmCZOutDaahFoKqAqVuRxJKf5+HcFaUU9HjeZ2pHCV2EuasLME
         waE7UCRl3MmBr5MKYADEu9JL1yk1Xs8r2Ia2UELvP/TC6KPJ4W9mDYIeN31O2zy36JvC
         2oyzk92IDNljqgUI6TyUp+mT3TuM72smbnV+vjNaSs8h8DeQgFgNxT2lIllIOQQNtsfo
         zuUJ8rVKbpdImJhAxqIpx1k7hm6LXhxIqM7MZrxDwshAPswpDBHyQPgoNnSOSQIuXktO
         HKHN6+g/iHSA82ly0rz5sHIUOKpnUuOyY1m9w1dR89MJTyUUNXJcXNwKo6TWfITqXJh2
         qp5Q==
X-Gm-Message-State: AAQBX9dHG/nhcPN4D5mNxjiPd9cO2PpxY4DLy7GWXjbOxLdghPO/O8b0
	dzZLXcGXKWp4zTB84lQ8mu+4DQxyGnY05hLs3GM=
X-Google-Smtp-Source: AKy350baG9pltO2LA3M/vpjV9CeUajSQo7ElTzZ1yx+bvBRnXi/279Iglf8QnxtJRtyeBHLVf00IZ2UroniFp81snVw=
X-Received: by 2002:a2e:8746:0:b0:29a:9053:ed1b with SMTP id
 q6-20020a2e8746000000b0029a9053ed1bmr2103004ljj.3.1680691806075; Wed, 05 Apr
 2023 03:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
 <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com> <CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
 <68045681-5481-80f5-30f4-e15616503dcd@mvista.com> <CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
 <CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com>
 <lysfded5w3.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkerNGGj6cadUKfk581kMEXSXqBF=DQC5MMwzZKsD_vmkHg@mail.gmail.com>
 <lyo7o2d49z.fsf@ensc-pc.intern.sigma-chemnitz.de>
In-Reply-To: <lyo7o2d49z.fsf@ensc-pc.intern.sigma-chemnitz.de>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 5 Apr 2023 12:49:54 +0200
Message-ID: <CA+cAkeoXigpUDwewp2cJw8nstaJsSMyvoZviiS-zzHcX+PVsug@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at once
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: Martin Jansa <martin.jansa@gmail.com>, akuster <akuster@mvista.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000013ffc905f8948ec5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 10:50:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14648

--00000000000013ffc905f8948ec5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As a regular recipe which miss a checksum on its src uri, you can just let
bitbake fetch and output the whole list of missing checksums, then copy
paste that into your ${BPN}-crates.inc file.

Le mer. 5 avr. 2023, 12:15, Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
a =C3=A9crit :

> Fr=C3=A9d=C3=A9ric Martinsons <frederic.martinsons@gmail.com> writes:
>
> > I'm pretty new to cargo package (and even more with the support of it
> > inside yocto) but I read from that the update_crates bitbake task is
> > the way to go for those recipes and that cargo bitbake is not
> > supported in yocto (see
> > https://lists.openembedded.org/g/openembedded-core/message/178415)
>
> well, the problem is, that 'cargo-update-recipe-crates' can be only used
> to complete the list of crates with their sha256sum entries.
>
> It is not suitable for creating the initial list of crates (which is not
> a trivial task).  You have to use something like 'cargo bitbake' for it
> (regardless of its maintenance status).
>
>
>
> Enrico
>

--00000000000013ffc905f8948ec5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>As a regular recipe which miss a checksum on its src=
 uri, you can just let bitbake fetch and output the whole list of missing c=
hecksums, then copy paste that into your ${BPN}-crates.inc file.=C2=A0<br><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le mer.=
 5 avr. 2023, 12:15, Enrico Scholz &lt;<a href=3D"mailto:enrico.scholz@sigm=
a-chemnitz.de">enrico.scholz@sigma-chemnitz.de</a>&gt; a =C3=A9crit=C2=A0:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">Fr=C3=A9d=C3=A9ric Martinsons &lt;<=
a href=3D"mailto:frederic.martinsons@gmail.com" target=3D"_blank" rel=3D"no=
referrer">frederic.martinsons@gmail.com</a>&gt; writes:<br>
<br>
&gt; I&#39;m pretty new to cargo package (and even more with the support of=
 it<br>
&gt; inside yocto) but I read from that the update_crates bitbake task is<b=
r>
&gt; the way to go for those recipes and that cargo bitbake is not<br>
&gt; supported in yocto (see<br>
&gt; <a href=3D"https://lists.openembedded.org/g/openembedded-core/message/=
178415" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.opene=
mbedded.org/g/openembedded-core/message/178415</a>)<br>
<br>
well, the problem is, that &#39;cargo-update-recipe-crates&#39; can be only=
 used<br>
to complete the list of crates with their sha256sum entries.<br>
<br>
It is not suitable for creating the initial list of crates (which is not<br=
>
a trivial task).=C2=A0 You have to use something like &#39;cargo bitbake&#3=
9; for it<br>
(regardless of its maintenance status).<br>
<br>
<br>
<br>
Enrico<br>
</blockquote></div></div></div>

--00000000000013ffc905f8948ec5--


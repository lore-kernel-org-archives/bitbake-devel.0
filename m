Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DE4C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 09:52:17 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web10.126014.1680688331647285818
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 02:52:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=h2Q0uBwT;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id d7so836827lfj.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680688330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9x2DG7PuEq8vfiYXhZII+WGsp2Y1D9QtL0DuzonM2yY=;
        b=h2Q0uBwT+oPmTBplo5q+/DOS6pV4mTpWEnZGvt3C5p4oeyAV/PWmrSrXZuVPCZlFpb
         g2HkycHg23Wv2N5ql9mZP8lShB8jiQkZgCHNKFQTACPvJMmiHHwj2I4ejd1/Q3jGGxLv
         yEAnD/z9B3Pykrg56z5+b95j/AIO58tzMX0t70Be7Qv5oXSWCZRPfdYHuBMhir2zhGlH
         9lySE4NNYxkLPoxvqiQQvsb9YNlwF3IV62cB/5H/w+FOtteVE3zUQn+GHYFcM2aHKX0k
         +THBlkxYN3N8tZ5zenoFIPbAFzFtkyfbvaGdZ7D09GQ3bf1XBzXY01oVFIg6Tqo6/hzo
         ZzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680688330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9x2DG7PuEq8vfiYXhZII+WGsp2Y1D9QtL0DuzonM2yY=;
        b=fjlnMRD/jkfHLctuPnILuauT0jrjAB5qU2Nja7mj/UGAqThHavFP20EHukdb/Ms5Oa
         yv955aBrTKLnMs8tj24e4fMVYeW6f2mVuIabLFRFd2PduBk0r0Ojz4is++DvUTNVjLvi
         yU4IYUORw3+2Ny2UX0wqORKyJ1gY+dFypxQ46oK15NvvAqDvl59CKWoXc6qx4ZGe2k9s
         1OUrFL+qTBgd2bVtQybLlrPJHs7e9otOYa+VSrnu8eEeTYXEfePmpNluQshtXOadqrgB
         Yg74U7+mUMVr7NcFwyoMh6wCsx5sJVB5lxU30E8jeQlthBJbTTgEOqWTPnagoqwW184O
         f4YQ==
X-Gm-Message-State: AAQBX9fEiBrGH/I+og/DHJUW7Vp5xkZSCvGPmdHJSJDxfTNVrY5SVzRJ
	+xHnUL9fU/SyacoBNyrwQ0E2pmpLfJ2hLQHliXc=
X-Google-Smtp-Source: AKy350b6OsM2gngMx5Dy8onM2/HdnxtIfAQ/GVZBM/ljeKT6GLfz8MXExiUfvdy3XQ6dHiOSlEkcVclovRqLX72XCGA=
X-Received: by 2002:ac2:548f:0:b0:4e0:822f:9500 with SMTP id
 t15-20020ac2548f000000b004e0822f9500mr1664101lfk.12.1680688329337; Wed, 05
 Apr 2023 02:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
 <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com> <CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
 <68045681-5481-80f5-30f4-e15616503dcd@mvista.com> <CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
 <CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com> <lysfded5w3.fsf@ensc-pc.intern.sigma-chemnitz.de>
In-Reply-To: <lysfded5w3.fsf@ensc-pc.intern.sigma-chemnitz.de>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 5 Apr 2023 11:51:58 +0200
Message-ID: <CA+cAkerNGGj6cadUKfk581kMEXSXqBF=DQC5MMwzZKsD_vmkHg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at once
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: Martin Jansa <martin.jansa@gmail.com>, akuster <akuster@mvista.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d9315205f893be6d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 09:52:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14643

--000000000000d9315205f893be6d
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm pretty new to cargo package (and even more with the support of it
inside yocto) but I read from
 that the update_crates bitbake task is the way to go for those recipes and
that
cargo bitbake is not supported in yocto (see
https://lists.openembedded.org/g/openembedded-core/message/178415)


On Wed, 5 Apr 2023 at 11:40, Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
wrote:

> "Frederic Martinsons" <frederic.martinsons@gmail.com> writes:
>
> > I looked at the suricata recipe in meta-security and it didn't use
> > cargo-update-recipes.bbclass
> >
> > You should modify your rust recipes to use this class and have access to
> > "bitbake -c update_crates" .
>
> Is this really the recommended way for rust packages?  As you already
> mentioned, this has a big problem with bootstrapping: fetch (for
> downloading the crates) and compile (to create Cargo.lock) must be
> run before do_update_crates works.
>
> IMO, the crate fetcher should be changed to create versioned 'name'.  Then
> the 'cargo bitbake' output can be used directly and missing checksums can
> be copied & pasted.
>
>
>
> Enrico
>

--000000000000d9315205f893be6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,=C2=A0<div><br></div><div>I&#39;m pretty new to carg=
o package (and even more with the support of it inside yocto) but I read fr=
om=C2=A0</div><div>=C2=A0that the update_crates bitbake task is the way to =
go for those recipes and that</div><div>cargo bitbake is not supported in y=
octo (see=C2=A0<a href=3D"https://lists.openembedded.org/g/openembedded-cor=
e/message/178415">https://lists.openembedded.org/g/openembedded-core/messag=
e/178415</a>)</div><div><br></div></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, 5 Apr 2023 at 11:40, Enrico Schol=
z &lt;<a href=3D"mailto:enrico.scholz@sigma-chemnitz.de">enrico.scholz@sigm=
a-chemnitz.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">&quot;Frederic Martinsons&quot; &lt;<a href=3D"mailto:frederic=
.martinsons@gmail.com" target=3D"_blank">frederic.martinsons@gmail.com</a>&=
gt; writes:<br>
<br>
&gt; I looked at the suricata recipe in meta-security and it didn&#39;t use=
<br>
&gt; cargo-update-recipes.bbclass<br>
&gt;<br>
&gt; You should modify your rust recipes to use this class and have access =
to<br>
&gt; &quot;bitbake -c update_crates&quot; .<br>
<br>
Is this really the recommended way for rust packages?=C2=A0 As you already<=
br>
mentioned, this has a big problem with bootstrapping: fetch (for<br>
downloading the crates) and compile (to create Cargo.lock) must be<br>
run before do_update_crates works.<br>
<br>
IMO, the crate fetcher should be changed to create versioned &#39;name&#39;=
.=C2=A0 Then<br>
the &#39;cargo bitbake&#39; output can be used directly and missing checksu=
ms can<br>
be copied &amp; pasted.<br>
<br>
<br>
<br>
Enrico<br>
</blockquote></div>

--000000000000d9315205f893be6d--


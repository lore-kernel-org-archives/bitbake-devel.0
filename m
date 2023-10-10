Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB1CCD8CA5
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 15:16:30 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web10.94457.1696950982843076937
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Oct 2023 08:16:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E0xKGFDY;
 spf=pass (domain: gmail.com, ip: 209.85.218.52, mailfrom: bhstalel@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9b98a699f45so978268366b.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696950981; x=1697555781; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zkxrh1R4WoomeYAs5h4IA15tzp+56EIlSgdvDiOwbhk=;
        b=E0xKGFDYilAC3qxSN3k3hz4/AmGX2KbxHNt8XMPt5RlV30ZviOmWlBO5r5bnIZ6cNj
         gqFEe/zL3quWC4zDGqAwsO4vR+tKLIH7ISsV+7I/mesj4uCciXPNsSdyeipAhnbGaO1R
         LxvcTdEQFdTb4WgmoXi7NQjEa5cUIjOCfSiA0cQd88BkUB0L2vqr0914KrPKU5AKhljz
         b7CoRz8fP+P1pSuNDVKukrTYNJJqPwkAN+/janVDnoSu/VSkkWvVpV6PcPNdWADQDwqt
         KwqsYEKlU26Rl8hH9huLWCUqRHZnDceer/5RoPCG0+qsn88Jw2+V8nqfFJix67yTOK4U
         g5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696950981; x=1697555781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkxrh1R4WoomeYAs5h4IA15tzp+56EIlSgdvDiOwbhk=;
        b=SPtg2g0uV4MKfkS+ANfj1KN35qTSkcs9G4ILWeanzUussYN63k0/bW98GGg+winiTs
         UneR2nxagmtomPoMiq2ticrldGPo+SSWCd5LPxz4ys6zC/HuTYRozpvuUeTo3NlIZn+j
         w62vGbVzGKnbLPPavojXAKRUGk16Cu9qOliBHjp8rpbSwGjldpfbnTREskdDvElclwp6
         LUIyZ21Fake/iUhDL42eEmY9shIYy6Ph3J8NiRQUihpkA+lWoeAj6gRa7YmDNsXthDql
         LQ4rbIJtRStqvrQt7qFicG6O6S3toLJUKdUMgJqEH+uPRlKnqj1eHREIN0AXuaWYjyD1
         xitg==
X-Gm-Message-State: AOJu0YyTVjixz2Fx+jr0jJEMAEkxupaBAR9OLojgZPsjIy/spLFgf2Y1
	9xa7K2176NYNHl68InJTwwjcIlPS4dCf1IbXzHs=
X-Google-Smtp-Source: AGHT+IHS3dTmLn4kbQMFmZmTUUN8XZJEsY95RnxCa7G/RPIQ5AYIC4TZFzqcDY1zxrXosD4Hf/+J4wKQM+5aDTrc0DI=
X-Received: by 2002:a17:907:778e:b0:9a1:bd82:de24 with SMTP id
 ky14-20020a170907778e00b009a1bd82de24mr15851616ejc.12.1696950980942; Tue, 10
 Oct 2023 08:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231010014835.947330-1-bhstalel@gmail.com> <49ed9ab41a08e2665bc66080d1955d078cb2d888.camel@linuxfoundation.org>
 <CAOgG7m2BVasNj-xPFMbP0VBBi5aXB0tGF84fiK1QFY+1eNFmrg@mail.gmail.com> <61aa3f568ea6cab50f0eb9e1168329122c3e0933.camel@linuxfoundation.org>
In-Reply-To: <61aa3f568ea6cab50f0eb9e1168329122c3e0933.camel@linuxfoundation.org>
From: Talel BELHADJ SALEM <bhstalel@gmail.com>
Date: Tue, 10 Oct 2023 16:16:09 +0100
Message-ID: <CAOgG7m2afwYvpPNc75AiL85Uz56LH8SAcBXrixxh60dfU87pZw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Ensure that BBFILE_COLLECTIONS and BBPATH
 exist at add-layers and parsing
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000006b9f1b06075e30b3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 15:16:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15207

--0000000000006b9f1b06075e30b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"*Layers don't have to contain recipes*" is what I missed in the first
place that led me to this analysis. I think it should stand out in the
documentation as well.

So, I think I will keep the first patch of find_bbfiles.

Do you have any further ideas for BBFILE_COLLECTIONS and BBPATH ? Because
still show-layers are based on BBFILE_COLLECTIONS, is it expected behavior
or it should be fixed ?

Kind regards
Talel

On Tue, Oct 10, 2023 at 3:59=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2023-10-10 at 15:35 +0100, Talel BELHADJ SALEM wrote:
> > Thanks for the reply,
> >
> > Regarding the second comment:
> >
> > Do you mean using addpylib can be an alternative for not setting
> > BBFILE_COLLECTIONS and BBPATH ? If yes, I can't see an example on how
> > to do that.
>
> Layers don't have to contain recipes. Whether or not there is an
> example, a layer with just library functions would be a valid layer and
> I'm not taking patches which show them as invalid.
>
> Cheers,
>
> Richard
>
>

--0000000000006b9f1b06075e30b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&quot;<b>Layers don&#39;t have to contain recipes</b>&quot=
; is what I missed in the first place that led me to this analysis. I think=
 it should stand out in the documentation as well.<div><br></div><div>So, I=
 think I will keep the first patch of find_bbfiles.</div><div><br></div><di=
v>Do you have any further ideas for BBFILE_COLLECTIONS and BBPATH ? Because=
 still show-layers are based on BBFILE_COLLECTIONS, is it expected behavior=
 or it should=C2=A0be fixed ?</div><div><br></div><div>Kind=C2=A0regards</d=
iv><div>Talel</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Tue, Oct 10, 2023 at 3:59=E2=80=AFPM Richard Purdie &=
lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@lin=
uxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Tue, 2023-10-10 at 15:35 +0100, Talel BELHADJ SALEM wrot=
e:<br>
&gt; Thanks=C2=A0for the reply,<br>
&gt; <br>
&gt; Regarding the second comment:<br>
&gt; <br>
&gt; Do you mean using addpylib can be an alternative for not setting<br>
&gt; BBFILE_COLLECTIONS and BBPATH ? If yes, I can&#39;t see an example on =
how<br>
&gt; to do that.<br>
<br>
Layers don&#39;t have to contain recipes. Whether or not there is an<br>
example, a layer with just library functions would be a valid layer and<br>
I&#39;m not taking patches which show them as invalid.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div>

--0000000000006b9f1b06075e30b3--


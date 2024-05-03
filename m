Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B801CC4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 14:14:39 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web10.13817.1714745675683951920
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 May 2024 07:14:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=INeDeKDy;
 spf=pass (domain: gmail.com, ip: 209.85.160.49, mailfrom: raj.khem@gmail.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23e78ef3de7so203299fac.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 May 2024 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714745675; x=1715350475; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KsxDkkJa1JCOjZgnxup7JKJh9coOrlwHaY08uJiykME=;
        b=INeDeKDyy4G6XMrZRR1JuxgQMKDGCc0w9LaNwKAd2TuUgxix/Q63cEnPHucEDn8jR5
         OxVLn9BqjbjsCFiO030+kNDYXe2CpxkTJQMs8mkSFUV90RLRPYi0Gaq81QRGRegHozuK
         fLP9scDZWMznQsz4Ey4gvSVnertxMsKEgxcMe/neHvrisCnhors+TyaBlRgGtgACle2Q
         ZsI4o+S//Mk8QK1mXvEbOor21ZeLcNHo63/YdaTE7FS1VWZ/3f7PlQXYCLWXy6vYb3HN
         Ck5DdBjNpp5sqjCnG7xYqvH5jMyGvo8wkGhFq2te+7jT2ibddclMb5aQd7cU0HNspNUu
         7DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714745675; x=1715350475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsxDkkJa1JCOjZgnxup7JKJh9coOrlwHaY08uJiykME=;
        b=ESE3ZHE+HxwTYsjJO8Rw2+xVWQxmqA41t0tniizxBoo6RZmcKFiZ8Ik24s9xWWNpc8
         i3cpoFZxfsz6YPq+lyx7+LHZxjhYF8ivxr3ySm6VakUm6+pEKpCFTBIT8RhRJi3v0Tsv
         K8oS+I1z7Sv+osWy6AYpZBTwmnngVxbycNBeOMPRSA9JFcLgjpjIfvElql7dxqERr/+B
         osoB2NmW5hGXxVhh+J7tnoraovujAKpIuVUmOis3VauNRsd66zQfIYBgHBurKsYtH9oc
         9+zt8g0Ma3S9THnUwUOZmAKHJPVFc5YSqbGnjSEgP84FqdlPMjwe9xJPZLMDkcDeN7H4
         kTBA==
X-Forwarded-Encrypted: i=1; AJvYcCUjO5hQUEWgFXY82QnCRlI2hCO7Kc/PoP04SUBpG+Y7NLhnpHiGiXe0cR9pl6oAtVpeCCnMLjbUKTa6uIFl0z39PmvYDemRJsqsJ4Jn01tgPfaE53g=
X-Gm-Message-State: AOJu0Yyhybfw272/+3W3Hm/GgT1dvSmJyLybyuLnuilJHPkRto+0RreW
	knZ4CbbYRX1GYSHwfDFAs4EyP0pSSJp2kBXbDkUHFvYmbiepjMneawXq87vGUZka/v36TCZ6LE+
	fejAQOm+MHuYvIjRHANtw7OZs4tg=
X-Google-Smtp-Source: AGHT+IHeglLTcdhgLKENCgf6rFw2rqlDGYOdxBkF1d4n7tirz9VfI1ONS4lzpXiplKVYn+N0ZQPL2I59e/cPTCmE8QY=
X-Received: by 2002:a05:6870:8e12:b0:23e:6f17:c27 with SMTP id
 lw18-20020a0568708e1200b0023e6f170c27mr1965239oab.47.1714745674817; Fri, 03
 May 2024 07:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
 <20240429201418.657042-3-michael.opdenacker@bootlin.com> <CAMKF1soyTt3He84XOgAv01ZdwGPZ2gxVwZaRxsL2Dufj3W_=rg@mail.gmail.com>
 <2a2f731e-7ca0-4442-a0e2-5e2b3bfde80c@bootlin.com>
In-Reply-To: <2a2f731e-7ca0-4442-a0e2-5e2b3bfde80c@bootlin.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 3 May 2024 07:14:23 -0700
Message-ID: <CAMKF1soksEYiF37G=1bhDSX83iecpfVcxjiS+QLW4DciVu7LCA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v5 2/5] prserv: move code from __init__ to bitbake-prserv
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Tim Orling <ticotimo@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d3ea0306178d5605"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 May 2024 14:14:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16186

--000000000000d3ea0306178d5605
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 1:04=E2=80=AFAM Michael Opdenacker <
michael.opdenacker@bootlin.com> wrote:

> Hi Khem
>
> On 5/2/24 at 18:57, Khem Raj wrote:
> > Hi Michael
> >
> > I am seeing a problem with this series, specifically following
> > patchset is causing a regression
> >
> > * ea1d7b8a36e bitbake: prserv: add bitbake selftests
> > * 5c66d345300 bitbake: prserv: import simplification
> > * c23f2c1680f bitbake: prserv: store_value() improvements
> > * 395b321af29 bitbake: prserv: avoid possible race condition in databas=
e
> code
> > * 8022dc1029d bitbake: prserv: enable database sharing
> > * b81bfdfbed8 bitbake: prserv: add "upstream" server support
> > * 9539ce3b14a bitbake: prserv: move code from __init__ to bitbake-prser=
v
> > * 4ec1553710b bitbake: prserv: declare "max_package_pr" client hook
> >
> >
> > error seen during packagedata task of base-files
> >
> > WARNING: base-files-3.0.14-r0 do_packagedata: Error talking to server:
> > Connection closed
> > ERROR: Error from client ('127.0.0.1', 59846): 'PRTable' object has no
> > attribute 'sync'
> > Traceback (most recent call last):
>
>
> Thanks for the review. Actually, did you test with the V6 update I sent?


I think it was version in master-next that Richard has staged

>
> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

--000000000000d3ea0306178d5605
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br></div><div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Fri, May 3, 2024 at 1:04=E2=80=AFAM Michael O=
pdenacker &lt;<a href=3D"mailto:michael.opdenacker@bootlin.com">michael.opd=
enacker@bootlin.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
Hi Khem<br>
<br>
On 5/2/24 at 18:57, Khem Raj wrote:<br>
&gt; Hi Michael<br>
&gt;<br>
&gt; I am seeing a problem with this series, specifically following<br>
&gt; patchset is causing a regression<br>
&gt;<br>
&gt; * ea1d7b8a36e bitbake: prserv: add bitbake selftests<br>
&gt; * 5c66d345300 bitbake: prserv: import simplification<br>
&gt; * c23f2c1680f bitbake: prserv: store_value() improvements<br>
&gt; * 395b321af29 bitbake: prserv: avoid possible race condition in databa=
se code<br>
&gt; * 8022dc1029d bitbake: prserv: enable database sharing<br>
&gt; * b81bfdfbed8 bitbake: prserv: add &quot;upstream&quot; server support=
<br>
&gt; * 9539ce3b14a bitbake: prserv: move code from __init__ to bitbake-prse=
rv<br>
&gt; * 4ec1553710b bitbake: prserv: declare &quot;max_package_pr&quot; clie=
nt hook<br>
&gt;<br>
&gt;<br>
&gt; error seen during packagedata task of base-files<br>
&gt;<br>
&gt; WARNING: base-files-3.0.14-r0 do_packagedata: Error talking to server:=
<br>
&gt; Connection closed<br>
&gt; ERROR: Error from client (&#39;127.0.0.1&#39;, 59846): &#39;PRTable&#3=
9; object has no<br>
&gt; attribute &#39;sync&#39;<br>
&gt; Traceback (most recent call last):<br>
<br>
<br>
Thanks for the review. Actually, did you test with the V6 update I sent?</b=
lockquote><div dir=3D"auto"><br></div><div dir=3D"auto">I think it was vers=
ion in master-next that Richard has staged</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex" dir=3D"auto"><br>
Cheers<br>
Michael.<br>
<br>
-- <br>
Michael Opdenacker, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
</blockquote></div></div>

--000000000000d3ea0306178d5605--


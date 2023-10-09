Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFF6CD6114
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 18:15:41 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.70728.1696875333961420186
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Oct 2023 11:15:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aT2TSHOz;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: bhstalel@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9b6559cbd74so886124666b.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696875332; x=1697480132; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb3bhOPqS4TiarTxXLZyvhO6tvEN+e9nmW3d5v5s0YE=;
        b=aT2TSHOzjrurYyzNEHFJheJqAeXA3+0bZvZ1137fjppNQoA250nJbU0Yn/2Ev5Gv9A
         U6hQ1gKksd+w+wUexA1Dh90FXdk9WXYtDz5GXsdkyEBKJhoKt2y69vKTqgzLbasbUIaG
         WwvR8uuJA4mi8Od6kfUksBKJ92TQ4OISzeEaR6HZ7oZBsOCj+LkFQSyjmKcXcB7VFnop
         g57E2A//Xbd3wwvcCWkiHl/7nudU9gfEDnuc4HUFpEBM06Z3eazjylzbL8AmoDjU8Dr2
         1fufEU/qhRD8ET1SQeSmsIlU1uUNUqAV06u4f224TYuVsVzVpLB2s6hxgE1pKQH249os
         LWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875332; x=1697480132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mb3bhOPqS4TiarTxXLZyvhO6tvEN+e9nmW3d5v5s0YE=;
        b=QUztwmkgW7IVFcsxAE60LrSal5ItN+iK0xa58bVRLDcBZkLjNfD6EXjVAhOgBReAB+
         Mse26QskZVEpvL7sCc6xRP7mue44oyB85m6AsNLoICpz8hXFg2VzPhmnBOfdrGRmh0/j
         zi48szLirJopYt49kGhZ82PyFPkjDGXjnD09HnPZLc8RnrI5VnmincPkGDymKMVj0y0n
         sDdYFVMgqmMx4AHWdky4rNVBl+0RUlqDvAhsHoT7i/He4G1Mn6hOcma8coWyrhuFlP1Y
         RttIWgn/z1lxlBHlIPlLQ7T6OJpFZn/j33H0YPYH8/A7BZPW5/RXT4Mwna9vW9/9V2f4
         Et+w==
X-Gm-Message-State: AOJu0Yw4N2j1nPETZyeNdfSyaFLMKiI1bQh4dvMu/QlOIyPyS9NCZf3Y
	+K/A+mEseYJV5GGdteFFHg1DNo9FWuPubHHS3tM=
X-Google-Smtp-Source: AGHT+IFH5nrIbBksdxO8T/2wevb8mWhxP6HKkDs2uBKeX4rWymdcsktcd9+siCVAs3LtkaR3Zn8BK9Gl1vcjeyCgkAY=
X-Received: by 2002:a17:906:3051:b0:9a5:7759:19c0 with SMTP id
 d17-20020a170906305100b009a5775919c0mr14308177ejd.64.1696875332123; Mon, 09
 Oct 2023 11:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231009145918.900167-1-bhstalel@gmail.com> <bae7df5d-fbf2-48e1-b11a-dd0bf326f15c@theobroma-systems.com>
 <5d529ab9-6581-4225-b059-997a58f90c25@app.fastmail.com>
In-Reply-To: <5d529ab9-6581-4225-b059-997a58f90c25@app.fastmail.com>
From: Talel BELHADJ SALEM <bhstalel@gmail.com>
Date: Mon, 9 Oct 2023 19:15:20 +0100
Message-ID: <CAOgG7m0_3BizhxYT4KgLHxnZvqzpiZwn6ScrOyxAxM8v=G1JYQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Fix find_bbfiles when BBFILES contains directory
To: Pavel Zhukov <pavel@zhukoff.net>
Cc: quentin.schulz@theobroma-systems.com, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000663fba06074c93ae"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 18:15:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15198

--000000000000663fba06074c93ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should I provide a test case (sample layer?) for this?
Or should I try to add the support to the documentation according to the
source code?

Thanks.
Talel

On Mon, Oct 9, 2023 at 6:23=E2=80=AFPM Pavel Zhukov <pavel@zhukoff.net> wro=
te:

> Looks like documentation doesn't support this but the code does...
> Simple test case can be useful.
>
> --
> Pavel
> On Mon, Oct 9, 2023, at 17:16, Quentin Schulz via lists.openembedded.org
> wrote:
>
> Hi Talel,
>
> On 10/9/23 16:59, BELHADJ SALEM Talel via lists.openembedded.org wrote:
> >
> > When BBFILES in layer.conf contains a directory, this triggers
> find_bbfiles function
> 1) BBFILES docs clearly specifies:
>
> A space-separated list of recipe files BitBake uses to build software.
>
> So I would say that giving it a directory is incorrect. If it is
> supposed to be supported, then we need to fix the documentation.
>
> What are you trying to do?
>
> > which will fail on endswith that does not expect a list.
> >
> > Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
> > ---
> >   bitbake/lib/bb/cooker.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> > index 2adf4d297d..a354f2f0ab 100644
> > --- a/bitbake/lib/bb/cooker.py
> > +++ b/bitbake/lib/bb/cooker.py
> > @@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):
> >               for ignored in ('SCCS', 'CVS', '.svn'):
> >                   if ignored in dirs:
> >                       dirs.remove(ignored)
> > -            found +=3D [os.path.join(dir, f) for f in files if
> (f.endswith(['.bb', '.bbappend']))]
> > +            found +=3D [os.path.join(dir, f) for f in files if
> (f.endswith(tuple(['.bb', '.bbappend'])))]
>
> 2) Just replace the square brackets with parenthesis instead to save an
> unnecessary array creation.
>
> Cheers,
> Quentin
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15195):
> https://lists.openembedded.org/g/bitbake-devel/message/15195
> Mute This Topic: https://lists.openembedded.org/mt/101854064/6390638
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> pavel@zhukoff.net]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>
>

--000000000000663fba06074c93ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Should I provide a test case (sample layer?) for this?<div=
>Or should I try to add the support to the=C2=A0documentation according to =
the source code?</div><div><br></div><div>Thanks.</div><div>Talel</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On M=
on, Oct 9, 2023 at 6:23=E2=80=AFPM Pavel Zhukov &lt;<a href=3D"mailto:pavel=
@zhukoff.net">pavel@zhukoff.net</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div class=3D"msg-520192259663173128"><u><=
/u><div><div>Looks like documentation doesn&#39;t support this but the code=
 does...<br></div><div>Simple test case can be useful.<br></div><div><br></=
div><div>--=C2=A0<br></div><div>Pavel</div><div>On Mon, Oct 9, 2023, at 17:=
16, Quentin Schulz via <a href=3D"http://lists.openembedded.org" target=3D"=
_blank">lists.openembedded.org</a> wrote:<br></div><blockquote type=3D"cite=
" id=3D"m_-520192259663173128qt"><div>Hi Talel,<br></div><div><br></div><di=
v>On 10/9/23 16:59, BELHADJ SALEM Talel via <a href=3D"http://lists.openemb=
edded.org" target=3D"_blank">lists.openembedded.org</a> wrote:<br></div><di=
v>&gt;=C2=A0<br></div><div>&gt; When BBFILES in layer.conf contains a direc=
tory, this triggers find_bbfiles function<br></div><div>1) BBFILES docs cle=
arly specifies:<br></div><div><br></div><div>A space-separated list of reci=
pe files BitBake uses to build software.<br></div><div><br></div><div>So I =
would say that giving it a directory is incorrect. If it is=C2=A0<br></div>=
<div>supposed to be supported, then we need to fix the documentation.<br></=
div><div><br></div><div>What are you trying to do?<br></div><div><br></div>=
<div>&gt; which will fail on endswith that does not expect a list.<br></div=
><div>&gt;=C2=A0<br></div><div>&gt; Signed-off-by: Talel BELHAJSALEM &lt;<a=
 href=3D"mailto:bhstalel@gmail.com" target=3D"_blank">bhstalel@gmail.com</a=
>&gt;<br></div><div>&gt; ---<br></div><div>&gt;=C2=A0=C2=A0 bitbake/lib/bb/=
cooker.py | 2 +-<br></div><div>&gt;=C2=A0=C2=A0 1 file changed, 1 insertion=
(+), 1 deletion(-)<br></div><div>&gt;=C2=A0<br></div><div>&gt; diff --git a=
/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py<br></div><div>&gt; ind=
ex 2adf4d297d..a354f2f0ab 100644<br></div><div>&gt; --- a/bitbake/lib/bb/co=
oker.py<br></div><div>&gt; +++ b/bitbake/lib/bb/cooker.py<br></div><div>&gt=
; @@ -1827,7 +1827,7 @@ class CookerCollectFiles(object):<br></div><div>&gt=
;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 for ignored in (&#39;SCCS&#39;, &#39;CVS&#39;, &#39;.svn&#39;)=
:<br></div><div>&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ignored in dirs:<=
br></div><div>&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 dirs.remove(ignored)<br></div><div>&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found +=3D [os.path.join(dir, f) for f in=
 files if (f.endswith([&#39;.bb&#39;, &#39;.bbappend&#39;]))]<br></div><div=
>&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
ound +=3D [os.path.join(dir, f) for f in files if (f.endswith(tuple([&#39;.=
bb&#39;, &#39;.bbappend&#39;])))]<br></div><div><br></div><div>2) Just repl=
ace the square brackets with parenthesis instead to save an=C2=A0<br></div>=
<div>unnecessary array creation.<br></div><div><br></div><div>Cheers,<br></=
div><div>Quentin<br></div><div><br></div><div><br></div><div>-=3D-=3D-=3D-=
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br></div><div>Links: You receive all messa=
ges sent to this group.<br></div><div>View/Reply Online (#15195):=C2=A0<a h=
ref=3D"https://lists.openembedded.org/g/bitbake-devel/message/15195" target=
=3D"_blank">https://lists.openembedded.org/g/bitbake-devel/message/15195</a=
><br></div><div>Mute This Topic:=C2=A0<a href=3D"https://lists.openembedded=
.org/mt/101854064/6390638" target=3D"_blank">https://lists.openembedded.org=
/mt/101854064/6390638</a><br></div><div>Group Owner:=C2=A0<a href=3D"mailto=
:bitbake-devel%2Bowner@lists.openembedded.org" target=3D"_blank">bitbake-de=
vel+owner@lists.openembedded.org</a><br></div><div>Unsubscribe:=C2=A0<a hre=
f=3D"https://lists.openembedded.org/g/bitbake-devel/unsub" target=3D"_blank=
">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a href=3D"mail=
to:pavel@zhukoff.net" target=3D"_blank">pavel@zhukoff.net</a>]<br></div><di=
v>-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br></div><div><br></div><di=
v><br></div></blockquote><div><br></div></div></div></blockquote></div>

--000000000000663fba06074c93ae--


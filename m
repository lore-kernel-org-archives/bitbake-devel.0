Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B24C433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 16:54:19 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by mx.groups.io with SMTP id smtpd.web08.8564.1639760058512570140
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Dec 2021 08:54:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lQo+PYqT;
 spf=pass (domain: gmail.com, ip: 209.85.222.41,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f41.google.com with SMTP id 107so5457359uaj.10
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Dec 2021 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFjUFmLH6EQdGUVGbStpitFns5Uc9S6SsvjWDExJGmg=;
        b=lQo+PYqTifYAr+AT7G7Rv2uDF751tJ1jBpp2riWD9msWk0t+CHK+Htq8j0krIwucZJ
         DmfN9Y6ra9MaCebL8fARH4e6yPtKE5RdmZWmAUqhs3R89KBGfHY64LA7hg7RFyi9s07r
         DfU5qqLfso6kXzalwfxFW14fA7yjLYoExLwVdOkh2N5CttrdUZDo7YLpGyNlSU0egATg
         oNuv0Y2pmzzdsCmTsUmWEL1hRyfcyfenW0g7h8h4+JsfLPWJTJ9uYnpSN3WgOh9uuN+U
         eM5e4c/oihp6qs7EMtahTbglqYr/YGjFAwkqcElzGRgH0DvpCud4rz2uxM7Sxsoeie9b
         r6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFjUFmLH6EQdGUVGbStpitFns5Uc9S6SsvjWDExJGmg=;
        b=bSA6hE1aU2Z0cDYJpkSDKsW0PjKb3RDqq8MtU6n8F7SdFlTjdv/lKS1ASLnds2EdJf
         OYJ6fpW0NX/aOAIP3kOgzM1nQv59J3SHq98ArRcPVfT8RmZKnROH2vOCA8AKb/fKBulm
         IeilkJSCVVuVJ3cl2eu5hdl8m7WjpxpNykSvMVm3h1v/Hb7Ew6n6Xp8vZQl51Hv43G+1
         LtSoiU6BHrOZ/47gcN6H3c8ND7ImxUPfEUWvTi85nVFJZKIV362iSwwEadR9n6io0dY3
         SxG3Ea3bvly8I4Qxa9VUlKtPpQDduIL4hGPg+OONMQVS0fX3wHqL7VtsmYE+Di6kHL+I
         D9Dg==
X-Gm-Message-State: AOAM533NX0KBuKq61NuNsbNdImBXnIIInKG7YkqML/rMdndCzDXlwstS
	tIU+H8AIsiGQRxX8OSgVzqdt6XJkXhy/BGq3p2JKCBca
X-Google-Smtp-Source: 
 ABdhPJzG5dQ25AEAekl08FiFGtypZXBVymrfUNGigno6wQ+RrcQws9z9KDT7tHJy/0hrh1UNWZJ5Upr77JBVXAabylE=
X-Received: by 2002:a67:f918:: with SMTP id t24mr134472vsq.73.1639760057692;
 Fri, 17 Dec 2021 08:54:17 -0800 (PST)
MIME-Version: 1.0
References: <16BED60D9AF8ECE2.12270@lists.openembedded.org>
 <dc689a39-6fa3-a839-32a0-653e09b8d448@ilbers.de>
In-Reply-To: <dc689a39-6fa3-a839-32a0-653e09b8d448@ilbers.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 17 Dec 2021 19:54:06 +0300
Message-ID: 
 <CANNYZj9-NcL+gjdnvZAAUWWyL3V4nkwOXefaZ=fCryo4bqoHjQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] process: Do not mix stderr with stdout
To: Anton Mikanovich <amikan@ilbers.de>
Cc: Baurzhan Ismagulov <ibr@ilbers.de>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000c1749a05d35a63ef"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Dec 2021 16:54:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13191

--000000000000c1749a05d35a63ef
Content-Type: text/plain; charset="UTF-8"

It helps if you describe the problem that occurs without the patch and how
it can be observed.

Ale

On Fri 17. Dec 2021 at 19.43, Anton Mikanovich <amikan@ilbers.de> wrote:

> 08.12.2021 19:57, Anton Mikanovich wrote:
> > We should not redirect stderr to stdout if we need to get separated
> > stdout and stderr contents from Popen.communicate() later.
> >
> > Signed-off-by: Anton Mikanovich <amikan@ilbers.de>
> > ---
> >   lib/bb/process.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/process.py b/lib/bb/process.py
> > index d5a1775f..af5d804a 100644
> > --- a/lib/bb/process.py
> > +++ b/lib/bb/process.py
> > @@ -60,7 +60,7 @@ class Popen(subprocess.Popen):
> >           "close_fds": True,
> >           "preexec_fn": subprocess_setup,
> >           "stdout": subprocess.PIPE,
> > -        "stderr": subprocess.STDOUT,
> > +        "stderr": subprocess.PIPE,
> >           "stdin": subprocess.PIPE,
> >           "shell": False,
> >       }
>
> Can anyone review this change to proof the fix is correct?
>
> --
> Anton Mikanovich
> Promwad Ltd.
> External service provider of ilbers GmbH
> Maria-Merian-Str. 8
> 85521 Ottobrunn, Germany
> +49 (89) 122 67 24-0
> Commercial register Munich, HRB 214197
> General Manager: Baurzhan Ismagulov
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13190):
> https://lists.openembedded.org/g/bitbake-devel/message/13190
> Mute This Topic: https://lists.openembedded.org/mt/87592650/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000c1749a05d35a63ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It helps if you describe the problem that occurs without =
the patch and how it can be observed.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Ale=C2=A0</div><div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri 17. Dec 2021 at 19.43, Anton Mikanovic=
h &lt;<a href=3D"mailto:amikan@ilbers.de">amikan@ilbers.de</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left=
-color:rgb(204,204,204)">08.12.2021 19:57, Anton Mikanovich wrote:<br>
&gt; We should not redirect stderr to stdout if we need to get separated<br=
>
&gt; stdout and stderr contents from Popen.communicate() later.<br>
&gt;<br>
&gt; Signed-off-by: Anton Mikanovich &lt;<a href=3D"mailto:amikan@ilbers.de=
" target=3D"_blank">amikan@ilbers.de</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/bb/process.py | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/lib/bb/process.py b/lib/bb/process.py<br>
&gt; index d5a1775f..af5d804a 100644<br>
&gt; --- a/lib/bb/process.py<br>
&gt; +++ b/lib/bb/process.py<br>
&gt; @@ -60,7 +60,7 @@ class Popen(subprocess.Popen):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;close_fds&quot;: True,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;preexec_fn&quot;: subpro=
cess_setup,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;stdout&quot;: subprocess=
.PIPE,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;stderr&quot;: subprocess.STDOUT,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;stderr&quot;: subprocess.PIPE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;stdin&quot;: subprocess.=
PIPE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;shell&quot;: False,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
Can anyone review this change to proof the fix is correct?<br>
<br>
-- <br>
Anton Mikanovich<br>
Promwad Ltd.<br>
External service provider of ilbers GmbH<br>
Maria-Merian-Str. 8<br>
85521 Ottobrunn, Germany<br>
+49 (89) 122 67 24-0<br>
Commercial register Munich, HRB 214197<br>
General Manager: Baurzhan Ismagulov<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13190): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13190" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13190</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/87592650/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/87592650/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000c1749a05d35a63ef--


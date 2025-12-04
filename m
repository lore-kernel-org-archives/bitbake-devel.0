Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBB7D1F9D0
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 11:57:45 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41227.1764847184983872048
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Dec 2025 03:19:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ANe/WBn5;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: swami310@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2dcdde65bso125820585a.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Dec 2025 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764847184; x=1765451984; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2IawvnT7jJzI8Tf2k/z3H5Bq3M6jfdWnvvvFNlv6G9g=;
        b=ANe/WBn5lpnlFdbSa+V4ENbqaqquLI5uw3r5pkUUu5Oj8ut+oF3xgSobIh1YunixUd
         BtTyyeXJjgTPScWH2xuK/2BwCfryl0+HOr+pM8RY3upmfFjRsBld11+9ExF8sPto/5zZ
         vsMNwmKSWWXpiKr/Tkp4TQCD7BJSEsbUQMp0jXYph7Mh4tetBbSv9+tbnUMvKQsGaT9S
         JAVYqq6sKbMcKxi3kK+GWmzVy6Vk4xjs6se/8mZ1HnbmEDyITuwwnNWQfK093O7ON/FU
         hYWtYcygnhU98XvtflYygCqyi+sL9a2sQjZEtqXGHictt0YBYLvJf+3gtUNJ5H8Xm36H
         Y1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764847184; x=1765451984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IawvnT7jJzI8Tf2k/z3H5Bq3M6jfdWnvvvFNlv6G9g=;
        b=d4XdS1zDC/3+ZgFp2qUYVwQiQpO2ov6dyKkrgIsmBjW8tYp8WtgEO/u5T65Ua/t8gq
         kCrI/jFRxR/340hpZ+OF6KBdtd4fCPNFEAI+xZPeD6PMjdjkKOc4jePsL6jov9mOQyTX
         lK8jx31/gXkX/xLhZ3MrWTfXKpHjecpp0HcNvjYUqqKtsKjHdxf20Uu0TsxZesxba2hN
         FtZxThr8n1GgY2mYx5D0vbfEDi2LOMqCiIGU2Lp1iwsaH2NrflhGzZVeMNmmYtLIBrak
         02RI6pw+CskJb1ncfoLDxUbU0b7j2ppDBhonccn6T7wzEzkd9VbQzwJ6phFDHtwQSMMI
         EfiA==
X-Gm-Message-State: AOJu0Yyp4dALj12NASsOH0fe7NGN8f68zDBERl5vDkRpMeDHwlux2UWj
	P6w8qfqLELQyUzQNZ0IIvBvk+nL1Ag54P04peCkMH633dq04z+OCZa6opS6R12EHPPOAaLKeAmQ
	JIqpwgmhqA8wQtitAoeO6fTtHNhF6yXHXclmZ
X-Gm-Gg: ASbGncsrnoUNffjVCi/Zwt5o+QXonD+IfxsJmLmCtHcfmjPcEDSSpIVRsf6C6dqxM1l
	V2SE9sC+XskRKtE2/2o2c55xO8g2Wx+yGrLHZdCXzunJAyuP1f6zdXxcuUf5ItAYcJan8KcnThW
	qpp5LV8B8ZGkQpA9vJdCwQFJcsScBVhE6aOe/TYPj4vfWoi+6NEz0gON1Zqvw2a2ThdQNTnlnvt
	79yLo+V+O8NSnJuVaQKkumFNHYVhOq2A/55TUv4A8Rnk22ZskiLy1XCSl++WrE4M6m7MRv3dZ7/
	Ab76QA==
X-Google-Smtp-Source: AGHT+IE6B1egreK8b78zu49TLI5AjxMgFxa/9Fu6EbNc7BpEnj1OmU8ZmejBU5qxuuHi3We4T03XBkDuTbqfcrd9sHI=
X-Received: by 2002:a05:620a:3952:b0:8b2:3371:e9d6 with SMTP id
 af79cd13be357-8b6181d4a74mr331098685a.62.1764847183741; Thu, 04 Dec 2025
 03:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20251204002531.7660-1-swami310@gmail.com> <af10c84c-1bda-42f4-ace0-74e7d3306cfb@rootcommit.com>
In-Reply-To: <af10c84c-1bda-42f4-ace0-74e7d3306cfb@rootcommit.com>
From: "Swami" <swami310@gmail.com>
Date: Thu, 4 Dec 2025 16:49:31 +0530
X-Gm-Features: AWmQ_blP9vjmCYdiybcdGhHbKxnoobVfPVCnXRcLyqi0Mvxni6Q11L1TCSgzpys
Message-ID: <CA+-_CqnmcJ1txe-AuECK-sJ+N-+itruvAtQAkpNPQh4ckhPFFw@mail.gmail.com>
Subject: Re: [PATCH v5] bitbake-user-manual: Documenting BB_CMDLINE
To: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000078481d06451e8161"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Dec 2025 11:57:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18538

--00000000000078481d06451e8161
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Michael,
I will do the changes and submit a new patch.
I picked up documentation assuming it would be easy :)
Many thanks to you,Antonin, for bearing with my endless patches for such a
small change.
On the positive side, I am getting comfortable with the steps by this
repetition.
Unfortunately , that is adding to much back and forth
Hope I can nail it with the next patch.

regards
Swami

On Thu, Dec 4, 2025 at 4:24=E2=80=AFPM Michael Opdenacker <
michael.opdenacker@rootcommit.com> wrote:

> Hi Swani
>
> Thanks for the update!
>
> On 12/4/25 01:25, Swami wrote:
> > Add documentation for the internal read-only variable :term:`BB_CMDLINE=
`.
> > Fixes [YOCTO #15746]
> > Signed-off-by: Swaminathan K <swami310@gmail.com>
> > ---
> >   doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 +++=
+
> >   1 file changed, 4 insertions(+)
> >
> > diff --git
> a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > index 734c7858a..00b28519a 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > @@ -116,6 +116,10 @@ overview of their function and contents.
> >         Specifies if SSL certificates should be checked when fetching.
> The default
> >         value is ``1`` and certificates are not checked if the value is
> set to ``0``.
> >
> > +   :term:`BB_CMDLINE`
> > +      :term:`BB_CMDLINE` is an internal variable and is read-only. It
> captures the exact
> > +      command line used for the current invocation of BitBake.
> > +
>
>
> Oops, you have unnecessary spaces in your last line. Please remove them.
> My editor flags those and this is distracting for a reviewer.
> Unless Antonin prefers to fix this by himself.
>
> If you send a V6, you can also move "the exact" to the next line.
> Otherwise, your line is longer than 80
> characters and it also stands out a little bit.
>
> Sorry, documentation patches are the most difficult ones =F0=9F=98=85
> Thanks for your patience!
> Cheers
> Michael.
>
> --
> Michael Opdenacker
> Root Commit
> Yocto Project and OpenEmbedded Training course - Learn by doing:
> https://rootcommit.com/training/yocto/
>
>

--00000000000078481d06451e8161
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Michael,</div><div>I will do the changes and s=
ubmit a new patch.</div><div>I picked up documentation assuming it would be=
 easy :)</div><div>Many thanks to you,Antonin, for bearing with my endless =
patches for such a small change.</div><div>On the positive side, I am getti=
ng comfortable with the steps by this repetition.=C2=A0</div><div>Unfortuna=
tely , that is adding to much back and forth</div><div>Hope I can nail it w=
ith the next patch.</div><div><br></div><div>regards</div><div>Swami</div><=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Dec 4, 2025 at 4:24=E2=80=AFPM Michael Opdenac=
ker &lt;<a href=3D"mailto:michael.opdenacker@rootcommit.com">michael.opdena=
cker@rootcommit.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hi Swani<br>
<br>
Thanks for the update!<br>
<br>
On 12/4/25 01:25, Swami wrote:<br>
&gt; Add documentation for the internal read-only variable :term:`BB_CMDLIN=
E`.<br>
&gt; Fixes [YOCTO #15746]<br>
&gt; Signed-off-by: Swaminathan K &lt;<a href=3D"mailto:swami310@gmail.com"=
 target=3D"_blank">swami310@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0doc/bitbake-user-manual/bitbake-user-manual-ref-variables.=
rst | 4 ++++<br>
&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=
.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
&gt; index 734c7858a..00b28519a 100644<br>
&gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt; @@ -116,6 +116,10 @@ overview of their function and contents.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Specifies if SSL certificates should =
be checked when fetching. The default<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value is ``1`` and certificates are n=
ot checked if the value is set to ``0``.<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0:term:`BB_CMDLINE`<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 :term:`BB_CMDLINE` is an internal variable and i=
s read-only. It captures the exact<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 command line used for the current invocation of =
BitBake.<br>
&gt; +<br>
<br>
<br>
Oops, you have unnecessary spaces in your last line. Please remove them. <b=
r>
My editor flags those and this is distracting for a reviewer.<br>
Unless Antonin prefers to fix this by himself.<br>
<br>
If you send a V6, you can also move &quot;the exact&quot; to the next line.=
 <br>
Otherwise, your line is longer than 80<br>
characters and it also stands out a little bit.<br>
<br>
Sorry, documentation patches are the most difficult ones =F0=9F=98=85<br>
Thanks for your patience!<br>
Cheers<br>
Michael.<br>
<br>
-- <br>
Michael Opdenacker<br>
Root Commit<br>
Yocto Project and OpenEmbedded Training course - Learn by doing:<br>
<a href=3D"https://rootcommit.com/training/yocto/" rel=3D"noreferrer" targe=
t=3D"_blank">https://rootcommit.com/training/yocto/</a><br>
<br>
</blockquote></div>

--00000000000078481d06451e8161--


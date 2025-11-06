Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED374CD13D9
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 12:28:57 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14190.1762432128886561917
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 04:28:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bd0NGwmc;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-880499b2bc7so9000966d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 04:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762432128; x=1763036928; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XF9mAKlakanKfjgkYViWHEpZSj65ghe5xML/gD446qI=;
        b=bd0NGwmcsipZNROaQ0xkAmiNXIcGNLr73MMmqNitBOjxW41bkfo9t2Jng09nFLNRxR
         r6QmV0cWtvDF/Jf4Vi4KD4ik4t0/EPJezENf22PDauVRz9ZgBjZJj+A20mw3J4LHyntI
         hOivZ6A/bffFLIAcs2FFSMfRhT2AG2X6H/rblFdn+DbJZ79dpIgBeq1F8qtWvvGjbt6c
         d85DJDjbg2uRQOudF/zPCjgS8sr1Kx2uWKTIwzLvOwi2RJC+mzGwccrzwnGT/dYjppkl
         rkOQAjijNLNLTNV/3gMiMEv6JoRHn9nP69n+s8TapO4g0uy9L05cruQTfUfxGhErHjAF
         pG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762432128; x=1763036928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XF9mAKlakanKfjgkYViWHEpZSj65ghe5xML/gD446qI=;
        b=CX2NtUqVHPHo9Gey9CVkuoCdSC4YlnF1Uc8ipTcSHoRu3dJ2QNXXVAu8vQDm5Ggs4t
         mGmhMLutodrf5ns+tSm9tRxE/+P7xBZMa30OFj4JmSKa1R1Jo9ZBaRX+CoepuGw5zfmj
         9dv3mPBipionR2S643961kNl5KFYKduajwwedbp9u7tS90iN+oY/8sOFbPgCoX9pGLg+
         DD7P+SHKUEDUA54l3mjfWygR6goaiLMD0fWhAh3iLZCLzJqf2cSU30/G2q3BowSspuQK
         /3iLCnwQG+tkZFCJRVrG9G9JlP6O9vg/jGuOBLR4Vu3iPIJJj1Qd+ro+sPbgdjmELOFg
         8i8Q==
X-Gm-Message-State: AOJu0Yy7f28wU0ah0jfL3eaB9EsUPtSB/dWvmqFzdSQ4+oAAJww+WWZq
	y2H0idWKfTgtW48+NHSLAWjdoI8biEmHJbNqdKL65hqY5+i9Xv7ERBINu49DNcHdmhiWr7+Ug/V
	a4v6FbvCgf5F6qCfBnPUGnNHSCT5vGHY=
X-Gm-Gg: ASbGnctDyMIoemLNGQABVggpP1lWzF0wK4wIuL7MBEekdRGCm403cMFP7BgvtLxewZ7
	xH75rWDj+9nmO/FXi+dQBT972l/zqEsRLNGYnKBwwFzjNJ1wCdneVPA+IxDwf5FicXEhXKVPbzy
	8DIrLy7ugDED6UKWe54jodFNc6z/rTwcO4TRVFd0uEE8l+bukPjx8Xbtdy46CcD4KmacSD6FV+o
	n3UHBSiQFanHfx7qN+Hbrt6JquHdCRH6OahUFF/HVpretY0RUzRt2nTSj/Q+gDRwS9OM2XVXMFJ
	eRFdo7cg1fKlqTA=
X-Google-Smtp-Source: AGHT+IFBFX5l94Z5IuJHYb2CsKMnsWKE8HwDOCDv21pmU2PVyaPoGGN6LEjmQipv0xGSRSyF6mumjA6EafPDUaPKgn8=
X-Received: by 2002:a05:6214:626:b0:880:38ba:a4d9 with SMTP id
 6a1803df08f44-880711df737mr79111366d6.67.1762432127617; Thu, 06 Nov 2025
 04:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20251106114714.918370-1-alex.kanavin@gmail.com> <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com>
In-Reply-To: <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 6 Nov 2025 13:28:36 +0100
X-Gm-Features: AWmQ_blaaNoneuzp5MbvtL2Mcc3z0TE64W2hH2HED9UE1oSDNLhulgZTm3kqDcs
Message-ID: <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="000000000000e84ff10642ec3486"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 12:28:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18288

--000000000000e84ff10642ec3486
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu 6. Nov 2025 at 13.11, Antonin Godard <antonin.godard@bootlin.com>
wrote:

> Hi,
>
> On Thu Nov 6, 2025 at 12:47 PM CET, Alexander Kanavin via
> lists.openembedded.org wrote:
> > From: Alexander Kanavin <alex@linutronix.de>
> >
> > {THISDIR} is a special value token that can be used in the list of
> enabled
> > layers to specify the layer location relative to the confguration file:
> >
> https://git.openembedded.org/bitbake/commit/?id=3Db3153be29de8b8570b0c184=
369bd41f4c646cf92
> >
> > This replaces the token with an explicit separate keyword for such
> layers:
> > so that special processing to determine the final value can be avoided,
> and
> > the feature can be formalized in the json schema:
> >
> > instead of
> >    "bb-layers": [
> >         "{THISDIR}/meta-my-project"
> >     ]
> >
> > this allows
> >    "bb-layers-relative-to-this-file": [
>
> Can I suggest naming it "bb-layers-local"?
> "bb-layers-relative-to-this-file"
> feels bit overwhelming, I think with associated documentation users will =
be
> able to figure what "local" stands for in this case.



=E2=80=98Local=E2=80=99 implies the path can be absolute, which is not supp=
orted, and it
doesn=E2=80=99t suggest what the path should be relative to. I=E2=80=99d ra=
ther make it
longer but clearer.



>
> I can't help but wonder: why is there a need to have a separate keyword?
> Can't
> bitbake-setup do:
>
>   for <layer> in bb-layers; do
>     if <layer> is not in <sources>; then
>       if <layer> is found next to the .conf.json; then
>         use this local layer
>       else
>         error
>       fi
>     else
>       use setup/layers/<layer>
>     fi
>   done
>
> ?



With hidden logic like this it=E2=80=99s not clear by reading the config wh=
at is
local and what isn=E2=80=99t. There=E2=80=99s also a possibility of paths c=
lashing.

Alex

>

--000000000000e84ff10642ec3486
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">On Thu 6. Nov 2025 at 13.11, Antonin Godard &lt;<a href=
=3D"mailto:antonin.godard@bootlin.com">antonin.godard@bootlin.com</a>&gt; w=
rote:<br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_cont=
ainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-=
color:rgb(204,204,204)">Hi,<br>
<br>
On Thu Nov 6, 2025 at 12:47 PM CET, Alexander Kanavin via <a href=3D"http:/=
/lists.openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openemb=
edded.org</a> wrote:<br>
&gt; From: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" targ=
et=3D"_blank">alex@linutronix.de</a>&gt;<br>
&gt;<br>
&gt; {THISDIR} is a special value token that can be used in the list of ena=
bled<br>
&gt; layers to specify the layer location relative to the confguration file=
:<br>
&gt; <a href=3D"https://git.openembedded.org/bitbake/commit/?id=3Db3153be29=
de8b8570b0c184369bd41f4c646cf92" rel=3D"noreferrer" target=3D"_blank">https=
://git.openembedded.org/bitbake/commit/?id=3Db3153be29de8b8570b0c184369bd41=
f4c646cf92</a><br>
&gt;<br>
&gt; This replaces the token with an explicit separate keyword for such lay=
ers:<br>
&gt; so that special processing to determine the final value can be avoided=
, and<br>
&gt; the feature can be formalized in the json schema:<br>
&gt;<br>
&gt; instead of<br>
&gt;=C2=A0 =C2=A0 &quot;bb-layers&quot;: [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;{THISDIR}/meta-my-project&quot;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0]<br>
&gt;<br>
&gt; this allows<br>
&gt;=C2=A0 =C2=A0 &quot;bb-layers-relative-to-this-file&quot;: [<br>
<br>
Can I suggest naming it &quot;bb-layers-local&quot;? &quot;bb-layers-relati=
ve-to-this-file&quot;<br>
feels bit overwhelming, I think with associated documentation users will be=
<br>
able to figure what &quot;local&quot; stands for in this case.</blockquote>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto">=
=E2=80=98Local=E2=80=99 implies the path can be absolute, which is not supp=
orted, and it doesn=E2=80=99t suggest what the path should be relative to. =
I=E2=80=99d rather make it longer but clearer.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;pad=
ding-left:1ex;border-left-color:rgb(204,204,204)" dir=3D"auto"><br>
<br>
I can&#39;t help but wonder: why is there a need to have a separate keyword=
? Can&#39;t<br>
bitbake-setup do:<br>
<br>
=C2=A0 for &lt;layer&gt; in bb-layers; do<br>
=C2=A0 =C2=A0 if &lt;layer&gt; is not in &lt;sources&gt;; then <br>
=C2=A0 =C2=A0 =C2=A0 if &lt;layer&gt; is found next to the .conf.json; then=
 <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 use this local layer<br>
=C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 error<br>
=C2=A0 =C2=A0 =C2=A0 fi<br>
=C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 use setup/layers/&lt;layer&gt;<br>
=C2=A0 =C2=A0 fi<br>
=C2=A0 done<br>
<br>
?</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">With hidden logic like this it=E2=80=99s not clear by reading =
the config what is local and what isn=E2=80=99t. There=E2=80=99s also a pos=
sibility of paths clashing.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Alex=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex=
;border-left-color:rgb(204,204,204)" dir=3D"auto"></blockquote></div></div>

--000000000000e84ff10642ec3486--


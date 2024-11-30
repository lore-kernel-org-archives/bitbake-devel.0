Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94019D735F8
	for <webhook@archiver.kernel.org>; Sat, 30 Nov 2024 08:12:00 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web11.131027.1732954319596710368
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 30 Nov 2024 00:11:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JZEO2ot3;
 spf=pass (domain: gmail.com, ip: 209.85.222.182, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6952e2257so15739885a.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 30 Nov 2024 00:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732954318; x=1733559118; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9iBHZrIuzzfBBGFfIppTdLJEZFbzCmHzNsHFZhlJqXw=;
        b=JZEO2ot3kycjJzU9mmAo/DxeU0m9LYG0aa+nHQbgTBbT3899Ycui5YNcgFSPr72WPt
         iuiYuD7RF8Dh90lxhn2GyOmjBRf72XkFiXu0T9cvI+ry9GFDBieChovfdsSjehpIaFNz
         ZmlldHGyGrEHFEg/JUOjrmDm7W8ZzpGVfk/Ra0h3SejbcKXy03gKYTSkNjH6z12jZPa5
         k65XNt9gKMYjlupLQleniqeU2GSR23+jG3dHIlEPBj/IyxaP/dOEhBys0uzc1oq9cd5R
         b/AfIjnzI24/kg9VsE2ULxMC79+Qswopq+IzOEdRsY1QwTTXFldIPCRl5/mB2c5IY11i
         VuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732954318; x=1733559118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iBHZrIuzzfBBGFfIppTdLJEZFbzCmHzNsHFZhlJqXw=;
        b=FfUoNA58ydq8/PHCjLeFYIoSntIFfpW1ADpE11Z2FXEvpmLGofk0O40BSauT3PswLM
         c0V1PLNM5Lurvrn0YW6xa1sx1St56RW2wTvy8qxRgf1/c3dUwGvcWRZtEGperBqKLlhf
         B+g0Y/H+uNPjssBuAzkQx2B6VEQ8hqy4ga8B5I1mycK98OzL8fLLDlZv/MHOc0CkBxb9
         nMhXJ+N4C6lIvEVrjKJo/gvWdlpM6ffFuuXdJs6VWawM8Q/OJBKUvm1xo3mGD++zIxTG
         AJNbTUCDDZfi4RKAraV9H0rTl0GzUsdPf4lH82IOQJs3xMNpIhnJiIebF59a0Ex+bgsM
         4C8A==
X-Gm-Message-State: AOJu0Yym8C6e8oBNy38fGBotIaDkYgai5E0a2os5SQ9Grs22ONTvOGSR
	x31FPE4rXLq7SobnkFvJwhyoRweb06VeSnYk8RnN/uLXeCgSC8o65aGuC0wL4fXndBvnf1JthWi
	qu6clhi5QsBYSlkssIkpT/Zw9ngBvMA==
X-Gm-Gg: ASbGncv4BN58uJdgMWi770BYlcx2p3BHbE+BAxraSptwb6gJQxadaRODqE2oPhUPAL1
	Xw7HmhNEGUUrq6Ne5xDYaKB8IrAtXntrPNP5yyqx7kJdyK2QWtLA6YhZkygUfwz4=
X-Google-Smtp-Source: AGHT+IHZbODlIJZ5iJEBszpP2PHvjG6tEepE5P7ucdBIz1JaOmXnkALUiDdc1ltlOVtaxcXelAYP8J0jtkbaKr2Fju0=
X-Received: by 2002:a05:620a:260b:b0:7b1:49a4:d1df with SMTP id
 af79cd13be357-7b67c48229bmr2070823685a.53.1732954318600; Sat, 30 Nov 2024
 00:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20241129125524.131362-1-richard.purdie@linuxfoundation.org>
 <CANNYZj_sJuUFJc9V37yhvjeFukqQ-A7GRC5SUwc+WMM24bvSeA@mail.gmail.com> <ae9a07452b8df67f44ead3a83d177e57cf4034c0.camel@linuxfoundation.org>
In-Reply-To: <ae9a07452b8df67f44ead3a83d177e57cf4034c0.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 30 Nov 2024 09:11:47 +0100
Message-ID: <CANNYZj_T9_hGTWOBF1ak8LM26tGZKeJ5cy=fkFi2W2uwY-kMMQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Fix performance of multiconfigs
 with large overlap
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000009283e906281cdeb6"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 30 Nov 2024 08:12:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16854

--0000000000009283e906281cdeb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for looking into this. I=E2=80=99m trying to keep weekends relativel=
y yocto
free (at least not start bitbake), so I=E2=80=99ll check this on Monday.

Alex

On Fri 29. Nov 2024 at 19.54, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2024-11-29 at 14:12 +0100, Alexander Kanavin wrote:
> > I noticed that particularly 'bitbake core-image-ptest-all' tends to
> > sit for significant amount of time without spawning tasks. I
> > cherry-picked this patch and it doesn't seem to be helping :(
>
> Try:
>
>
> https://git.yoctoproject.org/poky/commit/?h=3Dmaster-next&id=3D6522505769=
cea6bf96739469e64ec3a0a99be2b4
>
> since the issue there appears to be a different performance bottleneck.
>
> Cheers,
>
> Richard
>

--0000000000009283e906281cdeb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks for looking into this. I=E2=80=99m trying to keep =
weekends relatively yocto free (at least not start bitbake), so I=E2=80=99l=
l check this on Monday.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Alex=C2=A0</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri 29. Nov 2024 at 19.54, Richard Purdie &lt;<a href=3D=
"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-=
left:1ex;border-left-color:rgb(204,204,204)">On Fri, 2024-11-29 at 14:12 +0=
100, Alexander Kanavin wrote:<br>
&gt; I noticed that particularly &#39;bitbake core-image-ptest-all&#39; ten=
ds to<br>
&gt; sit for significant amount of time without spawning tasks. I<br>
&gt; cherry-picked this patch and it doesn&#39;t seem to be helping :(<br>
<br>
Try:<br>
<br>
<a href=3D"https://git.yoctoproject.org/poky/commit/?h=3Dmaster-next&amp;id=
=3D6522505769cea6bf96739469e64ec3a0a99be2b4" rel=3D"noreferrer" target=3D"_=
blank">https://git.yoctoproject.org/poky/commit/?h=3Dmaster-next&amp;id=3D6=
522505769cea6bf96739469e64ec3a0a99be2b4</a><br>
<br>
since the issue there appears to be a different performance bottleneck.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div></div>

--0000000000009283e906281cdeb6--


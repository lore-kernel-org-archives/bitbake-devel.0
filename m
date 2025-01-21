Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B9C02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 17:29:24 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web10.21608.1737480563373523954
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 09:29:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PNT29Bf0;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e1a41935c3so82135776d6.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737480562; x=1738085362; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Nhr78lCcfqVBZlO/vqHQYUWD1x/jnbn1AxXaRHB2jE=;
        b=PNT29Bf0CZ59txya1InJsgLSF/dNAzfin6NVH3pKAPQexdIwIngia189Tjl/OL0B2X
         L/w4Zrp5j07Px7tM+mr9Di8xGWRe8p3BRWylWZX+BPQoPJKLgNTWaMP9EncC8zy2eBjP
         /KpthCzf+iHRUIszmJlaPDw1oHy4SD/ARZhsFk1eiqBqNr73n1lKNFyQRCH8HtU8BKPy
         OLrpvS9CkI7PhZYGbPcKWUoAM9mX+ogFM39DoP28wLpjBNhiNidv6WWy0/nGmWAZpxXR
         nS/uX4+cSXLC4LZFn+5Cr5++NukRwlEJZQEC72X7c2PPHTggKv4cVIUWXo1pAhUkXDmR
         MTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737480562; x=1738085362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Nhr78lCcfqVBZlO/vqHQYUWD1x/jnbn1AxXaRHB2jE=;
        b=YLeC2BN9PMyT/5jdVMmN11OnxtqvwlGUcxm/UJYP/iemBnevDFZ5c7Wv02PQfBrJcC
         4KLDpik+qSXP0ALGpRGIDe4g4d5PUS22zYpw0EzWY+tSBy6nGNqKX+e5N+UJyAUS/slN
         Bo4ZqrBeUiQ9R23WRCbWmrDCmOpu0IznBVv8M6CwsUpgAc7v2aFDlW6A4Pd00s3GsNsD
         Z0tDz0CZu+YIZ/jFXWE2uV6CpUeKgDgGL0bpYH82ZoXyXh6JY42EMbM6aSXt7DZDlAKY
         ea4bQSDWWmn9i13jczSwc6auKYv7EIOTxzrKLGBAoDkQWlSY4/4dM7U0LumkNwFAvh4U
         51+A==
X-Gm-Message-State: AOJu0Yx6OpTDMxWr0sAJchTFIoB/o9W3APzzsdAKKis7/y6hw2Gud9Y5
	yIpKVu2bI5tWoCXtW5bvtDmeaDTBpaif3kqb1ETkpyA9Qcc79KRu5LVcK8c/yTTx3E5qD6Om/h9
	E+PBdCYhkruuMw85yzCW3xp5ApTo=
X-Gm-Gg: ASbGncuBGVULyF3egHeTsjAbxint/sKYiKeP2b0lg7XGvxm4S8Sc7pPCxtkJqv8U5+P
	hIRsylLwOox/1/Y23yipgf0/yAym9D8MEk2s9f9OhhPqF1PMJYfzLQRdHjWJ86i2ZZMN3XBfMBU
	TlpULYRQ==
X-Google-Smtp-Source: AGHT+IFp9kQwORR5qC3/I8lG16ddm4DOFIOMV7AXmct4tsMrw8KcUkQ7iUwwsVDuwOXw8zFqlUNz19121AeFTbmryBc=
X-Received: by 2002:a05:6214:1308:b0:6d4:1680:612d with SMTP id
 6a1803df08f44-6e1b19dee5dmr278773816d6.0.1737480562317; Tue, 21 Jan 2025
 09:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20241014125406.2322310-1-alex.kanavin@gmail.com> <D92E13F2-8973-407A-801E-D743AE755FD9@arm.com>
In-Reply-To: <D92E13F2-8973-407A-801E-D743AE755FD9@arm.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 21 Jan 2025 18:29:11 +0100
X-Gm-Features: AbW1kvYZsSW85tgdl3lxM_1CrweP_lZXV7Lo0PbpT1TxXYtuJYKrm0znFV6R9IM
Message-ID: <CANNYZj8tf_Gxwp_0GHgj+a0gvh+XGL1XxSVdZ2Erx+Q9Nzp6Aw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget.py: use default wget
 user-agent in upstream version checks
To: Ross Burton <ross.burton@arm.com>
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000b8a11b062c3ab7be"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 17:29:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17045

--000000000000b8a11b062c3ab7be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This has been discussed before. Taking things from mercurial with wget is
explicitly disallowed and there=E2=80=99s an official location for those ta=
rballs.
I=E2=80=99ll find that thread when I get to a real computer.

Alex

On Tue 21. Jan 2025 at 18.03, Ross Burton <Ross.Burton@arm.com> wrote:

> On 14 Oct 2024, at 13:54, Alexander Kanavin via lists.openembedded.org
> <alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:
> >
> > From: Alexander Kanavin <alex@linutronix.de>
> >
> > This has been set to various mozilla versions from this point onwards
> without
> > explanation or specific examples:
> >
> https://git.yoctoproject.org/poky/commit/?h=3Dmaster-next&id=3Dba06cc8943=
d021f406c3d292ce415b77319ca5c6
> >
> > However, sourceforge has recently banned the current 'fake mozilla'
> version
> > we've been supplying, resulting in broken version checks:
>
> Of course for fun we=E2=80=99ve just discovered that the openjdk mercuria=
l
> repository rejects wget/curl and you need to fake a browser U-A to downlo=
ad
> files=E2=80=A6
>
> Ross

--000000000000b8a11b062c3ab7be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">This has been discussed before. Taking things from mercur=
ial with wget is explicitly disallowed and there=E2=80=99s an official loca=
tion for those tarballs. I=E2=80=99ll find that thread when I get to a real=
 computer.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Alex</div><di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue 21. Jan 2025 at 18.03, Ross Burton &lt;<a href=3D"=
mailto:Ross.Burton@arm.com">Ross.Burton@arm.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(=
204,204,204)">On 14 Oct 2024, at 13:54, Alexander Kanavin via <a href=3D"ht=
tp://lists.openembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.ope=
nembedded.org</a> &lt;alex.kanavin=3D<a href=3D"mailto:gmail.com@lists.open=
embedded.org" target=3D"_blank">gmail.com@lists.openembedded.org</a>&gt; wr=
ote:<br>
&gt; <br>
&gt; From: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" targ=
et=3D"_blank">alex@linutronix.de</a>&gt;<br>
&gt; <br>
&gt; This has been set to various mozilla versions from this point onwards =
without<br>
&gt; explanation or specific examples:<br>
&gt; <a href=3D"https://git.yoctoproject.org/poky/commit/?h=3Dmaster-next&a=
mp;id=3Dba06cc8943d021f406c3d292ce415b77319ca5c6" rel=3D"noreferrer" target=
=3D"_blank">https://git.yoctoproject.org/poky/commit/?h=3Dmaster-next&amp;i=
d=3Dba06cc8943d021f406c3d292ce415b77319ca5c6</a><br>
&gt; <br>
&gt; However, sourceforge has recently banned the current &#39;fake mozilla=
&#39; version<br>
&gt; we&#39;ve been supplying, resulting in broken version checks:<br>
<br>
Of course for fun we=E2=80=99ve just discovered that the openjdk mercurial =
repository rejects wget/curl and you need to fake a browser U-A to download=
 files=E2=80=A6<br>
<br>
Ross</blockquote></div></div>

--000000000000b8a11b062c3ab7be--


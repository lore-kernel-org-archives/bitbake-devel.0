Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C35C54E76
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 12:48:19 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.49321.1700484489581087601
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 04:48:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=F2pfppsn;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so56648891fa.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 04:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700484488; x=1701089288; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoNDkYMbLKyqLx4tYXcyHRr4fe8sQr96UxkIKge2gjM=;
        b=F2pfppsnl9mJMgyTGhLXKxcL9DBSt2hETij6AXO3ahnNAaaAnnnXurOrDWHCeLaC3y
         ztA+8g27rp5YBj1IRErJ/TqZdyFvRgV5g5RKmz1Ha3WNPdJjWt2SWFibEe+1an+afFe3
         dP/3ndqdSSoBOu6xtOja4HDcSgK8EGE7cVyIBfAWAazSuLL1NPoZZ8dtm++M/k1fYFBX
         hMowJ9bqeWt7F5fpr6f99KrnJ5tPb07piR05Z1Cu6C4M+RRn7wOLjNjzXpOYCvk198B4
         5h/g210Q/TQqBGBigNqNgzgjxPzdKdHPU2Pxv56TYAhSnuyGEDWcBRdONhR6SkcFjf7I
         jL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700484488; x=1701089288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoNDkYMbLKyqLx4tYXcyHRr4fe8sQr96UxkIKge2gjM=;
        b=ETkqszqWNIWhCpZnY85eFuH9oyLhSzsrRp+oQyo/1d7VNtit4cU3BTeLGnWbNQt9P/
         4K2MIGsLKDA7sqwMNaMNNhYhLXtrYd3GsgoRgyTpNjJJvHsRIzTsa5mmSwUi7kv+MR7n
         I3dY+ZPxcy22fhxKkky5eDlFXwdV3g5TYvKpI/lW4vOmvUom250bcNK5xumBajYiJMvk
         ZpTyvxT2+ZVEbD/WkJHTva4yAM+SVQTA9qw1emPhqBvB3ZJC3WFKHhr4T03wGqrCXcJT
         ucsj1nm85r1KZiZS0yWZ+huHZ/tUtLL4C5pfPq6QbMSFc6fNtQhGc+nxrmdT560yqhRW
         YWGg==
X-Gm-Message-State: AOJu0YwU/j3S4vUThp8ibwya+dtG7/fsNEOdH2fHFQJXZlWjC9ddJNj+
	CGuEbQXg8+7koxagwyHgO32LIePQ/eRZxYwlXKI=
X-Google-Smtp-Source: AGHT+IGLhCTaKFq2b4y2d1X3vHP+muIzrjgXjFpdG2srQTRC0V2TyDTE3oq4Hslp2WJH7ELMVWryJ3sF/zkJ/KkGK48=
X-Received: by 2002:a2e:8e38:0:b0:2c6:ed5e:bbf0 with SMTP id
 r24-20020a2e8e38000000b002c6ed5ebbf0mr5071016ljk.34.1700484487404; Mon, 20
 Nov 2023 04:48:07 -0800 (PST)
MIME-Version: 1.0
References: <4851356.GXAFRqVoOG@n95hx1g2> <CANNYZj-cc2wDXUODqveROB6Hdpr0CnHoNLt49Nywfcpgs_19xA@mail.gmail.com>
 <2250070.iZASKD2KPV@n95hx1g2>
In-Reply-To: <2250070.iZASKD2KPV@n95hx1g2>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 20 Nov 2023 13:47:56 +0100
Message-ID: <CANNYZj8J+PQmKJOSzn=_CMJ4CGvo93ghArE1QrE4uuSK4qjQFg@mail.gmail.com>
Subject: Re: [bitbake-devel] npm/npmsw fetchers: Support for "offline" builds?
To: Christian Eggers <ceggers@arri.de>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d16145060a94e513"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 12:48:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15535

--000000000000d16145060a94e513
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Nov 2023 at 13:19, Christian Eggers <ceggers@arri.de> wrote:

>
> my intend is to run as few build scripts as possible as long as the build
> machine has access to the internet. For security reasons I would like to
> divide
> the build into two stages, one stage for downloading (with internet access
> enabled)
> and one stage for compiling (without internet access).
>
> While I highly trust the OpenEmbedded/Yocto projects, I fear that single
> upstream
> projects may become targets for supply chain attacks in the future. Running
> the package Makefiles/scripts etc. on a machine (e.g. docker) without
> network
> access reduces the possibility for manipulated packages to retrieve
> internal
> secrets and upload them to the internet.
>
> Are there any other use cases why people want to perform an "offline"
> build?
>

Depending on whether your yocto version is recent enough, all tasks other
than fetch already run with network disabled. You can try it yourself: try
using wget from do_configure, and it's going to fail.

I think you can also set FETCHCMD_npm if you trust host distro vendor
processes (that you can't audit) more than you trust OE build process. Even
then, you still need to trust a compiler to build a compiler.

Alex

--000000000000d16145060a94e513
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, 20 Nov 2023 at 13:19, Christian Eggers &lt;<a href=3D"mailto=
:ceggers@arri.de" target=3D"_blank">ceggers@arri.de</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div><br>my intend =
is to run as few build scripts as possible as long as the build<br>machine =
has access to the internet. For security reasons I would like to divide<br>=
the build into two stages, one stage for downloading (with internet access =
enabled)<br>and one stage for compiling (without internet access).<br><br>W=
hile I highly trust the OpenEmbedded/Yocto projects, I fear that single ups=
tream<br>projects may become targets for supply chain attacks in the future=
. Running<br>the package Makefiles/scripts etc. on a machine (e.g. docker) =
without network<br>access reduces the possibility for manipulated packages =
to retrieve internal<br>secrets and upload them to the internet.<br><br>Are=
 there any other use cases why people want to perform an &quot;offline&quot=
; build?<br></div></div></blockquote></div><div class=3D"gmail_quote"><br><=
/div><div class=3D"gmail_quote">Depending on whether your yocto version is =
recent enough, all tasks other than fetch already run with network disabled=
. You can try it yourself: try using wget from do_configure, and it&#39;s g=
oing to fail.</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail=
_quote">I think you can also set FETCHCMD_npm if you trust host distro vend=
or processes (that you can&#39;t audit) more than you trust OE build proces=
s. Even then, you still need to trust a compiler to build a compiler.<br></=
div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote"></div><=
div class=3D"gmail_quote">Alex<br></div></div>

--000000000000d16145060a94e513--


Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140BECA5FA5
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 16:48:53 +0000 (UTC)
Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.936.1790700526263797052
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Sep 2026 09:48:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=oJDevfAp;
 spf=pass (domain: gmail.com, ip: 74.125.230.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-9142e0b0668so46346156d6.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 09:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790700525; cv=none;
        d=google.com; s=arc-20260327;
        b=so8u3q7mX6bJ7DvlfNaxFmAnrfI1xU0r7kexNAREPdOXU02Ylkl7j8/Z1CInDR+yDE
         Kp5Caq82wtxYM2RXWO3qyCSuKKB/XV5wh9XjRfbr9ThFQDj5Q0i7TTEd9TVEtST8Fo5U
         rylxRtzy8d8mdk+p7UbHXlJzrLgf5NEt8ijt1vzGUZSqflDpZ66QKmToDOfVNWkYNI4V
         cOInIFh7rHCZtRddv++62vOjfY8cG/tV4UrVhoRDkJ01VBIOebQHpthBnlyKrmWD+hum
         +L42Q9bYX/wb84vyqNmx9Zoi27/Cj/OxfazYkPE/2xbsVlTg4mJNh2IsODtUQVIN9yCz
         2KFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aixikbgEWf+rUwEfI6DnZotYPkBOez0gGKCiXjIXlzM=;
        fh=ARmciCSIXj8do7zYeXGxZOaTyWd7jEWYlJk8SPT42H0=;
        b=K0Kw8sMWq0zyXh75puU9i6amFqMbbWMQjsdUPhIDAyE0nNWoM6YiP6U7ZKWvhbNDLr
         UKjuRPmsqZqVROAzrfkzkXVwg8bNxXGEG3KWFvzO9TMB9byUsfds8lPmEMOcrLM+ZoQY
         OHfRToaKJyQgYZQhU9ikKB8V4jrcwwJcER2rgGNnogLnuaqPM5cPkDMPcgXRlXjv3okK
         ofR/VUlb/BJOZtTo1I7nUa3x0US4zeuRakdCTinO60Apnunky+jnxndCyByzJuJijrx1
         CU9Z+kn+uYorSQulgTL1rSN9BC89uoxE4g6kVSqdm6dHNkM8kpC3et2rGY/l9BU7cP7v
         JtTQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790700525; x=1791305325; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aixikbgEWf+rUwEfI6DnZotYPkBOez0gGKCiXjIXlzM=;
        b=oJDevfApKm1wrIhuI8awYEGtL54Tg3W7GSCuCKrMjIFR1WaUkBgndMn0UT5f7IJ1gM
         hV6/vDgSET7yZVpxAJUFvGwuj5gM0YqRiHZvnXkX8ZmUM6N1MfrpTGhUQNsJPpeDmkja
         Y5JTPC5Q2TJSmPaF4SS02nj//BlYUc/p3plcVG9YunUHpp9+TMHhMv+BkL4q94ArtNZI
         FmgZ+tj9eKdID3E8QQ+W8gBOKhdSxRbihvtYgyKgxUPo6ttMTi0gXzi5rW/Rn5KysADm
         85Jsnp4o/Bc91uYpJDK11GrnVsoK7h9Gd7589+Re3wgKojZqn5PNcftNzpZbgIDJrqjm
         EImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790700525; x=1791305325;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aixikbgEWf+rUwEfI6DnZotYPkBOez0gGKCiXjIXlzM=;
        b=CwMqfmXnq3/asxL2d0FqCS2UnaOkQNFleuzfdYTahfL2JdbjUOuijuHIF0F6uyBNTV
         x0dcD3kfKG13Ib68gZ4e/etozBZ+kWgCyEP+HyalERpRUicwmyBCZ8nX8vC+pgty/KU7
         TD/Tej9DuKgRQMEiphQu2iAxWoK5odKUP9gOTJ2+vYsJhdOuTiqvcKRvVa6xzq34hBFf
         WAFP68bQz/ifrqFOZbqRnQR5fGR95zK33kV50jDoGoJfbS3I6L0gGj8fdhdc0nRJcTKS
         uh3fqgsBIVWRnSpq/kL7eJXMi6wuo+Dgx5iIcZyY57xAS9FvhM2NlZrUng/oHaqItpkG
         Kl1g==
X-Gm-Message-State: AFuF++lNtPgM+x2LUYbyamPkaGjp007qEo95c5kuMBFEgzCn/hL9WAxw
	yWS2+Db8z0v5vTSnozhmSLeOHi8Q2CEA44BCgJ92HDQ17u9iPC7nrnbEg6Qbe2hnk+JG/UeW5xR
	ubA1QpDMNCFNokGOSMRUedwe7nX9Jn9c=
X-Gm-Gg: AYBFou29of4RmJ/ohPwbL/b9nXTxvQI3fpmWiD30jLGsQ5gOfHAQCbYcmK5HNLWOtpu
	0y7fsO8lBmSMXnvKG0aw5vXwaSsQd9y0tJKR4wFp7Vjx9+lFMxC6hneXZbTTSy6xXh8qbdBDiCm
	JvQm/4mvfBEvZdgyuTfhVnrcJBKBue2FpbfcQTrryDLyaO+NEmS4YYiurwOjI3Rm8VjOiDtZkSD
	P5rZxV5JfqlpTSsZbD9TM+GurFEuxDEfsNlBnKVC+9HP4czurN0Y0dm2SnhOH2QVfx0aZpnyNsI
	TxhQKDtot1uYfLqJ++AXU8fbk9NQnuEjdJJwF2DJHUPbRoq7xhPx1xCe88G/2gBZEJtIf5PiM4c
	wHo523cneeTjNig==
X-Received: by 2002:a05:6214:5d04:b0:914:1400:9451 with SMTP id
 6a1803df08f44-9142f6e7115mr262715756d6.17.1790700524650; Tue, 29 Sep 2026
 09:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com>
In-Reply-To: <20260929012831.4193448-1-ricardo.salveti@oss.qualcomm.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 29 Sep 2026 18:48:33 +0200
X-Gm-Features: AclHuK9NLaFKHG6HpyHT5mvqq2QH3PTUNs0An13YJGLg5McUtwGnnDmq4VNYr40
Message-ID: <CANNYZj8T1WwNfCrSg98e_37B7i=n+aG9Mx3FF0-2unVn9ajbXw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/wget: rename the partial download
 on checksum mismatch
To: ricardo.salveti@oss.qualcomm.com
Cc: bitbake-devel@lists.openembedded.org, jose.quaresma@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000abc667065ca1f4f5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Sep 2026 16:48:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20280

--000000000000abc667065ca1f4f5
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sept 2026 at 03:28, Ricardo Salveti via lists.openembedded.org
<ricardo.salveti=oss.qualcomm.com@lists.openembedded.org> wrote:

> Seen with parallel CI runners sharing DL_DIR on Amazon FSx for OpenZFS
> mounted over NFSv4.2. What corrupts the file there is not addressed,
> only the recovery on retry. Tested with the new tests, which fail
> without the fix.
>

What is the plan for addressing the actual issue? Has it been reported? Is
it investigated?

The problem with such workarounds is that they remove all incentives to fix
the actual issue. Worse yet, they can obscure that the issue exists to
begin with, or that it has appeared on a system update where previously
there wasn't any (e.g. a new bug).

I'm firmly unconvinced.

Alex

--000000000000abc667065ca1f4f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, 29 Sept 2026 at 03:28, Ricardo Sa=
lveti via <a href=3D"http://lists.openembedded.org">lists.openembedded.org<=
/a> &lt;ricardo.salveti=3D<a href=3D"mailto:oss.qualcomm.com@lists.openembe=
dded.org">oss.qualcomm.com@lists.openembedded.org</a>&gt; wrote:</div><div =
class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Seen with parallel CI runners sharing DL_DIR on Amazon F=
Sx for OpenZFS<br>
mounted over NFSv4.2. What corrupts the file there is not addressed,<br>
only the recovery on retry. Tested with the new tests, which fail<br>
without the fix.<br></blockquote></div><div class=3D"gmail_quote gmail_quot=
e_container"><br></div><div class=3D"gmail_quote gmail_quote_container">Wha=
t is the plan for addressing the actual issue? Has it been reported? Is it =
investigated?</div><div class=3D"gmail_quote gmail_quote_container"><br></d=
iv><div class=3D"gmail_quote gmail_quote_container">The problem with such w=
orkarounds is that they remove all incentives to fix the actual issue. Wors=
e yet, they can obscure that the issue exists to begin with, or that it has=
 appeared on a system update where previously there wasn&#39;t any (e.g. a =
new bug).</div><div class=3D"gmail_quote gmail_quote_container"><br></div><=
div class=3D"gmail_quote gmail_quote_container">I&#39;m firmly unconvinced.=
</div><div class=3D"gmail_quote gmail_quote_container"><br></div><div class=
=3D"gmail_quote gmail_quote_container">Alex</div></div>

--000000000000abc667065ca1f4f5--


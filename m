Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31D5C7113B
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 09:42:54 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web11.7123.1692870168282298725
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 02:42:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=T0n+1pfj;
 spf=pass (domain: gmail.com, ip: 209.85.208.172, mailfrom: rybczynska@gmail.com)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so31875941fa.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 02:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692870166; x=1693474966;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CawdxxtoRB2XaH3a2+v0yDla5XRmEtBVC3SD4Kz1TXU=;
        b=T0n+1pfjXWFWhqDOOnsRtgBm4TG3vMLDjISW3lm7H/Dw4gMV+vjiRuffgiSk47HL1Q
         EceegJpKUsRcXZdg+pWFVX+w7sEu2eqlMXrLSBPuOgT0/1p+CirGgFAda63QBwjXLilN
         k8etqb5/znohOwy1ahKmx9NRt6caN44r1WC37zBlnuw5DJ72MB80YNo528X0IIj/s2yF
         lJYdxonqwGF8vh6v3mbMpGg2r+R7uxbLdr5q7YM99OQGC15yn8F005omy6vmqzXaI0f9
         22WYSoBSubtk2hIhz4Ym7/+sZbQJ25eUsjOP5lTAEeD3DqyrV2TduAkDgnftChM5BA0N
         TlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692870166; x=1693474966;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CawdxxtoRB2XaH3a2+v0yDla5XRmEtBVC3SD4Kz1TXU=;
        b=NVchdBGZy8a2dZqnI5gIEdRoqGp6w9jdoWjP7xeae3iO7ZGWlD0nZQ7VFsIx/HSxnO
         IOzhv4iS5aowYbpo3aMEjCRaGUzh8VgusctYUUvTeiyGaJdYxgTV9jLorvOk/a+K2dbH
         EKI6YfJNFZxGesfonaKMsxMgHKEi1Z3q6YV2Am7FmIVgbG7iX47r+0Q3X8jXeA1fvvVQ
         J6z/hxF6ofRPupG//MT5rvyh9j1hM030XVziD2cgZRlJcDG0yPpZ/62fw5O+heElK+Mc
         /Ts1sSRQbkZZ7VbuVBos27P6Xtowa3BQXBW2uNMzLhfpGufyd9UmcMIzMYqrt2n6Cyyt
         VOnw==
X-Gm-Message-State: AOJu0YyBHSR1LuZPIjR0YQOM34dhGkyvGBRFFOtsFmOgrOyd+xMroPT/
	buhkSeMuwTg+lNQgX4ZLCWXxukBsk06rNKyZKOQ=
X-Google-Smtp-Source: AGHT+IEwHFQDX7LrVRdQfxgWWIRYWVqoDT495XrGyD7FLStkKSMEm5C2AftwgYmxLkjseVsD7oxKPM72Yclry4+4sag=
X-Received: by 2002:a2e:88cb:0:b0:2bc:be3c:9080 with SMTP id
 a11-20020a2e88cb000000b002bcbe3c9080mr8330890ljk.27.1692870166089; Thu, 24
 Aug 2023 02:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230824081110.2851830-1-samantha.jalabert@syslinbit.com>
In-Reply-To: <20230824081110.2851830-1-samantha.jalabert@syslinbit.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Thu, 24 Aug 2023 11:42:33 +0200
Message-ID: <CAApg2=R2Opk75OqLRcLXBkaHv9WVFAXbnxS9t-PPi5AMywFwGw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Fix disk space monitoring on cephfs
To: Samantha Jalabert <samantha.jalabert@syslinbit.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e6958f0603a80c59"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 09:42:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14974

--000000000000e6958f0603a80c59
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 10:11=E2=80=AFAM Samantha Jalabert <
samantha.jalabert@syslinbit.com> wrote:

> Error occured while running bitbake on cephfs:
>
> WARNING: The free inode of path is running low (-0.001K left)
> ERROR: Immediately halt since the disk space monitor action is "HALT"!
>
>
This was our small Ceph issue I've mentioned during the call on Tuesday.

Kind regards,
Marta

--000000000000e6958f0603a80c59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 24, 2023 at 10:11=E2=80=
=AFAM Samantha Jalabert &lt;<a href=3D"mailto:samantha.jalabert@syslinbit.c=
om">samantha.jalabert@syslinbit.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Error occured while running bitbake on c=
ephfs:<br>
<br>
WARNING: The free inode of path is running low (-0.001K left)<br>
ERROR: Immediately halt since the disk space monitor action is &quot;HALT&q=
uot;!<br>
<br></blockquote><div><br></div><div>This was our small Ceph issue I&#39;ve=
 mentioned during the call on Tuesday.</div><div><br></div><div>Kind regard=
s,</div><div>Marta <br></div></div></div>

--000000000000e6958f0603a80c59--


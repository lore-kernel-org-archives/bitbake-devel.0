Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3520E7E35B
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 09:15:17 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8125.1775207714989676474
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Apr 2026 02:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=U0+dz0o6;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a2a70bb66aso1725970e87.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 02:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775207713; cv=none;
        d=google.com; s=arc-20240605;
        b=ciI7erMyFOxb44DnOBQcyyifAQtFoRocJTKlKqe2WxCz/Fza1HMPQhjfg8gMbqSvjL
         rdAEiku8WrLwGvhDAM6BatjauZ9BWlFq/TUd66ORQKP+DkbKtLbMs08WHl3+aTRRUQXP
         KDoUNjLj1tyUTMzOnnhE6i5zarVGS8cyve1oAroAnA2XDw/BSLztVWAcgTG+ttQEweBF
         uvx5Y1wWA9kpiUVNMiOvZPUKj8dJbDhZibuJ+okvsFp6ZdhbgGXA5m0WsosXo/V3H2l0
         06YIlxJ2pnQlmkMweg5i3G4ojNQfXQ7KuCIM09eGMTa1g31p1HgpoWNsbpPdTe61/eve
         7XmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CEL45YET/TWKNKnxAi7cpRSFhEBF8fKkU8tfhU6yazg=;
        fh=8ZK6WAa+HsIvGtcmiQhxDDgsYe78PfVg9d8K3w1u+pw=;
        b=MwmDN+/ATfrL/eropJspPbUgWLHuK3vkLgcZOMK/zNFMClovkg73gdGXPS9OkQLoZ3
         WrX3KEMflIaFYiyN9H6vKSUYsuJo37PopgiCrvjeUbNbA8Dtlz8QXDOxm9ptMjAW2lO1
         4xMZy7vrasZI/xd7D47Defph0o+jTdQV2HtwOFseBSPRAm0E3Pk5fpJyvyb4wdYwgs4Q
         zitVOk/roBOgt21bwhe6wtvDPPc+hVlDh0z+sBUFM64yScsVDXb4r5SsabQ7VCxxsXBX
         3AiE6clbXahjoEd1VVRwPAUMco6wjvkymNz5a5CeeboWu5EMZL4jHg5QmVPmxxjts7Ta
         AjdA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775207713; x=1775812513; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEL45YET/TWKNKnxAi7cpRSFhEBF8fKkU8tfhU6yazg=;
        b=U0+dz0o6vtA/q6BegQ+gmdmjiYUQnw78MDxOUgsewVczkYRYuzw1OCH0SsdS/Pi0MJ
         yEaAnSIEzSI0SVV0qcmOMOJYadrUrxtj0bXeLTzuaXfDOBc8PV44Bri2180KboN5WpQ+
         bAN8BM/wyt57Lo5s9AVQMMwrwxIpdaucph/pUtAfP+fBm78evs9pJvIjllZlyZGULzlJ
         AIqoJqTniEaEar1kBto1e+1IDPL83rDXs9lH3t52r+jk/1pqKFzEApDlI4Qw8B0QWTEd
         u06eTO9z8NjVf+03TPk5b7pGxDqVxrECmO2v3fBq8N9Pg5FFfH3nVO35+z+kIzBDtwiw
         Nu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775207713; x=1775812513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CEL45YET/TWKNKnxAi7cpRSFhEBF8fKkU8tfhU6yazg=;
        b=pvsxlSCEHSXlzXRhhFOIarP2+88G13tYcfbbsVF6/bCpxlTXDCz9T3jpoNkRaYwQm0
         udoSqCcLO9MMODM74KVOARCPFv2z+TichkauV5MY1TJcGJ3UfK9mYC/K8uBP9+K4WNet
         YYe6hHSK4VL1VQCJr1dv3BSEhcaxFbPxVw7RVVkQDE+LE6UY1dkC+xB4DrH7EAUPH+z0
         rY7sm3tzxPG1sOAr0ORkmzwX213gep76wrmIw0iVP0235e7nZVj75Q6vQ0bRJ9evezIR
         OH+y686AvUiUMa0A/DgjwQCtqitPc2VyQrfkdVH0BAlXE1rljArQm49QO1Nmw0OnGa/t
         VNaw==
X-Forwarded-Encrypted: i=1; AJvYcCVD17EU22t8bwkz20Pn3WVpNgEzXN7xqL7/FVi6elCuT9QS0WRYCY5VEQ2fRbkJ3OPpax1bRPgfoqyp2BhD@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxtsaj+Yn1wXNAtgRXgXNC4Y3ZnKg5XEpQeCnIUijaEn3kacwXt
	T/ir+MUkEWVgDi1DB4BPxzAe6pOe+ZRp9L9I0lR7Zhwqz/JWGwfzQjtvteL6HF9p0INsYaJ5GHB
	Bmhw7TAOmd6lmP+iz+HYz6kOX9QSvIpQ=
X-Gm-Gg: AeBDievZaW0Mn1pgmo9CJ7u0qvOMLA8Om3p5yUXKz3u1cFTNhljlN9+DxkQ5PdIxeHb
	3fZ0zv3P7W9Nc/NE7/vnZsOVOXpKapGchN7RTuHya906s/F76+7rPj/CqTZquzT+G+Pn9CU0LmU
	R1c+kZEQ1zOCS6qhCjUOemG94MRXRYiavlETlw8JsHuNWbapGyAx8utwCbvpHf1bSpZDTuejcZD
	CC3Wduyd18nuzDKcXoEVBgnP0O5QTUKCfu7WREulj6vx8HwuChY5dfA+fadzuhqa1v2+ZSXQAUe
	V7FGjGd/lg==
X-Received: by 2002:a05:6512:3b1f:b0:5a2:b43d:ac47 with SMTP id
 2adb3069b0e04-5a33754efb5mr721227e87.5.1775207712558; Fri, 03 Apr 2026
 02:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <DHJDUJSPA7LG.3IKCP2QUJBMRL@smile.fr>
In-Reply-To: <DHJDUJSPA7LG.3IKCP2QUJBMRL@smile.fr>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 3 Apr 2026 11:14:57 +0200
X-Gm-Features: AQROBzC66UuUmUGAr3LMp1zSKBkkoYp-2PN_PUFvQbh0f6HoHfsig70YdyhRgDY
Message-ID: <CA+chaQdp8E_HMyo6Qx6C+PuRrLbrqgbFdQF_WdbZS1ONncxb3w@mail.gmail.com>
Subject: Re: [bitbake-devel] End of whinlatter stable support
To: yoann.congal@smile.fr
Cc: Yocto ML <yocto@lists.yoctoproject.org>, 
	OE-core ML <openembedded-core@lists.openembedded.org>, 
	bitbake ML <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 09:15:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19317

On Fri, Apr 3, 2026 at 10:46=E2=80=AFAM Yoann Congal via
lists.openembedded.org <yoann.congal=3Dsmile.fr@lists.openembedded.org>
wrote:
>
> Hello everyone,
>
> As you may have noticed, the end-of-life date of whinlatter (2.16 for
> bitbake) is near.
> The last release of whinlatter will be the 5.3.4 and will be built in
> the week of the 20th of april 2026 for a release the week of the 6th of m=
ay.
>
> If you have patches that you want to see merged in this last version,
> please send them before the 10th (next week) so we get enough time for
> review and testing.

I would like to see my glibc-2.43 compatibility changes I've sent last
week merged.

I've tested it on 26.04 in docker, if it doesn't show any issue on
other hosts used by AB, then what's the harm of merging them to
whinlatter and scarthgap?

Even after whinlatter gets EOL someone might use latest ubuntu release
on host and then try to compare his wrynose build (where 26.04 works
fine) with whinlatter build (which fails immediately without these
changes). I often use EOL OE releases when trying to "bisect" what
changed in upstream layers e.g. between scarthgap and wrynose.

Cheers,


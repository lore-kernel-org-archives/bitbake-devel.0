Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB3CE8D6F
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 18:11:26 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4759.1763143885743007884
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 10:11:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JXCLSdwH;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88246401c9eso21400356d6.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763143885; x=1763748685; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mUilp21PJXxBHb8m2jLtCrIGI3xNjtcQVkW01LTOw6Y=;
        b=JXCLSdwHX8Tn0+VkQuZh8ES4A43q01AbcZJx5gF8cTzgxlGscI8rb5aOrtFiDx47wX
         nKytwDgJFXxm0FhPWpXYyxH1m0NnaZMMYvdl4YEKsMyEn8ixxXBimnJf82vDgaNvmeZV
         Dp8cGW10mG+yygKOwU8pEl+FsDAwtcpPwRx99OD53J61ftwLBMIPnNnSPbCjcsXLeL03
         4trCemMTfL2ZnNa3iGAd7yh/oQUP3X2NjFk4VOlPludIXPEJmchGH+wqJYWoXiBycwrl
         sl9QDnJdYWBeSg0muWZZk4bPdodGJ7aUU9GSzBbeobj8V4N5DJudhF1P8aV4GtZMsIFB
         QqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763143885; x=1763748685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUilp21PJXxBHb8m2jLtCrIGI3xNjtcQVkW01LTOw6Y=;
        b=r5/0yDd7j0OOpMubZ5Bo6r+y3rp/vmGX5AZ9Cjw/D4UezJS17Z2YZyxtc0jmp0X70Y
         KIGaMK8sd4ZR1FswYXiyBNjlGehHHUVJZf1jivIS94IQE4VD7KNOE6o6TldvHg5Fm4Vg
         cGsSljj6R8iy9Bul+xN/4AhXZMeU8sCW0NYncWNE/x3exkMSJ3Ud9xVvnqopfXM+ER5r
         j463CF8CUPjnBfUU4ZxtbN2gn27YftIS8vX7rL/knGNURjfyPAxqRF1ALcuBMkBjgRT3
         FkebGAe6PN2pukpXhR+j8EYpHIjakrXuLUEczC7wFbsEw3NzQ/85+un89XSolkyjRnC7
         teLA==
X-Gm-Message-State: AOJu0Yxa7fPhHypszKQT8lVGVxjj6AG5WcPImYYTzMXJ9wxaSEOfoWPa
	9YGWb4gDd1ZkkqEBbVPaS3v2B4oiKhtuul6UPec8x+WVJx5ze98qnwr5C1vAYHUijkftacyAkVr
	zdjtEUCqtkXKTr9Aw9VOlIm1XbQW6yh7tkw==
X-Gm-Gg: ASbGncsyvX9IEvXY4Ep9GKBBIi0/VCQHDVXmUQDKl63OQ7GO4c0l6OH7ka3MXGPJxu/
	Hk39lmQyZeMy9a6Z4hvjqLYdyumhdhRhml42BReLEQVu3tke6AimWTVoEptbUhnAhNixijyMD2a
	Fc1aWDZPuSTHTkgaNwOdBebzAS/rUjNhz9DixK1Bv5fA9K4jDf9TdpLmnINMip2eQCtxsXU2EtG
	qZQbBUxRP05rVZPB5Ik//uIZFJ/YmVHM/M6/nhHu9/qbgZ2TuszxxUUPcq+zqkoXOn1sQ==
X-Google-Smtp-Source: AGHT+IGDwOvYhFMLnCGVym0Vu3QFUo2gDQ6XDZFiFI0UmkvNjV/aHYO5wBD725Db/ac6zEUP3J6lNERO5unrteNdfVc=
X-Received: by 2002:a05:6214:c43:b0:880:501f:5cd with SMTP id
 6a1803df08f44-882925c5665mr52349086d6.2.1763143884622; Fri, 14 Nov 2025
 10:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20251114-update-bbsetup-doc-v1-0-044070bdffec@bootlin.com> <20251114-update-bbsetup-doc-v1-1-044070bdffec@bootlin.com>
In-Reply-To: <20251114-update-bbsetup-doc-v1-1-044070bdffec@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 14 Nov 2025 19:11:13 +0100
X-Gm-Features: AWmQ_bnXxYJxuCs-uGzSJ_bvVcD85L_KOU0N0aEq1XVVxo1zuD51mnvjMY911nM
Message-ID: <CANNYZj8jeGq8Hq87a=ha7wfb8_ra3D3v5RJseQR8ee9yyPu7bw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] doc/bitbake-setup: show how to clone
 bitbake before using bitbake-setup
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 18:11:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18407

On Fri, 14 Nov 2025 at 12:12, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
> -#. ``bitbake-setup`` is part of the BitBake repository under
> -   ``./bin/bitbake-setup``. To start, run:
> +#. If you haven't already, clone the BitBake repository:
>
>     .. code-block:: shell
>
> -      $ ./bin/bitbake-setup init
> +      $ git clone https://git.openembedded.org/bitbake

Add a note here: bitbake-setup is not coupled to the openembedded or
yocto releases that it is setting up, and generally a copy from
bitbake master should be used as it aims to be backwards compatible,
and yet have the fullest set of features.

Alex


Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1C3D1A628
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 13:41:59 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10228.1767966109038807832
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 05:41:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jMq6tU/u;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88fdac49a85so44509176d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 05:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767966108; x=1768570908; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EA5AfwHrDg1PsCC/sNLh3Nu/YmBmhPeZhTn/0b2YKns=;
        b=jMq6tU/u3DogwbysQaw45+p+4lYcJIVyBu6nD/Z/T9/aK1zxghpv4p+oXhkz/MwDg6
         ri43qLdXcTvbPMtpvL++u/3ejnSh+LIj5OSTHHHU5iJA0EgQZgff7xjX4ZjOhpLphkwB
         DRmSg9e8d9Sl44nbN+oxt6gtNn9v1ra56g9o64ELbGXSaErmRn42f6Jz8fmFh7mT0yck
         EpJyq1+HMOoYIEYP+JiD5/vhdhmegs4ZXLAMZZu9W85UTuUP5xTeuuVuhcjuMq9soq2/
         UTzDek6y77iRg1+1sUT8tlQbWm5X3UxgYGw4V/6FybiSRqVIHi8CsN+nQDj4CQ8vUS1C
         53pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767966108; x=1768570908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA5AfwHrDg1PsCC/sNLh3Nu/YmBmhPeZhTn/0b2YKns=;
        b=iqj0huUWhf2yTWsuz84eCwywnSbXZoBsY1zd9qBYllmFMsviwd2mcbLBI4H7mXZrKh
         s6NgjEVU+HtJRJ9evjuKSqW5wq0bJLLV0Do2DQxIYPSlUo5H0exaZpCY6xfq7aUHELkd
         Iww8+A7Wk5eopMH4zFghN1d02JuLO8wzIuDole2UfYR2YioxXyIKdcUDOhoeprjD7pEo
         ApNeBjUoGlbURQ3+VT4PDru9GurCBePhbuAYckIQxNM/Xc6pTfsKaQIWFLs3eOFtNhP2
         082C4P2UiVrMt2lBBv0RG3GRNA7TgdZ8DkSR1H4PxlBK79jnz+9Zr/nAaD3rCPX0kIni
         OmaQ==
X-Gm-Message-State: AOJu0YyYKZU4Y2Dgwq67Bqd9EweOTOnNpqxJAfTKvDIPcqyu4nb+se9y
	ULljsEW49ONkkdlcS8Il1RxXgBMazxLOyu/0VCaNXq4zma/zom2o/k/NnThHsApU46x+0haflec
	RBZzQe+47NDx4bRU4Ovu8VZTg3/S5IwE=
X-Gm-Gg: AY/fxX4VokcxsHvBz2PfRGjCcXMlundg7DWQDOYEeOJbLKS3VDlvNOc2LU1V2aXwLX+
	+WKT0992bzY6QrFtKKPZpn5f8NKNcGDyiudwEMgvBIGowOHrG8zJsNvdCyyfwvd4kKkjbx6HCGh
	rJPrOnUF4SHAmb75AdCCq8Apegjfz+xkpHCIb7qOrPA2an/kkGLvY6BGkBRIAe7kiXW9r5Fz9f2
	9a8m+vXw+eoMsBJVYW7nxfKq33/DtPw3eFxGdS1w112K0hssOyBG9u030gQ67liISm8ttCv3Rbe
	YgUTAOSEtN/llXugO/8gLePqMkG8Cw==
X-Google-Smtp-Source: AGHT+IHuwF5ktUXyIiBz6OifDvqzh/j/LPRRHFheXydUTh3t5E1pYWQdr33KQvu3lBVKO7Gu0jBhmxWUROCkKAVTyZs=
X-Received: by 2002:a05:6214:458e:b0:888:6fa6:782b with SMTP id
 6a1803df08f44-890841d596amr139071706d6.30.1767966107981; Fri, 09 Jan 2026
 05:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20251223101757.1057188-1-corentin.guillevic@smile.fr> <20251223101757.1057188-3-corentin.guillevic@smile.fr>
In-Reply-To: <20251223101757.1057188-3-corentin.guillevic@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 9 Jan 2026 14:41:37 +0100
X-Gm-Features: AZwV_QhaygH5Qu1GV-ZzhBUuiLPTftf7XLubcEF6v1PZs8VNy5AUgQgstK5OiLo
Message-ID: <CANNYZj_NWzc_ZJyAXZ+ydG_k0uxehnfkaMJy-G7RRWn=SzcMog@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v5 3/4] bitbake-setup: use URI shortcut
 for all configurations
To: corentin.guillevic@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 13:41:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18728

On Tue, 23 Dec 2025 at 11:18, Corentin Guillevic via
lists.openembedded.org
<corentin.guillevic=smile.fr@lists.openembedded.org> wrote:
>  .../oe-nodistro-master.conf.json              | 18 +++-----------
>  .../oe-nodistro-whinlatter.conf.json          | 18 +++-----------
>  .../configurations/poky-master.conf.json      | 24 ++++---------------
>  .../configurations/poky-whinlatter.conf.json  | 24 ++++---------------

Hello Corentin,

I forgot to mention this: whinlatter configs should still use the old
format. The issue is initializing them with bitbake-setup from master,
and then using bitbake-setup from that whinlatter-based setup to run
status/update operations. That older bitbake-setup doesn't know about
the new format, and it will fail.

Other than this, and Antonin's docs comments, the patchset looks good.
Note that there are other bitbake-setup patches flowing into master at
the moment, so make sure it's all rebased before sending.

Alex


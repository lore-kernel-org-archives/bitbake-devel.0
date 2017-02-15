Return-Path: <armccurdy@gmail.com>
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com
	[209.85.128.178])
	by mail.openembedded.org (Postfix) with ESMTP id 3943A7724C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Feb 2017 09:03:36 +0000 (UTC)
Received: by mail-wr0-f178.google.com with SMTP id i10so186457831wrb.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Feb 2017 01:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=qVEm6CICuelf6EGXFsSRsCZRh8crdFjo321iFaoxVhQ=;
	b=pkQEgR/bOiKrlvq9kDWBYas4bhEkprz7S3yutCI9MBTlb7+Te2it2NmbUjeHp4zp3q
	bQPmxDE1HTvjkBPtmmwHwD/G9nmKNQS6lE/qs3EDStb6glUdZ8NyO1cfm4U+efd/9Zoy
	Bg9r1C05LDDx9SE5wvEQ1ePh4lx+WjqQiph+yRw3uZMA4vnESzb1bMsOIRLZUJwTDz9N
	eiw75bDxCuVHK6d6VUfg/I4S3In5+OG4VASt1cJH7oPj/P1zQ0fc66ZtqKNVCMT/C8IY
	09CIvb6E+CC2dZFSukjsKRp255Nmz2nLI80UyhEd43jr+XLvMuok8Nosd/+0WYP4NvUq
	9Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=qVEm6CICuelf6EGXFsSRsCZRh8crdFjo321iFaoxVhQ=;
	b=amJxRnAaoVzbB8ApSV97E1TWjnqbT3n/W9ADxYS7iDreeRAI+GoCkKWGSmRa5a60/8
	rD2vP0PPwTC2BORH9n2eVEezeRiWUjNy+mk8zb4OJqvlBe84jXc53Q1dSXgeRgtywsJV
	wuaZKBq3EXVBt7rcInH0xzoTHPKX3Dl8At4m36WNJuOLcB9Z8UROkcTWLh8a2dwQfrbZ
	uBsZVOkRPS3hGQP8UHE8mL/m1Yb8ahx69rByYnqXw2dWTI7jbZcNF3+FXp4SH0WFXAxz
	RA7nQkbeK7x4Dc2ci+3H2z9f/wUoIbCFF0/yv4kbdMifVzJAOseD+REdTC6ZbJ7kf5+z
	3veQ==
X-Gm-Message-State: AMke39nzULptyd32zkV6cp0rl4w2XdLnO8cg4B2DROECiWXiUYMzFJBDE2Wln3AdkV9p0g/Ai+iVLuKt2IzgVg==
X-Received: by 10.223.174.199 with SMTP id y65mr32788075wrc.19.1487149416906; 
	Wed, 15 Feb 2017 01:03:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.174.82 with HTTP; Wed, 15 Feb 2017 01:03:36 -0800 (PST)
In-Reply-To: <1485983356-15764-1-git-send-email-armccurdy@gmail.com>
References: <1485983356-15764-1-git-send-email-armccurdy@gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
Date: Wed, 15 Feb 2017 01:03:36 -0800
Message-ID: <CAJ86T=Vkgwbd+v4z2GfCmbaLkCcrkUYSz02_z1srsYVoo3inwA@mail.gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: detect malformed BBMASK expressions which begin with a separator
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 15 Feb 2017 09:03:37 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Feb 1, 2017 at 1:09 PM, Andre McCurdy <armccurdy@gmail.com> wrote:
> When constructing an older style single regex, it's possible for BBMASK
> to end up beginning with '|', which matches and masks _everything_.

Ping.

> Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
> ---
>  lib/bb/cooker.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index e654a60..ddfd4a6 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1867,6 +1867,11 @@ class CookerCollectFiles(object):
>              # that do not compile
>              bbmasks = []
>              for mask in bbmask.split():
> +                # When constructing an older style single regex, it's possible for BBMASK
> +                # to end up beginning with '|', which matches and masks _everything_.
> +                if mask.startswith("|"):
> +                    collectlog.warn("BBMASK contains regular expression beginning with '|', fixing: %s" % mask)
> +                    mask = mask[1:]
>                  try:
>                      re.compile(mask)
>                      bbmasks.append(mask)
> --
> 1.9.1
>


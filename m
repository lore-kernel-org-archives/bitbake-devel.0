Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BD3FF886D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 17:26:35 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3008.1777397192575059035
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Apr 2026 10:26:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PAKb/EYe;
 spf=pass (domain: gmail.com, ip: 209.85.208.172, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e68e4389cso123337781fa.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 10:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777397191; cv=none;
        d=google.com; s=arc-20240605;
        b=N5ABP82eB+h8ikCI+eyjVpRA++vDMS811H2xMw12/MO8LG7TitUDg2CeL/d/AOP/Xg
         ENLFD1Tj2kOo5l6yUMq+qjsWcDYF8QHlAORP+PDfbOn3ZfZA9pl8znSJ7Z22f2A13sfl
         ajVp/+tTDv5gA9CzbHm839Nqpn5ZD03pOpCNo1HBO6h+IB/p5PTryz/WwLezLR34mFMj
         55djChtYyEvbMG9l78oYzoa0gutYFMK/6ju9el3NTvxZMLQIIIDBKqYJndEi1EiImkry
         QJuKWkdGSiJHN6oKnLf+Ph39/tiytidgXuA2Jfgrv/hFqfCWIER5LYChZqG6TF3cVWRK
         +E0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VU8rO15BlK28z261SLawIQKle8PQviXifm/iBvMVVWk=;
        fh=rkNsVwzrJRRjwPeQbTvoL9N3zgRE/y+w/jO9wDe99p0=;
        b=FPVGcXoClKxkPF+KMk6Eo2Vm9IIK5hTZnjGrZu6VIg24IymLikLP7II7qUayIqr8vo
         xlf2HPN+5Ma4NKPwgJnLYaPxLk5X3dvijm/4YluX+Xd/cT4U3LNcxmsWo4PGQhp+AgbA
         Q7zHUsKPN2zshPmf1abOXaLDCbQM+Tyc3lSj6UnYNlZAAoa71l+NHuHAY8WObbT+Wt3j
         ukZmlV5vcfo1HwpYwgcBnAu0crIDg/BdCukfXlnjkCIDQh7WJ7e4VQGCQkFkNt7NHGwG
         rRRjfLR/+/Kj0FuWra68fb9g3BOjdCLkte0AOcYkCnJ0DKDOCWtlwK7Paqx5KNfDJGLu
         nuYQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777397191; x=1778001991; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU8rO15BlK28z261SLawIQKle8PQviXifm/iBvMVVWk=;
        b=PAKb/EYeQ7B4OIcdsebSWJL265ZWO+iy3z4/I9bW7TAKjmaP5QksTl2DvJdI69FuQf
         5ORasZ9qCG+bi8P3gtx1Z0FOkjdd/09tUU2EvZPLuWUnNpAGOWZq4pLfB0UEXYCelgdW
         VpddQalIHC8ZKJd1T3Uv4OkkJla2gu5AVufDTcdPRBHgnVp7kpst9nOwvYGtUCRPRN7q
         1JMUvN7vQ6x0KeQp+gVGoaSrltogN6fZmuiuCtYH3FKj4jpwASSPn4nmfsMK5l+SdK4X
         a44uhjX7HVxiGEKMhDpfsHKWpciCtrWogFxm0vTs49Ti03X9UPicbhvVvbaEQ+X80H3x
         1uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397191; x=1778001991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VU8rO15BlK28z261SLawIQKle8PQviXifm/iBvMVVWk=;
        b=WPUvxDX+CdmXCYyc2kjPRgLrutq1tq3F1elQ27JQVeJpEhbPOX+wWNxCDaFPBpSSY1
         J/hjOuOGGfQFODzf+2zdZYxoxM/dVfCYYvpjvLtIuQTMk0L1y+FyfuOkIXZhzRvHDJuK
         /l9We/x0p3GNZUPf4GH/nLEgKNxcQL1ISWq+2e7WbUMO5vhbQuKTJdBtgn8ODwH0tUoJ
         7OmxeMIfDTdeeufGZjtEZlxjO9QEzmiaQIFKECIpHkOxfb9vRIxSnVspq4qxFhXFLw2z
         ZvqHx5jaqVNVmnC3v6fJtvRZjgCx57hE2wvoE56iu/oLVS0VK8nZ6JWU2vyXT3Yrq0Zt
         cdLA==
X-Gm-Message-State: AOJu0YzbInrJkDptEu6hcsu5EZobOci+cAaJZQ8R/IkEnKf99ApJMNWT
	jpsPcu7QZ2dYAdB13yjwXXNjPChNdg77cG3S4K5p5fu385Tp5JKVC5agxzsW0IzEz9Yvupn3IdS
	1r2NxjbRm5DRH+LBCH59NxEv9r0x8qFg=
X-Gm-Gg: AeBDieupsvlt2bFIDnU32fOuVnONDbB8JUstxcG6XhH9Y5WY29bjun4U6+0YZfEPDN0
	kAcXXr1IljhZDzf+9BHgo3jG/ntSathsoefdzLHXknOVIdjA1w3xoOQ1FPSdB6agi/+Ca/m7E5x
	uSjITFTTyywKV+cmLGzKf/iRMiC/kFAUYg2EKNtSTjT+xQ1rqjXA0lloL6WHBfvRwtzG51uVZPY
	tuvB7Lj5Nn2t3VOClGbADmaAR8jLdmFuWQzQDUU+bXzH+aUCH3Zdm5Y1typcwG3iF5plgySeZYO
	EIY2fVKyZTI+thQ+273TdF8dyYF8hY+b/QGgABpY4FgNtDdLR7shIXllwwuq/2A00KITmz75E8x
	4
X-Received: by 2002:a2e:be90:0:b0:38a:291c:dbcc with SMTP id
 38308e7fff4ca-39240f7ae4bmr15843151fa.19.1777397190312; Tue, 28 Apr 2026
 10:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <18AA95279EAAD3C6.1915996@lists.openembedded.org>
In-Reply-To: <18AA95279EAAD3C6.1915996@lists.openembedded.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 28 Apr 2026 19:26:16 +0200
X-Gm-Features: AVHnY4Jenxb5lc-aiKp68rkFGlDz67GWDBiIg-W2vMDac0QzGRYMQj5D7pgqjMU
Message-ID: <CA+chaQckrncteLLjpZNL4x=+=MBkYe_yajcigsY+dNaQzXndnw@mail.gmail.com>
Subject: Re: [bitbake-devel] [2.16][PATCH] fetch2/git.py: fix update_mirror_links
To: martin.jansa@gmail.com
Cc: bitbake-devel@lists.openembedded.org, Chen Qi <Qi.Chen@windriver.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Apr 2026 17:26:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19405

I know that whinlatter is pretty much EOL already, but if there is a
reason to update 2.16 bitbake branch once more, then please consider
this one as well.

I've noticed today docker-compose from meta-virtualization failing in
do_fetch because of this ud.shallow and verified that this backport
from master fixes it.

Cheers,

On Tue, Apr 28, 2026 at 7:23=E2=80=AFPM Martin Jansa via
lists.openembedded.org <martin.jansa=3Dgmail.com@lists.openembedded.org>
wrote:
>
> From: Chen Qi <Qi.Chen@windriver.com>
>
> We cannot assume ud has the same fetcher with origud. For example,
> if we set map git:// to file:// in PREMIRRORS, ud is using local fetcher
> and origud is using git fetcher. In such case, the ud does have the
> 'shallow' attribute. And we'll see the following error:
>
>   Exception: AttributeError: 'FetchData' object has no attribute 'shallow=
'
>
> Looking at the logic of this function, I think it's the origud's shallow
> that should be checked. So the logic becomes: if origud is using shallow
> and its full shallow tarball does not exist yet, symlink to ensure it
> exists. This should make more sense.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 0fcdb19df..738174cd1 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -356,7 +356,7 @@ class Git(FetchMethod):
>          super().update_mirror_links(ud, origud)
>          # When using shallow mode, add a symlink to the original fullsha=
llow
>          # path to ensure a valid symlink even in the `PREMIRRORS` case
> -        if ud.shallow and not os.path.exists(origud.fullshallow):
> +        if origud.shallow and not os.path.exists(origud.fullshallow):
>              self.ensure_symlink(ud.localpath, origud.fullshallow)
>
>      def try_premirror(self, ud, d):
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19404): https://lists.openembedded.org/g/bitbake-deve=
l/message/19404
> Mute This Topic: https://lists.openembedded.org/mt/119051825/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [martin=
.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


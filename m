Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296D7C98321
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 14:57:24 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.245.1790348243115705399
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Sep 2026 07:57:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DxvJBcPU;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.140, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff23af865so6625915e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2026 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790348241; x=1790953041; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RQnoRnYHg7N03S4jYhwRMVuBxlVRrpEOappxuT/9E48=;
        b=DxvJBcPUDX19azLb/jrILBm7k3bTeTyPDPDdZNs8u4OO0OXtEY8OTi/E8ZNxQYmuNd
         aJpo+TdxbvOhws3ka2sGAQk28FRibCE3rMLvHnoE8nvD7VQ97sLcpqFS/bLcaU/eYi24
         kJ/i6G5f6LQ6vndPQxVYrUsJPsnu232LA51+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790348241; x=1790953041;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQnoRnYHg7N03S4jYhwRMVuBxlVRrpEOappxuT/9E48=;
        b=jt4RkcVl6HkCKFDQDdwe41gMML9GWaQDdQD0J+aq0IhkaSVQ9QBzUwKU4y63/d9z9M
         aW6v6lSY0gNA0Y66FtUXk1vGxjWmB4O3gBNLT+aioBCgdKLpIhQw+N4gz1/+bZVeY7aG
         GL16zVdVz2AjrCq9Q4aCm8YkEqa/B38pqO5yq4FStLy234aYHgkeyylUldxNbqAoz52P
         dK5dZO8LWQiLe26L+DP1uH4XfMDtQb7pMLQr3SabIt8cQbyx+ZpMpGCmIjCMrNlR00m8
         YkfuAlIOOo+PgGU8oC5JX3YtcoBkPhgH03huCjmUK8fglyyPbyQx6X/ElJco/Cr8vUav
         fhYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1539pWrxoTgOt3i1M/dv5HYlAoFkPrgAcoDJS6AC4wsqZCREpOHlwFsBnX1glSZ3Oc7IDhmkuEzxJEiFF@lists.openembedded.org
X-Gm-Message-State: AFuF++k08XXTV2gEtEHY8Ipu9fmFOuJ5434xKukrS00D/ONxthASWANt
	CtBPqLcOM8B7kkQdAJVmMKAJ9q/+NTXXnaSaIFcU1ksa7z29Ihd8TTKwi/FKi2ZhNwk=
X-Gm-Gg: AYBFou3kxWTpx2QBeK/LgWSWOU//ZSwqNFZ8ifmZLoIQ270owCJWYn+hOnRsVWn6GWv
	iaVxJsBetNGK/WiiSriXA2TbRmwcc8JGU2vDRXaCWq3ldsIkpcSZPf3w3g+BOMvh8Tpvcq170q7
	/gewwVVAnOGC0vksgoWJAfXf5b9L/xmbbJH64TXCD9gNvt+6Ie0e5shRVVL5B+dC9w/2yQi/eqt
	BxHpJINL87YYrqkTDTjBdAcXFwrpPDcMqkcUDK1ZuzFBdTsXeHuO9hHn+2C/y/5GklQ1Pm3Gb59
	9uto6FDapI7zOfg+FSC+GJvMnJJiMEV7GEeDMcTR5hFQ1yfeXMVRzzP/dYZbP5Xp/1dAacbTXgC
	ZUv2lqhTA829nJD5ycS5A6773q83Vabf1WEmYNsnrvgMbOMalxVATSDMyC5MxtBy/AeiPn6zXDk
	wJ6oqoxiH8mtgx7j2UXHgMTeRdViZ8smaQgWcfy2Sjddpk3VKhlu+yj2iuvXfkK+EvRvyiNdjWb
	qhaxRDf3F3zoG+pSSY3xkmM/0nr4GVlOUfV+mOjM64rNaKr4p0muLBwK//rPdTu1vPOsBlzRw==
X-Received: by 2002:a05:600d:6454:10b0:49f:e80c:3d66 with SMTP id 5b1f17b1804b1-49fe80c3da4mr70784805e9.29.1790348241200;
        Fri, 25 Sep 2026 07:57:21 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:63ad:54b4:d74c:3436? ([2001:8b0:aba:5f3c:63ad:54b4:d74c:3436])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fef60cc72sm46982455e9.3.2026.09.25.07.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:57:20 -0700 (PDT)
Message-ID: <9f14d7c0579a4e72521d0a8e52c5d5c14ea64e84.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Add OSC 9;4 to bitbake terminal runner
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: git@cookiesoft.de, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Sep 2026 15:57:19 +0100
In-Reply-To: <719659404.262685.1790338566452@app.mailbox.org>
References: <719659404.262685.1790338566452@app.mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2026 14:57:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20255

On Fri, 2026-09-25 at 14:16 +0200, git via lists.openembedded.org wrote:
> Hey everyone,
>=20
> BitBake runs can take quite some time, and it bothers me that I don't
> have any visual feedback while a build is running.
> So, I tried to make use of the OSC 9;4 feature[0] to get some visual
> feedback on what is happening.
>=20
> I managed to get a first draft working, but honestly, I'm not really
> happy with how I integrated it into BitBake yet, and I could use some
> help with that.
>=20
> I uploaded a diff that can be applied to the scarthgap branch[1].
>=20
> I would really appreciate some feedback on the patch and on how I
> should go about getting this merged. If someone is willing to take a
> look at it and maybe merge it directly, that would of course also be
> great.
>=20
> Thank you very much!
> Marcel
>=20
>=20
> [0]:
> https://learn.microsoft.com/en-us/windows/terminal/tutorials/progress-bar=
-sequences
> [1]:=C2=A0https://gist.github.com/hellow554/257ffa02b4e236ede8f1a5a46cc9a=
e

It looks like you might be able to make a subclass of ProgressBar with
OSC9;4 support. You'd then just need to detect when in a windows
powershell and trigger that.

I don't use windows so I'm afraid I'm of little help on this.

Cheers,

Richard


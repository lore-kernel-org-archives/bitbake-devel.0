Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A379CCF2C1
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 15:19:04 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8245.1792250333698823168
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Oct 2026 08:18:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bZc5ecBM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so5602265e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792250332; x=1792855132; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lbp/nGaLycenxMMvelPYbq1CqMNsRcBCPRH2sIjqYGM=;
        b=bZc5ecBMt8zCBZ7lg0rmDIcrLs+rIzvQSLANyt1HipRAh6K7ZCmdqqg7sXwvjFMCIU
         xRNiZS+tw8dWBqGhW0QEj+7Ck1DT7PWBZuGwEJhdmtL0fRAjLN77KUyTgfdK5S7Bx7IQ
         vGq+SMfVEU1H8XO7azAe4LkaY0Bm9D0+s+H7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792250332; x=1792855132;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbp/nGaLycenxMMvelPYbq1CqMNsRcBCPRH2sIjqYGM=;
        b=hvx1oAXExt8o4CTI6hctOZZ2TWFPDtgFE5xPS7UHtxz5Z/p1JW8E/BzyPtyzzIB2QK
         irb6vpRY6dtZ2/gkxggjhsUUyIMU3iOo1Y2BsNl8ipU/Q/cg1ql1NxRcI6Dn9sGF4Q9q
         BD5qxS1tjZMdEBkABJzNb+IU0arGcOz1iTuC4flm8aTsfeZh5IBcXAP0kZwBEltsT6Id
         wms23IHgENMVCdGCaQ+Sns6udfE8IdMxFXe+qe6tRbw1Yhsx5qTRECu20sRjD5IcNdiz
         LZinlX86Y9FVOn3i2AyMrt+dC8wp7czXXMv7JcLJaJvIIxzN/5rP76pXsuYpxCKiEr8q
         /JKQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6XRHV7QdiUFgi6G0reyQueFxt6u0IQ9TJ8jBaz49zS/3C8SFHfV1bGK13mEbQodT4FTtVZTJxHbLgrpKt@lists.openembedded.org
X-Gm-Message-State: AFq9FYKYc2ptwzirMJ8zErsy4kVag+uZbZdL8yVJJxBl7JOmbbyARel8
	3Ywl6RBzHNmPBxj2I4CBm379UV0k+swy5tocEotV5mF9EVbO7HJQe9Qpkr6qwXDWXp4=
X-Gm-Gg: AYBFou0m3B29ajy39n6KRAXz502eqvaiErh7anQ7QLkRNL8K74JK3Oo1RfZdRTlq96h
	QlyeFsCq9g5jueMe2YGc8iUk4f874bhkH0M94zPkQDosEaOyPoMK1jPzmySL6ecJG+3uiskbjG2
	kfcG1Yj7sV/M69bSSZG5r0Ay2JENfsFoFOFnZ3fRgZNJwZfrnEzG5+OezjZXy0Bk/CcvX6jiYaE
	/yFaesEyWSv4Jca75OmOole8Rd8nWlpRSbGzJL1bkBG4K1AiJ9JGTV5uIVjB4pFxbQtQy9HEjUh
	D3/x1YdyAYm4n74T4E4vAlayZTHFwsBt17VCgW70xb5g9lWSx0R7JecaAGaGUiTbUsO2rkJJMw5
	w8uSKhngw0a4yDj/vwpxHQvRirmU4tviES6xXMb7I7QL0U3+nLqzdL9j6tQ26HECR98QiM/bFHI
	jVbxGQ/It67o6WOxm3Z4pXi/JCStqXcWEilv1ZBERCcBnqPEKdumC2KQ4J3zDoIcOGF0d1E1X/k
	MtdTbaK/c79c1IQtdjMlOShj36nhWxquuxWvetFaRTDfnrthst9bdKxD7vRdIQ=
X-Received: by 2002:a05:600c:3b91:b0:4a1:e0b7:ff09 with SMTP id 5b1f17b1804b1-4a1e0b80060mr5725415e9.33.1792250331707;
        Sat, 17 Oct 2026 08:18:51 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:471d:9ae9:4cd8:a378? ([2001:8b0:aba:5f3c:471d:9ae9:4cd8:a378])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bb6sm12456537f8f.34.2026.10.17.08.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:18:51 -0700 (PDT)
Message-ID: <8c77cdccbbef939d980d80c07376c9808e37fc5f.camel@linuxfoundation.org>
Subject: Re: [bitbake][scarthgap][2.8][PATCH 0/1] Pull request (cover letter
 only)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Yoann Congal <yoann.congal@smile.fr>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 17 Oct 2026 16:18:49 +0100
In-Reply-To: <cover.1792191269.git.yoann.congal@smile.fr>
References: <cover.1792191269.git.yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 17 Oct 2026 15:19:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20355

On Sat, 2026-10-17 at 00:55 +0200, Yoann Congal wrote:
> This is the patch from the last patch review:
> https://lore.kernel.org/all/cover.1792020468.git.yoann.congal@smile.fr/
>=20
> Passed a-full on autobuilder:
> https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4934
> * reproducible failed with #15898 =E2=80=93 New sstate.yp.org CDN reveale=
d partial sstate reproducibility tests false-positive error
> =C2=A0 But the test warns about a missing sstate object from the reproduc=
ibleB
> =C2=A0 build that is supposed to rebuild everything anyway, then, rebuild=
s the
> =C2=A0 recipe. So, there is no issue with the series.
>=20
>=20
> The following changes since commit d3b32587c2314febf96897f97e0172790b4fc1=
cf:
>=20
> =C2=A0 toastergui/views: Replace os.system call with improved parameter h=
andling (2026-09-28 22:25:53 +0100)
>=20
> are available in the Git repository at:
>=20
> =C2=A0 https://git.openembedded.org/bitbake-contrib=C2=A0stable/2.8-next
> =C2=A0 https://git.openembedded.org/bitbake-contrib/log/?h=3Dstable/2.8-n=
ext
>=20
> for you to fetch changes up to 6b443060ee96a62efb94723c97f22b51c9b20507:
>=20
> =C2=A0 prserv: commit new revisions when a request succeeds (2026-10-11 2=
3:40:57 +0200)

Do other branches need that patch?

Cheers,

Richard


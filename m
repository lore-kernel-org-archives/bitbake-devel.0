Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FD6F013F9
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 09:26:48 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46569.1773653205829625584
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Mar 2026 02:26:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E5lU2nab;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899fc265126so51980586d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Mar 2026 02:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773653205; cv=none;
        d=google.com; s=arc-20240605;
        b=JRqZ+zrUEdU18NOG/57UKYLdXLyQPaZKPthyxy4yvuerYJ6h5OkRYlGbxyOJA3hnbD
         kgKxTYz3r0+r8OKyv/wErO8IRQwfs2FwgYnCbLQjI3wk6kG/JBREWuiF5wLZNirBHakA
         dl/6xHhLhXCXVO98LujXgsX13hd2XqFo805ejsI2+fOewxPe30ok1HWr62pTyQkjprBj
         pL/ZVlhOssYhUzeQvWCk7xDMrQPQO+EgrT6H2rlz74nep0pWAtekZiXQZEQ1suWgeZCM
         ZYSjQ4bQWaltNdiSMXAIYP8NodFZtUlMKHA76+pKF8ZLzyh6qUbVsgxsKJqtVzWh+uDu
         m1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9n/DMDMfwJVzrSe9UnW6AhjdWclyt+8IKzEeVR3aP9c=;
        fh=yDcyW/7xJ+Ani2pFlv9zmf35GeCKyL/VUXFH3Afwlps=;
        b=F3dDPJbQS+wVrty5c0DSi2S++fdDLyJyqi9aWEl90z/SPRlaqk3jffyA1JO11jW+X/
         boy4suK7CjhDyEunfxaic2KcQuJ8fhbLV3qwYGoBBYfZEa1QxVMVQT4m7HWPPpCeBoUL
         oTx1aqeDSKaWnsloqn0pjV57dq7jd8awJO38kN0dospjdICyJY170a7B5yusvDrdAUHa
         KMyc6F3Y8qbgM8VOw0M0viOelIlFHSXtdzYn9ER4tnOMI+VygyPGWZdtNLJb+Hrnyeop
         Jl8ssZ5b5o2Gg9atHtl7Z6TGJvcPnzwf3erD3rXXV2wJdIOA5ZHfY68YrjU46NOEoffA
         A6kA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773653205; x=1774258005; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9n/DMDMfwJVzrSe9UnW6AhjdWclyt+8IKzEeVR3aP9c=;
        b=E5lU2nabT2ZroBYzzlWGkh2Sapm7kZeCE+/+TykBX0a/N3cJKlBMC953TwZA1cL+GL
         6GvyfPz1awxgLZK96poiQSMLEzAHY6xWEaLgxM43VYN/Kj9cwT9uaCuaIz4eRe5sNEWt
         aHNQJLjQ8M0+9GGtTuq4jueWls1OvpJVmn/2Uy55xrzuc9mkV7x2YAx3kUCae4x4BwX/
         q3JHdXXWTYqaiHtbAua/mfVXZPoaZZ2fZsMtcPi7SA1yHN69TwfFFDyLGfOSQLxkltAr
         aNZQq6ysavbkX9HSQa8kazLp1ZqCKlI0f8NdKGowokPzFBSAHZ2va42/r3aHz5wNUhl7
         pcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653205; x=1774258005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n/DMDMfwJVzrSe9UnW6AhjdWclyt+8IKzEeVR3aP9c=;
        b=gEkO99jKJ3aeiT0wUIKyrNKtc0KQVo3kABL0x1AepemPwVY538zyuqTMKYJqumNnFi
         +DTV5B/7FIIn4a5VEZXAgP/JnqYiiTqsTmE7uTifQKCVPzlminEO1nzfEHTPfSuDK7oN
         SlaNwh7k7Z3ZdSH7w6kMgnnFO2rPB39+HlXMDo5K3AwgKdVmln4sOw+cSKiS7B8LEKfq
         XWav2XOyWcYh4Yaxfl6BCuqBBQGly8bB4YIrFIB7WetQrL0Z7BnI5MAZJ3mUo09hKDib
         xOeosiSsl+SEBC/ZYkl4jfcirpXui/2GarWEd0B5Ntx39762v3+nN8D+brGN4CuDKURG
         Yv/A==
X-Gm-Message-State: AOJu0YzisFhztlU7hY6qAgs3m3S+pAZwpK4DKyThpG27UCr2WaaHJceI
	DuCLInvNW8F6nueoisSDMuTIYYjxeWHjFeOpLZnMleIlEF4BGg0npfimM/24qtgNrwciPejDfTf
	AF0G3yiWiFaIfMSxjjAcaEX2Epoge/F0SqQQ/
X-Gm-Gg: ATEYQzxy8gGEmlaRfZWNDtzeNfDBjKpPoZfRQHAVl5rF48RkLIG78+PkFgu9vHdNAYB
	OYQdy+2vWl68KrBxEGHAgCcdUJ24soChHVspfKFb1bjYsPTlUbaKBO3/z1Y8WF86rPs8ES9O4ZX
	bZbBjEetLZhbaoEm9EkImpIn9il80JvnC/50hvAUUjBcjsqoJQWur/fka0XheD2tV45t+bN6NIh
	I49ieqUBeRgft3ROSSN1uHVbnlpgJK48eIi9W9EYmYDY1sFrhJdeGAgD6op3xJe1s9D49bJgCW1
	3LY83otWSbmxERFo/q6T7p0MgePmPA6i15SpHZh7HQ==
X-Received: by 2002:a05:6214:e85:b0:899:f9f5:97a2 with SMTP id
 6a1803df08f44-89a81dbaf49mr174294896d6.24.1773653204638; Mon, 16 Mar 2026
 02:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260316090420.914602-1-pierre-loup.gosse@smile.fr>
In-Reply-To: <20260316090420.914602-1-pierre-loup.gosse@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 16 Mar 2026 10:26:33 +0100
X-Gm-Features: AaiRm52cEUQBoxXBQXEQ8q7SY3VUnyVvyUJAHhCRdp7EHHPGTLPpB3F2nLqzGP4
Message-ID: <CANNYZj-BGkGbQcq3yTdp1f2pMpPdEQrpQQj2as4w53bJoyj26w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch: AWS Codeartifact fetcher
To: pierre-loup.gosse@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Mar 2026 09:26:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19157

On Mon, 16 Mar 2026 at 10:04, Pierre-loup GOSSE via
lists.openembedded.org
<pierre-loup.gosse=smile.fr@lists.openembedded.org> wrote:
> Class to fetch AWS Codeartifact asset with the AWS cli. The aws tool
> must be correctly installed and configured prior to use.
>
> Signed-off-by: Pierre-Loup GOSSE <pierre-loup.gosse@smile.fr>
> ---
>  lib/bb/fetch2/__init__.py     |  2 +
>  lib/bb/fetch2/codeartifact.py | 94 +++++++++++++++++++++++++++++++++++

Please note the fetcher requirements in lib/bb/fetch2/README. Does
this fulfil them?

Alex


Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFBDCEACEF
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 10:38:32 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6487.1763375898463217762
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 02:38:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e/YH0qvN;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8823d5127daso48748686d6.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 02:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763375897; x=1763980697; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EyOnWLBAlrNTFvVswL4m7ojSKSq68xm4J9Y9Ixkq+vE=;
        b=e/YH0qvN2BwmSNMVD0w0jd5460r4BMagUA8yKjIzKiEd5CmqNVNjakxZT+1rTsfvOT
         PV4d2UdN6/CY7yajUEFaPtJRdAI8GQFv/qudVDGDZ9Teuu6lvxB/DRyu1LMD0LL0mo3g
         KxEF9oVUbBYxQ6qlFfCN4GGVGPvtbuaLX3UZVqDMywuyTb+nJ1qr0ttC2S5cOI6aBJXh
         FvgAZRDzVY8LPEyEqmFRzG9q/m+k6r4gfTGZ2uFENuL/6Gmd+h8WgLKP2yCnuQv6+Emg
         dEZ07f3y6nXtN1rTNGrBNNZY3RYOcJN3oMWB4CroHLZyZC+XRB6k3jHo0ys2fbFIRTAK
         Eybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763375897; x=1763980697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyOnWLBAlrNTFvVswL4m7ojSKSq68xm4J9Y9Ixkq+vE=;
        b=v03cEfpop1xMaFTzOXzb1qpqPK36jqvPaGvVA4+IUXB94in9CTDtmtQLvTd4y4Q9nE
         vP05ufVYWwQjniJXJn5862x3/OF1qhTaCw6PYnTX3Hw3dJe7c5CXzO/kr6UfDKoalttw
         2gdGhyGaud5AUE3Mvy9LploprRI4+32wbNw9t4ajxjXkFiVeWhAd6OBiOrGLzrShueG7
         4p9ynOX7ditTrcZMPuhRmeYnvQuYtmItrV+MvYPGqnoJwNN6+J1JFArZv1njJZ2Ij6rg
         5AKAWosshhfmjiCdwAbE+H7MtvAR7DJdTPPEKf0T6xVptj2pv9NNjQm7AB0V6lKqlPEo
         aZKg==
X-Gm-Message-State: AOJu0YwyhXmu8nukOTfkbpFKOaHWT7ZaU8j6uKvDwC3Iq27VaRx6ndzM
	DVP+Eh2MiGiD14288GAVKCkoW7ppq7T7WmC58bfgMEthujnGXsdebzf8znbDD1NcurdnO1p6Jux
	TKjpux7NvlAuzIHsgGLpQso83wMk4Uv4=
X-Gm-Gg: ASbGncuIqD74cwfVnqwVbsR5o6OCajzsgeFirv7VY28yZDe+0xycQhuZBbHueh2ViFe
	0nIn4b1lBZGQ0VP2Wi8beGwtUSM0So7DX3hCHbkk83QFxA283dJV9dktVnxjQVpBDAcOMJNDv9J
	p/EX50ZV5zF6STqHUliOqh1tIQwJN4TLGtp5BApikN2e30f5GWjiAhXvB5cx8+jnvegf2CyKRAx
	qAWAjGXJgri+qD/2Uxz6RNE1yxPQF50rCDOpnCM7yjTID7ec1FYVyZx1e1P6J9fHsG95D8GdfnY
	Y56DFFwpF2ZTpCGaE3lI5OUInFMGWYHv82gDjy/3
X-Google-Smtp-Source: AGHT+IGSrZpotrMqJqzBk54KQNGydgvHbx8Fi/UuuyIW+GhU00qZx9G9cuXzX4qXGtQpkfr3MB7ijDDA78Ql+Xb3wyk=
X-Received: by 2002:a05:6214:40d:b0:87b:cbf7:5eae with SMTP id
 6a1803df08f44-882926e192bmr189746406d6.59.1763375897268; Mon, 17 Nov 2025
 02:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20251117-bitbake-setup-abort-v2-0-a73f44e83bc0@bootlin.com>
In-Reply-To: <20251117-bitbake-setup-abort-v2-0-a73f44e83bc0@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Nov 2025 11:38:06 +0100
X-Gm-Features: AWmQ_bmCumhnOvfPlxGKBdQHZQFrcmMAidTLKZ40-X9ZHUGfzty7Mnwhks1XGv4
Message-ID: <CANNYZj8EA75sPDmPJ_+w==s+J+S+6y1ZRCgNtFaSd_FhB81Snw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 0/3] bitbake-setup init improvements
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 10:38:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18422

Thanks, v2 lgtm.

Alex

On Mon, 17 Nov 2025 at 09:16, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
>
> Improve the init user experience by:
>
> - Creating the top directory only when we need it (and avoid leaving
>   empty directories behind)
> - Print a message when a user sends Ctrl+C
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Changes in v2:
> - In the first patch mention that the top dir was created by chance.
> - Add if..else so save_bb_cache() is still called after init.
> - Make the sigint handler global, print message based on called
>   function.
> - Link to v1: https://lore.kernel.org/r/20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com
>
> ---
> Antonin Godard (3):
>       bitbake-setup: fix top_dir creation in create_siteconf
>       bitbake-setup: create top-dir later in init
>       bitbake-setup: handle ctrl+c
>
>  bin/bitbake-setup | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> ---
> base-commit: fff23f8ce8f60aba6b89512a734623067661816e
> change-id: 20251114-bitbake-setup-abort-8a5333c049ea
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18415): https://lists.openembedded.org/g/bitbake-devel/message/18415
> Mute This Topic: https://lists.openembedded.org/mt/116334413/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


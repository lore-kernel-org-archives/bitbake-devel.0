Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E4DCED255
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 09:29:19 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8642.1763458149748312189
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Nov 2025 01:29:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bcFyF6B+;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8824a756771so51749946d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Nov 2025 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763458149; x=1764062949; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pusW3JUNqAf0VfljNaU2ND+svvC0VYbC3ysky7kYTKo=;
        b=bcFyF6B+jorBKk3NS+ncPP97gWn82ksNVB4w5vaPkhDaPqlslcAiRy4fOhPEz6UWri
         T10IxQMU1iiGgj9Wmf2BW8bdKGs7Ps7q+Vq/Buut4f40/q2l54dcHfx2Fz1wP2mKaAaM
         IoD/y4/OobEszCqAAtZLv48Xdla2mqjJGyt7yefsUGJ7LjrMks/SuVHAEgUIfEqHmU1C
         MOqF+gMugqO25mw7u7dNR0/+m+fFQ/XN3FoByTZLcw17RL6hguW3jifEsTZ5IeLL/a4L
         qA2AgF4xCKRE5B/qg8W75fapLyHWl98zwWKXd88e50jCBkjYXv9+e8UnZL/i8H4qARia
         nZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763458149; x=1764062949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pusW3JUNqAf0VfljNaU2ND+svvC0VYbC3ysky7kYTKo=;
        b=Xo8/WDfpqolOPT33J97vSJN5akmc8mRnjCVEUiaWD7qJrm/g8ZAWP3w3Vd8KgbwjF5
         RIKrsVvqQnckxpIZflOi7lAXw8ZcBkyRCaL235QfzhWcmXl2Tqm2NB8UBp38UM8v54gc
         5hdVA6wIIFwSK/nQd8GqR8pX8il9W/1PEoJ1osUlLEPD/CMMb/IxfSg1vMIk8yaUJXVQ
         heU8NnEpNbfbwl8VMnBI/DZkpPIzxgi3BSgNAwX72+ka8Wp/pQqFZcUHrlJLAW//j9Wj
         qc00bWlmyHPS9a/ftalD1ne/5CKjeKvA7GIi4q0607Um25565JZVRAC4IsXWW7/H5hIA
         0Omw==
X-Gm-Message-State: AOJu0Ywc3e4Rbzgc26X5iyXD3mHo3I5olnLJyU1XxlYASEaP7QiPiwok
	jMC170gmpIvpLkAiys9JHsml6reAbeqzXd4qzA2rXtfRbPPMNuIhLWCXpseHVHsgOModikHcqgc
	bGpHpalkOv8hTxNN47QbVTIPEoDkqyPAYCA==
X-Gm-Gg: ASbGncuMZQ7KiOARpCyRVnnPNs7q9ZV/Zmw70z66AhI0Ca1B93xFxxzerpKs2AHUaDl
	6hKg0Z8qpsXay56jkBewUCh5V5++LdrNNFe3WE+CITOLvlkCAmAAkEnJnjFnmHZeOahm/mEJAiv
	JywztBWSK0YLhfpSP6gSqUiKjx2ANQFT1XCJr0ycpfSXbIOCClSbD1TLoEWjB7WPV1XdaWKedXu
	C21aQfEx4FmZ0hN+W1aMLd4ko47Nfi6pur5txkhyShiR6Z7cRrUL97zgVNdWvGsbiP0b3C1Nk7I
	eov6JL7XxFivXRAWGtYKMT3e10vt2mF8pJc8i7Cb
X-Google-Smtp-Source: AGHT+IGk3Rp8q0c2BOJ/Q9r7LUklezvX6Lk5S4FIhlV+zL6U7WUA2ZQWa31peXwYKyVdX8GlGw2jXTJMZoxJh3g0C6A=
X-Received: by 2002:a05:6214:2682:b0:880:4c2b:1c31 with SMTP id
 6a1803df08f44-88452c0df35mr35583636d6.32.1763458148604; Tue, 18 Nov 2025
 01:29:08 -0800 (PST)
MIME-Version: 1.0
References: <20251118-bitbake-setup-conf-updates-v4-0-7336b663bca6@bootlin.com>
In-Reply-To: <20251118-bitbake-setup-conf-updates-v4-0-7336b663bca6@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 18 Nov 2025 10:28:57 +0100
X-Gm-Features: AWmQ_blHPbYZmizYzJc8MRavt5ozSgQqTYBZeZTPXiP4BngSL6QwSNEExZF5-n0
Message-ID: <CANNYZj8LQR-VBPzsk0fLbOtqLS9+jcY73aBOxA43-=rag5MEfw@mail.gmail.com>
Subject: Re: [docs] [PATCH v4 0/2] bitbake-setup: update: add a
 --update-bb-conf option
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Nov 2025 09:29:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18447

Thanks, I think this patchset is now ready.

I'm glad there are now several people that actually know the code;
that means you can experiment and implement your own ideas :)

Alex

On Tue, 18 Nov 2025 at 09:20, Antonin Godard via
lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Changes in v4:
> - Simplify argument passing in build_status(), as suggested by Alex
> - Link to v3: https://lore.kernel.org/r/20251117-bitbake-setup-conf-updates-v3-0-46cdf826e79c@bootlin.com
>
> Changes in v3:
> - bitbake-setup:
>   - Change the conf diff logic as suggested by Alex.
>   - Use args in build_status() to get update_bb_conf.
>   - Use get_diff() instead of git diff in _setup_bitbake_build()
> - test:
>   - Use hashlib update() instead of file_digest() for
>     backwards-compatibility.
>   - When computing checkum check that the item returned by glob.glob is
>     a file and not a link (previously it would have tried to open a
>     directory).
> - Link to v2: https://lore.kernel.org/r/20251117-bitbake-setup-conf-updates-v2-0-209637e01fbe@bootlin.com
>
> Changes in v2:
> - As suggested by Alex, Rework the logic to apply upstream configuration
>   changes first, then print the diff and ask the user whether to apply
>   or not (default behavior).
> - Behavior can still be overridden with --update-bb-conf='yes/no/prompt'
> - Link to v1: https://lore.kernel.org/r/20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com
>
> ---
> Antonin Godard (2):
>       bitbake-setup: update: add a --update-bb-conf option
>       bitbake-selftest: setup: add test for --update-bb-conf=no
>
>  bin/bitbake-setup                                  | 53 ++++++++++++++++------
>  .../bitbake-user-manual-environment-setup.rst      |  8 ++++
>  lib/bb/tests/setup.py                              | 41 +++++++++++++++--
>  3 files changed, 84 insertions(+), 18 deletions(-)
> ---
> base-commit: ae9a70c919f14ca323eb7c03ef9080fd0bd52c29
> change-id: 20251114-bitbake-setup-conf-updates-91ae4efa86ae
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#8068): https://lists.yoctoproject.org/g/docs/message/8068
> Mute This Topic: https://lists.yoctoproject.org/mt/116353215/1686489
> Group Owner: docs+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/docs/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


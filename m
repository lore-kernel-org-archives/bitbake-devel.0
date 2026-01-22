Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7908CD6261B
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 17:55:11 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43650.1769104503085053813
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 09:55:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Zx33yhMK;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a35a00506so19621306d6.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 09:55:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769104502; cv=none;
        d=google.com; s=arc-20240605;
        b=etaFgFyoL20cFOs+7Xz8vRSVmSaTZEflWhYl1YMV43ZGCijCjwfP+QBd338blkUt53
         jyi2jqXOSkX6IYC9Lpd9PUQGKw+WH4kFGlgm3HKIoIwdmkZHg2YJP714ra2wzHjrYWow
         b/SkOemAZRtTFQ+9o0lUDKaGNhQLwjo26ijz+XznflgRZtoJn40PR1NWpsZLUj0dFkby
         rV+K5iBX6Kx0Mi/g0pSNBg6CbS90EpwiJMS+NBesPnwsdmEmUx8G6NgYkjl1cJ6z0Zw8
         MP2evYerBNr+twxhfFz8K9ytHMvGzzV3Ppje2JradDXsmKJRBRc9nDREEBTfbmXaH2SN
         TUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6nue6nmU5mXdC5K4QDrTfm9FnLMNFMqwdEXJ/cKPSv8=;
        fh=qhSEGFZ5DCm8IWokOYU3VicGVJrPDbAcwTkr5XyhA7I=;
        b=GmefTjChldUg2ydn8wU5PKzmPaHryrx3CZoXFGRkQeJz1brfaHj0RgkXlTsJP0MTlf
         r9gw7RsvhRZlp7DU/IBZycp//Nl6gT8QofvUrPYX1XC8OpPIQgzZ/3dnQnJ08pDAUo1Z
         LYsMAwn9AnwJwMFmFTcyz5/1TGys9pk81w/p156kQwyJJhsnD1L5Z1GmOCgUwGNaoi+t
         GtEeYQBn8qGZLnCe7kQ4kyC1mMd/97IDJhTnFm648HNQBZ0/1Fkj2eO37lJphdytRb8Q
         BjzM+zeh7bW+llyYYk8z6ydhxlQclTi8+UkC2puSxzxpjczrYr0wv+WNDHDfHXO/Jw8t
         cIig==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769104502; x=1769709302; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6nue6nmU5mXdC5K4QDrTfm9FnLMNFMqwdEXJ/cKPSv8=;
        b=Zx33yhMKkw/abQAVLrgWxu0HCH8ByO1Meo8hK8pgsg6bl8FTL+QPClRL5DZiROnwCW
         eKb58zKeq+CEm4N/rRoF/Jxt5bckWKOTLHAEDHxEtIcva4e/wktB/XCg5jhP35OHoTQQ
         KiE2WpWmYgyprM5Jh7I7ztz9c/xJ/LyMFSAAgfd5AZJn3ufq8W6qiSAYPQcgmIwlzlsm
         BWqweU9nltvsOIV7n+IzieUD0DH49dPm61CfO0DP4G1+ep0uTCL0X7uetuEoeoVWnRwU
         H5geunRaeSftkOwzwZO4SLw9V7z7o2Wzi2UNbCVG+lqXd0yv3IfX7s9Shd+mY1RT3tk5
         iX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104502; x=1769709302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nue6nmU5mXdC5K4QDrTfm9FnLMNFMqwdEXJ/cKPSv8=;
        b=KZVikAZYek8N6mSbOR7tXWleVDrSyhqErt771hEyirkJf2nmE+eZBc5Ho5Y8rv6mD8
         TRdP69eQwSjUHJMKBnmT5ZzCmcyM1YB1X7vIMfocn6OFbyyTInqhxZnQb2eOwEtRQd2O
         m96yto0ZvcqBmhCUGOZHhpJVliTRI0sFk6KnoCoLrgVlt0C1BVWyVtUSoq5scHpi+TTD
         rMiwOu+WCTIzWUsFmUTHNh7ATc67ao+rA+tGPAGWKMfpXfCj+MwzTCSoCa2GkOQzhFy/
         sovvhjVuzY61qrVR4j2+bQF2OlhSbu3ysqRw42yIw1VZxBPuKG0Mt1F/gPQAfns5NN77
         ov8Q==
X-Gm-Message-State: AOJu0YzFofCCzPP2hkiXbokM3WBvbg/IwFgv2pj0gaH55tGVTUb+QXnx
	9ivsZoVDfwzMh3tPNVt1f5IPQSwnEDOwejB4wVJfrzdtSBlE83Uj4jZ7HVsL7gySAisFHiKUGGI
	q6+PxDYGXXSJK/WVrbK80/Bsuuz1snQY=
X-Gm-Gg: AZuq6aKVIA3oBjcvaOxoIeMXyivJ8fwzBfbspO7cFzLiatio+4qlXsJ9gtt/7ANHCGj
	wYYNkT73K+8ExTzYQE+0kgK5k2v/SLGuNMOU6k+lSAYBu9OTOeg4GmaHvTtHlBS5KfNdURVhq6u
	GdiRsCCbK+D8zZLQIHzvqV5/dqGM2adEdL3KrUtga8vo3U7pAH07Zb9tKzefhmtvFqXBw2LV6Q+
	RmfOZipv9KjOTbeNC7fjzKpTAmD3Hn6idrMsJFizpODxp9WYHy9FZL/gitmN7W4xkn13zPQJnil
	FOCwMrwsRItNF2Wo0OWedI4xhi33UUPVwsg851r4
X-Received: by 2002:a05:622a:44d:b0:4ee:1b0e:861a with SMTP id
 d75a77b69052e-502f772500cmr6356921cf.13.1769104501970; Thu, 22 Jan 2026
 09:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
 <20260122-bitbake-setup-choose-builtin-v3-3-c55291acc1a7@bootlin.com>
In-Reply-To: <20260122-bitbake-setup-choose-builtin-v3-3-c55291acc1a7@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 22 Jan 2026 18:54:50 +0100
X-Gm-Features: AZwV_QjO-jYNQXari-fVIBaJhP-1xx7vE748q_nwOSbT8drWAnNQtjwT2e8z538
Message-ID: <CANNYZj_SUcRFLWobRO9GHPzN+ZtG9koKVg4iZ-gzoKsSAUiMoQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] lib/bb/tests/setup.py: add tests for oe-fragments-one-of
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 17:55:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18854

On Thu, 22 Jan 2026 at 16:02, Antonin Godard <antonin.godard@bootlin.com> wrote:
> +            },
> +            {
> +                "name": "gizmo-fragments-one-of",
> +                "description": "Gizmo configuration using oe-fragments-one-of, both formats",
> +                "oe-template": "test-configuration-gizmo",
> +                "oe-fragments-one-of": {
> +                    "fragment-desc": {
> +                        "description": "Test fragments (with description)",
> +                        "options" : [
> +                            { "name": "fragment-desc-1", "description": "fragment 1 desc" }
> +                        ]
> +                    },
> +                    "fragment-nodesc": {
> +                        "description": "Test fragments (no description)",
> +                        "options" : [
> +                            "fragment-nodesc-1"
> +                        ]
> +                    }
> +                }

To avoid multiplying test configs further (and making the tests
slower), perhaps this can be added to gizmo-notemplate, and that
renamed to gizmo-notemplate-fragments-one-of ?

> -                                                                 'gadget-notemplate','gizmo-notemplate')},
> +                                                                 'gadget-notemplate',
> +                                                                 'gizmo-notemplate',
> +                                                                 'gizmo-fragments-one-of fragment-desc-1 fragment-nodesc-1')},

As there's only one choice in each, bitbake-setup should pick that
without asking, or having to specify them on command line. Let's test
that too, and drop the fragment names from here.

Alex


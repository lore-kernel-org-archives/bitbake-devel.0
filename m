Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F15CFD342
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 18:04:29 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23297.1764007464253938067
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Nov 2025 10:04:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DIiqwYfK;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8823e39c581so70643206d6.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 10:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764007463; x=1764612263; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5cSpZIQ0PGkwc3mUcG3s264Qc1hbSb+YkNgfTiTGM/8=;
        b=DIiqwYfKNJPP2F7ZRNpcpS/ecrT5R3dT8yTR6eOXV4Dd4WvEu2pu+EJEdD8+P+tHag
         yZ+agvjMgBurxPUsZKRoBJ9utSmwkLoYEUaBIffV0z9t1LP3Pg4vZom68uvyzYfAVaKN
         q95QxYytU1Jro/ybYXtGIRVz/rF+0jLgeOwWcZaouw+5Hc7hA8KNNPoCRh9r6jfbK0cg
         STQC13HoBy/8fJydxNcJY2vGMvC65GrC5W004xtR3yza74o26I9+wZD77lueZxOHArvH
         oPGPGUw3FGFm0ognPQDAXh41MscR5CH9btmKuaI7Lo4CGysKMqpRuYqcjxjYsmkDtsg9
         hNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764007463; x=1764612263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cSpZIQ0PGkwc3mUcG3s264Qc1hbSb+YkNgfTiTGM/8=;
        b=YTb7PKo3nzJZ3GFp5mh65NmorMCUCfPPgw/k1nqOavs4hyJfYu/Jtxn2qXh6rqMEnS
         YLxJZTBvrsKbkFZhIDnQ0THFWMhQ6EvnseV6ZRElPd5kIBPyJWSXPeacVQ+mWm/zBMEK
         FifgHEko/QKlQYz5oydJhS4sW/++s5e2Cw7QWpwMIOyTI57xtzbnpJjb94uYnexS5VIS
         KJMqRyh+GYXgDhMjxPDnQoDCOLLNrhaN7zBItap7s8vdgQwDGqMxDTLmFfKISiTY2PgX
         NJS4XTeY9HHpccwbRcfV8S3BxBufxGI1uM4b8oebDNML5Jx0vCeGP3hIImspv4HAeduS
         TQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCWNTFWJKIfco/DANEWSuptnFsvFXw/7Oix0BCuKxRW2108mxXOACQnZIMM4iBzZJbhe6RjmVTXKHxKE2EVr@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy6z51miGLClmeTCOMz1oZst3IjllmF6HYz1DvtPCZUPUWaQyt/
	d+ZZu+xVhm+10Vuo4/xLxbeO6o02SmmL83usZoEUn6xqJspSZV8Kks2/yl1pOXUG8rsybenn+ln
	RT3SKS6yfUiGc4JEzU9lIUFNx7LH3gMs=
X-Gm-Gg: ASbGncvbwNBrWQSaiyNuJNv77RSilKAGLGJnRFn2ZE+bDlJ7ht3j6V3WL2HUDIqUnJv
	ML6OBToBah1xO1b+AAjIfpJdxwqzduYIf7iQolAo4URU5vVecmaNsTnDKmDT/gq8gcF3ZxqaPvl
	E5HYTD6GBP6LBX7G5TFDxSHd+NzjENm00qDbxYP4DQnzCxv67b5VYjFUpVLJbO0z95D/WkRFpR+
	AZ3YcTh9k2alYtSfW36DwhD6Us9xyIIVGVWI14XldcKgWkyr+ON7dQfJTwvorKwQCGrnlD2Vlck
	w1w4Z14MN9Giefn8wJjdALWZI29lwg==
X-Google-Smtp-Source: AGHT+IGUeszkuMEwI45n3yxBHPzV3yuo37Zjna3JWwobycL50tdk8qnyHyAZTwf+SHzZ8PGuLg74fKFpIADaIEtBHyc=
X-Received: by 2002:a05:6214:1942:b0:882:3c0c:a41c with SMTP id
 6a1803df08f44-8847c49f579mr168667926d6.11.1764007463016; Mon, 24 Nov 2025
 10:04:23 -0800 (PST)
MIME-Version: 1.0
References: <aSSUtHYFQlychNQk@osama>
In-Reply-To: <aSSUtHYFQlychNQk@osama>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 24 Nov 2025 19:04:12 +0100
X-Gm-Features: AWmQ_bmFrRYF1HwrKYNG6eWsuAE-_IMbi7ML-GskCbl6pWZ6rnPBYqWhOtSibCs
Message-ID: <CANNYZj85vK7o4KVDUtJ_DkW73bxs7UMA-bM6K2VRada-yCFpfA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC] Proposal: New tool to display recipe
 dependency trees
To: osama.abdelkader@gmail.com
Cc: yocto@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 18:04:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18481

On Mon, 24 Nov 2025 at 18:24, Osama Abdelkader via
lists.openembedded.org
<osama.abdelkader=gmail.com@lists.openembedded.org> wrote:
> Should the tool:
>
> cover only DEPENDS (build-time)?
> include RDEPENDS with pkgdata?
> resolve virtual/ providers?
>
> Any prior work I may have missed?
>
> If the idea is acceptable, I will prepare a proper implementation and send a patchset to the appropriate mailing list.
> Thank you for your feedback!

Hello Osama,

DEPENDS is a somewhat unfortunate variable name that we're stuck with.

It does not actually specify a recipe dependency, it specifies
something more specific:

- run A.do_populate_sysroot before B.do_prepare_recipe_sysroot (a task
dependency)
- within B.do_prepare_recipe_sysroot task, take the output that
A.do_populate_sysroot produced and place that into B's sysroot (a hint
for sysroot creation)

So I feel that any tool that aims to make things easier should
continue to present particular tasks; there's really no such thing as
'recipe-level dependency'.

In addition to that RDEPENDS is not specifying recipes. It is
specifying packages that the recipes produce (which sometimes match
the recipe names, but are otherwise distinct). You really should not
mix them together.

I guess the question we need to ask is why 'bitbake -g' output is
difficult to understand or unhelpful in resolving questions people
have about dependencies. How can we make that better?

Alex


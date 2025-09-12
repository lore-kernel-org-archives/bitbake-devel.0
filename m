Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C5ACA101F
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 10:13:04 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.13058.1757671977522079221
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Sep 2025 03:12:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=klEDRy3K;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c6b9fcso13773571cf.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671976; x=1758276776; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm0BowGJvmNEvWPVOM5xtT39bcmoiUdlfgx9TWragXw=;
        b=klEDRy3Knasjetrutibmj3rLN5oXte7JW+IP3V75NMAL5fe/b0ll/EdBdk+r+sWYoz
         6n9sImVWds1JC11srcCOqkE6iadX26lZz7jWZzJOiv8YmcPB7TSURcXuwVuY+dDE3Gr+
         MiK2J0sjIFSKap+VK6vf5C+yb+D3pX7+1diyU6y9NMEBsZZdaLKPyXXniYZtIpBQ1WoQ
         Np1X0FryxqVzTA91XZVknJiOlmr0kr8TnzEPFbATD5Nl8MrOmdrxHkg04yPbAP97xGVJ
         aEbizA5pcpgCN9M57FsiycnKddIieMRU4HL6hW0d93Y6qCG+w4v0pI6272tXET7/Fyrz
         X6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671976; x=1758276776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm0BowGJvmNEvWPVOM5xtT39bcmoiUdlfgx9TWragXw=;
        b=cAdBQGlDkbLiIVDrj8e3NE96rZXCbYnrfhIIR2QK29AtxiGRpmUGx/nsnJLcp+PYwd
         a2rUyzAKe50fEXSb5A/JdY2sEBB2U3BMmqp5nFNcKyyCtWT0gHd9h6D22Vn8VfAC9Skh
         UPs0zpLV45oVsqIAIW9zWvFxVsCIsbg6q2qNzVkgmYB/HCW7FTnuFk8bCmihIeak4H4d
         6q2PuONgokXtcHZjTdCTWRdk4xOvuzTlphVn37PYgfeKt7lQu1qf4LLDRXKmnWXWsKtu
         FqYK3jZVUYmiAjHqy6O+EsXp36pc4qGuctQVEfi2e4fiIXHWvyK01rar3Bc11h+bu1UJ
         EA6A==
X-Gm-Message-State: AOJu0YwBiYuSoAEAfn7EOLJm7i1WupWdtH5HqiNIlxTsWvdR+mHjcgih
	s5nrmUB0/yTBrhycyqbHRZkU6DXhzCWmHIQaDXcK8TqY48HjfFHq96hIiS8JDUXdQ46F833p54u
	9kzi96s7RY6SUtAA2voApjRIzMn/ynRg=
X-Gm-Gg: ASbGnct3CEfbOtSzXQqKVasSbjyAIbAkvj0CbxFxGhya6DWJDQfNvOwADc2YujoEweC
	Bex25AdRy/GZ59kdppAScdCfrBIIta1ZZpdUWqHMjJIPvJJL3cfz56v8VWEWFvJqgznwGYFMWxW
	AkAWZlUH2oETyeWed9Il+ggLCOIUugBkQGOwo3bA7XReF6Bjnb91ZJMkLZNR/5vEHsAYwhDzoC7
	F2wPDmbZRcDypiYhw0Xprp4Iyyg86zCdLWE0l4yVZVUvY2WBDXJyXVrnz+or0cnoE2aWuly+dhg
	7Ho9kyjH467UR/AOIasoNAKAtRo2G4bf/j2q/VUIF5IxgPT81/k=
X-Google-Smtp-Source: AGHT+IFIkErVAy38oARuSSqhuxYrb5W2E8el/HIe0NTk8Fuc7m1HG/wHzglkaFO8HukFqYOzDbXhRIqHaq9F2efylWo=
X-Received: by 2002:ac8:7dcf:0:b0:4b5:dbe5:c1d with SMTP id
 d75a77b69052e-4b77d14578dmr22376781cf.47.1757671976537; Fri, 12 Sep 2025
 03:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250908123437.1728264-1-alex.kanavin@gmail.com> <dd91f763f6d54bf3fd48215cfad51c2d0b0cfb56.camel@pbarker.dev>
In-Reply-To: <dd91f763f6d54bf3fd48215cfad51c2d0b0cfb56.camel@pbarker.dev>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 12 Sep 2025 12:12:45 +0200
X-Gm-Features: AS18NWCijd8skyBY2TmlDnmapw3gjnS57kB2goSyd0_ZRFFXYdjdzyTgMjSryAs
Message-ID: <CANNYZj-o8Csxi5gN9PMmBivo7_SEn61rcRAos+deHDWVaq+Abg@mail.gmail.com>
Subject: Re: [PATCH 1/3] bitbake-setup: add the initial implementation
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 10:13:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18008

On Wed, 10 Sept 2025 at 11:35, Paul Barker <paul@pbarker.dev> wrote:
> > This commit includes fixes by
> > Ryan Eatmon <reatmon@ti.com> https://github.com/kanavin/bitbake/pull/1
> > Gyorgy Sarvari <skandigraun@gmail.com> https://github.com/kanavin/bitbake/pull/2
> > Johannes Schneider <johannes.schneider@leica-geosystems.com> https://github.com/kanavin/bitbake/pull/3
>
> The commit message is missing a Signed-off-by line.

I corrected this.

> > +    init_script = os.path.join(bitbake_builddir, "init-build-env")
> > +    shell = os.path.basename(os.environ.get("SHELL","bash"))
> > +    fragments = bitbake_config.get("oe-fragments", []) + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
> > +    if fragments:
> > +        bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
>
> We can't trust that SHELL will be posix-compliant and able to run the
> init-build-env script. Perhaps we should just use 'sh'?

I have also corrected the shell= assignment to just
shell = "bash"

Alex


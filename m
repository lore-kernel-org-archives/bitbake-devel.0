Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AE1C433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 05:35:41 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web12.3284.1658813735387684968
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 22:35:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=VXI9M3g3;
 spf=pass (domain: gmail.com, ip: 209.85.167.41,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id m12so20014322lfj.4
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 22:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQ8kSJBnsDHIz5kN0rsB2h/5PgD2EnMFJ1EEOkCDZ9I=;
        b=VXI9M3g3ny1O/xILe1oEvbQwzPX/t86GMPHTKcNYqC566Qw2A3Bp6eGy+zDz7QP7f7
         TpG/jXTC6uD/6OGkt+VIohEaNPijS75Xufo5KVFDFf/b1DIzH7XWrK2rYJ/rlnFHm/En
         uW7PelLYUPJZFhRk64pAS32TE7tNHu8NN+ErEbnr/APILhp1CFqUL9iMZap9bcC8wK5b
         X071oUZdoD1rQJOEeNtuzRj6dNues+dNhUWhung9FYgGwg5aKLh6k2QC731CW00MWV8E
         38WnqDbLFeHQ0CrjvhYiWyQg81J+r/MSM1yOUH5KyAnnmiaoCl+yO/Ji67nW9WHAOJR/
         FNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQ8kSJBnsDHIz5kN0rsB2h/5PgD2EnMFJ1EEOkCDZ9I=;
        b=RNtbVt5NSYR/cqIq1jQxuxg5XlohBoaY1FGL5n4F33cD0yLk59khsWUjsf2j7MN/rs
         Ill4pfqN1QqH21zWN/uR51uPVpmxMCUoF0momrR+haXLQngH7bQPLZ/DjSuNAJ4BfWxW
         uNCspajX5+KaLeNEIAHhDGeTH3r7zIAtNJAG6TvSe4i0FtLLZsxa9OlwGgKSskEmrcsW
         H/hiHTi9mVRmZbq8MT5lwrT5KPBqHjb+YPsmUDotn/B2P4RJ66+bukOkxx3SZL0W0m9Z
         TLLmXJr2FHi4BNkoKqS76Z5h+8zSRIAv2bl96YyhoP2NkMGR41gy/UNbru3O+0OLn3Mz
         o+Bg==
X-Gm-Message-State: AJIora86zD6BBqXE6ETsZOcJAvWHWfpCaEKbtMMmIvwiZEfdSapUBA8M
	7LQr1/CyjQeqxs1KPD0uoxUsClGC7G9hmTeR45g=
X-Google-Smtp-Source: 
 AGRyM1seud59bF0WtsxNJHFqPa9LkKEGgdDfscs3o9qncOAmhGsDKeGofnc8g+Buhs9wAYcXFnCR/+nGgTBLqGo2pEw=
X-Received: by 2002:a05:6512:238a:b0:489:e6f6:c13f with SMTP id
 c10-20020a056512238a00b00489e6f6c13fmr6190353lfv.673.1658813733214; Mon, 25
 Jul 2022 22:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <20220708205407.1680137-2-ptsneves@gmail.com>
 <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
In-Reply-To: <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 26 Jul 2022 07:35:21 +0200
Message-ID: 
 <CANNYZj99t0x08TYJ6JmZC9uT7VderpqjPCdKRp-QNzJAS2s6Qw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch: bb.fatal when trying to
 checksum non-existing files.
To: Patrick Williams <patrick@stwcx.xyz>
Cc: Paulo Neves <ptsneves@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Jul 2022 05:35:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13850

On Tue, 26 Jul 2022 at 06:09, Patrick Williams <patrick@stwcx.xyz> wrote:
> There are some more complex examples, but one easy example is a recipe
> which had `file://${MACHINE}/eeprom.h` in its SRC_URI[1].  Any machine
> which didn't provide this file, even if it never intended to use the
> recipe, now fails when we picked up this change.

This is not how machine-specific versions of the same file are
supposed to be listed. Just use `file://eeprom.h`, and bitbake will
look for it in subdirectories that include $MACHINE, and if not found
there, a default version will be picked (which you can make bogus, so
builds will fail at recipe build stage instead of parsing stage).

Example:
https://git.yoctoproject.org/poky/tree/meta/recipes-graphics/xorg-xserver/xserver-xf86-config?h=master-next

> I know we've been ignoring the warning(s) for a while on these kinds of
> failures, so it is our own fault, but it is kind of annoying the new
> behavior.  We now have to make sure every recipe not only parses validly
> on all machine configs but it also has to have fully populated SRC_URIs
> even when the recipe is never used on that machine config.
>
> 1. https://github.com/facebook/openbmc/blob/f0d9511ad2fbd563a6b793093cdac557c5ef2a89/meta-facebook/recipes-utils/mac-util/mac-util_0.1.bb#L12

Look, this is bleeding edge. And bleeding edge sometimes bleeds and
breaks your builds. You signed up for it; if you don't like it there,
use stable branches, or use controlled transitions to milestone tags.

Alex


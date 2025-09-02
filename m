Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67231CA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 19:41:30 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web11.86777.1756842085359379508
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 12:41:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SRSucn5P;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b30d09da9dso3062371cf.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756842084; x=1757446884; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mjN2k4Ux39EWEWAWOe9H4UlkQ0wnvjaFCVLaOYRbDZI=;
        b=SRSucn5PGkgMS4KXIRAoAf8qq0kdlMN30PphE5h4Y/+HtxeY9ZiVN8ff4efbOc3yuB
         7SLC5L4833UsvUwB/OAOtYl1D+k4wQw8SRLcYnoFnbxRTwElwTade026Lcd+cLy0uIeF
         7s9i+bVcLQKLpafjHVB4PhHM/CqZPsf5ajp95G4oK95CH2GtfkSM1XpnbABkYQWxtg+L
         KY0WBE6iVN5Vokp7OKoq5rSdAt8H3vM8cW+jmFtkLB9G8BewnU9vgO2l5RoA9qalTBh7
         9AlVkkDCxDKE19Ltp16tsgoIVeTH3fxZmMUtDdsPZAIGbto/Yj6BzCfIpWHWeR6A+2bT
         u6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756842084; x=1757446884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjN2k4Ux39EWEWAWOe9H4UlkQ0wnvjaFCVLaOYRbDZI=;
        b=anZ83VkXXuDQGu2xXl/sH4lNFiXDEAsTtxEN3HzDTKjJhKdWBjdHThK+ZdstTIVP4o
         uudfbD7yiG+4UUdGaLNfLEh0YJYq0IHgpJQTSdBg6pMSBTGNIyJcD+UZQOET2T0ZGQRR
         2oy7l7csULh2+KPczj+JJ/OB7qZiEXV/qRgkNgxGMpmc2ZpInM1OU7uR8LogXfwxzcsC
         481UcxcThc4pS4jkFY0yZdZlYKb3fvP/6Srq+Ya7rTacjcfkpNzan2wIlUBci/zPCt3u
         MTZu6yFMKC0nF6u/NCCGNQ9R1QesgZEIzfaq1tIowkJKUfQnUPDNiL9qwFL1xXKkt333
         vzPw==
X-Gm-Message-State: AOJu0Yw0oVTqKECj/rcNNYaaH8wRbP2zHcZV2QA+EY2eBjNnEXlGJCPM
	qNXkHFlhUdhda/iNuedz5KFjy+HgDwvhjYF1COCD31bzJ2uSXhYrerl/vlPrKDvctLPx4TUxQ35
	Kj3Frym3OphrVG2xtS1Tn7mOVbNNJUwE=
X-Gm-Gg: ASbGncu/ceOSLxUSb5TtATuEft3ZOBQ/D1FN2Dv0epmlgJhXId139kv6VTbyqhVlMwd
	Dhi+Q11O7k1/eafDu2K0HYUCw2w6F22+OPZEglTIBXJ/By1bCWDVIIGirDtAmfyq64+WvQK7Cz4
	jTLEFkDIf66xzTSuIvSIgWxSmADw8ne1CHiVIASgix/E9J3JmuMYyd3Df0aGu+xtOJUTGRHJrP0
	b6608PKVrcomQQoBm3jA4ShmxfXcMhRASF85dSmFWb5dFkmZ2Vtu+ANZ/USfjSP8yhCyHHKJavY
	fIpXvxCRu0OPKQb9YvljBgtS53bILwBKMn7y/5oRhQmvnjAFJTw=
X-Google-Smtp-Source: AGHT+IHeOejJFw90/Y21MmA0rbZaRM3EP5sSsq9CuvUwMHDEnUYZDbxLJfTP7kCpsBf43Ay2k78Xue/CqFefBsG+9xA=
X-Received: by 2002:ac8:7f15:0:b0:4b2:9883:830d with SMTP id
 d75a77b69052e-4b31b5e86bfmr137310531cf.0.1756842084264; Tue, 02 Sep 2025
 12:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250901135836.2927686-1-alex.kanavin@gmail.com> <DCIDMIQZKLXV.2ZM8YXZTV1MM8@bootlin.com>
In-Reply-To: <DCIDMIQZKLXV.2ZM8YXZTV1MM8@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 2 Sep 2025 21:41:11 +0200
X-Gm-Features: Ac12FXxZoyezKt01LWaOuNYnCT2ormYBGURPh1Bty4HbiUQ1louaheMgL45xVDU
Message-ID: <CANNYZj982UwaX97yiyN-9gXkRJb1qmQCnrGKri9mMkK1CL8LDg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/6] bitbake-setup: add the initial implementation
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 19:41:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17945

On Tue, 2 Sept 2025 at 16:16, Antonin Godard <antonin.godard@bootlin.com> wrote:
> > +            if y_or_n != 'y':
> > +                print("\nYou can run 'bitbake-setup write-settings' to edit them before setting up builds")
>
> write-settings does not exist, I think you meant install-settings?

Thanks, corrected.

> > +            parser.add_argument('--build-dir', required=True, help="Path to the build")
>
> Could we add the shorter form `-b`? I feel like this is going to get typed a
> lot. Same for --top-dir/-t, although the BITBAKE_SETUP_TOP_DIR variable makes it
> less necessary.

You only need to add --build-dir if you have not sourced the bitbake
environment, but if you did, then bitbake-setup will deduce the
build-dir from that by default.

As for --top-dir, the awkwardness of setting it to something else than
$HOME has been bothering me too, I've given it a bit of thought, and I
think it needs to be split into two parts:

- top-dir-prefix, which defaults to $HOME but can be set to cwd
(someone requested that) or some custom local directory intended
specifically for yocto builds (this is also common).
- top-dir-name which is appended to that when a build is initialized,
and defaults to 'bitbake-builds'.

Defaults for both items are taken from ~/.config/bitbake-setup, but
can be overriden with command line options. Then the environment
variable is not needed. What you think?

> Do we really need --build-dir for the status command?
>
> "bitbake-setup status" alone returns:
>
>   usage: bitbake-setup status [-h] --build-dir BUILD_DIR
>   bitbake-setup status: error: the following arguments are required: --build-dir
>
> Maybe BUILD_DIR should be the only positional argument instead of an optional
> one:
>
>   bitbake-setup status <build_dir>

See above: source the bitbake environment, and 'bitbake-setup status'
without arguments will work. I'm not fond of positional arguments,
because they make the command line less readable, especially if there
are several unrelated ones one after another.

Alex


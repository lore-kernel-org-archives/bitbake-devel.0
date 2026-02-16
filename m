Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891F1E8382C
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 19:52:14 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2572.1771271532747302126
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 11:52:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZF6ZLAuv;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506bcb23a78so17351621cf.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 11:52:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771271532; cv=none;
        d=google.com; s=arc-20240605;
        b=DfDP8v9gw7vdr+xs1lSNnl2TBqkQEtJH25UO6AegoIeiI2ic4g1LR5LjLkLwnG4P1C
         lDnpCnBKK9ZEQXeVr4mhvfdGWtS2MZemKN36J6oxfV0eB7FuozcYhbkBpgD++uWsSP5A
         LfqEJ1MLrP8tmcz+1KPXqIWFQ3BBsllI4rfzZX+omEm/NhpjIMXltXnKcnlKUXxGZ+La
         V/ijIZCeZJT4sjpn/2bj/KUzflXhE+ejJ1n0NGAY+jmfZowaGjWND1f7JZ2AxSF7Gy68
         ARxuZnoBJHGxhyHkaa5AQ+tOtuYnACZ8n8f/Hdo3iyRkY6dcCgEG9QFo0+Aj4SD5CSag
         xtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YxLCDavuCY5l/sVzQzWevXu3RGEbqZ04BTskGCqz0bQ=;
        fh=UY90k4PlQOzv0SHkLPYnGUROqDnYu+dGNcFSIvIhMlk=;
        b=jBzGVW0mgNfBRe852/dE8lJMmrUaowKsOYEX6EM8N1piy+0PSG/Ap6w91JuxoLuheI
         gcBCZWCtb6DJUBGWR65WcakTOLhD/KNde+tKr4myoBfcv8mSBQ6B20e4A1CTSHcvM04h
         4MifDnd4Xp0a0grp6F9jfypZJzTxJ0jx1TZuVXTnEeMis20rFRcTWw4UfHqYAWGnyeTG
         iMV14tvVfpnRgL/hwZXVAAYlFSdd0s0BdO4Vvij/WvVfIEPUoPCYTJph4ktzSLmXrWd/
         EnCDzUpKuUZQrAn+OYFYj4ILdr2tygu91LK+waPmhyuoD9Ltxhrbpk4/uTOXA5qzpBR0
         sofg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771271532; x=1771876332; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YxLCDavuCY5l/sVzQzWevXu3RGEbqZ04BTskGCqz0bQ=;
        b=ZF6ZLAuv+v/nREXRSg0rzQVf9g1vvoEiFzyXgudQZBvRSpmoUdL8SvZFsOdnpHOkPK
         MhiHzW32/i/fYjJCmvk0uKOrzTfoHim2ZkLcSiAWA0+z//aAvc9tGT8e75wv73ZTCfCW
         2lalC73JKJS8EHfdyE6O1B9AB52L7KUFdH6X0RcEY9Sl8KFBBNOoW8J/dLNrfzhgRVw/
         BfcWWxpKpR4HHp0aiMn5CV3DRBEUyXFrZsasHThwG4Nr4guK45QsvN2OqPpsNApk13G7
         my+TcfZ/SdpsgvORAzd+iWee/GS/YrwFqkC0ZDUgOdkc2ud1NUeIpybUrammxLqj4rSx
         hqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771271532; x=1771876332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxLCDavuCY5l/sVzQzWevXu3RGEbqZ04BTskGCqz0bQ=;
        b=qA1wBw5/GiH4Hljqsv81cZfCxl29i/iCQQpM9m0pfNAJA3C1aWEB/K+C6nKXqI1+dx
         h4ebYDIxkfzNQvdJpLnKeRQ+3GMDctRneviukiQ9gsWFf9Eipw2+oPRJGF+4XIk2vkJB
         Y7KPEuqlqqkyu7IG10JOB+WdPq0uaOrbb6yp64JytpAwOVSif9Bf6Q/166nv8bn9AtOt
         OafR25rvJ4Gat4PWQ8biBht/iUIuGoDABNXECy+Re8wTohTPf/+RhM4yx/CM+jImCesZ
         pO+VD/KO7lLB6Jm9AzMlZDZDKYLi2CwLzVUC78P0z/cc7ZUBpq4lGUlaEN2L0bULBzBI
         Fg6A==
X-Gm-Message-State: AOJu0YwMEDNu2yOaIKwF9x77pnPfaokL+RD9F0U4/TZYZNr4MQDZpTNC
	SL0F67izJcE/vbVyGUqKxsf9fNQVA4KpCZpOCd6upjLXjOfXN7lJSs/SnIfUnew9axxMmdK0lfY
	Iud+sI9QMTFnJW4IUHFLhX9o5ssmzPwo=
X-Gm-Gg: AZuq6aJF5GudGBAMjQvHXjPY1OyE3rKSL3HEKYVMIXTNYXrLnrdaDW0N/P3Ni1piExT
	C0q8wVGGKZgVNXTKY0475YiNFzf93h1JC3Y9BoMH5f2+1MwYv1dGhxiYs5l5Tr3PCZGtvtZOwNX
	BgcHnahX7d8AqOUPhM4LBdlzWs9SP4tUMFb1n+sZuspbAaacZ9adVPGukd0zdp5+6TYPQrG/Uli
	QKt70UnfbGqRvNBo39fSUKMF8XmKVESxx65nf9S0hCCi7rYq+naBl/BIbSfxBPObk4AW+gpR803
	NhLeCHfTpasZZBraPReBIWRxzcF0hXVKHMSEHHENAQ==
X-Received: by 2002:ac8:5e09:0:b0:506:1f48:a009 with SMTP id
 d75a77b69052e-506a8370540mr148924931cf.74.1771271531524; Mon, 16 Feb 2026
 11:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
 <20260213-improve-bbsetup-readability-v1-1-41cec3b06992@bootlin.com>
In-Reply-To: <20260213-improve-bbsetup-readability-v1-1-41cec3b06992@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 16 Feb 2026 20:51:59 +0100
X-Gm-Features: AaiRm53oW2jS2DpoFP2ztf_wnZVWglnkSMRgUTYcR7C0yFzE-tGA_V2YeZJXWMA
Message-ID: <CANNYZj95XYCc3hGQA3jwxR+CYHsPn8gpmbAbS-UuY8sNQGPcoQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake-setup: define a global for
 the color choice
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 19:52:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19041

On Fri, 13 Feb 2026 at 14:50, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
> +    global BBSETUP_COLOR
> +    if args.color == 'always' or (args.color == 'auto' and sys.stdout.isatty() and os.environ.get('NO_COLOR', '') == ''):
> +        BBSETUP_COLOR = True
> +

Global variables are evil. They easily enable unwanted side effects,
when a function call doesn't just 'return something', it also changes
the global program state, which makes it harder to reason about
program behavior, especially when the program is multi-threaded.

Which is to say, can you change this into a function please?

Alex


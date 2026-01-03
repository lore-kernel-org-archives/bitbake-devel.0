Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4112DFC6179
	for <webhook@archiver.kernel.org>; Sat,  3 Jan 2026 09:38:55 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22016.1767433128271178563
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Jan 2026 01:38:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TH/IpG2r;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b25ed53fcbso1777358885a.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 03 Jan 2026 01:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767433127; x=1768037927; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Oil2AVrolcg1qiWrnNL2C3ta3g9Mh+ZMTxrx0qd3Qw=;
        b=TH/IpG2rmQgKK5gihNXAvsjOI9baIeKcyZ3HIybnH5DojwKco+JJFPt52hotZwVNrr
         hD9+dni1rEwjcIblJpTwNA71K6TBF5g7ynwVdni+XgoOshDZAxnKkbSnhlboOh/gE983
         FLIaSiVe9GEl4T6uSUYz0p6CpJuTl5ua7i53DYgo+tTTWmd/UQv1u49GY9tAvN8SO3Mv
         W2cuguWOSwu5YHNwYU+ww+PVYZ1uJGx5RW6bkt9DnKWb/1LySesvLhFBS8iAOfGOx58t
         NSVCdSeU3/R3ndnVcvGJmlb8IWwjYhWhSlFixOfhPnt5W2b19g6Qrto5v1Qhx3QDWLP9
         yUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767433127; x=1768037927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Oil2AVrolcg1qiWrnNL2C3ta3g9Mh+ZMTxrx0qd3Qw=;
        b=ew/QhQTPqIM7hyHrXYdXYfdc7U02Vkydqtqca1jEtEeDtxNDmkpNw++Rudgf3UAzfl
         CSxh7y+Q3SF2c0FWGkUGZQNA/JAjLwc+tAA4TCwP8ZOQq3iQQlnOVKhnTjvr27YZjiPk
         iE0mm3uadObpCjYi3tfSMoiEfKq8NJeNjo4CDIQEqGqe63LlORua9SAIzlDh3NIE1WHD
         rhry3d0j/P0y6sUGKXLhWl7tHlZILyw2ianBZlKRtgfOq0sms9lrjUSEYZ0Ge8eSXfj2
         zgdP3t/Z8FtClpEcDtJChDsdB7/9rBxI74bMPtfF1Y61oZJ6qJ74vDhKR37fDc0SaLT9
         lgLw==
X-Gm-Message-State: AOJu0YwzBPiP/wGEwwGuR+lJKodajsWVIpW2C3+JSIr394BNiMOR8CFR
	b5lhpY48PirzGNPxvUF/eTZHrWh6M4BYuB5Miwj2vAuSFJQDIFReiRDAJbJSx8eI/jhFpjv3whN
	XuVkLLMz4NWJFT+uwIMK91kM3MjMJ7lA=
X-Gm-Gg: AY/fxX5LxL1CdPkTJmC+9aUaTXOG0NWg3n36E3R2PVodlx2kHEWkfsnUEvkuYQmwvJm
	22xg1k3OhK4dt0XXBcovVViox2mCuZ6dUOVDESgvRvMafLsZbpKlTEVkx1czb+oJTSKUeobV0aq
	Orp2pwDpM0UGfIs3Tel+MmtyzroDCkXL4BVwKz68ZOyT8UJLXM+O2oAtRCVyPibCfIXcVgzWPl0
	1dTm1rOHCehWdOUQ2c0cgeSFBPFirq6l754Q15Sbs0GBTQFlzmYG/vDEXHoxJ7QJ9lNRBl9zonV
	k7WGjFClqTL4V1IhxYG+9CwpFzc9vw==
X-Google-Smtp-Source: AGHT+IHYEi2hfHBvvE6lbCQuNGph76jLHlGe4tCf4QTDxRfKV+H4lsNTtmFBnh07Ixj9q/xdGmN68fOTkZXjl5sCGr8=
X-Received: by 2002:a05:6214:495a:b0:88a:3657:d3f3 with SMTP id
 6a1803df08f44-88d851fc357mr465773766d6.10.1767433126943; Sat, 03 Jan 2026
 01:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
 <20260102193438.2960561-8-alex.kanavin@gmail.com> <CAOU5ZMssE3bAzH=o7CnL=7qyjPmX72R8AwLRJVQTCamSo=HmAQ@mail.gmail.com>
In-Reply-To: <CAOU5ZMssE3bAzH=o7CnL=7qyjPmX72R8AwLRJVQTCamSo=HmAQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sat, 3 Jan 2026 10:38:36 +0100
X-Gm-Features: AQt7F2okDPvvx1kKwEbqPe6EoIsuLhxZEk64mi77rmyL9Wy34fFL1YlI6h_eQUI
Message-ID: <CANNYZj_20HLpT6gOVuKnvkg16zbBuE_06UTK_HpBThQY-MoeCA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 08/10] bitbake-setup: symlink json with
 fixed revisions into layers/
To: Anibal Limon <anibal@limonsoftware.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 03 Jan 2026 09:38:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18684

On Sat, 3 Jan 2026 at 00:09, Anibal Limon <anibal@limonsoftware.com> wrote:
>
> Just hit the case fixed by this commit,
>
> ...
>   File "/workspaces/ls/bitbake/bin/bitbake-setup", line 121, in _has_local_modifications
>     fixed_revisions = json.load(open(os.path.join(layerdir, "sources-fixed-revisions.json")))
> FileNotFoundError: [Errno 2] No such file or directory: '/workspaces/ls/bitbake-setup/ls-master/stm32-sdk-stm32h503/la
> yers/sources-fixed-revisions.json
> ...

No, this is an issue with the patchset. The _has_local_modifications()
function expects the file in layers/ but the file is only there if the
build was set up by a version of bitbake-setup that has the patchset.
So bitbake-setup needs to read the file from config/ to maintain
compatibility with existing version in master. I'll come up with a
fixup.

Alex


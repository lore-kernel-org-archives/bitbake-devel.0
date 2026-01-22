Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5928ED6CFA0
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 17:57:41 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43269.1769104653694828622
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 09:57:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HOQVv7SG;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8946f12b1cfso16088166d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 09:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769104653; cv=none;
        d=google.com; s=arc-20240605;
        b=UadZRHYGGjUDKdoga82DBxgPysPHCkKExFTv/qVCjkIURwk4OeGo3LwQVq+1K33Cfb
         XlWyBnoTbSj62p2BOaA+1+8udI15ijIMdKdoKcs6RDP9GPrzH/uhwsVTw6kzLw9IV9KB
         SE8bczbfrC49LsoqlosUN7dAuyyDPpynv9pZDBKWGQMzjim0Hxfy75MqQv1AjMifwlCD
         wn8+80hyu0I58+zWQJ4mtmxmPHAWkbKqenOQKNoOVMvESWsFOqImuWz4pY/LMwRYvQCF
         m+PFXb+X0kxBfH3ZmSXxke5KMbjwSa4KsFcwMt1gCLSapOZ7C3jHtDSL40Dw8Dw3LKX7
         770g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9waowehkHPqlgBYVtsjblRMZ+AO7rarj5nCE9t788lI=;
        fh=qhSEGFZ5DCm8IWokOYU3VicGVJrPDbAcwTkr5XyhA7I=;
        b=O9TAgMrCtbmkl9b2Pai1K2OVyPKaPmkcKvWDH2JU3KKZUgd8fGcSD/i7IjXm86MHhx
         EhDM+THNEeC1mTBn38xAzVbLzuLdCWfWkkweKCuDZdY/hoEOHxvoGk+sJS3usAH5xpw9
         rjKSr4TrmDZNIVoDuGQQ5htN208ALyQC8rueTeXNuDKXRpMZnCyZAZXRFEg0Xs55epRM
         fIIVuYcxbV4wGs6LYwXkT19prp4yIPoTb+JSCN+kxj20O/fFSVoXrrdMxdpuhqrojKZc
         1ZoN9i80g5fRKPD4Q4+/+3Zfb3xFenF7bSjXfqvi0pqJVAugDYOMMS4yospMk7whEcrm
         N9pA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769104653; x=1769709453; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9waowehkHPqlgBYVtsjblRMZ+AO7rarj5nCE9t788lI=;
        b=HOQVv7SG0BjLBMCD2P1loLQ1SkPvT2sPrBX+dSjm+1NUCiAGMbAe3PlLBK5t9gcMiA
         SyjnMoQXD5WiPMRVRD37y5O8yOLzw+k+4794gLrxlqzO1E1aCEJg572XwKT6O4URGf+2
         MILvmWxSrtslPSEfygmRWogv0G10x28nvLZ6GFBTcEZtGWUnTyKJtfTTl7tZg4Mywa1R
         yKDtz1uXAPeG7KOkoySl4v3mz1lZS892GUPnWEklF+Ocx3+SSMBLt/KGZIRCQJwA4WjU
         8pYUqlM3zMFaUB6aptPgr67UOCEUGALhto5HvmUXritVTZi4KBQd7EsSEnxLqUX/2r3S
         PSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104653; x=1769709453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9waowehkHPqlgBYVtsjblRMZ+AO7rarj5nCE9t788lI=;
        b=WZ9QVCVi2PaZi4C07DRd/LK5Jcer3J0v60zcxF2Tzc17rCr2n405fUd1BIyZC/+Q8s
         x3Ze9eSmbkPNM6mWG4mU/HS7QuN3YmH8QYoKm+18B7IrLfv2JDTOdk1kPaVvh7WjVxsN
         eKroGMBA0mxDR6AOf7RDQTQEvkNfvwd7aD/ML+MP7DBbpf8669m6DrxAn3MCJBu6mwn3
         6Gh9VN09Hfb4+v7Yc0aRSUx9tF9M/AtKQU8/foKcvo5DDXGDAmLjIQ4MI0YFetvT3koY
         vFJhk3saesGR0Gr6VusNirkwvXgMReSD5ojvfSKDF7p9jBFpPcaxGwdRpCUsIt+/XskL
         FiEQ==
X-Gm-Message-State: AOJu0YwHnehLNFXSNxQC0tXj6Cd0dlqUWLmBPSgstSwGllALFbIXmJ2/
	K4i4d0wvXSFwO4ndmcEPJrQjl/zuUlPFX8fuk7KSuq0hGK3W6yWExBdUXqSTAutbsvdqhfykBz3
	d8acBr1fkUjBq43bLxeFlZ/rl1yzxNxw=
X-Gm-Gg: AZuq6aL5QWuTUyYuOazZwKxbnKmqr4VOZ6c7xpa8M/j0j4EyRmZO3U1wMSThzI6zgMk
	NZNEVRBJWkGtolelbz99iX/3ivMR9NtRW9paBhEqIC0WR3cf6qtbTKqDYijlLObr2DtEVIkdpT4
	4m3Kea8GqwLSB5qrYb9tJH8giAJNpx8mRTjSH45nlQwAyZ9DGIyv2VecL81XlBXEHuN22Zwb4pD
	X5+jrv9/b/D1J5uw3/1vNnD51QCMrmsayGs+vpEDFgbEL8qpVGIqxpLxfZOXM+44nb7p4wbARgb
	iMk3V3l8tES00YjVfmWYdNgMKWmoeFhwvGO1/QJn
X-Received: by 2002:a05:620a:4494:b0:8c5:2e5a:5c80 with SMTP id
 af79cd13be357-8c6e2e3e95bmr32879985a.65.1769104652500; Thu, 22 Jan 2026
 09:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
In-Reply-To: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 22 Jan 2026 18:57:21 +0100
X-Gm-Features: AZwV_QgE6-4n7fuhSOLmZhQnJS07jXX7CuRcW9GqTPoMYUqWjbMG0Apu4A5dPj0
Message-ID: <CANNYZj_FHvrXGk-=Q1pFd9Vo5b=puY41EERTQdivXikdbd_LmA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] bitbake-setup: add descriptions for fragment choices
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 17:57:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18855

Thanks, other than the suggested test tweaks, lgtm. There might be a
merge conflict with the tests, as I've also tweaked them, but it
should not be hard to resolve.

Alex

On Thu, 22 Jan 2026 at 16:02, Antonin Godard <antonin.godard@bootlin.com> wrote:
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> Changes in v3:
> - Rework logic as suggested by Alex
> - Remove modifications of {oe-nodistro,poky}-whinlatter.conf.json
> - Add a test case for oe-fragments-one-of
> - Link to v2: https://patch.msgid.link/20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com
>
> Changes in v2:
> - As suggested by Alex, change the new way of specifying fragments to
>   remain a dictionary so they can be extended in the future
> - Link to v1: https://patch.msgid.link/20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com
>
> ---
> Antonin Godard (3):
>       bin/bitbake-setup: add descriptions for fragment choices
>       default-registry: update fragments choices with descriptions
>       lib/bb/tests/setup.py: add tests for oe-fragments-one-of
>
>  bin/bitbake-setup                                  | 23 ++++++++++++++-----
>  .../configurations/oe-nodistro-master.conf.json    |  6 ++++-
>  .../configurations/poky-master.conf.json           | 14 ++++++++++--
>  .../bitbake-user-manual-environment-setup.rst      | 26 ++++++++++++++++++++--
>  lib/bb/tests/setup.py                              | 25 +++++++++++++++++++--
>  setup-schema/bitbake-setup.schema.json             | 21 ++++++++++++++++-
>  6 files changed, 101 insertions(+), 14 deletions(-)
> ---
> base-commit: 5127faf986d8543bb88e73cf3dccb407d80c9a25
> change-id: 20260116-bitbake-setup-choose-builtin-fb199054cc25
>


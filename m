Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535B8C0015E
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 13:19:00 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.12705.1690895934847807546
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Aug 2023 06:18:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=VgllhCqw;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so8839186e87.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690895933; x=1691500733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eIKKpf7pqCJlkbYT8x/Ig5CBOpuAlaohSbifjcnOq4k=;
        b=VgllhCqwruw+VM5LEOdCJh4Dnh62twtkPjv3ReurKEAvD1u5CEXkcjEpkL09PFg3bL
         sGygQ7Ryo1dB+kQ5XoBPlaXAbbUKIYvD4FrQ+Ge9ByKTzdIXs4NxobIu1TK7tGWsmTZQ
         n/1Kcudj4Z7wo6Pxazi4+DrnE4kwGZnTlmtNm1mSGE/qjyOswgQqlVGXa4l1b2RDvReE
         zkLH4kRZAt3pUUe4JrROOmv7D5zieOT0f5osEp0rDXsbTVdpu7yjpkm/KWBUt9LYxBPl
         p3YfZgKSM1VlpB643cjFIfI9kOitP8Aiu1XT0rasIghef5MPGn0E7Pp7GHRfgSjMw4ah
         s/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690895933; x=1691500733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIKKpf7pqCJlkbYT8x/Ig5CBOpuAlaohSbifjcnOq4k=;
        b=efbRngVKGbW+26W91DOSVTegp0q7c/kQr+6+CZ2Vpo748klW18ziGcX5v7d5LMPTtX
         MYEJKqV66y0RSAeXH2lNrgiO+pV/bGM6FHFpcjI9XMbjiiC02xsIK+QYt80gLE2Pzuqq
         HGl808KBLF4pUVE0YQMNbxCzBTp2V46aro02WG4mfT4zPjdEprMPi5+NIemqMdTa4abn
         0strOQgkVYtLcm11XchoY+9h7KoMrpR3B+lkdPtG2/mRDxsLdErS8ayIU2hDBmrIs/en
         a7Au+acIRldkaHrgU1cfrtTLua/9l5bshurqZESSU4Pm000+BAVY1XeOT1J5m9WcUDWt
         qAwQ==
X-Gm-Message-State: ABy/qLaR6k15xOoSslu6T9kHBiDPthSF4S8TX2uR33w9k1cC+pINfUiQ
	hwKFx9sY/PE+HTKFHCHTIgfcGQ2O8xYEGLIcqpc=
X-Google-Smtp-Source: APBJJlFe+GNlI9aihx61+3rDLVCtXqjV2jrNXtLGT8ZwiufsBtotaruqzWz2rG683G26eTcruKS4IezinnNvpgA/NSw=
X-Received: by 2002:a2e:3817:0:b0:2b9:a28d:6495 with SMTP id
 f23-20020a2e3817000000b002b9a28d6495mr2772424lja.9.1690895932674; Tue, 01 Aug
 2023 06:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230801124715.752243-1-eekmecic@snap.com>
In-Reply-To: <20230801124715.752243-1-eekmecic@snap.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 1 Aug 2023 15:18:41 +0200
Message-ID: <CANNYZj8mkTBNfevYz7eWr45D2renfen5FCLc1C6pMNHpUhd03A@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH v2] fetch2: add Google Cloud Platform (GCP) fetcher
To: eekmecic@snap.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Aug 2023 13:19:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14898

On Tue, 1 Aug 2023 at 14:47, eekmecic via lists.openembedded.org
<eekmecic=snap.com@lists.openembedded.org> wrote:
> e) Yes, the fetcher output is deterministic because it is downloading
> tarballs from a bucket and not modifying them in any way.

Let's say there's a supply chain attack on the bucket side, and the
tarball has been replaced with a maliciously modified one. Will this
fetcher be able to detect and reject such a download? For http tarball
checksums are provided in the recipe. For git, the commit revision
doubles as an integrity checksum (we trust that the local git client
performs the check correctly). How is this handled here?

Alex


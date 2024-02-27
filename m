Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C0CC54E4A
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 22:04:41 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.2219.1709071476209787700
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Feb 2024 14:04:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=gjWdTkJt;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.181, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4d869b019so2463449b3a.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 14:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1709071475; x=1709676275; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbKqx7UP3U3PFTIgU/w5HXo/gGJ4eRnfE9C8qo/PHl4=;
        b=gjWdTkJtyYTFW8UpWvX/MMnUXx7OXjAyT+SVjSVm59V40eM7sX1r9Rem+Vq2yQN9E0
         nXCi9QSduXPiK3OeMZAiJXV68RnhJOv2MWfUpSPTJ4kYez65klUrMamFrLDwGPXLXJf9
         WgChdpuobbnH71ySXJmtxVLfH0MNZcH/KKfVisSTcpCMlPzBHWsbgwjNxCbj3XwWRFUe
         wsplPH6ARwhNtB75Egyg6oac4Jp+tLG9LH/7TlRtDll39GsF0gSDi7LSF7/sYBgibB24
         nLHWg2hDEmsOufnXCysgHr/w5xcCgw0hl08qU99OZayd9clEuI9H9chxgVZgQ60xNx71
         bjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071475; x=1709676275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbKqx7UP3U3PFTIgU/w5HXo/gGJ4eRnfE9C8qo/PHl4=;
        b=Wl+Pgb41YKB/8YcU0HKMfk2EzwDz0i4DVOLUfcthfj93ozVOMdZCalt4pQn1FayaTl
         YRpoCiqIJo6J2yQCKmPZAisydKsps8rq0ltvVR4RB+KBkjnnpifTw/T+H5z4kQgCro9a
         V0iUqA4VimRFJVHDFjwwCVUbejyjxgHLxABdjUnIm0grMgVZcTCwPhV0vnXmf6jVttNH
         FX2oLvwOjlF4PvpF6wNlgAVMgUKuyMKLy1S+rcNF9EqGBVuFMXWfo2x2bl0Rt1KApIpE
         BdEbvJrpBkU2iIqF40Kmp24IUCHZo6SD4UQd4ZEpbBV2ijTirLf3K8BdlMbQXmELk99k
         mA8A==
X-Gm-Message-State: AOJu0Ywy8882xXhW79Vi8pcpA2aeCNu4kCsrUsl9MHB6m0lO9+BUahDX
	ohWINEqWlK8U24C5HG84bPuAyOxQEiIA+GZgnF0TT86kYTlU61fmeJRVIx6KaVcJjh5qAGis0YQ
	/NFc=
X-Google-Smtp-Source: AGHT+IHyZGZ47lGFjoAR7SHT5GGC3UlO0OwI82Alw9h5/p/jT8F+tNuIwE7k9I1fTra6kt5hInKG7A==
X-Received: by 2002:a05:6a00:4f01:b0:6e4:1a29:732f with SMTP id lb1-20020a056a004f0100b006e41a29732fmr9750018pfb.12.1709071475502;
        Tue, 27 Feb 2024 14:04:35 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id t13-20020a056a0021cd00b006e50c0d6421sm5059772pfj.11.2024.02.27.14.04.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:04:35 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/6] Patch review
Date: Tue, 27 Feb 2024 12:04:19 -1000
Message-Id: <cover.1709071317.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 22:04:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15966

Please review this set of changes for kirkstone/2.0 and have comments back by
end of day Thursday, February 29

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6616

The following changes since commit a4c516ef5e72b2d77ac5ff7e86c5ee2190ebc42f:

  toaster/toastergui: Bug-fix verify given layer path only if import/add local layer (2024-02-06 10:10:20 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Adrian Freihofer (1):
  bitbake/lib/bs4/tests/test_tree.py: python 3.12 regex

Alexander Kanavin (1):
  bitbake/codeparser.py: address ast module deprecations in py 3.12

Chris Laplante (1):
  codeparser: replace deprecated ast.Str and 's'

Paulo Neves (2):
  tests/fetch: git-lfs restore _find_git_lfs
  tests/fetch: Add real git lfs tests and decorator

Philip Lorenz (1):
  fetch2: Ensure that git LFS objects are available

 lib/bb/codeparser.py       |  24 +++----
 lib/bb/fetch2/git.py       |  45 ++++++++++++-
 lib/bb/tests/fetch.py      | 135 +++++++++++++++++++++++++++++++------
 lib/bs4/tests/test_tree.py |   2 +-
 4 files changed, 171 insertions(+), 35 deletions(-)

-- 
2.34.1



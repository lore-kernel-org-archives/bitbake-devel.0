Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CA6C25B76
	for <webhook@archiver.kernel.org>; Wed,  5 Jun 2024 13:04:07 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.14718.1717592645190822693
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Jun 2024 06:04:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=fTVE+6ef;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.169, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-702342c60dfso1652689b3a.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Jun 2024 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1717592644; x=1718197444; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XoDMZJkeUZfP8Abm0uKUOjtSKL+E1el18SafsQhjyNE=;
        b=fTVE+6efknvPddNap5MlDjouJsuPxxnx+bm/J4aALFQbtqUx+eT5qWOQQly7wb6E5H
         8zGU/5FbEKvgR9Rwu+Lq87bKHnwNTruBT84v9UN0W6aTX9AHZqXqeJEDzJR7w7Ldhn4H
         +lFyjx8kh/deyJhYTPqneAp6UdmKOywQVHAZLMuSUD6kdfEQJBadelNkI5CYgZWrrfH5
         gEz21LtrCyY+wFvtmRia8+Sw90VorUfBZiuB6zsBNAo50ceuBAL7dUcowGQ/HqQi3OP2
         aNk282kvWjgUcO/ZKih7l/PGHozkmnlDngb8iGdWxlAHBb0Y0IJ81UdFfIiqjDoIyl+h
         mhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717592644; x=1718197444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoDMZJkeUZfP8Abm0uKUOjtSKL+E1el18SafsQhjyNE=;
        b=ZLyhSRD74fYjz4NHOXCqjfkZRXv/z7iybSI17YNIELCC26F9Mfmxj3gPieGvgmu7gR
         gKpECp4hohXLP1Ee248fHkOXC+wR3FrKNKDq6Jl91bE24uZp6gfNfQs8oHJ9gksFmNP7
         fvO48Ae64dlWSQAWIjiXrBz/M9PR3R+T7L0S1i9Y8gjTQSZhBuZ0LYkn/3JJ1iPrUj2j
         VTXUmDuknouF3yAbvJYN/17B4KwvO3MjY1Xfa7k8XXclRwRqEpsil2G2kv7501RXreLH
         HUMBN6QRC5xUWAh7FQYQDyqynyBDCVVJfGMpIaWwONLYrfLtTLELq5deJfXkGGu7ayLL
         XOsw==
X-Gm-Message-State: AOJu0Ywk7wkzO2GENc4dzDw86c5jaq0jQdWS6gPzCuT/NMk/VQ3ujOLA
	eDEuB9uxHGWjqDrRAXH2ofc0Qerz3cz5pM7G33R10UQKi83g/B8Mzzlt7EaxW0mcIID3Hhw6nrW
	C
X-Google-Smtp-Source: AGHT+IFMJuXNIxdPwzjZsipq3uR0L2dG9aiW8h4qhIyyh6WAbH2103JIfBXBjBVX7mDP7BiUccrJyg==
X-Received: by 2002:a17:90a:a610:b0:2bd:6552:6474 with SMTP id 98e67ed59e1d1-2c27db6a40fmr2466982a91.41.1717592644183;
        Wed, 05 Jun 2024 06:04:04 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c280697d88sm1442428a91.30.2024.06.05.06.04.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:04:03 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/8] Pull request (cover letter only)
Date: Wed,  5 Jun 2024 06:03:59 -0700
Message-Id: <cover.1717592566.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Jun 2024 13:04:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16319

The following changes since commit b5159c0373e2e7d403aed16e096ad655f38b1fa7:

  fetch2/gcp: Add missing runfetchcmd import (2024-05-28 15:27:08 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Joshua Watt (3):
  bb: Use namedtuple for Task data
  hashserv: client: Add batch stream API
  siggen: Enable batching of unihash queries

Richard Purdie (4):
  runqueue: Add timing warnings around slow loops
  runqueue: Allow rehash loop to exit in case of interrupts
  runqueue: Process unihashes in parallel at init
  runqueue: Improve rehash get_unihash parallelism

joshua Watt (1):
  siggen/runqueue: Report which dependencies affect the taskhash

 lib/bb/__init__.py     |  12 +++++
 lib/bb/cooker.py       |   1 -
 lib/bb/runqueue.py     |  99 +++++++++++++++++++++++++++-----------
 lib/bb/siggen.py       |  11 +++--
 lib/hashserv/client.py | 106 +++++++++++++++++++++++++++++++++++++----
 lib/hashserv/tests.py  |  75 +++++++++++++++++++++++++++++
 6 files changed, 263 insertions(+), 41 deletions(-)

-- 
2.34.1



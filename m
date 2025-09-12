Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E99CA101F
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 14:08:26 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.17698.1757686102077521387
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Sep 2025 07:08:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=H7mVsHob;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.182, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77460a64848so1496687b3a.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 07:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757686101; x=1758290901; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WnZWSeNVVYiO8teE/L1WI1T3OzeAUpQa7dTzTxzdSeM=;
        b=H7mVsHobTwZTe/OVW68G8v1/KkUGRW5rZz6G4eieXegD+LJM2AAMQuzStUMwYtdb9f
         X5YZ/f8O8GzrJx//AzgL1gOzy7ZRQEILttBkDo4wAl18MT53V0sJ7lsldYvr7q8GEhA9
         ONumk5kaGMgAku1XxiMvqLOkZ3Vqzw5nzMMvq3AmEik/fvgXixxPMPXpTT+zE91VFcJe
         5MU1R8snvIS3wOunTu5fu+nsRnNlNxFj/mNU9Lqe8CgpBhO+Absbyonn6AAZRBm6c4sW
         NT/fo4B09+3s8ijP4Vl1e1JtOCd1UuXLdooQs79cjHdgU9BZxyXHf4rID5xv3P3IBuhN
         Wmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686101; x=1758290901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnZWSeNVVYiO8teE/L1WI1T3OzeAUpQa7dTzTxzdSeM=;
        b=XfxKJKdxDfAssg+jNxmIgUp4G/Mg8qqKPpZ/JaweAuS0LDMJxSd0zzuvePNcX9rvJb
         HUXiLzqRcuB8oVJCImjYrM+AbovA7rd0E4V6+NZ0Ur+w8jNTffZWFnUfnYW/tmEtTUaS
         qCYyvCiRPUJnzCb949SHfkhLZcTzlxSZzSH8IHO2DwSX6qzn4k7edZ4XegdZDsE/GO6r
         fLcXe2vNKQmul/Qgz6youepc9c0SfqPxvy69ZL6p4Xzt91gqKZXd9v0Yw6JX+7C/Gveh
         vI9aFwHjcxnPRT6Fw4X7HL05ugTjSDG1McMzpVmdTbTGY7pKPWZrCzjRVnU6hI9JTpZZ
         QY5A==
X-Gm-Message-State: AOJu0YyZMLEmAjSLZnZQkMoqjCozgdfWRUuC3tjeH1h0+kewW6biEEKe
	7JxdCQrPmpod+KUvWapVWyaj3nL8Qb9a+9Z6k4iNc/a5X5/MWq2GysL80JppL3qeZ5lCj0tiXIn
	Oh2zN
X-Gm-Gg: ASbGncvfDWWO8l1i8IX2Rz7QmkteNnAX5D+ryVIqJrq74GKtV5xadkKSkK4cP8jo1cR
	gYwSYU0MreSAA+onDF4yb6g6+vbyA//FcPR/TF4/+YTyH7CA2D1ZZnJYamTaNnHWSbs1ZbX9XM1
	H0OkJOR4Pth/uRYWPDAHRioDUnHFYqa9px6TrUvnpElGP3nVzETMxrtxtmRwkSJWDHNqxWzPoOY
	3NolnSCVQqhnXX7gX/ZCYPsjzRjBYRvOGQpDLO/Xx//5L1O4MSVSomZfSTrlAlj7q+4E97iMTni
	mRG1NPGDKeKJpNspnHbhJG3b9wKcpx1nuiP+z9ee9y5ZSPvTPb+vFp0HWUAJ3HxPKLYHiYMAKk2
	Qwiu9JbT/X1NhZzhTmspu4BqE
X-Google-Smtp-Source: AGHT+IE9n3nUVHuZp23ZfcCLdFTYysMlp4zenhfkqVDkfwWODOOI4Qi+arVy3e+/IO13sv7sNNRUpw==
X-Received: by 2002:a05:6a00:4fd1:b0:772:4319:e7ed with SMTP id d2e1a72fcca58-7761219b997mr3473439b3a.29.1757686101078;
        Fri, 12 Sep 2025 07:08:21 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5e34:462b:e2f0:5898])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c472ccsm5711834b3a.98.2025.09.12.07.08.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:08:20 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][walnascar][2.12][PATCH 0/2] Pull request (cover letter only)
Date: Fri, 12 Sep 2025 07:08:10 -0700
Message-ID: <cover.1757686034.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 14:08:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18010

The following changes since commit 710f98844ae30416bdf6a01b655df398b49574ec:

  utils: Optimise signal/sigmask performance (2025-07-31 09:32:00 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.12-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.12-next

Joshua Watt (1):
  Use a "fork" multiprocessing context

Martin Jansa (1):
  bitbake: Bump version to 2.12.1

 bin/bitbake                        |  2 +-
 lib/bb/__init__.py                 | 30 +++++++++++++++++++++++++++++-
 lib/bb/asyncrpc/serv.py            |  2 +-
 lib/bb/cooker.py                   |  2 +-
 lib/bb/server/process.py           |  2 +-
 lib/bb/tests/support/httpserver.py |  4 ++--
 lib/bb/utils.py                    |  4 +---
 lib/hashserv/tests.py              |  2 +-
 8 files changed, 37 insertions(+), 11 deletions(-)

-- 
2.43.0



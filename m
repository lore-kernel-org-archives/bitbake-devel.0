Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F24CAC587
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 16:56:43 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.24312.1757523400357848355
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 09:56:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=rb8aSud1;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.174, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so5415717b3a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757523400; x=1758128200; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRwU4Pa03xYDk/mDS9iBqcabnOraZ9UgAAMxntA0FZg=;
        b=rb8aSud1AS4KXJ272hitwcuCirtWzT23QOOMm2RoamrsmAxlIwGOPYAdfcsMxmDBhO
         O/JJuHLoMi4DGwoEps0w/8cvqeH2Urmsa9gcLdrjQHL+Oi/9AzPSG03mx6y6MX9pwhYf
         4GbooRy+mGde+o9ukb6VM0GHcxxW+wmYWGfc9C6/Rf11QPzw/ljy7QJ+CCstGZVsDtHL
         su76l9TZ3OUPXe/9885LdCkp9gaFhV0ssOxJLky1u3yCTSH+dg8HdFc/HUYoBZbYZstg
         YnAQLIagIZhaUoGttt8oBG9Df6Qoxl5A5FrfDN+DaUaoWmV33apI93m7u+Q1guoJb4my
         UPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757523400; x=1758128200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRwU4Pa03xYDk/mDS9iBqcabnOraZ9UgAAMxntA0FZg=;
        b=wSD4qljvgTlm+ivCKY23G5yfP2IHk/hzBTeyvj/6bSnAWbMoIZpWpXPxoG8NpPMUw3
         PPczr7iyimy63Hje8IW08uQvBBc4Zsy6aOQLn93gCogBFSjhT2aXR5jVKENSzwXOtSgS
         0HBFYWo6T2pEIXNO4roIkU8OIKJOzYxoywC2OLzqaMsT5fjm62vk4nSICe0MCmvL2Me0
         uzTAS8kVOa2xdpwLvgMJp0sFixKZnmt+lSpL4qswi3sd7l/pCbD92SeOXtDc9wLi5l2Y
         t4va4Qz+MhUgp5FHIX8h3CSpq3v9rU1paGXEn7jtJqhUJT3r59PizRe1C0Q4CNx6Krw6
         5P6A==
X-Gm-Message-State: AOJu0Yx3wOy9HjyZQXJhbUygHOQrcXgDtidcbDfDadslqQqpoD4XIzWd
	00K8xVhDieYejGonDQNHwJTqySNNv+T79vguoUjgjexoB8+0CVuN6tug3c6LwZXvaa4B3w7cawP
	ibpWw
X-Gm-Gg: ASbGncun8xzXZQAVFCaWBo/W/qrKRgRlqR9eSjbXl8ctuThWr8s7brVw6G9ooTSZNC5
	AUW6MCZY+9JkVZEG/jqY/gsEnMYRsJCdjfjWZitGWmoIiCThMXsFGHY/qdESQzTUodwAPS7huR2
	uT/lOYJt7dTi6XOjD1fj/pvVIuV4iQBVVRhJ9hvKai9JZqMyT40Ws6L1Y3QNS+C5Vsx0TcVxkS7
	tUNUn/vDZPG1menP2R9NpJbF5KkoFLNrttnDr4AFS+ph/DP8dYpJGx6rcYjw7VKocMEwoOrO8Lu
	xHMy9y3MA3yyn+F0zfgUjd/aFUSog+RdkddTzaj1PN9t4asbGlbwaWvvggm9PTxSUlryKhZ+SVR
	+ljStH2nsJOOgxL+YrOlorU842lhcaUdO2eY=
X-Google-Smtp-Source: AGHT+IEL2/iV2rA0pfIoa6SLefDy9ekv/l+/BzWpmwSDvy8eH2wdF09Fe/BJIJ/W2S6S/LM1c12fOw==
X-Received: by 2002:a05:6a20:3c8e:b0:24d:7926:bb2b with SMTP id adf61e73a8af0-25343c5f59dmr23640355637.31.1757523399490;
        Wed, 10 Sep 2025 09:56:39 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5b33:a32c:9e59:27d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466118071sm5673608b3a.24.2025.09.10.09.56.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:56:39 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/3 V2] Patch review
Date: Wed, 10 Sep 2025 09:56:32 -0700
Message-ID: <cover.1757523235.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 16:56:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18003

Please review this set of changes for 2.18/scarthgap and have comments back
by end of day Friday, September 12

V2 includes the previously missing version bump to 2.8.1

The following changes since commit 982645110a19ebb94d519926a4e14c8a2a205cfd:

  utils: Optimise signal/sigmask performance (2025-07-31 09:21:27 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Bin Lan (1):
  bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()

Joshua Watt (1):
  Use a "fork" multiprocessing context

Martin Jansa (1):
  bitbake: Bump version to 2.8.1

 bin/bitbake                        |  2 +-
 lib/bb/__init__.py                 | 30 +++++++++++++++++++++++++++++-
 lib/bb/asyncrpc/serv.py            |  2 +-
 lib/bb/cooker.py                   |  2 +-
 lib/bb/fetch2/__init__.py          |  2 +-
 lib/bb/server/process.py           |  2 +-
 lib/bb/tests/support/httpserver.py |  4 ++--
 lib/bb/utils.py                    |  4 +---
 lib/hashserv/tests.py              |  2 +-
 9 files changed, 38 insertions(+), 12 deletions(-)

-- 
2.43.0



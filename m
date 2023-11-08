Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9140AC4332F
	for <webhook@archiver.kernel.org>; Wed,  8 Nov 2023 22:57:30 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.107217.1699484249710224344
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Nov 2023 14:57:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=BAIuUPxc;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.180, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-692c02adeefso188245b3a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 14:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1699484248; x=1700089048; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KQNjacSbSzczK0qHvpj67kRuXUE8lryyPoyyWi4yazc=;
        b=BAIuUPxcaPIodRz+p7bW8tIdhAKp+6EIbbTxSarZgTgYh81+gA3MMxaK0iMz826SyJ
         gYf0kae4wmc/ot6YGqNUeU61G+XUxDDJ84+CwlXJIGnDz7SrHxCIjhHGQgpODF8dgDOa
         GYsaL4PSS78Z2w6WXttFT7rC/7ohy4ZLmyWEpEOGo0jkrgaGMpFF891cupcK+uF+55j3
         ZQKWpuR2Njj8VJPo/3eHJN6RDxfDqJuhwKz5sgcSCqXPGQmJl4rpbJIY9xyMeRU0DyaU
         xpsDXlmsFu3Qf9Cu5I1ZUe1mmxgb2e+IIZaUclp8CyWFD8Bs5vADzvriLsmPGvk1Sjot
         QxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699484248; x=1700089048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQNjacSbSzczK0qHvpj67kRuXUE8lryyPoyyWi4yazc=;
        b=UumEQi6YZfZOLlk3P0tyNlwOhCDNBmWv21xyENnHF+Y8iEYV+iVV52mDlIkRXSiCQp
         58KBQ2xU+zAHoXTvsk2+2bFTgA+M6xCGHCaPBdcppt7kobZk12KY8QTChKhdMTPBzSlv
         7qw7BxgsD95k6qRgAksKmRXtYrL8njTVs9l7I1vfnf+Xto6bpwlZUOUlpRlenRF9RI09
         VSLIjrQ7L4COPDCddg4JRGpjXLoEU6wWb1X8QqzrtT55q18XMSB3II7jnpicp3aj1/1L
         6mFbGzpJOs7iYYwzA0ZMeMGXsW4KJ++lyqz2MiHXOdA4/AMIJ8527Bp75QXmXupHX3XK
         mDug==
X-Gm-Message-State: AOJu0Yy/dfYcnJsucnpu26s8zkp/LQoEIoYCKv8FnDe8pLmSF8lms7Cc
	JubVRu+ilqnvtdNMMSrz0oKog/67bHzrFj7zg9Xv1w==
X-Google-Smtp-Source: AGHT+IFDC1ZZtxnpvOzgjlg7m1lNDQ+vdOJd7WSo8bTcFz6EG2514o9p+zjJleiHe04Z5hCjH2OprQ==
X-Received: by 2002:a05:6a00:801:b0:6be:2bfa:6290 with SMTP id m1-20020a056a00080100b006be2bfa6290mr3606444pfk.8.1699484248423;
        Wed, 08 Nov 2023 14:57:28 -0800 (PST)
Received: from hexa.lan (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id x6-20020a056a000bc600b006862b2a6b0dsm9798063pfu.15.2023.11.08.14.57.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 14:57:28 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/3] Patch review
Date: Wed,  8 Nov 2023 12:57:18 -1000
Message-Id: <cover.1699484095.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Nov 2023 22:57:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15452

Please review this set of changes for 2.0/kirkstone and have comments back
by end of day Friday, November 10

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6158

The following changes since commit 6c1ffa9091d0c53a100e8c8c15122d28642034bd:

  SECURITY.md: add file (2023-10-24 12:50:43 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Denys Dmytriyenko (1):
  runqueue: convert deferral messages from bb.note to bb.debug

Peter Kjellerstedt (2):
  bitbake-getvar: Make --quiet work with --recipe
  tinfoil: Do not fail when logging is disabled and full config is used

 bin/bitbake-getvar | 5 +++--
 lib/bb/runqueue.py | 6 +++---
 lib/bb/tinfoil.py  | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.34.1



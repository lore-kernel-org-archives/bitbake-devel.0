Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85007C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 13:14:27 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.210002.1724073261263103138
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Aug 2024 06:14:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=xukwRW1L;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.178, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso3542397b3a.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 19 Aug 2024 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1724073260; x=1724678060; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5MOIVqIbpXh8Oc3zIVqRj4038fY+8EcPFPmcS97/5sg=;
        b=xukwRW1LmSWFj8SBN4Hqy5suxiGrspu3W0XauEO82JHREqgxVrDAMDoVg7qCR9Wj5X
         g2FgxHFQagmyQY+c4yapQDiXnZ/TJnbzNcTmeVrFYqfRZRmvm2tLsSrXuRHq0sVeyAph
         LDqhGF4ilncj64G7XR9lEyppLYP2N2DIf9dyGhZRiER2vcdv/p3ye9pSu7cOyVuUu9Lk
         4Cs/WDyDz5HWLgiltgntykKZpDx802O5VjOdIL3t7guuK6Jmr7hZQC5aaQSNl3kGOc4w
         tjxuVq3VmqufMD+dH/TcBLqNO3iDY3iE4GoEYWto3SXkzH9kSNgwCdvFbZ6AOlxcMLbE
         B1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724073260; x=1724678060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MOIVqIbpXh8Oc3zIVqRj4038fY+8EcPFPmcS97/5sg=;
        b=bN6w223RSfrVeUFh98HHT7n8NTtKTB/kZnCBBb2Z4XzaUihOc28jBL1/oo4RUotp4N
         4iTezNrCTT5msaJu0+xHnfnvf7UqhVtQPBVo00jrc2Vpq6UQo+VfsxsyEZkA9URnsLOI
         kBG3Yp3lajV4h0+DAtP7JYPHmx6JOsl37JMhleDs+EWLtV4Cr1RDjJ/vlvKeEZlP3Uip
         w1FjtKC+wHlCID+zfFNj/K/d3dnOL391SH2BDQ/zIwaAmecjyh8u1dkA7anGabmHUzo/
         Qi50YnG6u+Acej5fASNYO63QHtxHH+3vQ2rSwMwRWk6tQrkSQ0U9qdpazJAY6g8a9DQg
         zxzw==
X-Gm-Message-State: AOJu0YyU2EtDX8cEk/nXsdxfytzbFkim2SOmAWYGotkmb5WR2wzCcOy+
	lHJKwjmd/+TM0YUwXyfPO6w8qDsGdoXE6vwGjaNj5KCLGxaPUqXFhS5f/x9LD/bCRKvnA9WQOnl
	QYgMbUA==
X-Google-Smtp-Source: AGHT+IGppqeoRSESmuLK0kR5YfAkR6pVYlxyXubpvDExHK+2f0W8ieBsXM/adkC/UDBhCCyP9ckNFA==
X-Received: by 2002:a05:6a20:6f87:b0:1be:c4bb:6f31 with SMTP id adf61e73a8af0-1c904f88645mr14437982637.18.1724073260139;
        Mon, 19 Aug 2024 06:14:20 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d99479sm7117831a91.48.2024.08.19.06.14.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 06:14:19 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Pull request (cover letter only)
Date: Mon, 19 Aug 2024 06:14:14 -0700
Message-Id: <cover.1724073160.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Aug 2024 13:14:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16495

The following changes since commit 11d83170922a2c6b9db1f6e8c23e533526984b2c:

  codeparser: Skip non-local functions for module dependencies (2024-07-17 06:24:29 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Robert Yang (1):
  data_smart: Improve performance for VariableHistory

 lib/bb/data_smart.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.34.1



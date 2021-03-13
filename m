Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web12.2957.1615662314124449399
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Mar 2021 11:05:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=FbkJ6E3V;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.45, mailfrom: steve@sakoman.com)
Received: by mail-ot1-f45.google.com with SMTP id r24so5157489otq.13
        for <bitbake-devel@lists.openembedded.org>; Sat, 13 Mar 2021 11:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttJ5qDGAgDvLl4nsg/504AJv+PW1KPxZSXg5DFeVmwA=;
        b=FbkJ6E3VieW4ZKXDQ5fQL9RoGCVDXc5DwMgnXOhr0gt3p8BHIOVPxeyeFBZEw2quwZ
         RKSzC+xO2VgQkyZagvOKjPZQyDbc+swApzHfuFGulFn/AvbZZz2vmbWLaflsgcc9XGkm
         yqsRDgjAutfYNhVOpv5fG6VZKnFQzJCv3iQqHDtscT5ZIFRTfej/k67rS+x5IQkXjHZq
         CqVyM/IbRp1mX6l4cWt/gbLwKG0x12Ae0L0kO+PCcSz/N3kPSTF9yjo39yo7sImnUqCv
         Nhzeq6jM/yS3VNoKa6MkIq8+FGYhS6nmEC7m+N0ZsMiStpB6D+fXMIIArrqRUlHA91V8
         TQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ttJ5qDGAgDvLl4nsg/504AJv+PW1KPxZSXg5DFeVmwA=;
        b=ihyJmb4EgqRZZbOrJmRNBCBCZUkXxHU2uyU//mtZjotCTEl2IXaRxbZTR3gV85c7q8
         DYiqh9yZoSo5gTeo5gJp43Ek31EX/q9iA7Pc0WAAbPcjFGaB2gy6Utp+uJs9mhD+7JZ3
         URvT9gsoBgaE4Q2BSGkJuBqZTYZYj3KHZE9z4sQEIDbzVGbgqf7VgM0SPMeCX/bpp1Rh
         pohPgWiiHX6jYVH+j/nZURDwSqSgSGmlW+S3f3rbUFmrRVIuJjc3Ah+XcZMT6DT2QuVD
         W62uQPclwWOnZn5REKumWTbKL6WZcqHAxgccbSvZsQ1A0NaCaNCAwTuTTGj2s+Y/LbGW
         A8nA==
X-Gm-Message-State: AOAM533UEyZb6HLF99jxP3h+ecSt+14efxr4M9KZ4zZcdBa7pXTWHLI5
	vDVSp1z7KEnSuDq8Dg4r22Qswx0eACIHr/0N
X-Google-Smtp-Source: ABdhPJzl1AVyeIXmjqiLHx2M2dRwmuUp6zje+twJXh3KLGLealvpsv/heGvrXob9jUqfbPDaO7XUAw==
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr5840552otu.138.1615662312799;
        Sat, 13 Mar 2021 11:05:12 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id o63sm4056160ota.6.2021.03.13.11.05.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 11:05:12 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Date: Sat, 13 Mar 2021 09:04:50 -1000
Message-Id: <cover.1615662134.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review this next set of patches for dunfell/1.46 and have comments back
by end of day Tuesday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1962

The following changes since commit e0dd20a006ce6fdc656e6be6ac581e93e2ed4a95:

  __init__.py: Fix bitbake debug log handling (2021-03-09 00:03:26 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (2):
  runqueue: Fix task execution corruption issue
  runqueue: Add setscene task overlap sanity check

 lib/bb/runqueue.py | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.25.1


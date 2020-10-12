Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
 by mx.groups.io with SMTP id smtpd.web12.667.1602515289214525737
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Oct 2020 08:08:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=cTSHbsVF;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.193, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f193.google.com with SMTP id n14so13748779pff.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Oct 2020 08:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=jDbXH9E9M/eXU1cbx3BTBTLxEwAm0QQZhMcRDPZaBSc=;
        b=cTSHbsVFw01EG3ESNO+rIkdahgG3AB6Nw2O1JCcO1/37H8z+Eoh1j+IGgr163ENGUM
         +fqGgknt0FP5x04rw9jsxWj9f48SS2HC69pytjdfRNIF6VHS5ORvmBVgW8jAsHXKb+ie
         ivlBgPjauUfAP6UKE5KVUYc9mC4HMOuHxSRS21nUTUHzjesZ63131i936+p7tFWiyRFD
         XGBUF0gfawef75H7xMxnGw0zbUtcU6KsFmsHeBFpNiBIIx2rR97pIpf+2PdYg0In87CH
         XgJCHNJMCU0ynEoPrK4rK7sc64sdGR5t+TPzOScTa/iv+IRWnca3vvqBhqJEmC5zRuD3
         FuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=jDbXH9E9M/eXU1cbx3BTBTLxEwAm0QQZhMcRDPZaBSc=;
        b=fyRC1Cq+ClQQ7Pt601jZmRQiNVJ4LJwyurgUuWk+LBbeN/pRoVihykwioXEMseFZJH
         r0TtRcvfP6jqbueGJ++tzY7ImHqAFOM4tirP8UaE5/AohhhKNBiyUt0yzOE006JSgh//
         WuI4mSX9C9bLwg3OhAkvukhJh0CRyKNBOUVLCicGc9Alf7nbAB4Ia4FX8PBDx/65Zhme
         38jPHInk1elybgq5bZKPtp7zoINuGLM0PWp+OD707ZqPzlNXCIltNDBzDhOYzKarkhCk
         dfiwr2YGuen2iAVSSzW05/mU9DgmaltgU8T5lJdkJlLL0Uu94ojF+K2Eljck/Ga9zC1o
         kTvQ==
X-Gm-Message-State: AOAM530Fw5ZjpETQe+z0B+gaLpJB/b8NOuy8cp7cT2UiqpD7oDXHb89K
	JzRUHCIKZY07BsBqjH6uXfsfDJq2tGUBI0lm
X-Google-Smtp-Source: ABdhPJxxLisUP+TP3YITAvtcwiXdA5UnCMB2W1w6RhALgGC5L7tz/69vVhVdwP709Nz/lVHY0N1XKA==
X-Received: by 2002:a17:90b:310a:: with SMTP id gc10mr20085018pjb.164.1602515287983;
        Mon, 12 Oct 2020 08:08:07 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id f9sm24009246pjq.26.2020.10.12.08.08.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:08:06 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Date: Mon, 12 Oct 2020 05:07:51 -1000
Message-Id: <cover.1602515077.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

Please review this next set of patches for 1.46 (dunfell) and have comments
back by end of day Wednesday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1466

The following changes since commit 18e1957337fd9f06bc673d28dd4f8277321d07bc:

  tests/fetch: Move away from problematic freedesktop.org urls (2020-09-17 09:13:32 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Charlie Davies (2):
  bitbake: fetch/git: add support for SRC_URI containing spaces in url
  bitbake: tests/fetch: add unit tests for SRC_URI with spaces in url

 lib/bb/fetch2/git.py  | 12 +++++------
 lib/bb/tests/fetch.py | 47 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 6 deletions(-)

-- 
2.17.1


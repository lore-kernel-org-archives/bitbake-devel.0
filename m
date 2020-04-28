Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.238.1588040245852769822
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Apr 2020 19:17:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=E9S5GwqE;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: akuster808@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id a32so450536pje.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Apr 2020 19:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=CcPRIGLy2eXNQC6hrFVxofFexDoyy+z8r2HHFQCuL9k=;
        b=E9S5GwqESVxYR2m+8k1u/BgvHZ/nTK0u+Ml0v0iNEOKcR5LJkwgXCNvQusC9td4rA3
         ZCoUZ2/GVKjgwmRFloXTzfRbeGx1eVrBnIs1HbTjb5vCEv0I/9HYimZHcwCFg1JktQn0
         Rum54yitPud+BVHdmca1ZIjLCbBNHDonKvBrhFF0GFp5fsrREhhbEFYvGcx9YMYMyz9J
         0hUNAo18UGa7EBfoB4Suli7WDSLfNMtg/hhjXXzpDyVyAQh41MG90DboE6nSgErL/Z+V
         nniv70BCFZXcQE91kDegmXJxDE7YuDhyCBjtx4h9yGr1e0upb5a2PE3xAm7opA9M01RL
         58Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=CcPRIGLy2eXNQC6hrFVxofFexDoyy+z8r2HHFQCuL9k=;
        b=s3LEbdzBa7IqI4MSJh+IuonmRY1VUNYPaUo9GSa4n0G/HAtPV1lbUm2aJXlVGAHaGp
         U3vewmifDdNljgCPZX7EieOTRBDzgCDBvSpOGoslLemKRupGnadM5yepGkl1/3x0pVuu
         dy/EgAtJqExz6KWM3R8JOYqNLQNTWaNBDb5cG7QNC1gQBv/xbPjg8YFSTZE++2Wf2Psb
         gKnGcz6ZCUlqvlBC7wYnoqH5/yiUa7iyeCY4/pdwwJU8B5gxpa29S5hljSVDpNssOaHR
         UVUUBRAatCFxsO5/7tQ1BuT1WoSR8Fl6zuKJPPhjjwX6eDZ4McSrOYuHfFHHWcpyOb24
         xb6A==
X-Gm-Message-State: AGi0PuauK5Kc4aW7cahStDKTEiCpqyTg2yqPa9JLtazYQfkcpEVW0YtG
	7B6bK914P+gMbNfmorD/2cUb0sO4
X-Google-Smtp-Source: APiQypIZNn2D7GQ93Ywqe7yhpuG8k5d/Mtt6LYUtsCAvJBbCLK05B7Kqp3MtxCUpaujKSfy97FaoOw==
X-Received: by 2002:a17:90a:2949:: with SMTP id x9mr2160999pjf.33.1588040245220;
        Mon, 27 Apr 2020 19:17:25 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:f1bf:759e:e8cd:49cd])
        by smtp.gmail.com with ESMTPSA id c63sm9820866pfc.2.2020.04.27.19.17.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 19:17:24 -0700 (PDT)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.44 0/3] Merge request
Date: Mon, 27 Apr 2020 19:17:19 -0700
Message-Id: <cover.1587931627.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1

Please consider these changes for 1.44.

The following changes since commit 6836184ef5220488a1127413c7d2e523fc37e2e9:

  lib/bb/utils.py: Preserve ownership of symlink (2020-03-06 17:25:10 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.44-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.44-next

Peter Kjellerstedt (3):
  knotty: Make the bb.command.CommandExit event terminate bitbake
  fetch2: Make fetcher_compare_revisions() work
  fetch2: Allow ${AUTOREV} to be used when BB_SRCREV_POLICY is "cache"

 lib/bb/fetch2/__init__.py | 51 +++++++++++++++++++++------------------
 lib/bb/ui/knotty.py       |  1 +
 2 files changed, 29 insertions(+), 23 deletions(-)

-- 
2.17.1


Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.8865.1632493322315020896
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=p1OOu4S8;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id w11so6543563plz.13
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+/bkBnN1pGEVr9lDK5XAaxvJdSSJnPJP2SGsjdQESW8=;
        b=p1OOu4S8i336wqQFoytrMvjbVfs/PJolp1mMePOWGV9AkO6VhCouStTzMeT0oUMBjj
         abXo1iVge7fzhKzJ/kHQKJfy2Mz4lf6n59DjaJz+xICULHyG9W7IgI8DcKkJYG68FCYr
         FHsrvUhpTmyzdKg3hd6BByOWu5YFrAGUl4Sj3W4AFARDyXMxLagMp6PuMr9gxEMdu8oP
         VritAySnxpOfOYi6bl5gBSzpOiqzjVnbqIbLiK/t+puPrhn4IQIbQCJmPUxxAvzqNafP
         qZXAsGamQ5vyZbVbc26rLFZB9XRy5gShvJwuboY//VhZC8ey5Rq/5vL3F/HHq32sEzn6
         k1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+/bkBnN1pGEVr9lDK5XAaxvJdSSJnPJP2SGsjdQESW8=;
        b=QvkturKnw6ITbZPr90eKe5vKF0XKKyO2+VhJNsu+gbnCNBEr42qw66I4Y7jQ7wUDNJ
         CwFaN/vXM327AidhQTmsSbegFhDCXUjswXnug5BIt204SoOXGjzITqECxiVVYfp29O8Y
         knnrgnnbZ74DIfx8lZiiMSX+a0UAeVKFj8jc1ENEyN7JUpeTun590h3HeyW9JaxpJ3uY
         Rd1XZt/OBVCryg/2t5zRcuwf7xZEoSZAGOzNYTCFiDQqZ/5tQomeKL3FP4d7rlpb9PpH
         tWF5MPA9xbEnWO18G9WrX5iegeliqe5C4u5mph5xElx8a6khJpuQhmjbxVOFXaUQ3Jnj
         5hig==
X-Gm-Message-State: AOAM530OW894XraU3AsmgbV1/EUoQ7WtUTszp3XrAgiBx56Z1aQ54XnX
	BkjyB/2Hxn4xhb3eNhBNLOKykZWXqp/cq0YWI5U=
X-Google-Smtp-Source: ABdhPJyye01j5oUWDHHX8tm2fdJ7b0UfOqRxnfxpmMm9f+wplcOvGw0Xcjm8TfXW4MioNowoHY+6DQ==
X-Received: by 2002:a17:90b:4c52:: with SMTP id np18mr2585715pjb.166.1632493321035;
        Fri, 24 Sep 2021 07:22:01 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.21.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:00 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 00/14] Patch review
Date: Fri, 24 Sep 2021 04:20:53 -1000
Message-Id: <cover.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review this next set of patches for 1.46/dunfell and have comments
back by end of day Tuesday. Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2639

The following changes since commit c2a3bda3a29e12472ef7862e424ea1552fab2959:

  providers: replace newly added logger.warn() with logger.warning() (2021-08-02 21:34:27 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Joshua Watt (1):
  server: Fix early parsing errors preventing zombie bitbake

Marco Felsch (1):
  bitbake: bitbake-layers: add skip reason to output

Richard Purdie (12):
  ui/taskexp: Improve startup exception handling
  ui/taskexp: Fix to work with empty build directories
  build: Match markup to real function name
  build: Handle SystemExit in python tasks correctly
  process: Don't include logs in error message if piping them
  build: Avoid duplicating logs in verbose mode
  build: Catch and error upon circular task references
  data_smart: Improve error display for handled exceptions
  cookerdata: Improve missing core layer error message
  cookerdata: Show error for no BBLAYERS in bblayers.conf
  bitbake-worker: Improve error handling
  cookerdata: Show a readable error for invalid multiconfig name

 bin/bitbake-worker       | 10 ++++++----
 lib/bb/build.py          | 12 +++++++++---
 lib/bb/cookerdata.py     |  7 +++++++
 lib/bb/data_smart.py     |  2 ++
 lib/bb/process.py        |  3 +++
 lib/bb/server/process.py |  3 ++-
 lib/bb/ui/taskexp.py     |  5 +++++
 lib/bblayers/query.py    |  2 +-
 8 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.25.1


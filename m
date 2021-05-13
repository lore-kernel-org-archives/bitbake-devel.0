Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web09.13872.1620914959753211145
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 May 2021 07:09:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=eqYsQwuM;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.173, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f173.google.com with SMTP id h20so14449250plr.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 May 2021 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GaPuHbM0tuGBBrmR2APGg5w5weH+n5fAyuLVtN+rVHw=;
        b=eqYsQwuMkPvfO97JOlBLUtKYwh+7Gk2LbS4XD7mfCTgKpqirKOhrtGpKIcoB7fhrmE
         UmdcTQzLkkjvDK9OaJzKiEp/reXdHOiG4u8u37FqUos3IqR1ev1iWv87c8X2p88TBo4I
         69itMwrSoNTKymmMOpAJuVaefu51sQkA6frZe8mZqzRNHfVIG5DLihpw5taR2CPZlMDk
         B9uWC4zQ9h3LZ5TdZ6rWUd8Z8HWuUKST/0SO6TtSLWiEVTU+uRq1LWtrQ7CMM/sw/dsT
         TtXl2ZVZSuT1m8u6fDIWcNyO3bXzH15Rmqg2neIsXVsu5nw2bI/OMMzi6VPGyfb1blno
         yuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GaPuHbM0tuGBBrmR2APGg5w5weH+n5fAyuLVtN+rVHw=;
        b=Sd1IQWgKXNwXUZkY2RbLispK3p7zxuc/qJNYEH1/Kg3RK8dYn+7fTqMyF0oyXzdvLc
         sh8TG3x0YNbI8FFFvfOiYRF0L6dud0FO0R2v8PSE/RC21mD/Ny14tzJH25hxK+zXl7AK
         nzzFg68EpMshSGc/Rkjel+u1WOX30rV+kXAAhIJ5Rzojf3gsmJHE/ag2OTnShS6HUJ0w
         hbXY8X8e+qkZwPW2BjF6NFTh71KFm/VZt9Sd9tfD1+wmL4vYSmpXxyKG1I4/R5fLVik0
         WU6QZnK+Z0m3Nso6xb4M8ZHi+StivwdIhc+2Of4OvknauldFhT2E9iyYxExDxdlyBnLs
         zKKQ==
X-Gm-Message-State: AOAM531FirMH34n6eJk+k60d6vCnr9j0BJ8z/xHNxmR5dkjMaFwA1IA2
	ZwksYODMVOtg9U044t5YHgR1DUgS4MKq8Np6Io0=
X-Google-Smtp-Source: ABdhPJx2xjgy+p/hvt3+/8FUPO9vgl0g+zOnk08vpyt99qeZ0rC6nCQw5/4gQNmbhMRTEpbWYSP9kQ==
X-Received: by 2002:a17:902:e54e:b029:ed:6ed2:d0ab with SMTP id n14-20020a170902e54eb02900ed6ed2d0abmr39988907plf.24.1620914958715;
        Thu, 13 May 2021 07:09:18 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id k38sm2328369pgi.73.2021.05.13.07.09.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 07:09:18 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/4] Pull request (cover letter only)
Date: Thu, 13 May 2021 04:09:02 -1000
Message-Id: <cover.1620831658.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 017a39ed05d065bf28fd38f91bcde8a098300551:

  Force parser shutdown after catching an exception (2021-04-06 22:45:22 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Mikko Rapeli (2):
  bitbake: tests/fetch: fix test execution without .gitconfig
  bitbake: tests/fetch: remove write protected files too

Niels Avonds (1):
  fetch/gitsm: Fix crash when using git LFS and submodules

Richard Purdie (1):
  runqueue: Fix deferred task issues

 lib/bb/fetch2/git.py  |  2 +-
 lib/bb/runqueue.py    |  4 ++++
 lib/bb/tests/fetch.py | 18 ++++++++++++++++--
 3 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.25.1


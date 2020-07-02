Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web10.2853.1593654272385088914
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jul 2020 18:44:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=wfNCWmk8;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.193, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f193.google.com with SMTP id o1so4058307plk.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Jul 2020 18:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=v9tmNOX9KjW6RLw28ltBUY+Kem5JfrXz/VkEluyi28Y=;
        b=wfNCWmk8nfo3lBmQk4aZNdzBupDJG+r/smC97R6oiUFUEwOh/XJHCKlezDyArifKhF
         RVlzhecLMOvdAxma4ImKud8Ex344jamLTRqVMyCpxCxdL89tm21dazEXQJCwtMtexwrL
         Hi6nxKO2jAkEg4rNCWBjzN5mnpiOcsvLqoFJd1dqnGweF2Nv8KA1l/xznmNG2mp2zkzd
         9KvXlFNcljoUtFKi6P6jYy60aLj3q8EAnCB9mRWnEB5kb8NvVmYnQ6XVxUYHGpr4WZPM
         /TR2L5+q3jZtebKBNvQ5kstTMc83N4VcEA8cdeSnCEpF+JsSQWT2tV4E1SCYU5HRIeLS
         OCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=v9tmNOX9KjW6RLw28ltBUY+Kem5JfrXz/VkEluyi28Y=;
        b=RKnznJamHCQUDjxBuzLotrD8fYpjyIRhKDPSpREBzZz+BcozpRZDOCq4wxwFQf9l6B
         ns0qjtIFrH1Kji9UjSUHtYTrrx5kVDQEwWNcM0dInGLcRCjjnRIdOajZSlS++19VLB3t
         lQj4WRIokYKr2AVZfmxGla3D1pJyfyDzo4gw+kucprRtcXVa7I/cvi6dKRs/X9ZthRa6
         aezEecC2x7/YeTdi0FMk72Z7nvW2+tqeq+EM68Q2xNqww8X/6IO9oCU/HSIIk2I3aLqy
         lYGsR2E74q5UIgUV1i3AZbjjpbTvGJ/R4yPlZMeujLzp/QtayFFUi+oG0/h28T2bUAzX
         uupQ==
X-Gm-Message-State: AOAM531xt6WlXEWNeb59v9ltXolLyzJEsN6HbedCOYqXW/NY3nScncQq
	ES/Phg0kk7huXeRY6YdBqVz5PFoa/SBhMQ==
X-Google-Smtp-Source: ABdhPJwCKUw6XDm3CRTghMQPtAfQDiTDdTvfKF2w+bhwIBRL6xeKV617YVETGwdn8snEKwCsjl5Qzw==
X-Received: by 2002:a17:902:b203:: with SMTP id t3mr25406122plr.324.1593654271014;
        Wed, 01 Jul 2020 18:44:31 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id v15sm6981873pgo.15.2020.07.01.18.44.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 18:44:30 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/5] Pull request (cover letter only)
Date: Wed,  1 Jul 2020 15:44:22 -1000
Message-Id: <cover.1593654198.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

The following changes since commit 83296870bede70e31bdf6e73683bcc30681023fc:

  tests/fetch: Switch from git.infradead.org to a YP mirror (2020-06-22 20:53:17 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Joshua Watt (2):
  hashserv: Chunkify large messages
  siggen: Fix error when hash equivalence has an exception

Richard Purdie (2):
  runqueue: Avoid unpickle errors in rare cases
  msg: Avoid issues where paths have relative components

akuster (1):
  test/fetch: change to better svn source

 lib/bb/msg.py            |   2 +-
 lib/bb/runqueue.py       |   9 +++-
 lib/bb/siggen.py         |   1 +
 lib/bb/tests/fetch.py    |   2 +-
 lib/hashserv/__init__.py |  22 ++++++++
 lib/hashserv/client.py   |  43 +++++++++++++---
 lib/hashserv/server.py   | 105 +++++++++++++++++++++++++++------------
 lib/hashserv/tests.py    |  23 +++++++++
 8 files changed, 162 insertions(+), 45 deletions(-)

-- 
2.17.1


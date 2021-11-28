Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A35C433F5
	for <webhook@archiver.kernel.org>; Sun, 28 Nov 2021 22:03:01 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.52927.1638136980428692052
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Nov 2021 14:03:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=OJxLswcr;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.43,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f43.google.com with SMTP id
 y14-20020a17090a2b4e00b001a5824f4918so13808386pjc.4
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Nov 2021 14:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVp127oj26GValJPAHItq2zrfeGfiG1lrBpFjcS+5wM=;
        b=OJxLswcrZziiuMwnTFlrWsdW+wReciil/SLj0lRjZ7dh1E8pHUHut8alUMomMlFfjj
         Ygd+c+ZKNEnQeFOf6dxVEvKxnBSUBPD5HexR5j+37I+0AmRJOw27Bv4edMwnox468Oub
         xroV5quOXo3GvTsPOtWC3y/eX5a3c/mvZUO8BBnZFVrHu66KzqrVNBw5KmDzhdbEp3VM
         zHAplBL1yh92PgpMAoBn4HraXXI3lrryr/Yf+Z1k/ZJ+CV1jGoPhd4DrTwjcUdXWmvb/
         n0RINmtRP2A+fleyeY5+hljMjnoIP2zJvbclspd/PfZNJPkyDCCUi9AGoGrFRR1QlYiI
         uycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVp127oj26GValJPAHItq2zrfeGfiG1lrBpFjcS+5wM=;
        b=7r94yh9Hcuzh/nIHi1PvmIxgSYsoqlK6lF2Qc0Jl+rHOH8dIDR5lrlaQzq2wCu7yOU
         uQzQvOFPstEX8mGhJ8FPkuu6H6ERP9uux9Y05ciwafKpL0qNy5TRTLMHzK6gzdF4R/FB
         kk4b6hPUhpUQFPZwqFcSrvBjVECShcR05kjNvZtnTr+ffc3Qf6+u6yWeTI9Z0cfaDxhV
         LtN8NW7TGZbZMyjsMW/rGSq4y490czCwFVUIiX6Blf86/tEYZmQZQJrVrT7K5RqmNLv3
         i9neu35+WI1qHf/b251Q6cKbas+C8brZdBBVnHW1zRqn6qe1F1UeF/y3Uw/i0eKub+4J
         GsWQ==
X-Gm-Message-State: AOAM531HYKFtjIiBvG/TthlFChebnw+lTbh62ZPgTiC0WYR8tV20Inlf
	bDWWUW0lryIahv/hiwk+3I7UPwd6/wBc4FprpGA=
X-Google-Smtp-Source: 
 ABdhPJyc7MekFaYZW3gnhne3LACoSZU82qrjq4R+94qHC5wlnQp9t+y/qoFCAH6bRNoJ2DN9NgaAlQ==
X-Received: by 2002:a17:90a:6487:: with SMTP id
 h7mr33301554pjj.40.1638136979271;
        Sun, 28 Nov 2021 14:02:59 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 d9sm19749139pjs.2.2021.11.28.14.02.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 14:02:58 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/3] Patch review
Date: Sun, 28 Nov 2021 12:02:45 -1000
Message-Id: <cover.1638136822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 28 Nov 2021 22:03:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13118

Please review this set of patches for dunfell/1.46 and have comments back by
end of day Tuesday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2968

The following changes since commit c0348de8121c3a842bf44906f7e2f79e93f7275b:

  fetch/wget: Add timeout for checkstatus calls (30s) (2021-11-11 10:58:01 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (3):
  command: Ensure exceptions inheriting from BBHandledException are
    visible
  tinfoil: When sending commands we need to process events
  process/knotty: Improve early exception handling

 lib/bb/command.py        |  6 +++++-
 lib/bb/server/process.py |  7 ++++++-
 lib/bb/tinfoil.py        | 11 ++++++++++-
 lib/bb/ui/knotty.py      | 21 +++++++++++++++++----
 4 files changed, 38 insertions(+), 7 deletions(-)

-- 
2.25.1



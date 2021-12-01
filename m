Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F15C433FE
	for <webhook@archiver.kernel.org>; Wed,  1 Dec 2021 22:45:00 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.746.1638398699151242244
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Dec 2021 14:44:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=Ub707A6m;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id
 gx15-20020a17090b124f00b001a695f3734aso3018882pjb.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Dec 2021 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWDzSM6RMzVwkotozhRYZN73kfcShXcbcAxj5bh7HKU=;
        b=Ub707A6mJjSg7M1Mly63mLPJtuBt0cbwJ+VAF5A9bANDq7ExU0/l6SW0kBGYegqayn
         YEOlVmqgPT1YDv5FA2Q8PsWlH7nyyOJsN2b6M5+nTtVFkDCzX1csrJp6lXluvQZbD2xa
         i3vvT2i4byeor6sypZytRizAR5vJQRP/Lp+sBeRpbq9jP6jUW/9IIFdJQwfb0CZnCg9U
         v1srJhU42gncecMjI8nDGQjCAiTtUuR5qttoc8/CmwHRW2T6oQcEl1wEgUIN4YFmMemM
         cd6Qu+ik78TKTtUlvuHoLHbVEnC9ECe9gLSY+yQtMqphdh1BtrVAjhg4FG+RjXvSBwRj
         L/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWDzSM6RMzVwkotozhRYZN73kfcShXcbcAxj5bh7HKU=;
        b=P8lPiW6nN+mI2gsp1SUP5CGoOJLSgerZj9d1khaHASuf3prA2rbdjy69P3Kk6UNAhT
         2qTh6c+Uazd3VI/6Ss6TdnVxdI5GAx4G4lldElwB4mGyUlgNQqRFYm3kNJVGc8vBSb89
         ED5ytlg9IeA4ugFWT7UK9sUCqjCrgTN8tu22z02/HpI5krTFbxPrAWXartWaonAPzi1m
         bNIq1Tbu8JMe/+lgeAqAEOkVgTi/NWogGUcyVCmlI+91GpQct8nO1k8DpSs7S1myutd4
         h6gLCDWWBmSggp+sHPgMtV/gvWPvLOH/RPtQsX2Qrhk0JaNvsPVwhkuofTPAFui+Fomp
         EDSg==
X-Gm-Message-State: AOAM532zqZdqdlO9QiPI8E6IgaSa452g0WZq942rMJEbQ3C0z/248YLS
	RK+s09+7VI7k0TuqQSxBj0aJq7yzSrj4UMNA+tc=
X-Google-Smtp-Source: 
 ABdhPJy13Cx1sIBJG3ER04mdTxIEmiAlXAvNitXbMsG2VJSQ3jD2xVmLoY4yHVwfIebHIfmCiIPwzA==
X-Received: by 2002:a17:90b:3ecd:: with SMTP id
 rm13mr1330301pjb.157.1638398698159;
        Wed, 01 Dec 2021 14:44:58 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 k18sm561778pgb.70.2021.12.01.14.44.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:44:57 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/3] Pull request (cover letter only)
Date: Wed,  1 Dec 2021 12:44:48 -1000
Message-Id: <cover.1638398608.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Dec 2021 22:45:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13123

The following changes since commit c0348de8121c3a842bf44906f7e2f79e93f7275b:

  fetch/wget: Add timeout for checkstatus calls (30s) (2021-11-11 10:58:01 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

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



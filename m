Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1401C433F5
	for <webhook@archiver.kernel.org>; Sun, 27 Mar 2022 16:44:11 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web09.806.1648399451065919775
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Mar 2022 09:44:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=3+82K4XI;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id w4so12830524ply.13
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Mar 2022 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0SU4UBE7GcExNlr5FQpvzxnY+x3idk1csY9eZaWUPlo=;
        b=3+82K4XIry6U8WtXllvMTfiRchBUlEfrT3My3mNk+jRuc7q3N0iVEAx+nUQGCMnwT+
         8zVRsjIuXon9luGg3ITiQuGhl8y+bJGGAtcxQ0ua2nAivy9vpwvf23nuTE9/2mCjKaRV
         A0VrVoVJh9P+kKyIwibKoX4eCs3a/MJhRhhrACe/XbI5ivBvnmCsqwVy6t6gBkCVh+YP
         0FGor/3qF1Tg2bhm/bqu3eJCFjaEsR/31pbZhRTIioMwfLr11xEumcZiV+68UjDY3u3D
         5q/BySGo/A/w/pmlfWatJr6NzUcB8botwF3LIZSqEZC6widn2aUz7x0k1paEDsTn7GRr
         fnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0SU4UBE7GcExNlr5FQpvzxnY+x3idk1csY9eZaWUPlo=;
        b=GP9naL8AUf/2gew6ZnJZH3eoyVhZxSEwY97We7fKxuG5cp/5cRvgfyo4sl2xxLroUU
         WhSD2Foo8e09InANeuBr5XqOwviLtxDwzEdsiW2z7+S1u4TuXusun3hrh0fH6H9Y31DU
         dCw9sSX5O8W08oQ+r2yXIOzl6up7lXfMFEuR3PK2ZGqSDVfQXDHJM+5TW6OM71yMUQqO
         +S9oNOS8u09zZqWUZoDKHItNy/C0+uE2KDJanvYqaJ3SlffWAhu4JHHyBL4Y1PLFRvh6
         9wiefqq7mIYOpjSmsfiepL+cAamCpQJbRC0KzedM36R+ZLABfnvEKKSFbz3qJqP+aehc
         cUMw==
X-Gm-Message-State: AOAM531lgodeVjr7GKkdMIPZfFzg5E4KHK8IDWCyBNhAMOW6wXirk1K+
	kmpe3Jjh+Ns+q2WeUC59GxVqfcKRvhT6+Z7hg6E=
X-Google-Smtp-Source: 
 ABdhPJxzMqqWk5kYkk4XKmwv0VdU0gjGG/naf9n7thRVz9SuZGhFe8fNG7ZipSsZuCGKlfc1iK67gw==
X-Received: by 2002:a17:90a:a502:b0:1bc:8dd6:a859 with SMTP id
 a2-20020a17090aa50200b001bc8dd6a859mr24472576pjq.46.1648399450155;
        Sun, 27 Mar 2022 09:44:10 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k13-20020aa7820d000000b004fa72a52040sm12935630pfi.172.2022.03.27.09.44.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:44:09 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Date: Sun, 27 Mar 2022 06:43:59 -1000
Message-Id: <cover.1648399312.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Mar 2022 16:44:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13519

Please review this set of patches for dunfell/1.46 and have comments back by end of
day Tuesday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/3433

The following changes since commit d22cc1e587c650fd5f90cda32f5720f8a3105aac:

  tests/fetch: Handle upstream master -> main branch change (2022-02-23 18:11:51 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (2):
  server/process: Note when commands complete in logs
  tinfoil: Allow run_command not to wait on events

 lib/bb/server/process.py | 1 +
 lib/bb/tinfoil.py        | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.25.1



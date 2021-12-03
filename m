Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF7FC433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Dec 2021 18:27:27 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.15252.1638556046687042384
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Dec 2021 10:27:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=GWFC08MO;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.178,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f178.google.com with SMTP id m15so3853939pgu.11
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Dec 2021 10:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fp5Vyt9iRab0pfQhMdTBJgu9D30vok0kT5hmNkYab38=;
        b=GWFC08MOnrFuV/DF3fGNeMrzlVi2s4XgKo2LsM72Q9bzy107kv+sY5yR/2YlqeNLdG
         rSxNlpFkinq4i+dwKlNKnsVOk6sr09RuinCRQ3NB+UyqMDrBoNBAVkD3oOk8QpENc/aq
         zNrEYYucTFUIRT6U39jwzV/eQfjv8n8b+RsCe+GLCQkRNXYlmqwlyXi4VgO4/y9Yo5CS
         k0zskY/uIRRWg1Lx5Dj1FlqKNGiHiiaUlVPFx3ZHEbGHb0hemdczaqn1av/I6c7fmTUr
         NTFpOVlfuGHWRal4nj/580cOtYK/eZlPogo7zxLtym4bE1NJpWRz2wE+YwkDxh6beccv
         IHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fp5Vyt9iRab0pfQhMdTBJgu9D30vok0kT5hmNkYab38=;
        b=xmIVjnJ5qERC8p4ow/Dr6ekmRYHIQpz7bP36LjPUD9rQkVzdKtLuGAB43Bgi3HabLU
         qboech8qJV61HtYgU6ZcUH8b7Pgsya6JRNU1FHWL7jF6mLFSZfaeNr1O+rJwvyYNTA4S
         +P4/vAadMIzIRq3IErurWcvzr4mPFrmUXFmGz5VVEhUzROmDxUOdyp07V377TsppVkZq
         9rhpEbOC3BvmYylxU61fheZ9lPEM9h9sN5gptkDWL8nrwz8PNEW83fUWTfGnK5WP2LeC
         idpN8q5qEcAIs/V8fTohir+ElX5Io1yLsyVcQd1KOxX8NIeRd0e6U2Toyebp8KhdHLfp
         dIHw==
X-Gm-Message-State: AOAM533j1dszHQxV87T0vGEZaHzS+f3ll4AnxPEVoBXn0A1+uZNA8L2h
	ugIl34tB0Aa7AHHA6Ii/lgUOvnUiMQYI3YkgtgM=
X-Google-Smtp-Source: 
 ABdhPJx2AejnqWA4lfwRUIGOBCT8u1v4QSFGXpEa0KX+kCBX63flm8FpfzQe9Z4fBfX7bupVBfL8Vg==
X-Received: by 2002:a63:654:: with SMTP id 81mr5625110pgg.218.1638556045595;
        Fri, 03 Dec 2021 10:27:25 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 v1sm3785423pfg.169.2021.12.03.10.27.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 10:27:25 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Date: Fri,  3 Dec 2021 08:27:10 -1000
Message-Id: <cover.1638555853.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Dec 2021 18:27:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13127

Please review this set of patches for dunfell/1.46 and have comments back by
end of day Tuesday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2988

with the exception of a known autobuilder intermittent issue (on qemuppc test)
which passed on subsequent retest:

https://autobuilder.yoctoproject.org/typhoon/#/builders/63/builds/4402

The following changes since commit 7fdd43c5cbde38daa013076de2fdedcf3c3d3107:

  process/knotty: Improve early exception handling (2021-11-22 04:15:15 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (2):
  cooker: Ensure reparsing is handled correctly
  bblayers/action: When adding layers, catch BBHandledException

 lib/bb/cooker.py       | 2 ++
 lib/bblayers/action.py | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1



Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26F8C61DA3
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 22:25:32 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.27821.1676931931765574765
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Feb 2023 14:25:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=aLDA0gFH;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.42, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f42.google.com with SMTP id ei9-20020a17090ae54900b002349a303ca5so2757125pjb.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 14:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7K/KO2GqPlELV0LaTEy0qlHKDn0eMnZxvQr8oEuCb9k=;
        b=aLDA0gFH0UeVjj6kst66lbqj4raew4WsmXgWX9BmsIno9eYVn1Ny4uh+EWM4r9t2AH
         FvrZZcRV5S78Jbny5bZ4yP/tK6CtnW0an8vVy9DYTki6L8lDi1w3eb6Yrt4uL3gM+Spg
         W4TvxbcXpt2uBin9Q3KwWAaVD+anO4JI7eyH0ZeeX3VSijV7u4UIGzue9s/jh59y/4Sq
         zlz2x+PYHIObJGLZ99UmQcdEWpNw/H711+KzhLQ1GpZqk9EK41ESPX1uc9CUiX+Ilore
         Ht+m8cHdP6J7kZFI8UBixwfD1M+nLWOgqjS1kCwZc5KAX4CwRhlkVXh0TRRiaMnppAs+
         BX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7K/KO2GqPlELV0LaTEy0qlHKDn0eMnZxvQr8oEuCb9k=;
        b=REk1QpYcxJIXqbW8LoARE58EFyh5PbclytOyrs2NkWmQmyt26+yyVq/nkc2e4Qb9o9
         OJ37S1yIdb2ErVlDMWstqQkLVXQ2vYSZMVevNAMSsmvIXtSKkyIDYheuyHQSnlgSBWqF
         fQbBSV3tWW511C71AZiUF3vraz/fcVKWCu5luXngIw7ShrNA04nEh+Veri+Lw9YjzSOR
         1zwvEPpCDnmWC44X7kH/rjkMi/VISXchhw2C117WmLAaW3jT23OhUw/pwf1hR1HcvTun
         6X4YNPTt5xaR95VlXtG+v+VyPMWHtXUdih3Dpbqdixts4R1Yt7MZWIU1k4c0V7Zcbzs1
         1uTw==
X-Gm-Message-State: AO0yUKXwA8izl3nHxH8YNC8XjHjcfETqyYvQyMRuOSHhNWQURub9KDnH
	54IsjZiw3rDGvCUNP3TKo0gOoqOHdaI/ksSJqak=
X-Google-Smtp-Source: AK7set9T/DEO/xvDv1KCFzPX371lznpOvP9WVP6njL3URoPgfddhM+KzhYecZkCyVHLatSHrdKwSDQ==
X-Received: by 2002:a05:6a20:8417:b0:bf:abad:c7c9 with SMTP id c23-20020a056a20841700b000bfabadc7c9mr2634314pzd.22.1676931930804;
        Mon, 20 Feb 2023 14:25:30 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b005a9131b6668sm8191447pff.2.2023.02.20.14.25.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:25:30 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/7] Patch review
Date: Mon, 20 Feb 2023 12:25:16 -1000
Message-Id: <cover.1676931822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 22:25:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14467

Please review this set of patches for dunfell/1.46 and have comments back by
end of day Wednesday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4950

The following changes since commit c527976e28165de9606497c48d834872fe68372e:

  fetch2/git: Clarify the meaning of namespace (2023-02-13 07:48:09 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (7):
  runqueue: Fix multiconfig deferred task sstate validity caching issue
  runqueue: Handle deferred task rehashing in multiconfig builds
  runqueue: Improve multiconfig deferred task issues
  runqueue: Avoid deadlock avoidance task graph corruption
  runqueue: Fix issues with multiconfig deferred task deadlock messages
  runqueue: Ensure deferred tasks are sorted by multiconfig
  cooker: Drop sre_constants usage

 lib/bb/cooker.py   |  5 ++-
 lib/bb/runqueue.py | 88 +++++++++++++++++++++++++++++-----------------
 2 files changed, 57 insertions(+), 36 deletions(-)

-- 
2.34.1



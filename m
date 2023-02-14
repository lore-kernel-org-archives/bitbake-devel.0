Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15151C61DA4
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 15:25:35 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.9888.1676388330474831903
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 07:25:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=v1ImQ0Pb;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.172, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f172.google.com with SMTP id z1so17379403plg.6
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6MBP824VrixN/XbsqfvbhrTTbOiaTir3xtDnEtP/ng=;
        b=v1ImQ0PbnIhGIicLL6NsvP2s2l5OW0y6fywXuyk18aBJnEd72j0BFPtwgu9ytN0/Rk
         23fYyXTtnupiV9klwzB+akarMZaeNRl8vUluy2sNlHe4cqyScc0hJp+g4bQpQGpZucwm
         Q56ekybrvLjcZ7+4EQZMO1V/wmXQQlu110k3/erOlhV4j7jiXfeBMvqd6lUAeCW//ErJ
         2D+qpCFhYnTO7WVKqpoNP+8kc8GMVEA7Nhor20uxBZ//SdmO33FdCa3dTQ8x/lqfObiF
         6i2WN/L2fJcuAV7auL3QB5T4O2+2KxkiXrjALupcImx42WvaswT4IOU8zk2c6B3jh0HU
         h98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6MBP824VrixN/XbsqfvbhrTTbOiaTir3xtDnEtP/ng=;
        b=GU+pLjhoOhfa0seaheMtfqmjifx/JndzlnmjPQUMoUkKdblksdeoYnmgYfxDP3lIhu
         2WrdiIU9kSDiK1eMWx7lfC0AQaei/4tsv97108xBlVEE9TZH8NYfX0Yb+BdQ4a7Dg34k
         yL1wSZQutiVkvC8W3Q7t+5jfecddygZNYbwr/AhQXToRTEojhBpiVpPqpML5qD0Y5Gbn
         e0OfT2bxDIZplPGVo70I8qcBgE/+9PxpHKrku74kVRFnyFgSYD0WO9sQ8NKUOYzydgkV
         ebNBa94HdA2G8+XCZAB3yY2FBDyLl7vSO54NwCeLhFCcFMtj/1+d9IgH+HhVKRUN9L/K
         nIGw==
X-Gm-Message-State: AO0yUKWgK1G8smZkJCiqDmHJvdybytqCsgWa1uFgSjHJlduLdY8PiGTL
	EzI9ruVw2Z/sMkfbe0f9FY3Lmqa+aMhPSXX7lYQ=
X-Google-Smtp-Source: AK7set/xG8tAq8bZri6Gq8obJZp8hgtXxsn2t5aaDG7YugBgyNY3+tWia2nOgxC+bh1n7mAIPNa3OA==
X-Received: by 2002:a05:6a20:7350:b0:be:a177:af42 with SMTP id v16-20020a056a20735000b000bea177af42mr2835271pzc.62.1676388329476;
        Tue, 14 Feb 2023 07:25:29 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id s93-20020a17090a69e600b002339491ead6sm7914416pjj.5.2023.02.14.07.25.28
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:25:29 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 0/1] Patch review
Date: Tue, 14 Feb 2023 05:25:22 -1000
Message-Id: <cover.1676388239.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 15:25:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14412

Please review this patch for langdale and have comments back by
end of day Thursday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4920

The following changes since commit a40fc6a3f774bcb28cf72701ac146ceb7ae8061a:

  fetch2/git: Clarify the meaning of namespace (2023-02-01 04:20:40 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.2-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.2-nut

Etienne Cordonnier (1):
  siggen: Fix inefficient string concatenation

 lib/bb/siggen.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1



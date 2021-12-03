Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C4C433EF
	for <webhook@archiver.kernel.org>; Fri,  3 Dec 2021 18:27:33 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web09.15275.1638556052420193794
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Dec 2021 10:27:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=fKPn2P+R;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id
 np6-20020a17090b4c4600b001a90b011e06so3180290pjb.5
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Dec 2021 10:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HoNI9qluWCwEEVaCFs7UVg9cS9xiJGZE6qkKDfbW7kY=;
        b=fKPn2P+RehhPaafn8a6yiyJhMUsDsyy6dX2T1SfQgPMQkhJrr8wQfwww8SL7VMlIXG
         c9g3hgyn06U3X1BcuBM9gFQLpfZtX5G28MUV3v6+fxS655UeP4sPwlQoDbm9qt/lCqgN
         0lgxcrdiUxdTncq98Uxw240PpnUDoaPMNCmQ38svVZOUO6hzfUAxDBzZH8Zqsrh0SQGZ
         TuFgwc3+O9ykk3FPlpqzz/3V5X26De72rpKOy60QpNw+oU5lJ0r4ajTDF9UhAxYbKwT/
         S0rbuVwDot1AJh02dQGFR36Yej0OgANjl6NKhXVB46l0qiuzOnE560eeA20LA1gF/kZ3
         McDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HoNI9qluWCwEEVaCFs7UVg9cS9xiJGZE6qkKDfbW7kY=;
        b=cPFa8EOItHVnTyBRI7qb17ZfDpog+9bOYfb5mEpwpX4R29ueUXujpV+i+oniXEilsY
         rf6pkCXRcSFQtYZsTnlSyqHVGMmxtlY0fyzPuWkU0tAbizztEby7TJxZNrUWMy12AHPC
         XO0tVFaK0L+O10KU1Bip0apqk8u8x5hxUdv80KFnOB1DuJC9HbfDmWmvDNHkU/5Zamla
         5D5cSpsESON5EHVen9ioAmZ1jEOGMEf3MGRdhxcEvPSXCo6aJLlVpKlaqLXUU3CY/I7N
         ic75EoIG24Yd9TcInGxjj16rndGaiqd0k0ikrXnR/VzArM1ynFsTDF+7SB+r71pqpER+
         bANQ==
X-Gm-Message-State: AOAM531IyIuXUI39bXGS+fWkTeBIa9Qs61uZkOlz6dnTHW5/y7hgOlaE
	T6zLb2lGLEBnEZAG+sIdygs6izdsiQBplWUqM9w=
X-Google-Smtp-Source: 
 ABdhPJx8KDZATZm1bh2xRJ5GbGow0bMHpQSHQciai2vc18GoMqTfx2DuhtVbgWrYeJLC5yERHPSw1Q==
X-Received: by 2002:a17:902:76c4:b0:143:6f27:391b with SMTP id
 j4-20020a17090276c400b001436f27391bmr24694961plt.76.1638556051487;
        Fri, 03 Dec 2021 10:27:31 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 v1sm3785423pfg.169.2021.12.03.10.27.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 10:27:31 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/2] bblayers/action: When adding
 layers, catch BBHandledException
Date: Fri,  3 Dec 2021 08:27:12 -1000
Message-Id: 
 <b8c38db27d6b4f8716847badc771036c7e0133a6.1638555853.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638555853.git.steve@sakoman.com>
References: <cover.1638555853.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Dec 2021 18:27:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13129

From: Richard Purdie <richard.purdie@linuxfoundation.org>

When adding a layer, parse error can occur, raising BBHandledException.
Catch this and error, aborting the layer add to meet user expectations.

[YOCTO #14054]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ceddb5b3d229b83c172656053cd29aeb521fcce0)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bblayers/action.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index d6459d66..d2f9c1bb 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -50,10 +50,10 @@ class ActionPlugin(LayerPlugin):
             if not (args.force or notadded):
                 try:
                     self.tinfoil.run_command('parseConfiguration')
-                except bb.tinfoil.TinfoilUIException:
+                except (bb.tinfoil.TinfoilUIException, bb.BBHandledException):
                     # Restore the back up copy of bblayers.conf
                     shutil.copy2(backup, bblayers_conf)
-                    bb.fatal("Parse failure with the specified layer added")
+                    bb.fatal("Parse failure with the specified layer added, aborting.")
                 else:
                     for item in notadded:
                         sys.stderr.write("Specified layer %s is already in BBLAYERS\n" % item)
-- 
2.25.1



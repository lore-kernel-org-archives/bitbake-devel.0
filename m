Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F486C433F5
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:23 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.602.1652205974213689466
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=QlACOePE;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id c11so17414115plg.13
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AjANAmCOUBkBqwzL1akKeBlVniAPLvilxVdcLQRtr18=;
        b=QlACOePEUQApvj7NBwAT+ehdBzZQxdsBRFrv2QN+eN3JFi3t8yeAwfyd+da2F09Zhb
         C1wfFMnaQZVk/IQOh8C6fd8T0TyGWBe4F5QiXD1MtgcTLoSYA7Cy0QF4VntJbOsLDLp6
         Fk5V2sC0H7wjsJ/940kUjiSUR5bzFQSB/QWGJDcHVcVKffn6WyX59l7TbXNWAJp47jGq
         6ki7rDQI0vglFAq1yIRfeDb1EKAPke69lq3pRV9qxo+zKjBmZf3PieY9PvBbtgUPXgFz
         OsgFKvi7mPPfgUDFqTAyJy8yH59GDy70NARvuIpf6nre6trO0QhyLnDch3h/8nJffInx
         yHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjANAmCOUBkBqwzL1akKeBlVniAPLvilxVdcLQRtr18=;
        b=DxYvMrplvHaQGHyHsC3q50u9nVRRsSgxU4YDx4tBZVVIN6lgih79BLEI3bwcEd9DKQ
         LSYkS4pZ/dTu6gqMkoUKPwnH0lXs93/nQRE7iTj7mz3yACwwLynwTbSQLOOregZ78kPf
         ufB1Yj1NKYekN3QbSzdmJ8glY3eVwPF4dokoxg/tTpmhpMVcb2txhb9ECF9oqno4E418
         DPhG/v7bYG4OofjQsQXyVaFRPN32w3g23jvWLiaWhsrEjEoD/Psj1SYvRMFramUWd6j4
         CxxMMQxve/4BjB0YOzyAf09vuPJ83w1PTSJpjda/C+Zp8nwczyWzDkahYA2BPIKom2tB
         Lgqg==
X-Gm-Message-State: AOAM532IXl9uhF7kAnKMS6DyXTQAUqN6O+eQK6Adr9fyUe7WmcPEeh8u
	hnLFv7WjoGlE83h+0kgogO0lj855LsA1Az9z
X-Google-Smtp-Source: 
 ABdhPJynQzPFHTaGRnYxtcsVeWazQjz/MKusTFOUCMMsi/GdLYnhB0yV5sitOUhwBtRmnrO5FFC4AQ==
X-Received: by 2002:a17:902:f24c:b0:15c:b564:e4cc with SMTP id
 j12-20020a170902f24c00b0015cb564e4ccmr21435032plc.137.1652205973118;
        Tue, 10 May 2022 11:06:13 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:12 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 05/18] cooker: Drop unused loop
Date: Tue, 10 May 2022 08:05:30 -1000
Message-Id: 
 <d0251a360d83e300dd1112a9268d8dbe84db5e57.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13685

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1c811ad6f10560e7a7fb6830cf83707551ba04bd)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cooker.py | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 08593d11..6da9291f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -744,19 +744,18 @@ class BBCooker:
                     taskdata[mc].add_unresolved(localdata[mc], self.recipecaches[mc])
                     mcdeps |= set(taskdata[mc].get_mcdepends())
                 new = False
-                for mc in self.multiconfigs:
-                    for k in mcdeps:
-                        if k in seen:
-                            continue
-                        l = k.split(':')
-                        depmc = l[2]
-                        if depmc not in self.multiconfigs:
-                            bb.fatal("Multiconfig dependency %s depends on nonexistent multiconfig configuration named configuration %s" % (k,depmc))
-                        else:
-                            logger.debug("Adding providers for multiconfig dependency %s" % l[3])
-                            taskdata[depmc].add_provider(localdata[depmc], self.recipecaches[depmc], l[3])
-                            seen.add(k)
-                            new = True
+                for k in mcdeps:
+                    if k in seen:
+                        continue
+                    l = k.split(':')
+                    depmc = l[2]
+                    if depmc not in self.multiconfigs:
+                        bb.fatal("Multiconfig dependency %s depends on nonexistent multiconfig configuration named configuration %s" % (k,depmc))
+                    else:
+                        logger.debug("Adding providers for multiconfig dependency %s" % l[3])
+                        taskdata[depmc].add_provider(localdata[depmc], self.recipecaches[depmc], l[3])
+                        seen.add(k)
+                        new = True
 
         for mc in self.multiconfigs:
             taskdata[mc].add_unresolved(localdata[mc], self.recipecaches[mc])
-- 
2.25.1



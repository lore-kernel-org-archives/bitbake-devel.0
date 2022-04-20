Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7244C49ED8
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:07 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.7434.1650460931691626541
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=H2SVKCXP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id b19so2221836wrh.11
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 06:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TupQgpVzOFMI9lhugkyghWjKmh8CGqgiQiKaUOS1O2I=;
        b=H2SVKCXPNBTdQeupk8ZdrL5cuqSqMQWfAH3LXVB5OFCphM7/OpS01voRl3gkb9fpU3
         1yzwla2f1gVBuCYG9TPIx49wQCTdTbWisgwCxE4w+hfYcfEf48k+QpaVwYvUYo14xKBU
         GIGRd3477XAZ5fL3Kb/LvrkPRoUXB2FWjGShM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TupQgpVzOFMI9lhugkyghWjKmh8CGqgiQiKaUOS1O2I=;
        b=tvsIfibRkjD4h2z+tIlC2hGLw8UgQaLZN0BIHYPufHViZMS+WUBxop7RsvAH/JV7xi
         e3TpxIh1oomKfiFzou7VUe+p7tKFFtaML5Js//ueGNW++l5BjWXD5MjzeNALW5H9na/x
         9Mwf9JNWnVqhsCoWhLzSs3yTHwh64ED8N0/WFjUSn3iqj7Js5gZxG0CsJS/6rtS8Z/DC
         Z+cxrZ/4Ko4dbqSlza0D74cHAiq+ZOOfGgdgGVRe7r6PHPJ0WWNarxYfNOGn94ulY8Pt
         rvPctuvxL4vEiMfYK8Z70/rUgZaypWLSq8YTfIYQ8xtOLvwELdUoUeVRwA1JRKCadBGP
         fAnA==
X-Gm-Message-State: AOAM533odJlbhm8XnsNd/v0eLjBpygy0bTMwo/r1Eqp5OFbHD9U2SI+d
	BVlWTFnU9DZsDh+gcwFnadcegJZzVgylKw==
X-Google-Smtp-Source: 
 ABdhPJxgxZgc4zWGUCx+1+nwyU838T08I+U1ijbWyRcC9TDnfRmq+hV2zdeZQeF4zNC7achKl9uJtQ==
X-Received: by 2002:a05:6000:15c6:b0:20a:8f8b:d029 with SMTP id
 y6-20020a05600015c600b0020a8f8bd029mr13568291wry.319.1650460929803;
        Wed, 20 Apr 2022 06:22:09 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 a7-20020adffb87000000b00207982c7f4dsm15213265wrr.67.2022.04.20.06.22.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:22:08 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 03/11] cooker: Drop unused loop
Date: Wed, 20 Apr 2022 14:21:57 +0100
Message-Id: <20220420132205.2530591-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
References: <20220420132205.2530591-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13645

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 7685db11f3..701e49339a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -763,19 +763,18 @@ class BBCooker:
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
2.32.0



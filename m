Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20073C433F5
	for <webhook@archiver.kernel.org>; Fri, 25 Mar 2022 15:09:32 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.6562.1648220965576636914
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 08:09:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S4DZSE6L;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id j18so11276129wrd.6
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 08:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Yn24Mj41KVFOPLoC4RAF89GMUuS66HmTpKY/slVX88=;
        b=S4DZSE6LuYcW7bLeW78jUG21aekdLc1EvJi8plm7P2CdH4cTd4LKZDZYzl83VuSSA8
         2BjuzmocKJp4SU3HY3ae/QT4k0lN8vengEZBu7zLh/UZhTGCYf3XooFEiYcMWRvEprEd
         Ri6Dh6M2Jrl3oxOe0jUpch+qYVPH9RPmao6cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Yn24Mj41KVFOPLoC4RAF89GMUuS66HmTpKY/slVX88=;
        b=mld5BExG10ujDaQ8jivaOrDHtSj1cIHaiOlpbDqVcoUTz18jXs8+iwyiXu6c4M9N6I
         zaCPjKTjkyedoqtsuQYI17Q1pTlUdY/C2eZ7iziNL9ojM6iKjS6xGYswAx1go7NT7Jnm
         W1TM+vS86q6D4pZhxWf4BQE/42cnr1uG1pLLuo/wkCQi5mj4JzH3EisiSo51cLdLNq6b
         glc2ji1igJV8yuVPCdvcnEEcZQRE+rPMbgCCfxMpeuRs4Um5lgK4/FM4gP2QdPsJ3wzc
         uCJxH51Q6B68Xnw7CVkjXcphuVOUAkcBWkxByEs/NUlETI6wl9wb1b2XqXXRraJhMWce
         4aiw==
X-Gm-Message-State: AOAM530bmw1moWFs+6ydrq9yzBWoItvbF7IAeUEVgiK/cZhwYxEnOyWW
	HNyxJLCPnqb9EtJXw5zZm3reSG1gkV2u4TCW
X-Google-Smtp-Source: 
 ABdhPJwAAqNvaOUyYX8T3ZnksIT53cOMPHP0cR4dKX34tMRZd84dpQIA9/lBzw+urk9pFicH+6GjJQ==
X-Received: by 2002:a5d:5504:0:b0:203:e3be:518b with SMTP id
 b4-20020a5d5504000000b00203e3be518bmr9561379wrv.462.1648220963433;
        Fri, 25 Mar 2022 08:09:23 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:31ae:a7af:ec6f:bb27])
        by smtp.gmail.com with ESMTPSA id
 bg18-20020a05600c3c9200b0037c2ef07493sm5486644wmb.3.2022.03.25.08.09.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:09:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Fix inotify watches causing memory resident bitbake
 corruption
Date: Fri, 25 Mar 2022 15:09:19 +0000
Message-Id: <20220325150919.1361415-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Mar 2022 15:09:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13510

Thanks to great debugging from pavel@zhukoff.net we had a simpler reproducer
for the corruption see in oe-selftest when using BB_SERVER_TIMEOUT=60, i.e.
with bitbake in memory resident mode. This was effectively:

oe-selftest -r devtool.DevtoolUpgradeTests.test_devtool_upgrade devtool.DevtoolUpgradeTests.test_devtool_upgrade_git -j 1 -K

The issue is that if directories are removed (such as workspace), if
they are added again, we don't have the watches in place any more. This
patch adds some slightly paranoid checks to ensure we do the correct things
for directory additions and removals (we track directories, not files
specifically to avoid running out of watches).

[YOCTO #14023]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c0a7a2fd79..eac956aa97 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -253,6 +253,11 @@ class BBCooker:
             return
         if not event.pathname in self.configwatcher.bbwatchedfiles:
             return
+        if "IN_ISDIR" in event.maskname:
+            if "IN_CREATE" in event.maskname:
+                self.add_filewatch([[event.pathname]], watcher=self.configwatcher, dirs=True)
+            elif "IN_DELETE" in event.maskname and event.pathname in self.watcher.bbseen:
+                self.configwatcher.bbseen.remove(event.pathname)
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
         self.baseconfig_valid = False
@@ -266,6 +271,11 @@ class BBCooker:
         if event.pathname.endswith("bitbake-cookerdaemon.log") \
                 or event.pathname.endswith("bitbake.lock"):
             return
+        if "IN_ISDIR" in event.maskname:
+            if "IN_CREATE" in event.maskname:
+                self.add_filewatch([[event.pathname]], dirs=True)
+            elif "IN_DELETE" in event.maskname and event.pathname in self.watcher.bbseen:
+                self.watcher.bbseen.remove(event.pathname)
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
         self.parsecache_valid = False
-- 
2.32.0



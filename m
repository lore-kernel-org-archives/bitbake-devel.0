Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1411DC02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 17:34:55 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.18529.1737740088184520945
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jan 2025 09:34:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=H0bFsPJo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43634b570c1so17211405e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 09:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737740086; x=1738344886; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=svAXUkxovsoOfzviUmQZdUdxypoGNwopYAb59U3RSqE=;
        b=H0bFsPJoo4NObaabWO23u7RlocuJwwwQKXGkvGogWXKTFsOknyb7Grmf4/nlDCyPYI
         BypS25EdyrlMwwwZawDP5g5NuUZ+MzCMfOAHxxxnlP7oZn+/KlYnu07hx7Z8HPq/ruzA
         JNl3bmeAN9fId1gBkTjRxy4ZiWuWXcQY0r+aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737740086; x=1738344886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svAXUkxovsoOfzviUmQZdUdxypoGNwopYAb59U3RSqE=;
        b=dsH7ZeWuZ/cqI4fHifbRh2JLkegQj/BBAJdIV+iYoWFIfkseJtosEZoMNwryR4MQTa
         t+5jiKHmZ6Q4rNnCiEnwfoBtri5VCP/PPxTddUG4mQuBUeaDflmFimkBzGmH8ukvkO4d
         geOioZh1MTwfGHJ9k3UuRrARoAXiHxydpftWnjIwWUu/XlEagJ+uJpdOBrh+WVWUrh2n
         1oxugg7Ixe3TU1b7dU5nx5YXxP5bn9uCl9dO3ovCxxd1G2Hgm7pwb0ZRXZzz2JN5vhnq
         S2LqBXhZJ5oFRsc16MsmnDGDnyjWXOT7opLsu1aEmyTox3Y9EDsF48MDjlNzVnWPxQL3
         GBKQ==
X-Gm-Message-State: AOJu0Yx2KHiufQdnAZWiDhWalVttg7CWPUVpHkqIy0Zhew94/yEVopU2
	U87m3t0rz3zgVAiV+9mlbmPWIIjvCY/QtJoeT6NobTlr+K6hblJPa9AY97Omo8/GEInb0LqQumL
	Dx8E=
X-Gm-Gg: ASbGncvPEetNAhOMm+tRFktZePb5py799L1kATy+zBwk3DTRifQ9f19WbV3d31MVJNB
	C68JyABM7ClYKd7IJkj400yPxE3JwzcZE/hM0u/fwxXTbYFLx6NnV8NwTYAn8r/8OSW7PsUKyqK
	C3EbMuHUuGKHbwUP7XFcg+ptJ7dXqQxXHKMOq0y3nrjUog9o+1zqi4h7yjv7ua1ELxnZ2iohG5w
	kVUxWuqMnby+66irZ2lZ6w2ubXlBq8jPD+JxyVutVzLjXxnA862xEL6ofR6Uue3Mu6BakJnkHwn
	FVL1TPGsR8/p3rWLtM/soJr0qhXyC2+cXg==
X-Google-Smtp-Source: AGHT+IHlCUEiCnSxKfSGidLr2DXI04QjqmppHX67U0+c0fqXrU/USgqJXHOtkURTuADr3OFlknfqew==
X-Received: by 2002:a5d:64c9:0:b0:385:f220:f788 with SMTP id ffacd0b85a97d-38bf57bbfa5mr30569085f8f.48.1737740085728;
        Fri, 24 Jan 2025 09:34:45 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6369:e73e:59c4:8223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c418esm3318352f8f.95.2025.01.24.09.34.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 09:34:45 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker/cache: Drop mc 'default' string value
Date: Fri, 24 Jan 2025 17:34:44 +0000
Message-ID: <20250124173444.2368624-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 17:34:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17078

The string value "default" for the default multiconfig is confusing since an
empty string is used pretty much everywhere in the code. Remove the few
remaining references to that to standarise.

This affects the default value of BB_CURRENT_MC and does have an impact
on metadata, particulalry bitbake.conf in openembedded-core. That said, the
number of bugs we'll avoid by trying to make "default" back to "" within
bitbake's code make fixing those extremely worthwhile.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py                                  | 2 +-
 lib/bb/cookerdata.py                             | 2 +-
 lib/bb/tests/runqueue-tests/classes/base.bbclass | 2 +-
 lib/bb/ui/uihelper.py                            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index ec7b023fc7..2361c5684d 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -395,7 +395,7 @@ class Cache(object):
         # It will be used later for deciding whether we
         # need extra cache file dump/load support
         self.mc = mc
-        self.logger = PrefixLoggerAdapter("Cache: %s: " % (mc if mc else "default"), logger)
+        self.logger = PrefixLoggerAdapter("Cache: %s: " % (mc if mc else ''), logger)
         self.caches_array = caches_array
         self.cachedir = self.data.getVar("CACHE")
         self.clean = set()
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 1f447d30c2..65c153a5bb 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -346,7 +346,7 @@ class CookerDataBuilder(object):
     def _findLayerConf(self, data):
         return findConfigFile("bblayers.conf", data)
 
-    def parseConfigurationFiles(self, prefiles, postfiles, mc = "default"):
+    def parseConfigurationFiles(self, prefiles, postfiles, mc = ""):
         data = bb.data.createCopy(self.basedata)
         data.setVar("BB_CURRENT_MC", mc)
 
diff --git a/lib/bb/tests/runqueue-tests/classes/base.bbclass b/lib/bb/tests/runqueue-tests/classes/base.bbclass
index b57650d591..80b003b2b5 100644
--- a/lib/bb/tests/runqueue-tests/classes/base.bbclass
+++ b/lib/bb/tests/runqueue-tests/classes/base.bbclass
@@ -9,7 +9,7 @@ def stamptask(d):
     with open(stampname, "a+") as f:
         f.write(d.getVar("BB_UNIHASH") + "\n")
 
-    if d.getVar("BB_CURRENT_MC") != "default":
+    if d.getVar("BB_CURRENT_MC") != "":
         thistask = d.expand("${BB_CURRENT_MC}:${PN}:${BB_CURRENTTASK}")
     if thistask in d.getVar("SLOWTASKS").split():
         bb.note("Slowing task %s" % thistask)
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 82913e0da8..e6983bd559 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -31,7 +31,7 @@ class BBUIHelper:
 
         if isinstance(event, bb.build.TaskStarted):
             tid = event._fn + ":" + event._task
-            if event._mc != "default":
+            if event._mc != "":
                 self.running_tasks[tid] = { 'title' : "mc:%s:%s %s" % (event._mc, event._package, event._task), 'starttime' : time.time(), 'pid' : event.pid }
             else:
                 self.running_tasks[tid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.time(), 'pid' : event.pid }


Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA72C54EF1
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.45613.1672505934355516511
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JM3xObN/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso17659071wmp.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvrUha3NQoEF2ZHe8pOGBDv3YGKG2quYwV269VUJITA=;
        b=JM3xObN/oSuWF6R+9sO36Ba5QdMh1eWh+KeiOcLRW28ZTJzw+qiv56c7k+g+PzVOG2
         wxmEE+9c+UEEWsHPCnGoqJPJeoLfpd+KbXJmS5BcBmF2vbXPRqs++h2frbnenaCNg0nE
         7tBi2VN/c/mlGGL1LS7pYwFWaIZ8o0aKy9dHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvrUha3NQoEF2ZHe8pOGBDv3YGKG2quYwV269VUJITA=;
        b=1MYY80vUPiY2Qr8uGTJn+ayReW8BkrboF/PKKnEGCia8SUa4E0Ia/Oq4XE2TViglFM
         G/Vkf2ROR/OccEX8U6wvAbzOIMzEpge5qRJ6zeetB2csxGHv08SYFEF6rom5OXSOLWrw
         xjfpJbOPzwkpqwUA2/K6P/c8CrrrmL/mIFWVE++cJZIrT6lm7Q/oCMvmFv93FPN8okyr
         EnbDkb/YXm5v/hCNjoVLUlSbcFRc5m0S0jxWQXejBeLRU220G5jRIAT+Iy+1V2nDe1XV
         2A54d6zeBTm4MJxKjxJ0DV1vUPqxX5KXCkN60ezZhArnrsF/YnXMiqlJeiYO8aAHg8pL
         cb/A==
X-Gm-Message-State: AFqh2kqZb2samhHBKD6KtIQ6Zeu+Wsd3l7Hcm2M6rJaHCPs0mqR5rfXA
	zdmUhjvpUl1/K5W/eajpJ9uRG8Gu2TSkBn7N
X-Google-Smtp-Source: AMrXdXswfeAYZxiXgYDtNs9sUvd9PWOrw3mha17EnuJ80rIvtSYYVK2OpSTnb4Y6LWpkjJnrkUxxpQ==
X-Received: by 2002:a05:600c:1819:b0:3cf:8d51:fae1 with SMTP id n25-20020a05600c181900b003cf8d51fae1mr25483852wmp.0.1672505932603;
        Sat, 31 Dec 2022 08:58:52 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:52 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 03/11] cooker/cookerdata: Rework the way the datastores are reset
Date: Sat, 31 Dec 2022 16:58:41 +0000
Message-Id: <20221231165849.964169-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
References: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14264

As far as I could tell, the current code could result in some strange
situations where some data was set back to the original data store copy
but the multiconfig data was not restored. There are also some changes made
to the datastore which did not persist.

The data store was also being reset at every client reset, which seems
a little excessive if we can reset it to the original condition properly.

Move the __depends -> __base_depends rename into databuilder along with
the __bbclasstype change so these are saved in the original data.

Tweak the databuilder code to be clearer and easier to follow on which
copies are where, then save copies of all the mc datastores.

Finally, drop the cache invalidation upon reset for the base config
as we shouldn't need that now (oe-selftest -r tinfoil works with memory
resident bitbake which was the original reproducer requiring that change).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py     |  9 +++------
 lib/bb/cookerdata.py | 31 +++++++++++++++++++------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c712744382..7e0d6b47bf 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -400,9 +400,7 @@ class BBCooker:
             self.disableDataTracking()
 
         for mc in self.databuilder.mcdata.values():
-            mc.renameVar("__depends", "__base_depends")
             self.add_filewatch(mc.getVar("__base_depends", False), self.configwatcher)
-            mc.setVar("__bbclasstype", "recipe")
 
         self.baseconfig_valid = True
         self.parsecache_valid = False
@@ -436,10 +434,8 @@ class BBCooker:
                     upstream=upstream,
                 )
                 self.hashserv.serve_as_process()
-            self.data.setVar("BB_HASHSERVE", self.hashservaddr)
-            self.databuilder.origdata.setVar("BB_HASHSERVE", self.hashservaddr)
-            self.databuilder.data.setVar("BB_HASHSERVE", self.hashservaddr)
             for mc in self.databuilder.mcdata:
+                self.databuilder.mcorigdata[mc].setVar("BB_HASHSERVE", self.hashservaddr)
                 self.databuilder.mcdata[mc].setVar("BB_HASHSERVE", self.hashservaddr)
 
         bb.parse.init_parser(self.data)
@@ -1788,8 +1784,9 @@ class BBCooker:
         if hasattr(self, "data"):
            self.databuilder.reset()
            self.data = self.databuilder.data
+        # In theory tinfoil could have modified the base data before parsing,
+        # ideally need to track if anything did modify the datastore
         self.parsecache_valid = False
-        self.baseconfig_valid = False
 
 
 class CookerExit(bb.event.Event):
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 650ae05ec9..b4e0c4216b 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -263,6 +263,7 @@ class CookerDataBuilder(object):
         self.mcdata = {}
 
     def parseBaseConfiguration(self, worker=False):
+        mcdata = {}
         data_hash = hashlib.sha256()
         try:
             self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
@@ -288,18 +289,18 @@ class CookerDataBuilder(object):
 
             bb.parse.init_parser(self.data)
             data_hash.update(self.data.get_hash().encode('utf-8'))
-            self.mcdata[''] = self.data
+            mcdata[''] = self.data
 
             multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()
             for config in multiconfig:
                 if config[0].isdigit():
                     bb.fatal("Multiconfig name '%s' is invalid as multiconfigs cannot start with a digit" % config)
-                mcdata = self.parseConfigurationFiles(self.prefiles, self.postfiles, config)
-                bb.event.fire(bb.event.ConfigParsed(), mcdata)
-                self.mcdata[config] = mcdata
-                data_hash.update(mcdata.get_hash().encode('utf-8'))
+                parsed_mcdata = self.parseConfigurationFiles(self.prefiles, self.postfiles, config)
+                bb.event.fire(bb.event.ConfigParsed(), parsed_mcdata)
+                mcdata[config] = parsed_mcdata
+                data_hash.update(parsed_mcdata.get_hash().encode('utf-8'))
             if multiconfig:
-                bb.event.fire(bb.event.MultiConfigParsed(self.mcdata), self.data)
+                bb.event.fire(bb.event.MultiConfigParsed(mcdata), self.data)
 
             self.data_hash = data_hash.hexdigest()
         except (SyntaxError, bb.BBHandledException):
@@ -332,17 +333,23 @@ class CookerDataBuilder(object):
         if issues:
             raise bb.BBHandledException()
 
+        for mc in mcdata:
+            mcdata[mc].renameVar("__depends", "__base_depends")
+            mcdata[mc].setVar("__bbclasstype", "recipe")
+
         # Create a copy so we can reset at a later date when UIs disconnect
-        self.origdata = self.data
-        self.data = bb.data.createCopy(self.origdata)
-        self.mcdata[''] = self.data
+        self.mcorigdata = mcdata
+        for mc in mcdata:
+            self.mcdata[mc] = bb.data.createCopy(mcdata[mc])
+        self.data = self.mcdata['']
 
     def reset(self):
         # We may not have run parseBaseConfiguration() yet
-        if not hasattr(self, 'origdata'):
+        if not hasattr(self, 'mcorigdata'):
             return
-        self.data = bb.data.createCopy(self.origdata)
-        self.mcdata[''] = self.data
+        for mc in self.mcorigdata:
+            self.mcdata[mc] = bb.data.createCopy(self.mcorigdata[mc])
+        self.data = self.mcdata['']
 
     def _findLayerConf(self, data):
         return findConfigFile("bblayers.conf", data)
-- 
2.37.2



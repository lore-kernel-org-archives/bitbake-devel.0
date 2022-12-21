Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D207C10F1B
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 23:35:17 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.33951.1671665711595801268
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 15:35:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VsYvfQ3x;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so2712810wma.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 15:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0ONtpbjCTH0su7cgVw1Ip0Nhv9RztuUYIq5L/Jh9fE=;
        b=VsYvfQ3xCkH72bENeXXuVg8T4IUKZSOFOU/5o4rlBGfQV7rTm91BZvua/MZ94AxE01
         JJH0eWtkykk5VVpIqSn7FAcqH5vShfUISyZWpAlspPRj1PkWbh2413cR4p2h7+rSCpKI
         PFjneKXJfTwxG5os5NJNCMFT9Jcp2kYXcwE1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0ONtpbjCTH0su7cgVw1Ip0Nhv9RztuUYIq5L/Jh9fE=;
        b=cxL7Nbd+Sku3huwvgihoYev6ySuBdsZ39dfCdkCFSLTXF11x88pmB1t4GG1itag3Br
         jurF33upubazV6wVO8p6sZTj8BDVWLN2Noc8eL7lOoKGjhF6erIEZ5wi4f5VvMXmauCV
         uq1cZI6NN6m/ohF+DrNjr1XZ+7u9zOANR8nnG7PyJQpGhrv59L3Thhd7SL6oy4TsMzg9
         UM0CWl7GDfsRribW7Ys+f+jaugdSr3Y1fI5e7mq2ZsP1FOnvZZ+EON6QOsJi9IQUdakK
         y9kyCKhqS0rBXNXda6eADBc2CRDxIMIhwk2M41y6BmGWwhww25zwjKQcAuwcHAz384Hp
         2ppg==
X-Gm-Message-State: AFqh2kqMVVitM7z4Y/wXxs9hfXHtwJeQrJh8sllICF3N2SW/3vzcQQn1
	CNXRlmww46NHgkjQb+QjEYL3kDFcyF7nGUUe
X-Google-Smtp-Source: AMrXdXuMbmNtr9WJ071MfYoLz5J6l+B9BetfeOXFh0NHCQHOXzYprvknrxR3huOE/rT86zDX32yPtg==
X-Received: by 2002:a7b:c408:0:b0:3d5:64bf:ccc2 with SMTP id k8-20020a7bc408000000b003d564bfccc2mr2738000wmi.32.1671665709831;
        Wed, 21 Dec 2022 15:35:09 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a8db:6d5d:f54f:c6b2])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c310f00b003b47e75b401sm4063967wmo.37.2022.12.21.15.35.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 15:35:09 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] cooker/cookerdata: Rework the way the datastores are reset
Date: Wed, 21 Dec 2022 23:35:07 +0000
Message-Id: <20221221233507.519249-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221221233507.519249-1-richard.purdie@linuxfoundation.org>
References: <20221221233507.519249-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 23:35:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14229

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
index 1daa587ac5..43e0842284 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -409,9 +409,7 @@ class BBCooker:
             self.disableDataTracking()
 
         for mc in self.databuilder.mcdata.values():
-            mc.renameVar("__depends", "__base_depends")
             self.add_filewatch(mc.getVar("__base_depends", False), self.configwatcher)
-            mc.setVar("__bbclasstype", "recipe")
 
         self.baseconfig_valid = True
         self.parsecache_valid = False
@@ -445,10 +443,8 @@ class BBCooker:
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
@@ -1797,8 +1793,9 @@ class BBCooker:
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



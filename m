Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCCDC531DC
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 15:53:46 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.49926.1723478019945162949
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 08:53:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OXh8UhF0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428119da952so32072025e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723478018; x=1724082818; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ackeiZSarVZpnT4ejsk4OL8Bd37Bwu7ZTqEYSRKx81k=;
        b=OXh8UhF0miCYLKiWGvqts5Yro+UZDkXnFjuXp+wBhoWmiuw/w4MHe8VJc+un+IBjj9
         8T5lMlVEUbThQjMNsGkwmnXZsIUZOhfmCNvDsWxJIXvEvwZ4KQ7S1cTMehavkSaoBlXJ
         CH+ruUn5NkR51rluYkfqXgTyTBjXWdQeO0iqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723478018; x=1724082818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ackeiZSarVZpnT4ejsk4OL8Bd37Bwu7ZTqEYSRKx81k=;
        b=S7ZiqB3JrYLbdEbwR7vtb7xSCkdDuGhyiTBsOFDItiGKC0CGmgAvbmDXsesCjsZKWJ
         gDbeV7Bs0Ha7ZZoDHzuST0GuxWrn4PipzyqXg6RDIE+5l7YGAGo3Lj8scy6fYR3lQi4I
         WaNB5ZGbbI3hi0biVni6iTnmEGtCmDWD/tfDGutfVk/SNNj5Omp2iSCq+8SqnJqR0Q0i
         xjJaS9ALBF7LdZy+s55DQEbsPJIYdM/5aBa7L1F/0dc6iVEC1ZlqvC0TQOgzNu95D/qW
         Zx7X9p7fss/bSMnFvwWnIJVglRJjl0dkCGs8n382dzA3YQrC3CwB1iYFa8yO+L8gouEr
         uvdA==
X-Gm-Message-State: AOJu0Yy2a8Go6n5sVOt1eBZReoeqrH/BoVxM7koBJpZIUSbWLH0dfwNy
	H4NqLfQEvyCTUr7AiuzOG0tlr2Zuh+l1y8OQ8GoMCFHjebupixrr8z6WyAUige7JJXJciVNvQpH
	/1KU=
X-Google-Smtp-Source: AGHT+IFZfPGUQzr38EQPn2b7mPXjCreJmP//93CMk0xlvNCUJJAzDyga1uiXO8wqEERmPWqMBsSmjQ==
X-Received: by 2002:a05:600c:3b88:b0:427:faa6:5648 with SMTP id 5b1f17b1804b1-429d48188c9mr6617475e9.3.1723478017764;
        Mon, 12 Aug 2024 08:53:37 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:450:fb95:e7af:f3ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c77372e8sm109970015e9.33.2024.08.12.08.53.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:53:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/4] cookerdata: Separate out data_hash and hook to tinfoil
Date: Mon, 12 Aug 2024 16:53:33 +0100
Message-ID: <20240812155335.904273-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812155335.904273-1-richard.purdie@linuxfoundation.org>
References: <20240812155335.904273-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 15:53:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16472

Within tinfoil, the user can write to the configuration data but it won't
cause the data_hash checksum to be re-written, meaning cached parsing
data can be reused when it would now be incorrect.

Abstract out the data_hash code and add it to the invalidateCaches
command, called by tinfoil.modified_files() meaning that tinfoil can
instruct bitbake to update the caches and re-parse if necessary.

Also move the data_hash entirely into databuilder and drop the copy
in cooker as obsolete and not needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py     | 10 +++++++---
 lib/bb/cookerdata.py | 13 +++++++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6754f986bf..31fee2bead 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -281,7 +281,6 @@ class BBCooker:
         self.databuilder = bb.cookerdata.CookerDataBuilder(self.configuration, False)
         self.databuilder.parseBaseConfiguration()
         self.data = self.databuilder.data
-        self.data_hash = self.databuilder.data_hash
         self.extraconfigdata = {}
 
         eventlog = self.data.getVar("BB_DEFAULT_EVENTLOG")
@@ -370,6 +369,11 @@ class BBCooker:
         if not clean:
             bb.parse.BBHandler.cached_statements = {}
 
+        # If writes were made to any of the data stores, we need to recalcuate the data
+        # store cache
+        if hasattr(self, "databuilder"):
+            self.databuilder.calc_datastore_hashes()
+
     def parseConfiguration(self):
         self.updateCacheSync()
 
@@ -1338,7 +1342,7 @@ class BBCooker:
         self.buildSetVars()
         self.reset_mtime_caches()
 
-        bb_caches = bb.cache.MulticonfigCache(self.databuilder, self.data_hash, self.caches_array)
+        bb_caches = bb.cache.MulticonfigCache(self.databuilder, self.databuilder.data_hash, self.caches_array)
 
         layername = self.collections[mc].calc_bbfile_priority(fn)[2]
         infos = bb_caches[mc].parse(fn, self.collections[mc].get_file_appends(fn), layername)
@@ -2112,7 +2116,7 @@ class CookerParser(object):
         self.mcfilelist = mcfilelist
         self.cooker = cooker
         self.cfgdata = cooker.data
-        self.cfghash = cooker.data_hash
+        self.cfghash = cooker.databuilder.data_hash
         self.cfgbuilder = cooker.databuilder
 
         # Accounting statistics
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 0649e40995..3ad5cf3dd0 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -254,9 +254,16 @@ class CookerDataBuilder(object):
         self.data = self.basedata
         self.mcdata = {}
 
+    def calc_datastore_hashes(self):
+        data_hash = hashlib.sha256()
+        data_hash.update(self.data.get_hash().encode('utf-8'))
+        multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()
+        for config in multiconfig:
+            data_hash.update(self.mcdata[config].get_hash().encode('utf-8'))
+        self.data_hash = data_hash.hexdigest()
+
     def parseBaseConfiguration(self, worker=False):
         mcdata = {}
-        data_hash = hashlib.sha256()
         try:
             self.data = self.parseConfigurationFiles(self.prefiles, self.postfiles)
 
@@ -279,7 +286,6 @@ class CookerDataBuilder(object):
                 bb.event.fire(bb.event.ConfigParsed(), self.data)
 
             bb.parse.init_parser(self.data)
-            data_hash.update(self.data.get_hash().encode('utf-8'))
             mcdata[''] = self.data
 
             multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()
@@ -289,11 +295,9 @@ class CookerDataBuilder(object):
                 parsed_mcdata = self.parseConfigurationFiles(self.prefiles, self.postfiles, config)
                 bb.event.fire(bb.event.ConfigParsed(), parsed_mcdata)
                 mcdata[config] = parsed_mcdata
-                data_hash.update(parsed_mcdata.get_hash().encode('utf-8'))
             if multiconfig:
                 bb.event.fire(bb.event.MultiConfigParsed(mcdata), self.data)
 
-            self.data_hash = data_hash.hexdigest()
         except bb.data_smart.ExpansionError as e:
             logger.error(str(e))
             raise bb.BBHandledException()
@@ -328,6 +332,7 @@ class CookerDataBuilder(object):
         for mc in mcdata:
             self.mcdata[mc] = bb.data.createCopy(mcdata[mc])
         self.data = self.mcdata['']
+        self.calc_datastore_hashes()
 
     def reset(self):
         # We may not have run parseBaseConfiguration() yet


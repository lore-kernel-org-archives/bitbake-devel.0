Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634DBC61DBD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 16:25:42 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16566.1787761534388283360
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Aug 2026 09:25:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=C3LH9eHx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso3787485e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787761532; x=1788366332; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uAEXAnR09XtH2sr3IrpdCxijpWiL/Qg0Rh5Inw/OYHA=;
        b=C3LH9eHx6STskXDdwX8a7bJBG7hLTbciKbEGu4GjEQSau7/F4kZq6wD9lRahKAoPbx
         dPgKIxjC5TVC667GCiMNg40MNJBh2cltgmSFuHn+02loMpoBTJ88YRFzIbChiJq3sfqW
         /uAwj+1srAifcWi5k5PRpsMO3OG5ZzeoLTWIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787761532; x=1788366332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uAEXAnR09XtH2sr3IrpdCxijpWiL/Qg0Rh5Inw/OYHA=;
        b=hJRV7F/SRa4ycuPTb3IoNgjLCrrklEmNupRGQgbFeQL8nl3PLEr4ObvSo9Zi0/RHGj
         aWB4HnGPDwACdnGKg1GIlc8LDwRKYH8zPSMxOIXz9o7nwPcwX8HwKfK8gQuYIr6DdX3S
         F4gxejh9aMgLZGmjSQAUmFWgsm2VxW8F1jAnwuWSiyfhswR3KTaJk7UMu8+b8n8gcjaa
         VOqMxBIliKzaMOzvZcGnCCWnT2awR2IqTIerbFyFByGS/X4pcsGGxQolCVQfizcT8U3Q
         RHQRGRId4opDN3oufAGu5vOEaWdNcRNSF3e7UpN02msSzkRUNRBRFHRsmolmwCv8BlbX
         e1IQ==
X-Gm-Message-State: AFuF++nZEIoTdhMBo61xWvVstVWAbYkEKR0Gthp5pa2si6scHtdSh/s4
	KLCLloAYvWS1jRSdvxPHvUViMnxIEfW1TQPC/bzRYP1C8GeyUU2i4zrPSw2S8Nhjd81+dPjD/iG
	TAVH9zUA=
X-Gm-Gg: AR+sD13r5F25DTOk9vJZ2B86O3bDPauiFRi+dvdVbmqCz/it1CgNCfWDgMWmWtGcW8U
	SBUi/meHIDU61X8qq8KyTo5R9F5UgLNoYtwgMhul5nCHp9K+BBqNxpZpjpozzd6B2EDJ6hiFtLM
	Y4+JWZd6LIhC9ZTDQ7+4QAf5AIDiJrJgYfh1Fsov7CmJ41WrZXYZQeYl7aS+0UpppfHRO72uoT8
	2xzg62WcmBHAeFpguIzRR2w5FutAuQMMcXXLNJs+YQLCfH1ihKGLuQzLhqO1Ue5/I+6ooXWDPlh
	43nH9jwBtlG0MT6yOV82xFcChO9+1Vdx2Nkwan+ddvCpJ10rOza/9RIWZmDQKKBusIzLiECnPXn
	/ygFt2w9otja3NGh0IN3IQi+y4cIxWCG+dejLWE4Fd6brzFU1kDW1r3XtbcmUckPNxkSoY439p/
	CoOEtVG4bnpdoDyuvBauT98u27j1uEbCgsgPD8jVCFkH3r8z3gnWJxabhKMydVwv3x4ADy9nTCS
	Lf2jE4ly/1mR6qikA==
X-Received: by 2002:a05:600c:4514:b0:499:8777:ccba with SMTP id 5b1f17b1804b1-499dc822557mr73048305e9.12.1787761532470;
        Wed, 26 Aug 2026 09:25:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e581:1e52:aeaa:4925])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc977b7csm31965785e9.7.2026.08.26.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 09:25:31 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH] cooker: Clean up collect_bbfiles handling
Date: Wed, 26 Aug 2026 17:25:30 +0100
Message-ID: <20260826162530.2483331-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 16:25:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20060

Calling collect_bbfiles from within matchFiles is horrible. Most code paths
already have a parsed configuration, except the command API call. Change that
to require a configuration and then call collect_bbfiles earlier during
parseConfiguration so the data is always available.

Also, rather than have half object entries and half return values, store all
the output of collect_bbfiles in the object to improve consistency.

This fixes consistency issues where self.collections may have done something
different to the main code paths, e.g. when listing bbappends with -b usage.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py |  2 +-
 lib/bb/cooker.py  | 24 +++++++++++++-----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 1b16884fa77..9c421aa9a8c 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -257,7 +257,7 @@ class CommandsSync:
         except IndexError:
             mc = ''
         return command.cooker.matchFile(fMatch, mc)
-    matchFile.needconfig = False
+    matchFile.needconfig = True
 
     def getUIHandlerNum(self, command, params):
         return bb.event.get_uihandler()
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index bd4ee164abc..00a6bac555f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -445,6 +445,7 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
         self.collections = {}
         for mc in self.multiconfigs:
             self.collections[mc] = CookerCollectFiles(self.bbfile_config_priorities, mc)
+            self.collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
 
         self._parsecache_set(False)
 
@@ -1322,8 +1323,8 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
         if bf.startswith("/") or bf.startswith("../"):
             bf = os.path.abspath(bf)
 
-        collections = {mc: CookerCollectFiles(self.bbfile_config_priorities, mc)}
-        filelist, masked, searchdirs = collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
+        filelist = self.collections[mc].bbfiles
+
         try:
             os.stat(bf)
             bf = os.path.abspath(bf)
@@ -1668,11 +1669,9 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
             total_masked = 0
             searchdirs = set()
             for mc in self.multiconfigs:
-                (filelist, masked, search) = self.collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
-
-                mcfilelist[mc] = filelist
-                total_masked += masked
-                searchdirs |= set(search)
+                mcfilelist[mc] = self.collections[mc].bbfiles
+                total_masked += self.collections[mc].maskedcount
+                searchdirs |= set(self.collections[mc].searchdirs)
 
             # Add mtimes for directories searched for bb/bbappend files
             for dirent in searchdirs:
@@ -1813,6 +1812,7 @@ class CookerCollectFiles(object):
     def __init__(self, priorities, mc=''):
         self.mc = mc
         self.bbappends = []
+        self.overlayed = None
         # Priorities is a list of tuples, with the second element as the pattern.
         # We need to sort the list with the longest pattern first, and so on to
         # the shortest.  This allows nested layers to be properly evaluated.
@@ -1847,7 +1847,10 @@ class CookerCollectFiles(object):
 
     def collect_bbfiles(self, config, eventdata):
         """Collect all available .bb build files"""
+        bbfiles = []
+        bbappend = []
         masked = 0
+        searchdirs = []
 
         collectlog.debug("collecting .bb files")
 
@@ -1870,7 +1873,6 @@ class CookerCollectFiles(object):
         origlistdir = os.listdir
         if hasattr(os, 'scandir'):
             origscandir = os.scandir
-        searchdirs = []
 
         def ourlistdir(d):
             searchdirs.append(d)
@@ -1932,8 +1934,6 @@ class CookerCollectFiles(object):
                 collectlog.critical("BBMASK is not a valid regular expression, ignoring: %s" % bbmask)
                 bbmask = None
 
-        bbfiles = []
-        bbappend = []
         for f in newfiles:
             if bbmask and bbmask_compiled.search(f):
                 collectlog.debug("skipping masked file %s", f)
@@ -1963,7 +1963,9 @@ class CookerCollectFiles(object):
                 topfile = bbfile_seen[base]
                 self.overlayed[topfile].append(f)
 
-        return (bbfiles, masked, searchdirs)
+        self.searchdirs = searchdirs
+        self.maskedcount = masked
+        self.bbfiles = bbfiles
 
     def get_file_appends(self, fn):
         """


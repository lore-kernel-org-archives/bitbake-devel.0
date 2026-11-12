Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65.1794524267822613291
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Nov 2026 14:57:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UONM0wyA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso2263305e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 14:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794524266; x=1795129066; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BLoGwG4/WX1FTrgf2nIXZv+lRJdEqbv/lXVjDJWyFyM=;
        b=UONM0wyA9kDTVBSqPkcmBSuDWZshzG+UGW0t66eawyZrPkBiBczIhlV1Nav+PFfTtH
         xPNHrpnHNsEE0vbqAJmJJdRK0V2bbMmVgwdtR63nhElNIW5qZjqroZFATNOG/g6OoZSq
         gdypzwR/EUgMrGDPFsmK4YwpCMtt80f89tlqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524266; x=1795129066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BLoGwG4/WX1FTrgf2nIXZv+lRJdEqbv/lXVjDJWyFyM=;
        b=ZTpXhd0VQJHnkANo0DHIrt4QaExGn5bwDCENWzJ5UYm0fmWIi4Mb2rayP2x8Mq+3Hq
         00wa6mkFDioyyRGGrCNgr/R9DFzsYBQrDmSLIq4mrbA/oKVMG4XUnn30gflhG8gQahit
         o/RRkvDMaBR9fcospPClM0Ca6VgNUAPNTKQ8obtvj6aQgMEVsSwq/Rc0DF1H2i2/QbDN
         3i5X+uN+rC0dI+DdDy47WibGUDClw5kM2hpDp3aHrRf8N0YY7vd7Louf7CJBDI4Lx5yt
         oqMGBVGxG25f1XElwLi+/wMRLmLNEvRokhozJWnxxyti6IaNseACC4MsyL/v2ODJNRV0
         thXw==
X-Gm-Message-State: APuU4Z8hQUWS4j0VQ4xXuwoEukPQJ3GXXVaZRsV3xOf3m8hf8smB5zUt
	hXZGSQYd1nw/y5hwU/Woolv71B/xN5GhIpt+U0fuausSLuOfW2wvyQgItYUpL/vuv/zg0BItYNo
	rE8jJoMM=
X-Gm-Gg: AYBFou2cghWC5kG7mgQlYfYe4TOFh5jOSz1onhcbPcWFm/4gfjmU3cvZyHUFlElOjey
	tkoWeexlGmiAEnrvIFBEOF8s7Kwc7IkripOemiu2IIG58C2DZLkL5584saOK9iRJ5QAzlWGKY78
	42BD1YTct4YnNnxpZ1grY6Ft2P6/KUvPZLZPgruB3iK7rGsCVBvRfqUwZ/ixpD7popysEdABsrc
	/Jn1/WLJT69AC+K/y+YYyWHJeXIW6OxTlDnSIl91iOPJxiQythd/qow3mqmtIA8TOcE0PmWr/I0
	gH++gT58XRS/RzA0dsXpfLR3Qi9sj73IO0BDq12R6WcsEORPS1daPEgsjtkGxJIdslhARSPopTP
	EvQryNRcivn4HW06Jl4iKoMekk7HqrNVwwQz9O21rcxEzKM5X32XXp5aOvmibLVWd0kcvRsosqm
	M8dQ4sBmSD3+jk66d0g0WotaTwuJkemHSDDoMnrmaODLmJK7sa+evyx6DEMGmARpe7DGRlqRTZL
	7b00jkWF291DZ/8hcOO9qrdUMR0dFeofVHQx5HHktsrS2jdMxGgp9qyoKnIs1pIp20SoSaY64X7
	3FK9aLGC9BxW8piqLQ+r+53NVi8BOhYZ/GBI1/615OlowC1FHTzoUFME8A==
X-Received: by 2002:a05:600c:484:b0:4ba:493b:3401 with SMTP id 5b1f17b1804b1-4bb55a5d628mr10241445e9.9.1794524265726;
        Thu, 12 Nov 2026 14:57:45 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3434:b2e4:a17f:1587])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1968sm1600294f8f.10.2026.11.12.14.57.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:57:44 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] cooker/runqueue: Add and switch to use get_layername API
Date: Thu, 12 Nov 2026 22:57:42 +0000
Message-ID: <20261112225742.155487-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 22:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20428
Content-Type: text/plain; charset="utf-8"

Rather that using one of the fields of calc_bbfile_priority, add
a new dedicated function since we want the layername more often than
not.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py  |  2 +-
 lib/bb/cooker.py   | 14 ++++++++++----
 lib/bb/runqueue.py |  4 ++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 068d95c1649..f49ebb19d8e 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -583,7 +583,7 @@ class CommandsSync:
                 appendfiles = command.cooker.collections[mc].get_file_appends(fn)
         else:
             appendfiles = []
-        layername = command.cooker.collections[mc].calc_bbfile_priority(fn)[2]
+        layername = command.cooker.collections[mc].get_layername(fn)
         # We are calling bb.cache locally here rather than on the server,
         # but that's OK because it doesn't actually need anything from
         # the server barring the global datastore (which we have a remote
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index af53135353e..aaa7e82a81b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -590,7 +590,7 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
 
         if fn:
             try:
-                layername = self.collections[mc].calc_bbfile_priority(fn)[2]
+                layername = self.collections[mc].get_layername(fn)
                 envdata = self.databuilder.parseRecipe(fn, self.collections[mc].get_file_appends(fn), layername)
             except Exception as e:
                 parselog.exception("Unable to read %s", fn)
@@ -1391,7 +1391,7 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
 
         bb_caches = bb.cache.MulticonfigCache(self.databuilder, self.databuilder.data_hash, self.caches_array)
 
-        layername = self.collections[mc].calc_bbfile_priority(fn)[2]
+        layername = self.collections[mc].get_layername(fn)
         infos = bb_caches[mc].parse(fn, self.collections[mc].get_file_appends(fn), layername)
         infos = dict(infos)
 
@@ -1825,6 +1825,12 @@ class CookerCollectFiles(object):
                 return pri, regex, layername
         return 0, None, None
 
+    def get_layername(self, filename):
+        for layername, _, regex, _ in self.bbfile_config_priorities:
+            if regex.match(filename):
+                return layername
+        return None
+
     def get_bbfiles(self):
         """Get list of default .bb files by reading out the current directory"""
         path = os.getcwd()
@@ -2181,7 +2187,7 @@ class CookerParser(object):
         for mc in self.cooker.multiconfigs:
             for filename in self.mcfilelist[mc]:
                 appends = self.cooker.collections[mc].get_file_appends(filename)
-                layername = self.cooker.collections[mc].calc_bbfile_priority(filename)[2]
+                layername = self.cooker.collections[mc].get_layername(filename)
                 if not self.bb_caches[mc].cacheValid(filename, appends):
                     self.willparse.append((mc, self.bb_caches[mc], filename, appends, layername))
                 else:
@@ -2426,7 +2432,7 @@ class CookerParser(object):
         bb.cache.SiggenRecipeInfo.reset()
         to_reparse = set()
         for mc in self.cooker.multiconfigs:
-            layername = self.cooker.collections[mc].calc_bbfile_priority(filename)[2]
+            layername = self.cooker.collections[mc].get_layername(filename)
             to_reparse.add((mc, filename, self.cooker.collections[mc].get_file_appends(filename), layername))
 
         for mc, filename, appends, layername in to_reparse:
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ef95eb46bf9..a1e6487a6de 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2307,7 +2307,7 @@ class RunQueueExecute:
                 'unihash' : self.rqdata.get_task_unihash(task),
                 'quieterrors' : True,
                 'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
-                'layername' : self.cooker.collections[mc].calc_bbfile_priority(realfn)[2],
+                'layername' : self.cooker.collections[mc].get_layername(realfn),
                 'taskdepdata' : self.sq_build_taskdepdata(task),
                 'dry_run' : False,
                 'taskdep': taskdep,
@@ -2401,7 +2401,7 @@ class RunQueueExecute:
                 'unihash' : self.rqdata.get_task_unihash(task),
                 'quieterrors' : False,
                 'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
-                'layername' : self.cooker.collections[mc].calc_bbfile_priority(realfn)[2],
+                'layername' : self.cooker.collections[mc].get_layername(realfn),
                 'taskdepdata' : self.build_taskdepdata(task),
                 'dry_run' : self.rqdata.setscene_enforce,
                 'taskdep': taskdep,

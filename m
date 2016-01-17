Return-Path: <florin@resin.io>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 30A6860116
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 17 Jan 2016 06:49:20 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id b14so79382724wmb.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 16 Jan 2016 22:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=resin.io; s=googledkim;
	h=from:to:cc:subject:date:message-id;
	bh=ylD3fNrg3XqD2xbTOtrEPUbJ5fALcyQb6BxraeOmJvU=;
	b=BYSjfJIaQM46M/6yLWuoR1fFGNkHWc0zI2mlpHrTmYtlSQzc2k4H8WSdZJKh2zBoyi
	KcZOgLuvxplBrUnK6zUdMLQ2Bv9geuAmT2xgVkE9It9/d0WN+JzHytiSuMVCy1O+uiri
	F2V3lUrAbbHmB1q76wNTXgZSd3JENNpt5dX30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ylD3fNrg3XqD2xbTOtrEPUbJ5fALcyQb6BxraeOmJvU=;
	b=Ox8kR5jsBdo+dhGBGS9BSIbydPZSm/OOLM9udwDL9KKiBxm55PcLcc5NfebN3o+UvF
	EZUNP7dpWWfOz4hrWW9x1jxY8qjT1umucVJJ4Wn/V5k8tT56k9Bkg6KxHNTrk7x7HYTY
	wC3MlDwJTe6tkKjxABfNUvd5yucHOGh42+gGs8JzDXnxZSjAkJkdnChRzrXvR8QadwbF
	mrY0UIEjEN+oxNvnY2hPzIFhXlkA4wpVF9ut1J3u2fadOR874oEl/ooVEWpswQU62RSb
	9n/7GTKr/PczWPd7DcYny+H/596HRX+AEu2Bat/ct0z2/rQG+7q3F5U2qPw2RlvRJ8n7
	aE6A==
X-Gm-Message-State: ALoCoQmjQiAzzGnzifaD40PLCy6XFcDGWA9mYUPWhzlEx6BaJUZ1keiDxD0R0KRVOIGmj6qjmSnfRxKCyCyYRnmKHum1pakgzQ==
X-Received: by 10.194.114.1 with SMTP id jc1mr17592514wjb.78.1453013360943;
	Sat, 16 Jan 2016 22:49:20 -0800 (PST)
Received: from localhost.localdomain (5-13-225-67.residential.rdsnet.ro.
	[5.13.225.67]) by smtp.gmail.com with ESMTPSA id
	w73sm9854687wmw.21.2016.01.16.22.49.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 16 Jan 2016 22:49:20 -0800 (PST)
From: Florin Sarbu <florin@resin.io>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 17 Jan 2016 08:49:04 +0200
Message-Id: <1453013345-4776-1-git-send-email-florin@resin.io>
X-Mailer: git-send-email 2.7.0.rc3
Subject: [PATCH] bitbake: cooker: Ensure bbappend files are processed in a determistic order
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 17 Jan 2016 06:49:23 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

self.appendlist is a dict and as such unordered. This can lead to cases
where appends with different names (e.g. x_%.bbappend vs. x_123.bbappend)
can be reordered in application which in turn reorders the variables
that those bbappend files might touch. Reorderd variables changes the sstate
cache signatures causing real world issues.

To avoid this, use a list for the append files instead.

This patch is conservative and just adds a new data structure alongside
the existing one and uses it to resolve the core issue. Later patches
(post release) can handle some of the wider but less problematic ones
(e.g. issues in bitbake-layers flatten).

[YOCTO #7511]

(Bitbake rev: f980f060cd0d1e7fe5011f3c325c1b254f05eccf)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/cooker.py | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2176167..9c101f2 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1573,6 +1573,7 @@ class CookerExit(bb.event.Event):
 class CookerCollectFiles(object):
     def __init__(self, priorities):
         self.appendlist = {}
+        self.bbappends = []
         self.appliedappendlist = []
         self.bbfile_config_priorities = priorities
 
@@ -1667,6 +1668,7 @@ class CookerCollectFiles(object):
         # Build a list of .bbappend files for each .bb file
         for f in bbappend:
             base = os.path.basename(f).replace('.bbappend', '.bb')
+            self.bbappends.append((base, f))
             if not base in self.appendlist:
                self.appendlist[base] = []
             if f not in self.appendlist[base]:
@@ -1692,11 +1694,11 @@ class CookerCollectFiles(object):
         """
         filelist = []
         f = os.path.basename(fn)
-        for bbappend in self.appendlist:
+        for b in self.bbappends:
+            (bbappend, filename) = b
             if (bbappend == f) or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
                 self.appliedappendlist.append(bbappend)
-                for filename in self.appendlist[bbappend]:
-                    filelist.append(filename)
+                filelist.append(filename)
         return filelist
 
     def collection_priorities(self, pkgfns, d):
@@ -1716,10 +1718,10 @@ class CookerCollectFiles(object):
                 unmatched.add(regex)
 
         def findmatch(regex):
-            for bbfile in self.appendlist:
-                for append in self.appendlist[bbfile]:
-                    if regex.match(append):
-                        return True
+            for b in self.bbappends:
+                (bbfile, append) = b
+                if regex.match(append):
+                    return True
             return False
 
         for unmatch in unmatched.copy():
-- 
2.7.0.rc3



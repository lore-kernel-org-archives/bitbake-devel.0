Return-Path: <florin@resin.io>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 3343E6FFC8
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 17 Jan 2016 07:02:35 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id r129so16386181wmr.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 16 Jan 2016 23:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=resin.io; s=googledkim;
	h=from:to:cc:subject:date:message-id;
	bh=ylD3fNrg3XqD2xbTOtrEPUbJ5fALcyQb6BxraeOmJvU=;
	b=kpQ78OhX/WWEWMWqS7pM/Qy7BPi7JxesSlZh9nacVN/OhjqZVObDi9SO4joxO9LbZy
	JmULy2OtUQdRtp60OF7WHs4pK8RgpNzocM23qUcv7yP3SLMO9GOAxEUTuQSBrgi/9uzP
	nFR3cfzZiYTlG8T8hFqlf+/mbeW4jZEKKJ8Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ylD3fNrg3XqD2xbTOtrEPUbJ5fALcyQb6BxraeOmJvU=;
	b=hn+WOJ4btDkrnCWKBmmn/g8NtCeAIDhGSC1tR3j8E8b4Qsmbs2S9eKVvzkgiwA7Vxn
	f/9NhWtnUcxnxAchs71Xsof868UzOFTFVmv2d5IwTuyKhFz+d2CBKMpjjN29c6pyCETD
	U1vp5VT7hgPGIRNdTnwWxs+WUOtzzYkex5rreAXQyyKmxES4jUaFqsHFSQUMuX+dKuyq
	puEKY5YlXyZfvLbYQz5oz2nY9ObZrtAMNouh8NZkzJWMWEtaNYy09cZD+fcumddk07LC
	fdyQc3cqSDOaTE82H/8IVUaJO7PSn7Dl7GrJI33bmhVQb/ZxDsheeAMvEP2QN2h9W8et
	C/pA==
X-Gm-Message-State: ALoCoQnCSH0bpViYtnf9RPtGwDUWSQvblRFMyLuiJWxb9zqCjAkogMIwYswoyuJ9/Sh6fP1JCdPPEuBaekuqdn81bTgOsH7rzQ==
X-Received: by 10.194.240.67 with SMTP id vy3mr18348715wjc.168.1453014156425; 
	Sat, 16 Jan 2016 23:02:36 -0800 (PST)
Received: from localhost.localdomain (5-13-225-67.residential.rdsnet.ro.
	[5.13.225.67]) by smtp.gmail.com with ESMTPSA id
	c26sm9934066wmi.21.2016.01.16.23.02.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 16 Jan 2016 23:02:35 -0800 (PST)
From: Florin Sarbu <florin@resin.io>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 17 Jan 2016 09:02:27 +0200
Message-Id: <1453014147-5233-1-git-send-email-florin@resin.io>
X-Mailer: git-send-email 2.7.0.rc3
Subject: [DAISY backport] bitbake: cooker: Ensure bbappend files are processed in a determistic order
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
X-List-Received-Date: Sun, 17 Jan 2016 07:02:39 -0000

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



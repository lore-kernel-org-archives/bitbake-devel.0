Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
	[209.85.210.175])
	by mail.openembedded.org (Postfix) with ESMTP id 53AD87FC2D
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 23:43:27 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id d199so1688608pfd.11
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 15:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=HHn2uXs1Z46LnTtyhlpOIKac2f5SDu8r14PuBhSlgiU=;
	b=IZy11OUry2wZzQ2LxWwjTcjZz/7O3sdgHcBWHw9h3kHawBmU63dMvyKSDJThWoM46r
	w5LzVAyCxSfPt1NSkHOrTGBuMtOmCzYDQygkxOMyFH++F+Sy/SAl1PjdPVd9uFGetVeb
	jfg4xPkXfUbQW/BtYpDCCLZ4g/IH89DRHBt4GlfLDu8cXF4Ic0gRneQ71aqge0TeKtg/
	IWkpHwm0jHfqSLfwiRTZZ1oUE5w+XIhcotqMTSZP2IWO1+ae6o0sY/UpypZLmj+6P2TS
	8a+1p9d2YxEpZ+Y/tMoQwyJV1hn68V01EiGXH+TXJ1y1VDlQ830yitseib6cvnXQpHnT
	LcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=HHn2uXs1Z46LnTtyhlpOIKac2f5SDu8r14PuBhSlgiU=;
	b=rDZ90bfB9+60FqJQ6W7A2OZH39MeRwaPOhLWTwtzJd422aX6r2iXvIUJh/z4rrCxLD
	zxFayK4A8hnEkALDa/rpBZaIYtt0OGdQfgH9fxAcM5rr4jr0qh5VS6/7Nm9x8tldXLN6
	/+J7+EEGbhwXdEdzhT1udY/7dvW+oTkMEHOC8Tjb7Z19Yeq2D+UPSbR0uNCvCmK35BRf
	5ruI0cr+/hlTRAflCxTmJaBXN2BAiNi0F3lWIOXIIXPPL1sqU3wMMA1ZH56igH/3NIZn
	m1HNOkx5YLwCHXmNjOL2mb1qSYQ/NvTUL+6VzLDoAJnJVabBT0IyUCmyg9fBF/GVs3UN
	BwZw==
X-Gm-Message-State: APjAAAXFHkBwcZDw77nbGKF1MPKyclKKvsqJoydpxp0DVsbdAiSn0daB
	0H2cRzXMPUr1NbEh3vSA9YRyb+O0
X-Google-Smtp-Source: APXvYqyCql5jm6KF6zJcCz+B3E552LRjx+te2Kt3xjVk/cIv6oKT8aZzkeG8rcj7RbYXsNvrHHIklg==
X-Received: by 2002:a63:a0b:: with SMTP id 11mr29494477pgk.114.1574639008066; 
	Sun, 24 Nov 2019 15:43:28 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:69ac:e4d2:e89f:98da])
	by smtp.gmail.com with ESMTPSA id
	125sm5729367pfu.136.2019.11.24.15.43.27
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 24 Nov 2019 15:43:27 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Nov 2019 15:43:14 -0800
Message-Id: <24e3c7189e7d41bcbb46078a41c3a9daf391202a.1574638886.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1574638886.git.akuster808@gmail.com>
References: <cover.1574638886.git.akuster808@gmail.com>
Subject: [PATCH 1/9] fetch2/git: fetch shallow revs when needed
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
X-List-Received-Date: Sun, 24 Nov 2019 23:43:27 -0000

From: Christopher Larson <chris_larson@mentor.com>

When bitbake determines if a git clone needs updating, it only checks for the
needed srcrevs, not the revs listed in BB_GIT_SHALLOW_REVS, which will fail if
using shallow and the needed rev was added to the upstream git repo after a
previous fetch. Ensure that we also check for shallow revs.

[YOCTO #13586]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/fetch2/git.py | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 2d1d2ca..fa41b07 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -292,11 +292,21 @@ class Git(FetchMethod):
     def clonedir_need_update(self, ud, d):
         if not os.path.exists(ud.clonedir):
             return True
+        if ud.shallow and ud.write_shallow_tarballs and self.clonedir_need_shallow_revs(ud, d):
+            return True
         for name in ud.names:
             if not self._contains_ref(ud, d, name, ud.clonedir):
                 return True
         return False
 
+    def clonedir_need_shallow_revs(self, ud, d):
+        for rev in ud.shallow_revs:
+            try:
+                runfetchcmd('%s rev-parse -q --verify %s' % (ud.basecmd, rev), d, quiet=True, workdir=ud.clonedir)
+            except bb.fetch2.FetchError:
+                return rev
+        return None
+
     def shallow_tarball_need_update(self, ud):
         return ud.shallow and ud.write_shallow_tarballs and not os.path.exists(ud.fullshallow)
 
@@ -339,13 +349,7 @@ class Git(FetchMethod):
             runfetchcmd(clone_cmd, d, log=progresshandler)
 
         # Update the checkout if needed
-        needupdate = False
-        for name in ud.names:
-            if not self._contains_ref(ud, d, name, ud.clonedir):
-                needupdate = True
-                break
-
-        if needupdate:
+        if self.clonedir_need_update(ud, d):
             output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
             if "origin" in output:
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
@@ -369,6 +373,11 @@ class Git(FetchMethod):
             if not self._contains_ref(ud, d, name, ud.clonedir):
                 raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
 
+        if ud.shallow and ud.write_shallow_tarballs:
+            missing_rev = self.clonedir_need_shallow_revs(ud, d)
+            if missing_rev:
+                raise bb.fetch2.FetchError("Unable to find revision %s even from upstream" % missing_rev)
+
     def build_mirror_data(self, ud, d):
         if ud.shallow and ud.write_shallow_tarballs:
             if not os.path.exists(ud.fullshallow):
-- 
2.7.4



Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
	[209.85.216.51])
	by mail.openembedded.org (Postfix) with ESMTP id C7C3C7D00A
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 16:25:00 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id y21so4509970pjn.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=HHn2uXs1Z46LnTtyhlpOIKac2f5SDu8r14PuBhSlgiU=;
	b=QhKx06kkdtFR0unx1GqVj7XSg9edDrm07EMhx4cLafaErHJ+fQF5TFcq1rdiI9YYKY
	xuOBbRG04I/ckKNxfwJV7tbfvBf9t56emW+QPboC/PCpheLgDlDSqE6tSYlLBVL4cPkg
	KPkgfgbn+U2hurRzO8R9cXsRGHFqFOmxUP04TYt/gkJLBmxOOlh+3IDWIQw1WzYwJ7n4
	5ttM2mA9di6M7bH8cwf+NeYrScSxOelfAbd1txDE6zkSAMOJt7kSCofHbNTLVtbqNJ3Z
	aSVNAT2gxMwoCdlck0sAUUivrDeFotOqi+WM03GW+RsEt4raY4wDMdm5i3xr/Cf8uPVO
	94IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=HHn2uXs1Z46LnTtyhlpOIKac2f5SDu8r14PuBhSlgiU=;
	b=FYAm/Na+i9943s0VqGecZo2P7+1jfw7PkZZyE423Psi5PTCBkWRTCZ+IL8GjDG1r52
	QNky1QnDR9K9uECNudDtoHYR9SJuAEEbChUV+hoj52JYfrTe81YqkqlLKn31IwC3N4Lv
	fE8Cl2Wl/Fvy0HGKNO3fg8C1I5jCxsVPm7x0wvkhBDTp55O4TVmox5bR8H5LX0ZSHrzA
	XTOE32oTf7vpl45e3l6tivWckIXVHhkM7TGOmhXDqiybZlWie7vVx2JL/DpK3XQASPgU
	BjTWKuTOlLrbeaHnzC4EjLLS6MT+4ZyzPweOVxDp7B/8drwXwkvC0jav+YRc7owRgZ+t
	qKTQ==
X-Gm-Message-State: APjAAAUWLzgY13NUYpyQl+JnXTgri7g78TvvCCY8Zngz5lUXdmynXZOk
	pJPYm5exRyUuupfRupv69qExc+Fb
X-Google-Smtp-Source: APXvYqzvhMKaHw8my896Ha/++RhJ56wf2VTedYwR0433A9I6IU49oF9np/xrgnaSfZopStd3FKZraQ==
X-Received: by 2002:a17:902:6b0c:: with SMTP id
	o12mr19936222plk.173.1574526301663; 
	Sat, 23 Nov 2019 08:25:01 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:d5a1:4623:137e:d439])
	by smtp.gmail.com with ESMTPSA id h9sm2735572pjh.8.2019.11.23.08.25.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 23 Nov 2019 08:25:01 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 08:24:51 -0800
Message-Id: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [1.44][PATCH 1/9] fetch2/git: fetch shallow revs when needed
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
X-List-Received-Date: Sat, 23 Nov 2019 16:25:00 -0000

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



Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FACC369D1
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 15:25:47 +0000 (UTC)
Received: from esa5.hc324-48.eu.iphmx.com (esa5.hc324-48.eu.iphmx.com [207.54.71.60])
 by mx.groups.io with SMTP id smtpd.web10.11459.1745421943504997724
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Apr 2025 08:25:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=RKP81/gJ;
 spf=pass (domain: bmw.de, ip: 207.54.71.60, mailfrom: prvs=201e634cf=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745421943; x=1776957943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vg2+lyh2R2Sueo4iIR3js+irAiQxe4PHeUw6uhRoWMM=;
  b=RKP81/gJgnR444SRTD7h2uKIi8FoR9O5skH/ambUE1Q21siv8WEO6zYr
   3HXTnI/nKQKyX4OeBsVjOBMN4vtwO/UJv4XQLPQuFYYm5y/TOjw442IN5
   hzIw5+n2F56Ew7hpcxS1ivaSjPgGZYU/2llKpoXUBtWzz7O0R+sygolNa
   c=;
X-CSE-ConnectionGUID: tvtxv4NWT1aTGgBiEdteVw==
X-CSE-MsgGUID: tK3kFD07TESvACCEqApEMg==
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa5.hc324-48.eu.iphmx.com with ESMTP/TLS; 23 Apr 2025 17:25:40 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw4.muc with ESMTP/TLS;
 23 Apr 2025 17:25:41 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 23 Apr 2025 17:25:41 +0200
Received: from localhost.localdomain (10.30.85.210) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Wed, 23 Apr 2025 17:25:40 +0200
X-CSE-ConnectionGUID: Xf88iss4Sb6/lFpOEaThkw==
X-CSE-MsgGUID: RPExn3kFQ8SRDcOg22YEtg==
X-CSE-ConnectionGUID: lln3+7hpTkypyTpufyTUdg==
X-CSE-MsgGUID: 1+C2swWbTcqheU1Yi3dw2w==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [PATCH 1/8] fetch2: Clean up no longer used name parameter
Date: Wed, 23 Apr 2025 17:18:54 +0200
Message-ID: <20250423151901.1300944-2-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423151901.1300944-1-philip.lorenz@bmw.de>
References: <20250423151901.1300944-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp15a.europe.bmw.corp (2a03:1e80:a15:58f::1:68) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Apr 2025 15:25:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17543

There's no need to pass `name` when it is no longer used.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/fetch2/git.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b47a53e3b..39c183927 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -327,7 +327,7 @@ class Git(FetchMethod):
         if self.clonedir_need_update(ud, d):
             return True
 
-        if not self._lfs_objects_downloaded(ud, d, ud.name, ud.clonedir):
+        if not self._lfs_objects_downloaded(ud, d, ud.clonedir):
             return True
         return False
 
@@ -802,7 +802,7 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
         return output.split()[0] != "0"
 
-    def _lfs_objects_downloaded(self, ud, d, name, wd):
+    def _lfs_objects_downloaded(self, ud, d, wd):
         """
         Verifies whether the LFS objects for requested revisions have already been downloaded
         """
@@ -841,7 +841,7 @@ class Git(FetchMethod):
 
         if ud.nobranch:
             # If no branch is specified, use the current git commit
-            refname = self._build_revision(ud, d, ud.name)
+            refname = ud.revision
         elif wd == ud.clonedir:
             # The bare clonedir doesn't use the remote names; it has the branch immediately.
             refname = ud.branch
@@ -995,7 +995,7 @@ class Git(FetchMethod):
         Return a sortable revision number by counting commits in the history
         Based on gitpkgv.bblass in meta-openembedded
         """
-        rev = self._build_revision(ud, d, name)
+        rev = ud.revision
         localpath = ud.localpath
         rev_file = os.path.join(localpath, "oe-gitpkgv_" + rev)
         if not os.path.exists(localpath):


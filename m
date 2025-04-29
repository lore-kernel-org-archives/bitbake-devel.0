Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06A7C3ABAF
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:18:05 +0000 (UTC)
Received: from esa2.hc324-48.eu.iphmx.com (esa2.hc324-48.eu.iphmx.com [207.54.68.120])
 by mx.groups.io with SMTP id smtpd.web11.13074.1745914681685012812
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Apr 2025 01:18:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=hjDWhdKf;
 spf=pass (domain: bmw.de, ip: 207.54.68.120, mailfrom: prvs=207d80f5d=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745914682; x=1777450682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vg2+lyh2R2Sueo4iIR3js+irAiQxe4PHeUw6uhRoWMM=;
  b=hjDWhdKfifPrQ32/cDfpGDr8Qktu8mS5K0xqWwwl5jlWtOUteDaUH5BY
   o5CEF5v3KC4K6SjQXXVYPE30r9H2PFFHiS27LlCzogH7XruHAPdVV8Dov
   6AORDCov0Y/fxdgWKNYzXgujSJXcgBxM2kGVfM0zufMaeFn4W71T8EBwR
   E=;
X-CSE-ConnectionGUID: J3Herv3aQBOlJq+WY/Y6Ng==
X-CSE-MsgGUID: +T66giY6T2ChqyJ8FtG7Tw==
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa2.hc324-48.eu.iphmx.com with ESMTP/TLS; 29 Apr 2025 10:17:59 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw2.muc with ESMTP/TLS;
 29 Apr 2025 10:17:57 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 29 Apr 2025 10:17:58 +0200
Received: from localhost.localdomain (10.30.85.212) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 29 Apr 2025 10:17:57 +0200
X-CSE-ConnectionGUID: 7MNMQBeASfydtVQLxl+vAQ==
X-CSE-MsgGUID: ipv/60O2Qmi11J9PrataGw==
X-CSE-ConnectionGUID: kpaKKZBpRNWwcLnhzod0Mg==
X-CSE-MsgGUID: xyyowx3rRvivAfnr93Hd0A==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v4 1/8] fetch2: Clean up no longer used name parameter
Date: Tue, 29 Apr 2025 10:11:17 +0200
Message-ID: <20250429081124.3695505-2-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429081124.3695505-1-philip.lorenz@bmw.de>
References: <20250429081124.3695505-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp09b.europe.bmw.corp (2a03:1e80:a15:58f::203f) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Apr 2025 08:18:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17585

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


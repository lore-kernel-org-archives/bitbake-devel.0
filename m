Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B92C369D8
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 14:48:20 +0000 (UTC)
Received: from esa12.hc324-48.eu.iphmx.com (esa12.hc324-48.eu.iphmx.com [207.54.72.34])
 by mx.groups.io with SMTP id smtpd.web10.8244.1745592494667551650
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 07:48:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=KZnsU5gk;
 spf=pass (domain: bmw.de, ip: 207.54.72.34, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745592496; x=1777128496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Hv77MH5/tIplL7alvTM3RgdwLfBF7nTTeonzXa++DE=;
  b=KZnsU5gkERge8P3D2YeQjlInxsTvIuAJc68XiZdqvvREkiBOG6ExgyWq
   3q2vfG8JdrZXIkD7Bg0Q8pI75S2S0JVngJp+jF77w45LpPC9KdQ1dHQVT
   VGt+BK5nn80yikCovHcR21VtDKefsKW7egTkxpMyXrcCdvo4c3njAZNug
   A=;
X-CSE-ConnectionGUID: 5GH7lSQyR/ixbZ6kqRQJAQ==
X-CSE-MsgGUID: dNpbBWLaS/+IN24FEh6kCQ==
Received: from 160.46.252.35.spf.bmwgroup.com.bmwgroup.com (HELO esagw3.muc)
 ([160.46.252.35]) by esa12.hc324-48.eu.iphmx.com with ESMTP/TLS;
 25 Apr 2025 16:48:12 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw3.muc with ESMTP/TLS;
 25 Apr 2025 16:48:12 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 25 Apr 2025 16:48:08 +0200
Received: from localhost.localdomain (10.30.85.205) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 16:48:07 +0200
X-CSE-ConnectionGUID: wJqUohr7SH29W0VxOY6zDA==
X-CSE-MsgGUID: h4z9+QFNTlSzzrzec4sAvw==
X-CSE-ConnectionGUID: 0fkV9PmEQ56m2I9yLusSvw==
X-CSE-MsgGUID: sCRBK2ZbSduA6hIgN0wCBQ==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v3 5/8] fetch2: Use git-lfs fetch to download objects
Date: Fri, 25 Apr 2025 16:41:35 +0200
Message-ID: <20250425144138.4089681-6-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425144138.4089681-1-philip.lorenz@bmw.de>
References: <20250425144138.4089681-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp17a.europe.bmw.corp (2a03:1e80:a15:58f::1:3a) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 14:48:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17573

Its not clear which exact git-lfs versions failed to work with bare
repositories, however git-lfs 2.13.2 which is shipped by Debian 10 (i.e.
the oldest supported distribution by scarthgap) shows no issue when
fetching into a bare repository. Switch to git-lfs fetch which in turn
eliminates issues seen when using the gitsm fetcher with submodules
utilizing lfs.

In these scenarios, fetching of LFS objects did not actually happen as
the gitsm fetcher parametrizes the to be fetched repositories with
`bareclone=1` which in turn means that the target revision was never
checked out (and therefore no LFS objects were fetched).

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/fetch2/git.py | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 9b2ad455c..11cda2007 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -482,30 +482,7 @@ class Git(FetchMethod):
                 raise bb.fetch2.FetchError("Unable to find revision %s even from upstream" % missing_rev)
 
         if self.lfs_need_update(ud, d):
-            # Unpack temporary working copy, use it to run 'git checkout' to force pre-fetching
-            # of all LFS blobs needed at the srcrev.
-            #
-            # It would be nice to just do this inline here by running 'git-lfs fetch'
-            # on the bare clonedir, but that operation requires a working copy on some
-            # releases of Git LFS.
-            with tempfile.TemporaryDirectory(dir=d.getVar('DL_DIR')) as tmpdir:
-                # Do the checkout. This implicitly involves a Git LFS fetch.
-                Git.unpack(self, ud, tmpdir, d)
-
-                # Scoop up a copy of any stuff that Git LFS downloaded. Merge them into
-                # the bare clonedir.
-                #
-                # As this procedure is invoked repeatedly on incremental fetches as
-                # a recipe's SRCREV is bumped throughout its lifetime, this will
-                # result in a gradual accumulation of LFS blobs in <ud.clonedir>/lfs
-                # corresponding to all the blobs reachable from the different revs
-                # fetched across time.
-                #
-                # Only do this if the unpack resulted in a .git/lfs directory being
-                # created; this only happens if at least one blob needed to be
-                # downloaded.
-                if os.path.exists(os.path.join(ud.destdir, ".git", "lfs")):
-                    runfetchcmd("tar -cf - lfs | tar -xf - -C %s" % ud.clonedir, d, workdir="%s/.git" % ud.destdir)
+            self.lfs_fetch(ud, d, ud.clonedir, ud.revision)
 
     def lfs_fetch(self, ud, d, clonedir, revision, fetchall=False, progresshandler=None):
         """Helper method for fetching Git LFS data"""


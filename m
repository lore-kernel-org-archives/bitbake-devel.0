Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2506C369DC
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 10:18:37 +0000 (UTC)
Received: from esa13.hc324-48.eu.iphmx.com (esa13.hc324-48.eu.iphmx.com [207.54.72.35])
 by mx.groups.io with SMTP id smtpd.web11.3609.1745576309351521975
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Apr 2025 03:18:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=qVyyjSx/;
 spf=pass (domain: bmw.de, ip: 207.54.72.35, mailfrom: prvs=2034cd71c=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745576310; x=1777112310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SrZN+Xcty/R80wSBSubQUbETvapjbIkKeuuhVJgG7Y=;
  b=qVyyjSx/u3KDtZqTFXIWbNiajjoe0SJTOZgctm31rlA07iXVv8rnD0GT
   j6IfvaJHE5vNyMwXfjw8XLuAJUUr4Biiu4ntdVjNo1G/xpLnMFSukcp3M
   w2z3MO5GLXoUMXENqll7kP9ddV4vKfGBhBMHkC1lnsiMtHNwcbPoI7fGO
   4=;
X-CSE-ConnectionGUID: my4INOooTXmGXLLUsXLdag==
X-CSE-MsgGUID: bOc8VILlRvWFBIgGuagJsw==
Received: from 160.46.252.46.spf.bmwgroup.com (HELO esagw5.muc) ([160.46.252.46]) by
 esa13.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Apr 2025 12:18:27 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw5.muc with ESMTP/TLS;
 25 Apr 2025 12:18:27 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 25 Apr 2025 12:18:27 +0200
Received: from localhost.localdomain (10.30.85.206) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Fri, 25 Apr 2025 12:18:27 +0200
X-CSE-ConnectionGUID: 2N3LWraqTu6mCnRtub0oQA==
X-CSE-MsgGUID: Umzi16tfStOr0e1b8XWUNQ==
X-CSE-ConnectionGUID: 05W17eGvSnmATYnXkX32aw==
X-CSE-MsgGUID: WjNsrihJT5+Ojn8crzve4w==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH v2 5/8] fetch2: Use git-lfs fetch to download objects
Date: Fri, 25 Apr 2025 12:11:52 +0200
Message-ID: <20250425101155.2905972-6-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425101155.2905972-1-philip.lorenz@bmw.de>
References: <20250425101155.2905972-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCMP09F.europe.bmw.corp (2a03:1e80:a15:58f::1:2d) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Apr 2025 10:18:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17561

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
index a1dd12bf7..341bbf0ed 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -484,30 +484,7 @@ class Git(FetchMethod):
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


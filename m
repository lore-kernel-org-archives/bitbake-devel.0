Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852CBC3ABAA
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:18:05 +0000 (UTC)
Received: from esa2.hc324-48.eu.iphmx.com (esa2.hc324-48.eu.iphmx.com [207.54.68.120])
 by mx.groups.io with SMTP id smtpd.web11.13074.1745914681685012812
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Apr 2025 01:18:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=Yw5JANqv;
 spf=pass (domain: bmw.de, ip: 207.54.68.120, mailfrom: prvs=207d80f5d=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745914684; x=1777450684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Hv77MH5/tIplL7alvTM3RgdwLfBF7nTTeonzXa++DE=;
  b=Yw5JANqvePv/MeeUoQh+FmbqKlfZEXBhvJOWJAlzTkoBKF4E6uetqeLJ
   +kgvGFgXzXusTzYhaIR+mrJcHqxCGTXUohifHyw2qqODu9TI5y4y0D5Ue
   AYMRu6gCEAmbort1VWglZydAKcGnttfCc19s1D3eetzOonWRgnGGtdWB7
   w=;
X-CSE-ConnectionGUID: J3Herv3aQBOlJq+WY/Y6Ng==
X-CSE-MsgGUID: 6nNRz1IvSgu3veW5fHdz3g==
Received: from esagw2.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa2.hc324-48.eu.iphmx.com with ESMTP/TLS; 29 Apr 2025 10:17:59 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw2.muc with ESMTP/TLS;
 29 Apr 2025 10:17:58 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 29 Apr 2025 10:17:58 +0200
Received: from localhost.localdomain (10.30.85.212) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 29 Apr 2025 10:17:57 +0200
X-CSE-ConnectionGUID: RjVLhOM/Q3WTzpPFOy/MWQ==
X-CSE-MsgGUID: O4SecT03T6WKZedN9q2oNg==
X-CSE-ConnectionGUID: TsJs5m1kTS2M4JofsJW2pw==
X-CSE-MsgGUID: CEzNvmfCRrS38TDBnquh1A==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>, <mathieu.dubois-briand@bootlin.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [PATCH v4 5/8] fetch2: Use git-lfs fetch to download objects
Date: Tue, 29 Apr 2025 10:11:21 +0200
Message-ID: <20250429081124.3695505-6-philip.lorenz@bmw.de>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17587

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


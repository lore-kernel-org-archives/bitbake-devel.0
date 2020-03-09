Return-Path: <pbarker@konsulko.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id F1B28601F3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 13:43:05 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id a25so7412213wrd.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LaZ8F/u28Qi7rLFHlQllelu1t531SqqmU2zwlyiFJoA=;
	b=NzjIFMtIRUbUElN+9pyT5NgtCJV5NEpHDsDKheFaoCs+m3XuUiz420/2rgAX/bOFEQ
	EFD/4fvx9vyJPia1qKhW/6vAkdKx6RvZNjmOFRE3i5WWDbWaajW+W+v+u7H3Ve/nPIaW
	aVxpGgFZ9OADL0qd+o77S7pe+Ph+xHviDB+60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LaZ8F/u28Qi7rLFHlQllelu1t531SqqmU2zwlyiFJoA=;
	b=SAT7AkvS21I9KYB7qZlKoZUFbVmjtFTEv2uLXptGe6rKGDB2cuXdnfcyo2raaDo5Ws
	w+X6GglllatTiHYMacn/hzimnCDG8qP4MJficCREJGsUqnpgG5Qvs/Zqal5JQ6qHn5aA
	dDJgk+iVq2nqoZqhKvdWSOgr2geHCa+OR/u9yfGyZqzRNw7bIkAKNnmnKOJ8AuNrD4hk
	ZXeFmFbOC3mGWa4c1AQWM5BEvLTVKYa9KUCxN/u37rSI4tnzJzLBGHGMvXVh3sufZAl5
	tpt0bTAufd/nZ4v8GxLpDmfvERagewPpen88ar1FfEdTYdmIdWCUCZ2TlRssGr+gGuXJ
	PylA==
X-Gm-Message-State: ANhLgQ1V/eyyQTQinTJKpMWtKls75i6XVJZ1meMeZfrUAtsYl5s//EdW
	ymde19E9EmWPQL8pnQbL96JTZXlnPJ74ehxT
X-Google-Smtp-Source: ADFU+vuAWqr4ZByMJSd/gFbOB6e94FEDpOHFhqYXXFM7RYXuiRE6Aqz+/o2vGKTNY5GKCid+RmReIw==
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr22236880wrp.247.1583761386117;
	Mon, 09 Mar 2020 06:43:06 -0700 (PDT)
Received: from ub1910.Hitronhub.home ([213.48.11.149])
	by smtp.gmail.com with ESMTPSA id
	h3sm15282154wmi.41.2020.03.09.06.43.04
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 06:43:05 -0700 (PDT)
From: Paul Barker <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 13:42:46 +0000
Message-Id: <20200309134246.14067-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH v2] fetch2/gitsm: Unpack shallow mirror tarballs
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
X-List-Received-Date: Mon, 09 Mar 2020 13:43:06 -0000
Content-Transfer-Encoding: 8bit

When a shallow mirror tarball is used to satisfy a gitsm URI it needs to
be unpacked temporarily so that the .gitmodules file can be examined.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/fetch2/gitsm.py | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index aa121cbe..e7083001 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -20,6 +20,8 @@ NOTE: Switching a SRC_URI from "git://" to "gitsm://" requires a clean of your r
 import os
 import bb
 import copy
+import shutil
+import tempfile
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
@@ -130,7 +132,7 @@ class GitSM(Git):
             ld.setVar('SRCPV', d.getVar('SRCPV'))
             ld.setVar('SRCREV_FORMAT', module)
 
-            function(ud, url, module, paths[module], ld)
+            function(ud, url, module, paths[module], workdir, ld)
 
         return submodules != []
 
@@ -152,7 +154,7 @@ class GitSM(Git):
         return False
 
     def download(self, ud, d):
-        def download_submodule(ud, url, module, modpath, d):
+        def download_submodule(ud, url, module, modpath, workdir, d):
             url += ";bareclone=1;nobranch=1"
 
             # Is the following still needed?
@@ -163,16 +165,25 @@ class GitSM(Git):
                 newfetch.download()
                 # Drop a nugget to add each of the srcrevs we've fetched (used by need_update)
                 runfetchcmd("%s config --add bitbake.srcrev %s" % \
-                            (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=ud.clonedir)
+                            (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=workdir)
             except Exception as e:
                 logger.error('gitsm: submodule download failed: %s %s' % (type(e).__name__, str(e)))
                 raise
 
         Git.download(self, ud, d)
-        self.process_submodules(ud, ud.clonedir, download_submodule, d)
+
+        # If we're using a shallow mirror tarball it needs to be unpacked
+        # temporarily so that we can examine the .gitmodules file
+        if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
+            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
+            runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=tmpdir)
+            self.process_submodules(ud, tmpdir, download_submodule, d)
+            shutil.rmtree(tmpdir)
+        else:
+            self.process_submodules(ud, ud.clonedir, download_submodule, d)
 
     def unpack(self, ud, destdir, d):
-        def unpack_submodules(ud, url, module, modpath, d):
+        def unpack_submodules(ud, url, module, modpath, workdir, d):
             url += ";bareclone=1;nobranch=1"
 
             # Figure out where we clone over the bare submodules...
-- 
2.20.1



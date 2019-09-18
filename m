Return-Path: <ross.burton@intel.com>
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
	[209.85.128.41])
	by mail.openembedded.org (Postfix) with ESMTP id 5F4127F1BA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2019 16:59:37 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id y21so889814wmi.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2019 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ndkBtG7xnGdsD3obfFv2wnEvINJRiDohyY8dGdcCOjw=;
	b=SaCG91ebMu8FlD6d5uVU3BPy71d9TONOnBHJ2+KDUtLYrBJKxeiseLmRkxy9oEjF4M
	VonHf5+R/YUu6gLQ3FqfDlr+BA7L/xqb1aMwuL2t/regwsinhzsOqwQIMRBW2s9vwmUj
	2qkKwjcmsjv3PNaKqHsOCQEI1VxdNtelryxvfHLHNMegrmKTEcCh6cUZPfC9PK6HOoW9
	K7lQ4LK/Fu5L6qlHAO0r9XYcDGmZ0FKXjlLvwoO5Ek3i+VES7urtprcuqg9+La9HT8pB
	P17+5F8HiIg8S7LXJr5DhiMmxPAHvdcrFw/buH2ITWzjanzxmT4PK9XoC/20DnCeyvOh
	QXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ndkBtG7xnGdsD3obfFv2wnEvINJRiDohyY8dGdcCOjw=;
	b=uF7UH+bbDqsdTyAJIcxmxZaHFrzrnezx6Y5I1XUUC5d2A14mLqxSxR5ywPh/na53jK
	CQSmuNF6VR4pPAPzjtwh5VVQKio631xY0UxtHG4zJMgPe0cDfD2FSRyQPps2E6RlQsiA
	9FrJs2C0hpEwddvMFhhDW6zGnRmNbIj1VTIEakO/XbIGYXEdB2U88AEWDjIGIbASFjg2
	yp064rILLIRu+GV/QsrfozN/mvZ7sKzqrusefBcCYNexrFQfMzg+atqOQY2iH69NDrM+
	OyhJIGPPeHfTDaRacSor3sw/7EPLd7tU5/WQUKrVhqdVzuXxRqYTp41V+KTxZJIgPydU
	01og==
X-Gm-Message-State: APjAAAVYgK5W18SViu7bJgj+Z1YEKphV+gDw1xjennSpLHCtCsXRzgdN
	LzZh3ngHJFlEA04LNKd1d9xcfDK1OpQ=
X-Google-Smtp-Source: APXvYqwtN6kfpEyh5mscQqYWVqWlEzjoDiWVSWcPMMAM4LU4nOrR/HYIsUYhy0IROlYfA591pgFLDw==
X-Received: by 2002:a1c:cfc9:: with SMTP id f192mr3487704wmg.85.1568825977742; 
	Wed, 18 Sep 2019 09:59:37 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35])
	by smtp.gmail.com with ESMTPSA id h17sm5370393wme.6.2019.09.18.09.59.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 18 Sep 2019 09:59:36 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Sep 2019 17:59:32 +0100
Message-Id: <20190918165932.8358-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] fetch2/git: add git-lfs toggle option
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
X-List-Received-Date: Wed, 18 Sep 2019 16:59:37 -0000
Content-Transfer-Encoding: 8bit

Add a new 'lfs' option to the git fetcher so that we can optionally not fetch
git-lfs content, for repositories that contain LFS data that we don't
actually need for building.

By default lfs is set to 1, so if the repository has LFS content then git-lfs is
required.  Setting lfs to 0 will mean that git-lfs won't be required to fetch,
and some files will be missing.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/git.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index e171aa7eb16..5fd63b4e33b 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -464,6 +464,8 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
+        need_lfs = ud.parm.get("lfs", "1") == "1"
+
         source_found = False
         source_error = []
 
@@ -493,14 +495,16 @@ class Git(FetchMethod):
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d, workdir=destdir)
 
         if self._contains_lfs(ud, d, destdir):
-            path = d.getVar('PATH')
-            if path:
-                gitlfstool = bb.utils.which(path, "git-lfs", executable=True)
-                if not gitlfstool:
-                    raise bb.fetch2.FetchError("Repository %s has lfs content, install git-lfs plugin on host to download" % (repourl))
+            if need_lfs:
+                path = d.getVar('PATH')
+                if path:
+                    gitlfstool = bb.utils.which(path, "git-lfs", executable=True)
+                    if not gitlfstool:
+                        raise bb.fetch2.FetchError("Repository %s has LFS content, install git-lfs on host to download (or set lfs=0 to ignore it)" % (repourl))
+                else:
+                    bb.note("Could not find 'PATH'")
             else:
-                bb.note("Could not find 'PATH'")
-
+                bb.note("Repository %s has LFS content but it is not being fetched" % (repourl))
 
         if not ud.nocheckout:
             if subdir != "":
-- 
2.20.1



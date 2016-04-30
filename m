Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id 2EC1E60118
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 20:10:38 +0000 (UTC)
Received: by mail-pa0-f68.google.com with SMTP id zy2so18101931pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=HSJGDnDWjuzITO5vAH8RUlYtD9Ovq/QFy59XV39NJ3w=;
	b=yGzeCqlGecH/Jo/W7p08dMk2lrEButdJEqa5bl62d/PJth11IDhcvDEZToCxNKuEyG
	erDTrp84PAPtB65AQXpopyeTKu9k0eoxEcRNd8E9B0tSt582I45nBlTM+V1mk7Rbn1uw
	0PHrEaQ2tBwvAyBVRR9YK7IFsBN/enQrx+zrIDbBVGEjQODvqfubEPZRHCSBADPJrIWT
	KtNgYFhWTfp8UYytOpNFySpS6eu3rHQz4kAvlojpwLvSjnpGYjhcIymqV6PCY12Qfgoq
	8qZv3nJmWpcAkwnmm/509JCSJSe9y1IWLrxR4sK3GuebOvArpBXGpT7bXfreY7D1pIKr
	6s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=HSJGDnDWjuzITO5vAH8RUlYtD9Ovq/QFy59XV39NJ3w=;
	b=I5lU7Gkv6xO2Q9Q38RdnJmE4RCpNCtEGJ7N/xPVyKwG4ZLdUNfn0BUUfx1sVqsIZwP
	B4WoGxmjdJm1zeXCxYLaZUhL/uWlQC2lEK6z0xyktGGbM7fs+7aLQ3K2WjdPGivctABh
	y+qmyOnv7x6G+N6o1KZ8oCffX6yqIgbkDS9ILFunxUae/Mt5mEMg82zo/ZuKl992EY57
	Xo7XQ5aXUoPrqWbHMiJ2s5wt1SRHidn/hbABrSAlMxr+XDvdLr5HjeZxcXjwYS7RgKAe
	cv8IiCwjXNOvd1kTP+WXlAIMx4Aqj6o5ylO4trte+yfFwuMHMWJ8wf9Fp89TU2JdRGAP
	CoBQ==
X-Gm-Message-State: AOPr4FUMJoTz3Ej3x+GobnvrspDgnjnrx5TckKeZBvIt+7N3CvKPzeb5iMXeSyE07/hZ5w==
X-Received: by 10.66.50.105 with SMTP id b9mr38458499pao.122.1462047039736;
	Sat, 30 Apr 2016 13:10:39 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	h88sm33394725pfd.10.2016.04.30.13.10.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 13:10:37 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 13:10:34 -0700
Message-Id: <1462047034-21067-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH] bb.{cooker, data}: only emit a var as python if 'func' is set
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
X-List-Received-Date: Sat, 30 Apr 2016 20:10:39 -0000

From: Christopher Larson <chris_larson@mentor.com>

This avoids a common issue where PACKAGECONFIG is emitted as a function in
bitbake -e when the 'python' flag exists. It isn't a python function unless
both 'func' and 'python' are set. This aligns with the behavior of
emit_func_python.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/cooker.py | 2 +-
 lib/bb/data.py   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9b565fc..b2187d7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -656,7 +656,7 @@ class BBCooker:
         # emit the metadata which isnt valid shell
         data.expandKeys(envdata)
         for e in envdata.keys():
-            if data.getVarFlag( e, 'python', envdata ):
+            if envdata.getVarFlag(e, 'func', False) and envdata.getVarFlag(e, 'python', False):
                 logger.plain("\npython %s () {\n%s}\n", e, envdata.getVar(e, False))
 
 
diff --git a/lib/bb/data.py b/lib/bb/data.py
index dbc6dea..b5dcdbd 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -182,12 +182,12 @@ def inheritFromOS(d, savedenv, permitted):
 
 def emit_var(var, o=sys.__stdout__, d = init(), all=False):
     """Emit a variable to be sourced by a shell."""
-    if d.getVarFlag(var, "python", False):
+    func = d.getVarFlag(var, "func", False)
+    if d.getVarFlag(var, 'python', False) and func:
         return False
 
     export = d.getVarFlag(var, "export", False)
     unexport = d.getVarFlag(var, "unexport", False)
-    func = d.getVarFlag(var, "func", False)
     if not all and not export and not unexport and not func:
         return False
 
-- 
2.8.0



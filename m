Return-Path: <garbados@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
	[209.85.192.193])
	by mail.openembedded.org (Postfix) with ESMTP id E864D7823F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Jun 2017 04:55:18 +0000 (UTC)
Received: by mail-pf0-f193.google.com with SMTP id y7so20845525pfd.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Jun 2017 21:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=0NitF0UcMRuJ/O2vg+st+kHMJgLHH18ftebpdrHABqw=;
	b=UKVzmKd6S9zYKZdButvJ8pMmjTw4DWUE4UDykhYjnzfZxaGhx/GFj6STrALhvMJ7g+
	fum3JEVq5s+9rTiGOAi9cD5yzfAngRrlc8/ocWiQolmu63yPNH4w1tNKXRZ0ErOZhAW3
	sGz092BurN1rWBQPKOeu0HSItgC4oFtjJAGXeHpIB16yGivLV99BIs4CT7fzXFlFuVNU
	+5gLvnUWPuy/Mf8yKxJ6OrIZ7GTPqSJyXqFJELrPhYjSoAOXWey6Nm615zLaoztapWV1
	6EBTQjSUTIp353b68Yn7Obp1RYbTBEQ5RZ11FxqVVH2iSyToTbe7Qng1gH4sruZcGhiC
	dScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=0NitF0UcMRuJ/O2vg+st+kHMJgLHH18ftebpdrHABqw=;
	b=YZoPBfuQ95+sEC961f3ngbUI/GKGN1gnzqhw5FHPWjaj4jLmpQkzNuhyJ0Gx1doNFG
	piBvKvHonMj3P5Bm49QyOvSiCji1l2ix68LE97p47huLcFvdlNxjpzJ+N4Mn2LKWzCn8
	rnB75xvWogR2UKTV2hIfX9k2eFKAsk/yQw4xeCnIExwK+l3qd2VB+LCi3dPSHGYRmjfX
	0qs1rEJmtglxWpB/Ip/37DgZxFM/ujWq02WDjEYvvKE0BcJiMG9V98RJbiU7GaSB99t9
	FaDWmqKadNn33lZVsDjiYlHyBu3zH1VJKNLxIkIoHLZ4VYZjpkzsJvbKP3nWRTTNCLwq
	jydw==
X-Gm-Message-State: AKS2vOzA7O/eBiZIWG9+Io833EV2QJDFDk7hGkZlSMvQiLIeVvd8zvE7
	NgecSgwZTx6TKLJ6
X-Received: by 10.84.217.139 with SMTP id p11mr12490060pli.214.1497934519974; 
	Mon, 19 Jun 2017 21:55:19 -0700 (PDT)
Received: from deus.apple.sh.pie ([2601:1c2:303:6b0:14fa:265:e25b:a63b])
	by smtp.gmail.com with ESMTPSA id
	p4sm24401452pgf.21.2017.06.19.21.55.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 19 Jun 2017 21:55:19 -0700 (PDT)
From: Diana Thayer <garbados@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Jun 2017 21:54:30 -0700
Message-Id: <1497934470-12092-1-git-send-email-garbados@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] bitbake : Paginate 'bitbake -e' using less.
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
X-List-Received-Date: Tue, 20 Jun 2017 04:55:19 -0000

This patch modifies bitbake/lib/bb/cooker.py#showEnvironment
to call less using subprocess.Popen, rather than using the logger.
It is a WIP solution to bug 9203.

Signed-off-by: Diana Thayer <garbados@gmail.com>
---
 bitbake/lib/bb/cooker.py | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 479dc5a..eaec040 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -514,21 +514,32 @@ class BBCooker:
                 parselog.exception("Unable to read %s", fn)
                 raise
 
-        # Display history
-        with closing(StringIO()) as env:
-            self.data.inchistory.emit(env)
-            logger.plain(env.getvalue())
-
-        # emit variables and shell functions
-        with closing(StringIO()) as env:
-            data.emit_env(env, envdata, True)
-            logger.plain(env.getvalue())
-
-        # emit the metadata which isnt valid shell
-        data.expandKeys(envdata)
-        for e in sorted(envdata.keys()):
-            if envdata.getVarFlag(e, 'func', False) and envdata.getVarFlag(e, 'python', False):
-                logger.plain("\npython %s () {\n%s}\n", e, envdata.getVar(e, False))
+        # establish `less` as a pager for environment output
+        # TODO determine pager by env var
+        pager = subprocess.Popen(['less', '-F', '-R', '-S', '-X', '-K'],
+                                 stdin=subprocess.PIPE,
+                                 stdout=sys.stdout,
+                                 universal_newlines=True)
+        with pager:
+            lines = []
+            # Display history
+            with closing(StringIO()) as env:
+                self.data.inchistory.emit(env)
+                lines.append(env.getvalue())
+
+            # emit variables and shell functions
+            with closing(StringIO()) as env:
+                data.emit_env(env, envdata, True)
+                lines.append(env.getvalue())
+
+            # emit the metadata which isnt valid shell
+            data.expandKeys(envdata)
+            for e in sorted(envdata.keys()):
+                if envdata.getVarFlag(e, 'func', False) and envdata.getVarFlag(e, 'python', False):
+                    lines.append("\npython %s () {\n%s}\n" % (e, envdata.getVar(e, False)))
+
+            # communicate lines to pager
+            pager.communicate('\n'.join(lines))
 
 
     def buildTaskData(self, pkgs_to_build, task, abort, allowincomplete=False):
-- 
2.7.4



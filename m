Return-Path: <liu.ming50@gmail.com>
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
	[209.85.167.65])
	by mail.openembedded.org (Postfix) with ESMTP id 0D8177C2A8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 10:57:37 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id n18so6617047lfh.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 02:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=ZdnANeT4jmIk3sZWrqR/vQQ8bm/ghpsYQ9/JT+NUKiI=;
	b=Cmosr94BualRNSlvNVffWMzPw3zBlOXO7r4We+/QENthjFfUYs9+Lw/YHtsFEvsJMk
	udqmu7SbcRUa2ffva8jrjZM0wtb7Jvo769V/8JQv2rgnMMXKR9Uo22IQhPVyf3i/Q9pW
	pl7yMnlueyju5YZwg5V2hcIOl9ttrBWjKBOkMocV6CJyNd5Efsf4Xsg9v9jZflFt1MDV
	EZuIdF4H/RaBvURdIIsMe5mFFObaODj1ZK/au3lhxyLswjh4JjtgXp4ggdnZ6jB1Bl2a
	CqQBxWKJEWZfPW7vIBiMFq4SrjTXPffjFxIzzU8Q9J9cKYKoKndhppa7iCLJNSQMvOgR
	qB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ZdnANeT4jmIk3sZWrqR/vQQ8bm/ghpsYQ9/JT+NUKiI=;
	b=SKsuByikXj52RUBwTbVCxNl44QbzHYkQLzwD9JiE8cQH3K3mZInqmKB9e9XY1L7NPF
	pac5my57q7ivXz9JN/qpCRD0dRchfMiO+xRwd6hKTBy59N9yxIYoMOUjzHrypFirCRAv
	sMb8tYWwXS4/vDyR+dY0EEGNcLl88fXXn3iLogRqkLKsESDAGcxdTT/6L+pI17CtBNXS
	CDvlo5cophGp4n+3lptuT8bRSJCKGYd3URSZVrVYviX7B6sz0pC3dG3S+eqAy7tUzclt
	K5O6Hk4Kn37GL4J375Z69oQcfkmbDI7cr+YhEkxi/tk1PEtLWKw8mB9FLK0eNRdzwry6
	Y0tQ==
X-Gm-Message-State: AJcUukdAKarjETdT8pcUp00I4xp/B4u+WLp1mBEVJLFWMtmXsr9wBiMz
	8W2zR4/5v8X0H2YG4Ta35S1YD5RoeK0=
X-Google-Smtp-Source: ALg8bN4B7r41eiP4PgVQhUUSf2tIPQNwCDj3yLDCUidowacWG1CLlyBVLuWffZIQXwUAWe4ukGEzrg==
X-Received: by 2002:a19:a104:: with SMTP id k4mr7947232lfe.36.1548413858133;
	Fri, 25 Jan 2019 02:57:38 -0800 (PST)
Received: from peterliu-Precision-M4800.emea.group.atlascopco.com
	(m77-218-252-226.cust.tele2.se. [77.218.252.226])
	by smtp.gmail.com with ESMTPSA id
	q67sm1433837lfe.19.2019.01.25.02.57.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 25 Jan 2019 02:57:37 -0800 (PST)
From: liu.ming50@gmail.com
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Jan 2019 11:57:27 +0100
Message-Id: <1548413847-32550-1-git-send-email-liu.ming50@gmail.com>
X-Mailer: git-send-email 2.7.4
Cc: luka.pivk@toradex.com, stefan.agner@toradex.com,
	Ming Liu <liu.ming50@gmail.com>
Subject: [PATCH] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Fri, 25 Jan 2019 10:57:38 -0000

From: Ming Liu <liu.ming50@gmail.com>

A following issue was observed with gitsm:
| git -c core.fsyncobjectfiles=0 config submodule... failed with exit code 255, output:
| error: could not lock config file config: File exists

Since all git submodules share a config file and Git creates a lock
file (.git/config.lock) to synchronize access to it, but Git only tries
exactly once and returns a error if it's already locked. This leads to
a race condition if there are many 'git config submodule' run in
different processes.

It could be fixed by introducing a bitbake file lock to protect config
file from concurrent update from submodules.

Reported-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Ming Liu <liu.ming50@gmail.com>
---
 lib/bb/fetch2/gitsm.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index f45546b..bb49d5c 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -39,6 +39,13 @@ from   bb.fetch2 import Fetch
 from   bb.fetch2 import BBFetchException
 
 class GitSM(Git):
+    def urldata_init(self, ud, d):
+        super().urldata_init(ud, d)
+        # Protects the config file from concurrent updates by submodules
+        # e.g. 'git config submodule' run in different processes may lead
+        # to a race condition.
+        ud.gitsmlock = os.path.join(ud.clonedir, "gitsm-config.lock")
+
     def supports(self, ud, d):
         """
         Check to see if a given url can be fetched with git.
@@ -183,11 +190,15 @@ class GitSM(Git):
 
             local_path = newfetch.localpath(url)
 
-            # Correct the submodule references to the local download version...
-            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
+            lf = bb.utils.lockfile(ud.gitsmlock)
+            try:
+                # Correct the submodule references to the local download version...
+                runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
 
-            if ud.shallow:
-                runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
+                if ud.shallow:
+                    runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
+            finally:
+                bb.utils.unlockfile(lf)
 
             # Ensure the submodule repository is NOT set to bare, since we're checking it out...
             try:
-- 
2.7.4



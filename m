Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by mail.openembedded.org (Postfix) with ESMTP id DD0157F67E
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 23:43:28 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id z4so6318437pfn.12
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 24 Nov 2019 15:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=m449gysWQEnaU6BDZuS7TRYq+rqA1jTrORZGDAIFbSM=;
	b=FFJUqHmUVApStUErf1rdQ+YpU/sOxOkCKb99cezkOLCSzgmktDcBeX13bSI5bUABd0
	Ih+VfGCjX3sfWPXE7zjddY5Jco8Y9FHdEcIKDLXp67vY1aM1yu6PcS+YcNI22tXh3Q6M
	dxTPA+rCOG6Iri7FGSsLXyKUdwdNNIne0MCU0sjUe2VGrfoQUBad+YS7Q30QP/lj1KtW
	bINRukLNes/Q+4RHxDlaPVhNk8Bq3axug9QCSDLIx8x3B4i1milBa1xVnzZGLBzC2tGf
	S+peiLMbA9cxin49wmd41esn/JfhdcgVpHgorrb9trUH4K1MzymTN1Go1DJDJM0GwMfE
	0XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=m449gysWQEnaU6BDZuS7TRYq+rqA1jTrORZGDAIFbSM=;
	b=mrmYgIQj3hDAwUmIAa0XDlp2EmM6UEE53ajJwfEApXu5o++/XTJiIOJRXzh72tmygc
	poxGa/+VKLBZRsLL9xnQ3Ut/dACeMkxoGPZRE1QYCcx84t6Qr2N2q7ZuTEBd6qT8KWuq
	BQU+SHtMH5Oql32O4w3PL821ItyqyS6ShAf1JMrG9H4VqSYRANy1VQ3X9BwpLIVkmV0+
	TNkiaDC4IWVsqBkQjhaNl8AM0H5z1MyuAVDyr9XIDFya4QHYIGkNxcLlDdD0wcEHpfCA
	okxtKIcbehB0IAe7EPcrYl+VTOWWndSF4rho92HILsks0xqoEBIjvYy8MIlKS9aYS3hk
	Ap/A==
X-Gm-Message-State: APjAAAVLVMGRlWJUfZnnw0EODnbVzXF05aBVisCud9WnqpxDlDicm5zy
	qtFR6wXuwNt3vtxtQuHVrXJm53wh
X-Google-Smtp-Source: APXvYqw8Vl2LoyC/eQ+UINHrVjIYYeq1dmkeYVnLTdMHhmxn9aAtapLj3JPf1e9MMmtf7/DzoVCy6w==
X-Received: by 2002:a63:4c14:: with SMTP id z20mr20432082pga.10.1574639009772; 
	Sun, 24 Nov 2019 15:43:29 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:69ac:e4d2:e89f:98da])
	by smtp.gmail.com with ESMTPSA id
	125sm5729367pfu.136.2019.11.24.15.43.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 24 Nov 2019 15:43:29 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 24 Nov 2019 15:43:16 -0800
Message-Id: <c61c8356cce4d7307f74147dcf2b2cf103db84a8.1574638886.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1574638886.git.akuster808@gmail.com>
References: <cover.1574638886.git.akuster808@gmail.com>
Subject: [PATCH 3/9] fetch2/hg: Fix various runtime issues
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
X-List-Received-Date: Sun, 24 Nov 2019 23:43:29 -0000

From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>

Fix mercurial fetching after breakage from changes to the core fetcher.
Fix username and password usage and setting moddir needed by setup_revisions.

Signed-off-by: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/fetch2/hg.py | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 15d729e..e21115d 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -54,13 +54,6 @@ class Hg(FetchMethod):
         else:
             ud.proto = "hg"
 
-        ud.setup_revisions(d)
-
-        if 'rev' in ud.parm:
-            ud.revision = ud.parm['rev']
-        elif not ud.revision:
-            ud.revision = self.latest_revision(ud, d)
-
         # Create paths to mercurial checkouts
         hgsrcname = '%s_%s_%s' % (ud.module.replace('/', '.'), \
                             ud.host, ud.path.replace('/', '.'))
@@ -74,6 +67,13 @@ class Hg(FetchMethod):
         ud.localfile = ud.moddir
         ud.basecmd = d.getVar("FETCHCMD_hg") or "/usr/bin/env hg"
 
+        ud.setup_revisions(d)
+
+        if 'rev' in ud.parm:
+            ud.revision = ud.parm['rev']
+        elif not ud.revision:
+            ud.revision = self.latest_revision(ud, d)
+
         ud.write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS")
 
     def need_update(self, ud, d):
@@ -139,7 +139,7 @@ class Hg(FetchMethod):
                 cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (ud.basecmd, ud.user, ud.pswd, proto)
             else:
                 cmd = "%s pull" % (ud.basecmd)
-        elif command == "update":
+        elif command == "update" or command == "up":
             if ud.user and ud.pswd:
                 cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" update -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, " ".join(options))
             else:
@@ -247,12 +247,19 @@ class Hg(FetchMethod):
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata != "nokeep":
+            proto = ud.parm.get('protocol', 'http')
             if not os.access(os.path.join(codir, '.hg'), os.R_OK):
                 logger.debug(2, "Unpack: creating new hg repository in '" + codir + "'")
                 runfetchcmd("%s init %s" % (ud.basecmd, codir), d)
             logger.debug(2, "Unpack: updating source in '" + codir + "'")
-            runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d, workdir=codir)
-            runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d, workdir=codir)
+            if ud.user and ud.pswd:
+                runfetchcmd("%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull %s" % (ud.basecmd, ud.user, ud.pswd, proto, ud.moddir), d, workdir=codir)
+            else:
+                runfetchcmd("%s pull %s" % (ud.basecmd, ud.moddir), d, workdir=codir)
+            if ud.user and ud.pswd:
+                runfetchcmd("%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" up -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, revflag), d, workdir=codir)
+            else:
+                runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d, workdir=codir)
         else:
             logger.debug(2, "Unpack: extracting source to '" + codir + "'")
             runfetchcmd("%s archive -t files %s %s" % (ud.basecmd, revflag, codir), d, workdir=ud.moddir)
-- 
2.7.4



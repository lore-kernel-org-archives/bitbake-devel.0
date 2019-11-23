Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by mail.openembedded.org (Postfix) with ESMTP id CDADF7E53A
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 16:25:02 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id bb5so4558057plb.4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Nov 2019 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=m449gysWQEnaU6BDZuS7TRYq+rqA1jTrORZGDAIFbSM=;
	b=jlKn9kqMsFL1QuiQQApdJXa5LGbGa3sHa3tp1KKznFWprf6WStQNniHOAiTe59Q36v
	V8lqDIGvkZLBmQAFZWJkBdBltP4nGu84f13UkGwpFWQkcLYgzRoz/xCHZmvqtsF+JNj+
	TovbfO+cHMIhPoY0S63Qs1iaWxu15ZhfRmHsujbivWqk/HTHtPPtZNJ3vfMfA6+GwKf2
	/949PqsAWCrBteR2/8PS8mcBXNFtI5snOzBI2qdRp5XkB8/Tm5iKgriDqIp3XQlarvrL
	fgrCPGUJCKRHP+3/5xMDLYqAchS1D44VAw07oCkmH3IC6D0WRN1UVtRe7bzUTAPdSK/S
	zUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=m449gysWQEnaU6BDZuS7TRYq+rqA1jTrORZGDAIFbSM=;
	b=V+dJgTU0Q3bruGMC9cuWtRdd67E5pc17Ex2rQ8fLeHutGnGywHSQ8PftFvyqOaHc9P
	3vs8jxqGgQXnhsGexz80L+wFOUgm2RCYZTRpWqc7vQuOcabvK8zBx2r0irS0Icfimopu
	SLCexB8Sw7WB0UHqefjxT+Beu10pTFYvjY8mWLo+wmrUj/RAkoY5qyUcgviei4zVXlhg
	uMNXE+16rCRK4HMqz1xBLW+TJ6+0yZ8KVIhnelGnVh2+Eyvgp2DW2bHZtz2HQcXTPqvY
	uXYBEb3LJSAvXBaziXZdCGWsJZQ6QM31LtPIuIrFPKXGv2Y47UzRWHSv2tZ2NfvF3gMD
	wlZQ==
X-Gm-Message-State: APjAAAVAPyZjXfp1dXH57fR/cIy7MRY883lleMsD+yX0Y9vpo0axW+hO
	TNSS/GsZdfY4MW0y8C41IDrVAtKi
X-Google-Smtp-Source: APXvYqw8hJG7bMawZWCCzwe6544GYM9oeT7uqQ84sUiBMZX71hZBRnqSg1OcW8mK+2D+Zj2isRNkZg==
X-Received: by 2002:a17:902:9682:: with SMTP id
	n2mr19565044plp.336.1574526303722; 
	Sat, 23 Nov 2019 08:25:03 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:d5a1:4623:137e:d439])
	by smtp.gmail.com with ESMTPSA id h9sm2735572pjh.8.2019.11.23.08.25.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 23 Nov 2019 08:25:03 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Nov 2019 08:24:53 -0800
Message-Id: <1574526299-21018-3-git-send-email-akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
References: <1574526299-21018-1-git-send-email-akuster808@gmail.com>
Cc: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Subject: [1.44][PATCH 3/9] fetch2/hg: Fix various runtime issues
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
X-List-Received-Date: Sat, 23 Nov 2019 16:25:03 -0000

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



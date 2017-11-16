Return-Path: <v.vogelhuber@digitalendoscopy.de>
X-Greylist: delayed 382 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 16 Nov 2017 14:24:03 UTC
Received: from mx-relay16-dus.antispameurope.com
	(mx-relay16-dus.antispameurope.com [94.100.134.216])
	by mail.openembedded.org (Postfix) with ESMTP id 853047839A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Nov 2017 14:24:03 +0000 (UTC)
Received: from host-80-81-19-29.customer.m-online.net ([80.81.19.29]) by
	mx-gate16-dus.antispameurope.com; Thu, 16 Nov 2017 15:17:41 +0100
Received: from DE028.digitendos.de (192.168.20.186) by srv-msx01.digitendos.de
	(192.168.20.14) with Microsoft SMTP Server (TLS) id 15.0.516.32;
	Thu, 16 Nov 2017 15:16:03 +0100
From: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 16 Nov 2017 15:15:41 +0100
Message-ID: <20171116141541.5533-1-v.vogelhuber@digitalendoscopy.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-Originating-IP: [192.168.20.186]
X-ClientProxiedBy: srv-msx01.digitendos.de (192.168.20.14) To
	srv-msx01.digitendos.de (192.168.20.14)
X-TM-AS-Product-Ver: SMEX-11.1.0.1291-8.100.1062-23468.006
X-TM-AS-Result: No--14.523800-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-cloud-security-sender: v.vogelhuber@digitalendoscopy.de
X-cloud-security-recipient: bitbake-devel@lists.openembedded.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
	mx-gate16-dus with 273B9211800B
X-cloud-security-connect: host-80-81-19-29.customer.m-online.net[80.81.19.29],
	TLS=1, IP=80.81.19.29
X-cloud-security: scantime:.2403
Cc: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
Subject: [PATCH] Fix mercurial fetching (hosttools need hd for latest revision autoinc, fix username and password usage and setting moddir needed by setup_revisions)
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
X-List-Received-Date: Thu, 16 Nov 2017 14:24:04 -0000
Content-Type: text/plain

Signed-off-by: Volker Vogelhuber <v.vogelhuber@digitalendoscopy.de>
---
 bitbake/lib/bb/fetch2/hg.py | 27 +++++++++++++++++----------
 meta/conf/bitbake.conf      |  2 ++
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index d0857e63f7..04620f3722 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -66,13 +66,6 @@ class Hg(FetchMethod):
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
@@ -86,6 +79,13 @@ class Hg(FetchMethod):
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
@@ -151,7 +151,7 @@ class Hg(FetchMethod):
                 cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull" % (ud.basecmd, ud.user, ud.pswd, proto)
             else:
                 cmd = "%s pull" % (ud.basecmd)
-        elif command == "update":
+        elif command == "update" or command == "up":
             if ud.user and ud.pswd:
                 cmd = "%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" update -C %s" % (ud.basecmd, ud.user, ud.pswd, proto, " ".join(options))
             else:
@@ -259,12 +259,19 @@ class Hg(FetchMethod):
 
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
diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index 9696273acc..9ec527228b 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -494,6 +494,8 @@ HOSTTOOLS_NONFATAL += "join nl size yes zcat"
 
 # Used by bzr fetcher
 HOSTTOOLS_NONFATAL += "bzr"
+# Used by hg fetcher
+HOSTTOOLS_NONFATAL += "hg"
 
 CCACHE ??= ""
 # ccache < 3.1.10 will create CCACHE_DIR on startup even if disabled, and
-- 
2.11.0



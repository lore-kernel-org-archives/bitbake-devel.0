Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 92EBF7D00C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Mar 2019 09:36:55 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2M9aZi1026154
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Mar 2019 02:36:46 -0700
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.439.0;
	Fri, 22 Mar 2019 02:36:25 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Mar 2019 02:36:24 -0700
Message-ID: <06d0a4464990767bc7a3d4942e6664b8dac37a9e.1553247190.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553247190.git.liezhi.yang@windriver.com>
References: <cover.1553247190.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1 V2] fetch2: Add get_mirrorname()
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
X-List-Received-Date: Fri, 22 Mar 2019 09:36:55 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Then it can be used by both __init__.py and git.py, and use mirrorname as
'MIRRORNAME' if it is defined in origud.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 8 +++++++-
 bitbake/lib/bb/fetch2/git.py      | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 5c2a1c76c4..eee9b8e35e 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -889,6 +889,9 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
 
     return output
 
+def get_mirrorname(ud):
+    return ud.host.replace(':','.') + ud.path.replace('/', '.').replace('*', '.')
+
 def check_network_access(d, info, url):
     """
     log remote network access, and error if BB_NO_NETWORK is set or the given
@@ -910,7 +913,10 @@ def build_mirroruris(origud, mirrors, ld):
     replacements["HOST"] = origud.host
     replacements["PATH"] = origud.path
     replacements["BASENAME"] = origud.path.split("/")[-1]
-    replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
+    if hasattr(origud, "mirrorname"):
+        replacements["MIRRORNAME"] = origud.mirrorname
+    else:
+        replacements["MIRRORNAME"] = get_mirrorname(origud)
 
     def adduri(ud, uris, uds, mirrors, tarballs):
         for line in mirrors:
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 1a8ebe3da8..48c12bb9c8 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -248,10 +248,12 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
+        gitsrcname = bb.fetch2.get_mirrorname(ud)
         if gitsrcname.startswith('.'):
             gitsrcname = gitsrcname[1:]
 
+        ud.mirrorname = gitsrcname
+
         # for rebaseable git repo, it is necessary to keep mirror tar ball
         # per revision, so that even the revision disappears from the
         # upstream repo in the future, the mirror will remain intact and still
-- 
2.21.0



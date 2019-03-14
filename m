Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id EE7A17C6F7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 09:09:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x2E99CS1002040
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 02:09:12 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 14 Mar 2019 02:09:11 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Mar 2019 17:28:18 +0800
Message-ID: <b3ade2ccda56d3abbe44c5ede950093995f8b536.1552555629.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1552555629.git.liezhi.yang@windriver.com>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/5] fetch2: Add get_mirrorname()
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
X-List-Received-Date: Thu, 14 Mar 2019 09:09:12 -0000
Content-Type: text/plain

It can be used by both __init__.py and git.py.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 5 ++++-
 bitbake/lib/bb/fetch2/git.py      | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index f112067..5062bb2 100644
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
@@ -910,7 +913,7 @@ def build_mirroruris(origud, mirrors, ld):
     replacements["HOST"] = origud.host
     replacements["PATH"] = origud.path
     replacements["BASENAME"] = origud.path.split("/")[-1]
-    replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
+    replacements["MIRRORNAME"] = get_mirrorname(origud)
 
     def adduri(ud, uris, uds, mirrors, tarballs):
         for line in mirrors:
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index cf8bee7..45d7303 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -248,7 +248,7 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
+        gitsrcname = bb.fetch2.get_mirrorname(ud)
         if gitsrcname.startswith('.'):
             gitsrcname = gitsrcname[1:]
 
-- 
2.7.4



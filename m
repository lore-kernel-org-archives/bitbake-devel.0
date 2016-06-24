Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id A144E60111
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2016 07:55:51 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u5O7tp90001266
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2016 00:55:51 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Fri, 24 Jun 2016 00:55:50 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 24 Jun 2016 00:55:49 -0700
Message-ID: <ba8db9342c0793e7ee796140da0c9c638ae7e6ff.1466754896.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <cover.1466754896.git.liezhi.yang@windriver.com>
References: <cover.1466754896.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] fetch2: remove "." in the end
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
X-List-Received-Date: Fri, 24 Jun 2016 07:55:51 -0000
Content-Type: text/plain

From: Jason Wessel <jason.wessel@windriver.com>

The filename can't be "foo." for MS Windows filesystem, it will renamed
to "foo" automatically, so we can't upload sources like "foo." to the
Windows server, remove "." in the end will fix the problem.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 ++
 bitbake/lib/bb/fetch2/git.py      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index b6fcaaa..1633c81 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -865,6 +865,8 @@ def build_mirroruris(origud, mirrors, ld):
     replacements["PATH"] = origud.path
     replacements["BASENAME"] = origud.path.split("/")[-1]
     replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
+    if replacements["MIRRORNAME"].endswith('.'):
+        replacements["MIRRORNAME"] = replacements["MIRRORNAME"][:-1]
 
     def adduri(ud, uris, uds, mirrors):
         for line in mirrors:
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 59827e3..e669efc 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -142,6 +142,8 @@ class Git(FetchMethod):
         gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.'))
         if gitsrcname.startswith('.'):
             gitsrcname = gitsrcname[1:]
+        if gitsrcname.endswith('.'):
+            gitsrcname = gitsrcname[:-1]
 
         # for rebaseable git repo, it is necessary to keep mirror tar ball
         # per revision, so that even the revision disappears from the
-- 
2.8.2



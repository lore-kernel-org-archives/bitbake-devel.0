Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id ECA1E6D7C4
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Nov 2013 08:29:30 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id rA88TXOB020711
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Nov 2013 00:29:33 -0800 (PST)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Fri, 8 Nov 2013 00:29:32 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 9 Nov 2013 00:31:51 +0800
Message-ID: <589acd189b9af4ebb3e13845de0cba3035db37e0.1383927399.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1383927399.git.liezhi.yang@windriver.com>
References: <cover.1383927399.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1 RFC] fetch2/git.py: fix the filename too long error
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
X-List-Received-Date: Fri, 08 Nov 2013 08:29:31 -0000
Content-Type: text/plain

When we use the PREMIRROR/MIRROR from the local disk, and if it is in a
deep directory, for example, when len(path) > 255 (The NAME_MAX), we
will get the "filename too long error".

This is becuase we use ud.path.replace('/', '.') to change the path to
the filename. We seldom see such a long url, but it is easy to produce
it on the local machine.

Another problem is that:

file:///local/path

will be converted into .local.path whichi is a hidden file by default.

Don't convert the name when ud.proto == "file" will fix the problem.

PS:
- This is only for git, other fetchers also have the similar problem,
  will send the patch for others if this is fine.

- Another solution might be: use the md5sum(path) as part of the
  filename, I'm not sure whether it is worth.

[YOCTO #5389]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 6175e4c..53fd2f5 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -127,7 +127,10 @@ class Git(FetchMethod):
                     ud.branches[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud.url, ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':','.'), ud.path.replace('/', '.').replace('*', '.'))
+        if ud.proto == "file":
+            gitsrcname = '%s%s' % ("file...", os.path.basename(ud.path))
+        else:
+            gitsrcname = '%s%s' % (ud.host.replace(':','.'), ud.path.replace('/', '.').replace('*', '.'))
         # for rebaseable git repo, it is necessary to keep mirror tar ball
         # per revision, so that even the revision disappears from the
         # upstream repo in the future, the mirror will remain intact and still
-- 
1.8.3.1



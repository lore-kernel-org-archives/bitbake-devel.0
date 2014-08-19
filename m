Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 22F73617B8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Aug 2014 09:07:42 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id s7J97goK016173
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Aug 2014 02:07:43 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.174.1;
	Tue, 19 Aug 2014 02:07:42 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Aug 2014 02:07:41 -0700
Message-ID: <d2f547297c3e0004e4fc64457cd36f7899db60d5.1408439224.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1408439224.git.liezhi.yang@windriver.com>
References: <cover.1408439224.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] fetch2/__init__.py: remove broken sysmlink
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
X-List-Received-Date: Tue, 19 Aug 2014 09:07:43 -0000
Content-Type: text/plain

Fixed:
(Simulate mirror the tarball from PREMIRRORS)
$ ln -sf /path/to/local/PREMIRROR/bzip2 bzip2-1.0.6.tar.gz
(Simulate the PREMIRRORS are gone)
$ rm -f /path/to/local/PREMIRROR/bzip2-1.0.6.tar.gz
$ bitbake bzip2 -ccleansstate && bitbake bzip2 -cfetch

Then the newly get bzip2-1.0.6.tar.gz will be saved to
/path/to/local/PREMIRROR/bzip2-1.0.6.tar.gz rather than then the DL_DIR,
or get error if we don't have the write permission on to the mirror.
This is because wget uses "lstat()" to follow the symlink for FTP (but
fstat() for HTTP, so http doesn't have this issue), and we can't fix
wget (this might be intended by wget) since it is one of
SANITY_REQUIRED_UTILITIES.

Remove the broken sysmlink in DL_DIR will fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index df2f2b0..c95f177 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1081,6 +1081,11 @@ class FetchData(object):
         self.donestamp = basepath + '.done'
         self.lockfile = basepath + '.lock'
 
+        # Remove the broken sysmlink
+        if self.localpath and not os.path.exists(self.localpath) and \
+                os.path.islink(self.localpath):
+            os.unlink(self.localpath)
+
     def setup_revisons(self, d):
         self.revisions = {}
         for name in self.names:
-- 
1.7.9.5



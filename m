Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RJK65-0007le-AJ
	for bitbake-devel@lists.openembedded.org;
	Thu, 27 Oct 2011 09:09:57 +0200
Received: by opal (Postfix, from userid 111)
	id 1B8DB1032C; Thu, 27 Oct 2011 07:09:22 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111027070922.1B8DB1032C@opal>
Date: Thu, 27 Oct 2011 07:09:22 +0000 (UTC)
From: git@git.openembedded.org
X-Mailman-Approved-At: Tue, 01 Nov 2011 08:48:59 +0100
Subject: Joshua Lock : fetch2: enable checksum definition as SRC_URI parameter
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 27 Oct 2011 07:09:58 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 5f8f923b76722c9b6c7ffbe19e94df50f900155f
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=5f8f923b76722c9b6c7ffbe19e94df50f900155f

Author: Joshua Lock <josh@linux.intel.com>
Date:   Tue Oct 11 09:42:13 2011 -0700

fetch2: enable checksum definition as SRC_URI parameter

URI parameters should be able to be defined as a parameter of the SRC_URI,
this patch enables thus for checksums.

An example;

SRC_URI = "http://pkgconfig.freedesktop.org/releases/pkg-config-${PV}.tar.gz;md5sum=a3270bab3f4b69b7dc6dbdacbcae9745;sha256sum=3ba691ee2431f32ccb8efa131e59bf23e37f122dc66791309023ca6dcefcd10e"

Addresses the remainder of [YOCTO #1399]

Signed-off-by: Joshua Lock <josh@linux.intel.com>

---

 lib/bb/fetch2/__init__.py |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 71be6f4..a055faa 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -562,8 +562,14 @@ class FetchData(object):
         else:
             self.md5_name = "md5sum"
             self.sha256_name = "sha256sum"
-        self.md5_expected = bb.data.getVarFlag("SRC_URI", self.md5_name, d)
-        self.sha256_expected = bb.data.getVarFlag("SRC_URI", self.sha256_name, d)
+        if self.md5_name in self.parm:
+            self.md5_expected = self.parm[self.md5_name]
+        else:
+            self.md5_expected = bb.data.getVarFlag("SRC_URI", self.md5_name, d)
+        if self.sha256_name in self.parm:
+            self.sha256_expected = self.parm[self.sha256_name]
+        else:
+            self.sha256_expected = bb.data.getVarFlag("SRC_URI", self.sha256_name, d)
 
         self.names = self.parm.get("name",'default').split(',')
 




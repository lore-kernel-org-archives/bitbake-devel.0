Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RDftA-0004Ls-RW
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Oct 2011 19:13:13 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 11 Oct 2011 10:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,523,1312182000"; d="scan'208";a="61148720"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.64])
	by azsmga001.ch.intel.com with ESMTP; 11 Oct 2011 10:07:26 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Oct 2011 10:07:18 -0700
Message-Id: <74d583f1aeecf8d112a2b24d4c4a234fbadf8470.1318352470.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.4
In-Reply-To: <cover.1318352470.git.josh@linux.intel.com>
References: <cover.1318352470.git.josh@linux.intel.com>
In-Reply-To: <cover.1318352470.git.josh@linux.intel.com>
References: <cover.1318352470.git.josh@linux.intel.com>
Subject: [PATCH 2/2] fetch2: enable checksum definition as SRC_URI parameter
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
X-List-Received-Date: Tue, 11 Oct 2011 17:13:13 -0000

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
index b2b9d5c..6c3886b 100644
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
 
-- 
1.7.6.4




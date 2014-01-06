Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5BA8C6BCD7
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2014 02:51:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s062pBd7015103
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 5 Jan 2014 18:51:11 -0800 (PST)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Sun, 5 Jan 2014 18:51:11 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 6 Jan 2014 18:53:56 +0800
Message-ID: <4d61da4f684bc292dd35b407c2dfa9ce5e6633c4.1389005562.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1389005562.git.liezhi.yang@windriver.com>
References: <cover.1389005562.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [RFC PATCH 1/1] bitbake/cooker.py: set the PREFERRED_VERSION from command line
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
X-List-Received-Date: Mon, 06 Jan 2014 02:51:10 -0000
Content-Type: text/plain

We can't set the PREFERRED_VERSION from the command line, this will make
it possible:

$ P_V="3.81" bitbake make
$ P_V="3.81" bitbake make-native

Then the make-3.81 and make-native-3.81 will be built (the default is
3.82)

Another we that we have originally thought was:

$ export BB_PRESERVE_ENV=1
$ PREFERRED_VERSION_make = 3.81 bitbake make

This worked for make, but didn't work for make-native since
we can't use "-" in a shell environment variable.

TODO:
* This is just a RFC and open for discussion, any comments is
  appreciated.

* It only can set the PREFERRED_VERSION for the pkg_to_build, we can
  make it more flexible, for example, if we found the keyword
  PREFERRED_VERSION in the P_V, we can set it for any recipe:
  (assume core-image-sato RDEPENDS on make)
  $ P_V="PREFERRED_VERSION_make=3.81" bitbake core-image-sato

* BTW, another questions, can we change the PREFERRED_VERSION to P_V
  or PF_V, and the PREFERRED_PROVIDER to P_P ot PF_P, please ? They are
  a little long to type and easy to make typos currently.

[YOCTO #4965]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py     | 5 +++++
 bitbake/lib/bb/cookerdata.py | 1 +
 scripts/oe-buildenv-internal | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index db4cb51..a6c30b8 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -180,6 +180,11 @@ class BBCooker:
         self.data = self.databuilder.data
         self.data_hash = self.databuilder.data_hash
 
+        P_V = self.data.getVar('P_V')
+        if P_V and len(self.configuration.pkgs_to_build) == 1:
+            pkg = ''.join(self.configuration.pkgs_to_build)
+            logger.info("Setting PREFERRED_VERSION_%s to %s" % (pkg, P_V))
+            self.data.setVar("PREFERRED_VERSION_%s" % pkg, P_V)
         #
         # Special updated configuration we use for firing events
         #
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 6200b0e..faf71da 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -128,6 +128,7 @@ class CookerConfiguration(object):
         self.dry_run = False
         self.tracking = False
         self.interface = []
+        self.pkgs_to_build = []
 
         self.env = {}
 
diff --git a/scripts/oe-buildenv-internal b/scripts/oe-buildenv-internal
index bba6f8f..5c17a9a 100755
--- a/scripts/oe-buildenv-internal
+++ b/scripts/oe-buildenv-internal
@@ -106,4 +106,4 @@ export BB_ENV_EXTRAWHITE="MACHINE DISTRO TCMODE TCLIBC HTTP_PROXY http_proxy \
 HTTPS_PROXY https_proxy FTP_PROXY ftp_proxy FTPS_PROXY ftps_proxy ALL_PROXY \
 all_proxy NO_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY \
 SDKMACHINE BB_NUMBER_THREADS BB_NO_NETWORK PARALLEL_MAKE GIT_PROXY_COMMAND \
-SOCKS5_PASSWD SOCKS5_USER SCREENDIR STAMPS_DIR"
+SOCKS5_PASSWD SOCKS5_USER SCREENDIR STAMPS_DIR P_V"
-- 
1.8.3.1



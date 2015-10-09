Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id B61F073CBD
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Oct 2015 09:39:13 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 09 Oct 2015 02:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,657,1437462000"; d="scan'208";a="807135280"
Received: from sarallen-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.21])
	by fmsmga001.fm.intel.com with ESMTP; 09 Oct 2015 02:38:59 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Oct 2015 10:38:43 +0100
Message-Id: <1444383523-23550-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: update meta-yocto to jethro and drop dizzy
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
X-List-Received-Date: Fri, 09 Oct 2015 09:39:13 -0000

From: brian avery <avery.brian@gmail.com>

Toaster only supports building 2 branches back. This
updates the conf file for meta-yocto to support
master, jethro, and fido.

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 meta-yocto/conf/toasterconf.json | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/meta-yocto/conf/toasterconf.json b/meta-yocto/conf/toasterconf.json
index 9e45ff0..3df1703 100644
--- a/meta-yocto/conf/toasterconf.json
+++ b/meta-yocto/conf/toasterconf.json
@@ -39,13 +39,13 @@
             "name": "OpenEmbedded",
             "sourcetype": "layerindex",
             "apiurl": "http://layers.openembedded.org/layerindex/api/",
-            "branches": ["master", "fido", "dizzy"]
+            "branches": ["master", "jethro" ,"fido"]
         },
         {
             "name": "Imported layers",
             "sourcetype": "imported",
             "apiurl": "",
-            "branches": ["master", "fido", "dizzy", "HEAD"]
+            "branches": ["master", "jethro","fido", "HEAD"]
 
         }
     ],
@@ -57,15 +57,15 @@
             "dirpath": "bitbake"
         },
         {
-            "name": "fido",
+            "name": "jethro",
             "giturl": "remote:origin",
-            "branch": "fido",
+            "branch": "jethro",
             "dirpath": "bitbake"
         },
         {
-            "name": "dizzy",
+            "name": "fido",
             "giturl": "remote:origin",
-            "branch": "dizzy",
+            "branch": "fido",
             "dirpath": "bitbake"
         },
         {
@@ -89,6 +89,15 @@
             "helptext": "Toaster will run your builds using the tip of the <a href=\"http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/\">Yocto Project master branch</a>, where active development takes place. This is not a stable branch, so your builds might not work as expected."
         },
         {
+            "name": "jethro",
+            "description": "Yocto Project 2.0 Jethro",
+            "bitbake": "jethro",
+            "branch": "jethro",
+            "defaultlayers": [ "openembedded-core", "meta-yocto", "meta-yocto-bsp"],
+            "layersourcepriority": { "Imported layers": 99, "Local Yocto Project" : 10, "OpenEmbedded" :  0 },
+            "helptext": "Toaster will run your builds with the tip of the <a href=\"http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=jethro\">Yocto Project 2.0 \"Jethro\"</a> branch."
+        },
+        {
             "name": "fido",
             "description": "Yocto Project 1.8 Fido",
             "bitbake": "fido",
@@ -98,15 +107,6 @@
             "helptext": "Toaster will run your builds with the tip of the <a href=\"http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=fido\">Yocto Project 1.8 \"Fido\"</a> branch."
         },
         {
-            "name": "dizzy",
-            "description": "Yocto Project 1.7 Dizzy",
-            "bitbake": "dizzy",
-            "branch": "dizzy",
-            "defaultlayers": [ "openembedded-core", "meta-yocto", "meta-yocto-bsp"],
-            "layersourcepriority": { "Imported layers": 99, "Local Yocto Project" : 10, "OpenEmbedded" :  0 },
-            "helptext": "Toaster will run your builds with the tip of the <a href=\"http://git.yoctoproject.org/cgit/cgit.cgi/poky/log/?h=dizzy\">Yocto Project 1.7 \"Dizzy\"</a> branch."
-        },
-        {
             "name": "local",
             "description": "Local Yocto Project",
             "bitbake": "HEAD",
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.



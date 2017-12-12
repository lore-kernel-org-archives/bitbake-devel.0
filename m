Return-Path: <henning.schild@siemens.com>
X-Greylist: delayed 1342 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 12 Dec 2017 15:12:05 UTC
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
	by mail.openembedded.org (Postfix) with ESMTP id 3CC0A7824F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Dec 2017 15:12:05 +0000 (UTC)
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id vBCFC5b7028585
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK); 
	Tue, 12 Dec 2017 16:12:05 +0100
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net
	[139.25.68.40] (may be forged))
	by mail1.siemens.de (8.15.2/8.15.2) with ESMTP id vBCFC574032566;
	Tue, 12 Dec 2017 16:12:05 +0100
From: Henning Schild <henning.schild@siemens.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Dec 2017 16:12:03 +0100
Message-Id: <20171212151203.31408-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171212144443.30618-1-henning.schild@siemens.com>
References: <20171212144443.30618-1-henning.schild@siemens.com>
X-Mailman-Approved-At: Sun, 17 Dec 2017 14:25:43 +0000
Cc: Henning Schild <henning.schild@siemens.com>, isar-users@googlegroups.com
Subject: [PATCH v2] fetch/git: add support for disabling shared clones on unpack
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
X-List-Received-Date: Tue, 12 Dec 2017 15:12:06 -0000

By default the unpacker will create a "shared" clone when cloning from
the DL_DIR to the WORKDIR. This patch introduces an option to control
that behaviour. Probably something that hardly anyone would want to do.

Imagine some recipe steps are executed in a namespace that is different
from the one your downloader and unpacker ran in. (chroot) Because a
"shared" clone has an absolute reference to its "alternate" you now
have to make that "alternate" visible in that new namespace (chroot) at
the exact place.

With this patch you can unpack "noshared" and get a stand-alone copy.
This copy will also work if the "alternate" is not visible or existant.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 lib/bb/fetch2/git.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5ef8cd69..7b7f02b2 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -53,6 +53,13 @@ Supported SRC_URI options are:
    For local git:// urls to use the current branch HEAD as the revision for use with
    AUTOREV. Implies nobranch.
 
+- noshared
+   When unpacking do not clone with the parameter "--shared". This option will
+   allow the unpacked copy to work stand-alone i.e. if your recipe runs in a
+   chroot where the "alternate" can not be found. Setting this will increase
+   the unpack-time and the disk-usage.
+   The default is "0", set noshared=1 if needed.
+
 """
 
 #Copyright (C) 2005 Richard Purdie
@@ -159,6 +166,8 @@ class Git(FetchMethod):
 
         ud.nobranch = ud.parm.get("nobranch","0") == "1"
 
+        ud.noshared = ud.parm.get("noshared","0") == "1"
+
         # usehead implies nobranch
         ud.usehead = ud.parm.get("usehead","0") == "1"
         if ud.usehead:
@@ -176,7 +185,9 @@ class Git(FetchMethod):
         if len(branches) != len(ud.names):
             raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
 
-        ud.cloneflags = "-s -n"
+        ud.cloneflags = "-n"
+        if not ud.noshared:
+            ud.cloneflags += " -s"
         if ud.bareclone:
             ud.cloneflags += " --mirror"
 
-- 
2.13.6



Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id B3CEA6F7B1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Apr 2014 14:35:44 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 07 Apr 2014 07:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,810,1389772800"; d="scan'208";a="488623580"
Received: from scfernan-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.216])
	by orsmga001.jf.intel.com with ESMTP; 07 Apr 2014 07:01:26 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Apr 2014 15:01:17 +0100
Message-Id: <3a94ec7e6bf409b4fb6a200d047e452629e3de0a.1396879250.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1396879250.git.paul.eggleton@linux.intel.com>
References: <cover.1396879250.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1396879250.git.paul.eggleton@linux.intel.com>
References: <cover.1396879250.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] fetch2: avoid cache ignoring missing files
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
X-List-Received-Date: Mon, 07 Apr 2014 14:35:50 -0000

Previously, if a file listed in SRC_URI was missing at the time of
parsing, and then was added and bitbake run again, it would not be
picked up because the recipe was cached without it. If we allow the file
to be added to the list of files to checksum, then it will be checked
for and found on the second run.

Fixes [YOCTO #4790].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 8e5342f..150f864 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -938,7 +938,6 @@ def get_checksum_file_list(d):
                     bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN', True), os.path.basename(f)))
                 else:
                     bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN', True), os.path.basename(f)))
-                    continue
             filelist.append(f)
 
     return " ".join(filelist)
-- 
1.9.0



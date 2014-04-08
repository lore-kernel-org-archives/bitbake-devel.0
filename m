Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 7141665DC6
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 14:34:00 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 08 Apr 2014 06:59:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,818,1389772800"; d="scan'208";a="489275245"
Received: from paulonei-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.244])
	by orsmga001.jf.intel.com with ESMTP; 08 Apr 2014 07:03:22 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Apr 2014 15:03:09 +0100
Message-Id: <7e51acb042de9afc24a8d0001e67ce94d4cfb451.1396965331.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1396965331.git.paul.eggleton@linux.intel.com>
References: <cover.1396965331.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1396965331.git.paul.eggleton@linux.intel.com>
References: <cover.1396965331.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] fetch2: handle wildcards correctly when recording file checksums
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
X-List-Received-Date: Tue, 08 Apr 2014 14:34:00 -0000

The Local fetcher's localpath is returning the parent directory for a
wildcard match; we need to handle this and add the wildcard
specification so that we checksum the correct files.

Fixes [YOCTO #6127].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 150f864..a9ab75e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -932,6 +932,9 @@ def get_checksum_file_list(d):
         if ud and isinstance(ud.method, local.Local):
             ud.setup_localpath(d)
             f = ud.localpath
+            pth = ud.decodedurl
+            if '*' in pth:
+                f = os.path.join(os.path.abspath(f), pth)
             if f.startswith(dl_dir):
                 # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
                 if os.path.exists(f):
-- 
1.9.0



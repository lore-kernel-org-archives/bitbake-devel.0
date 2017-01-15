Return-Path: <brian.avery@intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 95E9C71CBF
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Jan 2017 03:16:45 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga105.jf.intel.com with ESMTP; 14 Jan 2017 19:16:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,231,1477983600"; d="scan'208";a="48945209"
Received: from bavery-ws-desk.jf.intel.com ([10.7.198.85])
	by orsmga004.jf.intel.com with ESMTP; 14 Jan 2017 19:16:46 -0800
From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 14 Jan 2017 19:18:32 -0800
Message-Id: <db99305fc21415713cc1d127e97f7e5f654ea578.1484450104.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1484450104.git.brian.avery@intel.com>
References: <cover.1484450104.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 1/1] toaster: bin/toaster whitelist TOASTER_DIR
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
X-List-Received-Date: Sun, 15 Jan 2017 03:16:46 -0000

Some of the tinfoil2 changes resulted in TOASTER_DIR being cleared by
the memory resident bitbake server toaster starts up.  This prevented
toaster from being able to connect to its sqlite database. Adding
TOASTER_DIR to the BB_ENV_EXTRAWHITE list stops the cooker from clearing
out the TOASTER_DIR variable.

[YOCTO #9252]

Signed-off-by: brian avery <brian.avery@intel.com>
---
 bin/toaster | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/toaster b/bin/toaster
index de38cec..daaf8ea 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -158,6 +158,7 @@ unset OE_ROOT
 # 4) pid's we need to clean up on exit/shutdown
 # note: for future. in order to make this an arbitrary directory, we need to
 # make sure that the toaster.sqlite file doesn't default to `pwd` like it currently does.
+export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE TOASTER_DIR"
 export TOASTER_DIR=`pwd`
 
 WEBSERVER=1
-- 
1.9.1



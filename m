Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id F296673E11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 13:20:27 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 19 Aug 2015 06:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,709,1432623600"; d="scan'208";a="751523657"
Received: from mclawlor-mobl5.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.12.193])
	by orsmga001.jf.intel.com with ESMTP; 19 Aug 2015 06:20:27 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Aug 2015 14:20:09 +0100
Message-Id: <9c6e61aab76b3cfad015aab68864bd1f920d9732.1439990327.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439990327.git.paul.eggleton@linux.intel.com>
References: <cover.1439990327.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439990327.git.paul.eggleton@linux.intel.com>
References: <cover.1439990327.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/4] bitbake-layers: remove-layer: accept just layer directory
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
X-List-Received-Date: Wed, 19 Aug 2015 13:20:28 -0000

If the specified layer isn't a path, then just match on the directory.

Fixes [YOCTO #7839].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index a0227d4..1b4694b 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -120,6 +120,8 @@ Removes the specified layer from bblayers.conf
 
         if args.layerdir.startswith('*'):
             layerdir = args.layerdir
+        elif not '/' in args.layerdir:
+            layerdir = '*/%s' % args.layerdir
         else:
             layerdir = os.path.abspath(args.layerdir)
         (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf, None, layerdir)
-- 
2.1.0



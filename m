Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id F375F76A64
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 13:20:26 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 19 Aug 2015 06:20:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,709,1432623600"; d="scan'208";a="751523629"
Received: from mclawlor-mobl5.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.12.193])
	by orsmga001.jf.intel.com with ESMTP; 19 Aug 2015 06:20:25 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Aug 2015 14:20:08 +0100
Message-Id: <095b858fb5ef79d61d56b9caa073af827f365f44.1439990327.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439990327.git.paul.eggleton@linux.intel.com>
References: <cover.1439990327.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439990327.git.paul.eggleton@linux.intel.com>
References: <cover.1439990327.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] bitbake-layers: ensure we exit if BBLAYERS_LAYERINDEX_URL is not set
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
X-List-Received-Date: Wed, 19 Aug 2015 13:20:27 -0000

We were printing an error here, but not exiting.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 5116e59..a0227d4 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -265,6 +265,7 @@ Removes the specified layer from bblayers.conf
         apiurl = self.bbhandler.config_data.getVar('BBLAYERS_LAYERINDEX_URL', True)
         if not apiurl:
             logger.error("Cannot get BBLAYERS_LAYERINDEX_URL")
+            return 1
         else:
             if apiurl[-1] != '/':
                 apiurl += '/'
-- 
2.1.0



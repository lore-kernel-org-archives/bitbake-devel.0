Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 199D377908
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Mar 2017 04:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1489982831; x=1521518831;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=R/135oqQzW6hNdYpdI/5QPzuvfPXxCZJ6SKyCt+0TfA=;
	b=QDAAyXInk65ZcTMLEGZmcc8asCT60WkYCZS+WXc7UPgS/C/RUkVEjgTu
	osa3Kr9Rwb1tuJSK8ZH5/P1XepQpTw==;
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Mar 2017 21:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,191,1486454400"; d="scan'208";a="68903098"
Received: from cloy-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.161.201])
	by orsmga004.jf.intel.com with ESMTP; 19 Mar 2017 21:07:09 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Mar 2017 17:07:04 +1300
Message-Id: <2640d485d6d529bec1bce7ef01997ea077f2c392.1489982808.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1489982808.git.paul.eggleton@linux.intel.com>
References: <cover.1489982808.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake-layers: fix layerindex-fetch for Python 3
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
X-List-Received-Date: Mon, 20 Mar 2017 04:07:09 -0000

The data we read from an HTTPConnection comes in the form of bytes, but
we need it as a string, so in Python 3 we need to decode it (missed in
the Python 3 migration).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bblayers/layerindex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 013e952..506c110 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -56,7 +56,7 @@ class LayerIndexPlugin(ActionPlugin):
         r = conn.getresponse()
         if r.status != 200:
             raise Exception("Failed to read " + path + ": %d %s" % (r.status, r.reason))
-        return json.loads(r.read())
+        return json.loads(r.read().decode())
 
     def get_layer_deps(self, layername, layeritems, layerbranches, layerdependencies, branchnum, selfname=False):
         def layeritems_info_id(items_name, layeritems):
-- 
2.9.3



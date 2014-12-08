Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id C1CB17248C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 10:50:33 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 08 Dec 2014 02:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,537,1413270000"; d="scan'208";a="644158898"
Received: from apwitke-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.30.33])
	by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2014 02:50:33 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Dec 2014 10:50:25 +0000
Message-Id: <bd4a209b8fd5adb0bc35d8a44b57c03aea07f099.1418034514.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1418034514.git.paul.eggleton@linux.intel.com>
References: <cover.1418034514.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1418034514.git.paul.eggleton@linux.intel.com>
References: <cover.1418034514.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/4] event: fix resetting class handlers object
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
X-List-Received-Date: Mon, 08 Dec 2014 10:50:34 -0000

If you don't explicitly specify to use a global variable when doing an
assignment, you will be setting a local variable instead, which means
this function wasn't working at all. It explains some odd behaviour we
have seen in the layer index where event handlers were sometimes
bleeding into other contexts where they should not have been.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/event.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 9645476..8bc6b80 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -55,6 +55,7 @@ def get_class_handlers():
     return _handlers
 
 def set_class_handlers(h):
+    global handlers
     _handlers = h
 
 def clean_class_handlers():
-- 
1.9.3



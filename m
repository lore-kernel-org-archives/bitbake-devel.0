Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id AEF2171A8C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Mar 2017 00:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490573859; x=1522109859;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=LecA6qDqRiXiHiplTCGttJwO0Ato9yTHzdZ4o4khCiM=;
	b=Lz+amPa1l3F27iQ8mnSaXZi375za+XkkHyEcRJY5LcOCpWrei+wZqSg9
	Z1iTntisgrycm6eXYWgXTH3h6psoZg==;
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Mar 2017 17:17:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,229,1486454400"; d="scan'208";a="80843994"
Received: from tienhauh-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.171.185])
	by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2017 17:17:37 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Mar 2017 13:17:28 +1300
Message-Id: <9f62b06d0f7c0df4f3ca91b24af2c0d791d16d7c.1490573768.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1490573768.git.paul.eggleton@linux.intel.com>
References: <cover.1490573768.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] tinfoil: enable client-side logger handling by default
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
X-List-Received-Date: Mon, 27 Mar 2017 00:17:37 -0000

If you had a script that uses tinfoil and it failed to connect to the
BitBake server, you did't see any of the expected messages - this was
because client-side logging wasn't being handled at all. Since you'll
almost always want this when using tinfoil, have it use the new
bb.msg.logger_create() function to enable client-side logging by
default.

Relates to [YOCTO #11185].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 19b41be..c2ee707 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -210,13 +210,17 @@ class TinfoilCookerAdapter:
 
 class Tinfoil:
 
-    def __init__(self, output=sys.stdout, tracking=False):
+    def __init__(self, output=sys.stdout, tracking=False, setup_logging=True):
         self.logger = logging.getLogger('BitBake')
         self.config_data = None
         self.cooker = None
         self.tracking = tracking
         self.ui_module = None
         self.server_connection = None
+        if setup_logging:
+            # This is the *client-side* logger, nothing to do with
+            # logging messages from the server
+            bb.msg.logger_create('BitBake', output)
 
     def __enter__(self):
         return self
-- 
2.9.3



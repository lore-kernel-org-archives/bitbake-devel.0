Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 70CAA71A0F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490662271; x=1522198271;
	h=from:to:cc:subject:date:message-id:in-reply-to: references;
	bh=h3FLXGK+MIQF1lQ8F3vXnC4MYBNuC+Axq8hBiuoQPEg=;
	b=bTsSKaZb9YdqqdfEmqSspYyPnoGz0yeyJODpA7EAzR4AfdtaQcYVzm/+
	Hh04oudT259R7HqcffPnUq9gqG2AzA==;
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Mar 2017 17:51:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,234,1486454400"; d="scan'208";a="948821382"
Received: from dalin-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.138.23])
	by orsmga003.jf.intel.com with ESMTP; 27 Mar 2017 17:51:08 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Mar 2017 13:51:01 +1300
Message-Id: <93968aed34753e90e05945b2bce34ccfb4743a60.1490662146.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1490662146.git.paul.eggleton@linux.intel.com>
References: <cover.1490662146.git.paul.eggleton@linux.intel.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/1] lib/bb/codeparser: ensure BufferedLogger respects target filtering
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
X-List-Received-Date: Tue, 28 Mar 2017 00:51:09 -0000

BufferedLogger was sending log records to the target logger using
handle() - this meant that the filtering (e.g. log level set)
on the target logger was bypassed, leading for example to debug records
getting printed when the log level was set to logging.WARNING.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/codeparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 5d2d440..c36397c 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -186,7 +186,7 @@ class BufferedLogger(Logger):
 
     def flush(self):
         for record in self.buffer:
-            self.target.handle(record)
+            self.target.filter(record)
         self.buffer = []
 
 class PythonParser():
-- 
2.9.3



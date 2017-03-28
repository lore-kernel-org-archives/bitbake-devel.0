Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D63FF77BB4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490733721; x=1522269721;
	h=from:to:cc:subject:date:message-id:in-reply-to: references;
	bh=7n2xqq+vews5c6a9lKi80mo5Ldr5U1H06GutxoLJTiY=;
	b=pChOW+APr/AwSaMrdr12sLS14B8EFzjHxTMml6cY0CXkJd61IxW+Y79D
	dMTR808EbxtBA/dMAxkEt0oyPB1dEg==;
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Mar 2017 13:41:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,238,1486454400"; d="scan'208";a="1128218153"
Received: from dalin-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.138.23])
	by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2017 13:41:57 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Mar 2017 09:41:47 +1300
Message-Id: <1c04460ad9b11930f74afcc4d1aa88e800056580.1490733586.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1490733586.git.paul.eggleton@linux.intel.com>
References: <cover.1490733586.git.paul.eggleton@linux.intel.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH v2 1/1] lib/bb/codeparser: ensure BufferedLogger respects target logging level
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
X-List-Received-Date: Tue, 28 Mar 2017 20:42:01 -0000

BufferedLogger was sending log records to the target logger without
checking if the logger is enabled for the level of the record - and
handle() doesn't check this either (it's normally checked earlier when
the relevant log function is called e.g. logger.debug()), leading for
example to debug messages from codeparser getting printed when the log
level for the main BitBake logger was set to logging.WARNING.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/codeparser.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 5d2d440..89d24ab 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -186,7 +186,8 @@ class BufferedLogger(Logger):
 
     def flush(self):
         for record in self.buffer:
-            self.target.handle(record)
+            if self.target.isEnabledFor(record.levelno):
+                self.target.handle(record)
         self.buffer = []
 
 class PythonParser():
-- 
2.9.3



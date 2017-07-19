Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 2446D78202
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:47 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410421"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:05 +0200
Message-Id: <b931d681c7895b46a37ca0dd2af7966dd1c2516e.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 06/12] knotty: make it possible to use termfilter without either console
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:47 -0000

This isn't useful for knotty itself, but for use from tinfoil
in case we can't get access to either the console or errconsole, allow
either to be unspecified (None).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/knotty.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index c301982..f3900bd 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -207,8 +207,10 @@ class TerminalFilter(object):
             self.interactive = False
             bb.note("Unable to use interactive mode for this terminal, using fallback")
             return
-        console.addFilter(InteractConsoleLogFilter(self, format))
-        errconsole.addFilter(InteractConsoleLogFilter(self, format))
+        if console:
+            console.addFilter(InteractConsoleLogFilter(self, format))
+        if errconsole:
+            errconsole.addFilter(InteractConsoleLogFilter(self, format))
 
         self.main_progress = None
 
-- 
2.9.4



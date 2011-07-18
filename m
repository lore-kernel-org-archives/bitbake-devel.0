Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QiwN2-0000HH-Cq
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jul 2011 00:33:00 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 18 Jul 2011 15:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,224,1309762800"; d="scan'208";a="29127439"
Received: from vorpal.jf.intel.com ([10.7.199.64])
	by orsmga001.jf.intel.com with ESMTP; 18 Jul 2011 15:28:53 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jul 2011 15:33:17 -0700
Message-Id: <ee08396be1b045e1cbe47dd841bdfd7416b7823f.1311028023.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311028023.git.josh@linux.intel.com>
References: <cover.1311028023.git.josh@linux.intel.com>
In-Reply-To: <cover.1311028023.git.josh@linux.intel.com>
References: <cover.1311028023.git.josh@linux.intel.com>
Subject: [RFC PATCH 1/1] lib/bb: preserve a copy of the initial environment variables
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 18 Jul 2011 22:33:00 -0000

We are gradually introducing code which wants to be able to modify the
initial environment of BitBake. The os.environ map is created on first
import of the os module so create a copy early on and store it for future
use.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/__init__.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index d20267b..414e836 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -30,6 +30,10 @@ if sys.version_info < (2, 6, 0):
 import os
 import logging
 
+# The os.environ map of the environment is captured the first time the os
+# module is imported. Take a copy so we can preserve the original environment
+# for later use.
+initial_environ = os.environ.copy()
 
 class NullHandler(logging.Handler):
     def emit(self, record):
-- 
1.7.6




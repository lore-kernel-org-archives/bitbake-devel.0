Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RruB5-0000QG-4t
	for bitbake-devel@lists.openembedded.org;
	Mon, 30 Jan 2012 17:33:59 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 30 Jan 2012 08:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="104198216"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.192])
	by orsmga002.jf.intel.com with ESMTP; 30 Jan 2012 08:25:58 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 30 Jan 2012 16:25:49 +0000
Message-Id: <fe7026082de36a8b0b9ac086a78d42176dab3543.1327940413.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1327940413.git.paul.eggleton@linux.intel.com>
References: <cover.1327940413.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1327940413.git.paul.eggleton@linux.intel.com>
References: <cover.1327940413.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/6] bitbake-layers: add copyright notice
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
X-List-Received-Date: Mon, 30 Jan 2012 16:33:59 -0000

This ought to have been added earlier. (I consulted with Chris Larson on
the notice covering his work.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index b4cfd55..3007d51 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -4,6 +4,9 @@
 # displaying useful information, or acting against them.
 # See the help output for details on available commands.
 
+# Copyright (C) 2011 Mentor Graphics Corporation
+# Copyright (C) 2012 Intel Corporation
+
 import cmd
 import logging
 import os
-- 
1.7.5.4




Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qjy4T-00053G-AF
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 20:34:05 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 Jul 2011 11:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,242,1309762800"; d="scan'208";a="28648890"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 21 Jul 2011 11:29:55 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 11:34:21 -0700
Message-Id: <bac689fc34ea55c062d60ef249b79faa35f546a1.1311273097.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311273097.git.josh@linux.intel.com>
References: <cover.1311273097.git.josh@linux.intel.com>
In-Reply-To: <cover.1311273097.git.josh@linux.intel.com>
References: <cover.1311273097.git.josh@linux.intel.com>
Subject: [PATCH 4/6] ui/crumbs/configurator: write new lines after new entries
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
X-List-Received-Date: Thu, 21 Jul 2011 18:34:05 -0000

New entries written to a configuration file should be on separate lines,
ensure this is the case by appending a newline to each written variable.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
index b694143..5511799 100644
--- a/lib/bb/ui/crumbs/configurator.py
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -228,7 +228,7 @@ class Configurator(gobject.GObject):
                 cnt = cnt + 1
 
             if not replaced:
-                new_config_lines.append("%s = \"%s\"" % (var, changed_values[var]))
+                new_config_lines.append("%s = \"%s\"\n" % (var, changed_values[var]))
 
         # Add the modified variables
         config_lines.extend(new_config_lines)
-- 
1.7.6




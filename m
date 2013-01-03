Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jessica.zhang@intel.com>) id 1TquLU-0000A4-JL
	for bitbake-devel@lists.openembedded.org;
	Fri, 04 Jan 2013 00:37:10 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 03 Jan 2013 15:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,405,1355126400"; d="scan'208";a="267023870"
Received: from jzhang-desktop.jf.intel.com (HELO localhost) ([10.7.201.69])
	by orsmga002.jf.intel.com with ESMTP; 03 Jan 2013 15:20:58 -0800
From: Jessica Zhang <jessica.zhang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Jan 2013 15:32:05 -0800
Message-Id: <eecefc2d16969c413dad379c8ba6605750665990.1357255745.git.jessica.zhang@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1357255745.git.jessica.zhang@intel.com>
References: <cover.1357255745.git.jessica.zhang@intel.com>
In-Reply-To: <cover.1357255745.git.jessica.zhang@intel.com>
References: <cover.1357255745.git.jessica.zhang@intel.com>
Subject: [PATCH 1/1] Fix GTK+ and PyGtk version check error message to be more clear [Yocto #3637]
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
X-List-Received-Date: Thu, 03 Jan 2013 23:37:10 -0000

Signed-off-by: Jessica Zhang <jessica.zhang@intel.com>
---
 bitbake/lib/bb/ui/hob.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index 9ec32b1..55bd84c 100755
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
@@ -22,7 +22,7 @@
 
 import sys
 import os
-requirements = "FATAL: Gtk+, PyGtk and PyGobject are required to use Hob"
+requirements = "FATAL: Hob requires Gtk+ 2.20.0 or higher, PyGtk 2.21.0 or higher"
 try:
     import gobject
     import gtk
-- 
1.7.9.5




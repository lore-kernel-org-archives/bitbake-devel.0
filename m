Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ddalex@intel.com>) id 1UXAQO-0004D8-Ti
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Apr 2013 15:17:22 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 30 Apr 2013 05:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,582,1363158000"; d="scan'208";a="295414691"
Received: from adamian-desktop.rb.intel.com ([10.237.224.34])
	by azsmga001.ch.intel.com with ESMTP; 30 Apr 2013 05:57:54 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id D7F0456023D; Tue, 30 Apr 2013 13:57:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org,
	paul.eggleton@linux.intel.com, andrei.adrianx.dinu@intel.com,
	bogdan.a.marinescu@intel.com
Date: Tue, 30 Apr 2013 13:57:54 +0100
Message-Id: <1367326675-18037-2-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1367326675-18037-1-git-send-email-alexandru.damian@intel.com>
References: <1367326675-18037-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/2] bitbake server: create common server infrastructure
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
X-List-Received-Date: Tue, 30 Apr 2013 13:17:37 -0000
X-List-Received-Date: Tue, 30 Apr 2013 13:17:37 -0000
X-List-Received-Date: Tue, 30 Apr 2013 13:17:37 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In an attempt to minimize code duplication, create
clear interfaces, and maximize code reuse through OOP,
bb.server adds base classes for the BitBakeServer,
BitBakeServerConnection and actual server implementations
instructed in particular server types.

These classes document the minimum interfaces that the
derived classes must implement, and provide boilerplate code.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/server/__init__.py |   95 +++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/bitbake/lib/bb/server/__init__.py b/bitbake/lib/bb/server/__init__.py
index e69de29..dcbae62 100644
--- a/bitbake/lib/bb/server/__init__.py
+++ b/bitbake/lib/bb/server/__init__.py
@@ -0,0 +1,95 @@
+#
+# BitBake Base Server Code
+#
+# Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
+# Copyright (C) 2006 - 2008  Richard Purdie
+# Copyright (C) 2013         Alexandru Damian
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+""" Base code for Bitbake server process
+
+Have a common base for that all Bitbake server classes ensures a consistent
+approach to the interface, and minimize risks associated with code duplication.
+
+"""
+
+"""  BaseImplServer() the base class for all XXServer() implementations.
+
+    These classes contain the actual code that runs the server side, i.e.
+    listens for the commands and executes them. Although these implementations
+    contain all the data of the original bitbake command, i.e the cooker instance,
+    they may well run on a different process or even machine.
+
+"""
+
+class BaseImplServer():
+    def __init__(self):
+        self._idlefuns = {}
+
+    def addcooker(self, cooker):
+        self.cooker = cooker
+
+    def register_idle_function(self, function, data):
+        """Register a function to be called while the server is idle"""
+        assert hasattr(function, '__call__')
+        self._idlefuns[function] = data
+
+
+
+""" BitBakeBaseServerConnection class is the common ancestor to all
+    BitBakeServerConnection classes.
+
+    These classes control the remote server. The only command currently
+    implemented is the terminate() command.
+
+"""
+
+class BitBakeBaseServerConnection():
+    def __init__(self, serverImpl):
+        pass
+
+    def terminate(self):
+        pass
+
+
+""" BitBakeBaseServer class is the common ancestor to all Bitbake servers
+
+    Derive this class in order to implement a BitBakeServer which is the
+    controlling stub for the actual server implementation
+
+"""
+class BitBakeBaseServer(object):
+    def initServer(self):
+        self.serverImpl = None  # we ensure a runtime crash if not overloaded
+        return
+
+    def addcooker(self, cooker):
+        self.cooker = cooker
+        self.serverImpl.addcooker(cooker)
+
+    def getServerIdleCB(self):
+        return self.serverImpl.register_idle_function
+
+    def saveConnectionDetails(self):
+        return
+
+    def detach(self):
+        return
+
+    def establishConnection(self):
+        raise   "Must redefine the %s.establishConnection()" % self.__class__.__name__
+
+    def launchUI(self, uifunc, *args):
+        raise   "Must redefine the %s.launchUI()" % self.__class__.__name__
-- 
1.7.10.4




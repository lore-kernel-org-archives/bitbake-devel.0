Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 7ABB973193
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:04 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="15002580"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2015 08:49:00 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:46 +0000
Message-Id: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1450370782.git.elliot.smith@intel.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
Subject: [PATCH 01/11] toaster: implement checksocket command
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:06 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Implemented new management command to check if it's
possible to listen on specified address:port.

[YOCTO #8775]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toastermain/management/commands/checksocket.py | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 bitbake/lib/toaster/toastermain/management/commands/checksocket.py

diff --git a/lib/toaster/toastermain/management/commands/checksocket.py b/lib/toaster/toastermain/management/commands/checksocket.py
new file mode 100644
index 0000000..0399b86
--- /dev/null
+++ b/lib/toaster/toastermain/management/commands/checksocket.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2015 Intel Corporation
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
+"""Custom management command checksocket."""
+
+import errno
+import socket
+
+from django.core.management.base import BaseCommand, CommandError
+from django.utils.encoding import force_text
+
+DEFAULT_ADDRPORT = "0.0.0.0:8000"
+
+class Command(BaseCommand):
+    """Custom management command."""
+
+    help = 'Check if Toaster can listen on address:port'
+
+    def add_arguments(self, parser):
+        parser.add_argument('addrport', nargs='?', default=DEFAULT_ADDRPORT,
+                            help='ipaddr:port to check, %s by default' % \
+                                 DEFAULT_ADDRPORT)
+
+    def handle(self, *args, **options):
+        addrport = options['addrport']
+        if ':' not in addrport:
+            raise CommandError('Invalid addr:port specified: %s' % addrport)
+        splitted = addrport.split(':')
+        try:
+            splitted[1] = int(splitted[1])
+        except ValueError:
+            raise CommandError('Invalid port specified: %s' % splitted[1])
+        self.stdout.write('Check if toaster can listen on %s' % addrport)
+        try:
+            sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+            sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
+            sock.bind(tuple(splitted))
+        except (socket.error, OverflowError) as err:
+            errors = {
+                errno.EACCES: 'You don\'t have permission to access port %s' \
+                              % splitted[1],
+                errno.EADDRINUSE: 'Port %s is already in use' % splitted[1],
+                errno.EADDRNOTAVAIL: 'IP address can\'t be assigned to',
+            }
+            if hasattr(err, 'errno') and err.errno in errors:
+                errtext = errors[err.errno]
+            else:
+                errtext = force_text(err)
+            raise CommandError(errtext)
+
+        self.stdout.write("OK")
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.



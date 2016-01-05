Return-Path: <sujith.h@gmail.com>
Received: from mail-qg0-f51.google.com (mail-qg0-f51.google.com
	[209.85.192.51])
	by mail.openembedded.org (Postfix) with ESMTP id 78AD2605FE
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Jan 2016 13:00:22 +0000 (UTC)
Received: by mail-qg0-f51.google.com with SMTP id o11so277158262qge.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 05 Jan 2016 05:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=njIDXhcpJ2Ai98jViDeBImkjBbCj7EwF8epcTkb2pdo=;
	b=N3DVo0x2E253i2jpQZ7N8oIjbW29whm86LYa0GUx4XIZvQhshtJBaOD73kIMtYWnqc
	oL7x8BcCdOMb9EtB6yXJGeLwR+CD++BgdmDQnog+TRvSk9HnHbxxgZsCth8hjVW0JBs/
	Z439MEOwC6av8cSMmuTj3KK+EB2oDUskHbxFVTYQlASTrN9RltH505EanxiB30FI11p6
	rXBmGTQZFkbXia9MBNLZQNuYZI2xxAXZ21JFaSYV7gHSr8hiP/2i1RRS/CaHn2kjQ1KV
	VELMbj2TD6DsP5i3G1IubLI6qtQTMEvr03E5hoXvMqMMbl815lozcUMQJDXUtfjpM+o3
	Ifjw==
X-Received: by 10.140.242.147 with SMTP id n141mr81692662qhc.2.1451998823441; 
	Tue, 05 Jan 2016 05:00:23 -0800 (PST)
Received: from kdekidd0.inp-wifi.mentorg.com ([139.181.35.34])
	by smtp.gmail.com with ESMTPSA id
	d188sm39347333qkb.9.2016.01.05.05.00.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 05 Jan 2016 05:00:23 -0800 (PST)
From: Sujith H <sujith.h@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jan 2016 18:30:15 +0530
Message-Id: <1451998815-4536-1-git-send-email-sujith.h@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] bitbake: BBUIHelper: Remove function findServerDetails
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
X-List-Received-Date: Tue, 05 Jan 2016 13:00:26 -0000

findServerDetails function can be removed safely
from the source tree. Couldn't find any files
calling this function.

Signed-off-by: Sujith H <sujith.h@gmail.com>
---
 lib/bb/ui/uihelper.py | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index a703387..db70b76 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -57,44 +57,3 @@ class BBUIHelper:
         self.needUpdate = False
         return (self.running_tasks, self.failed_tasks)
 
-    def findServerDetails(self):
-        import sys
-        import optparse
-        from bb.server.xmlrpc import BitbakeServerInfo, BitBakeServerConnection
-        host = ""
-        port = 0
-        bind = ""
-        parser = optparse.OptionParser(
-            usage = """%prog -H host -P port -B bindaddr""")
-
-        parser.add_option("-H", "--host", help = "Bitbake server's IP address",
-                   action = "store", dest = "host", default = None)
-
-        parser.add_option("-P", "--port", help = "Bitbake server's Port number",
-                   action = "store", dest = "port", default = None)
-
-        parser.add_option("-B", "--bind", help = "Hob2 local bind address",
-                   action = "store", dest = "bind", default = None)
-
-        options, args = parser.parse_args(sys.argv)
-        for key, val in options.__dict__.items():
-            if key == 'host' and val:
-                host = val
-            elif key == 'port' and val:
-                port = int(val)
-            elif key == 'bind' and val:
-                bind = val
-
-        if not host or not port or not bind:
-            parser.print_usage()
-            sys.exit(1)
-
-        serverinfo = BitbakeServerInfo(host, port)
-        clientinfo = (bind, 0)
-        connection = BitBakeServerConnection(serverinfo, clientinfo)
-
-        server = connection.connection
-        eventHandler = connection.events
-
-        return server, eventHandler, host, bind
-
-- 
2.4.3



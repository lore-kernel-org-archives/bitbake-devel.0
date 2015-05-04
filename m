Return-Path: <Maxin.John@enea.com>
Received: from mx-3.enea.com (sestofw01.enea.se [192.36.1.252])
	by mail.openembedded.org (Postfix) with SMTP id 07523601DC
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 May 2015 11:35:39 +0000 (UTC)
Received: from sestofb10.enea.se (172.21.3.145) by smtp.enea.com
	(172.21.1.208) with Microsoft SMTP Server id 14.3.224.2; Mon, 4 May 2015
	13:35:37 +0200
Received: by sestofb10.enea.se (Postfix, from userid 4454)	id 2FBD128BA1D;
	Mon,  4 May 2015 13:35:37 +0200 (CEST)
From: "Maxin B. John" <maxin.john@enea.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 4 May 2015 13:35:35 +0200
Message-ID: <1430739335-31145-1-git-send-email-maxin.john@enea.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Received-SPF: None (SESTOEX08.enea.se: maxin.john@enea.com does not
	designate permitted sender hosts)
Subject: [PATCH] bitbake: prserv: serv.py: remove unused and duplicate imports
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
X-List-Received-Date: Mon, 04 May 2015 11:35:40 -0000
Content-Type: text/plain

Remove unused xmlrpclib, atexit and duplicated threading module imports

Signed-off-by: Maxin B. John <maxin.john@enea.com>
---
 bitbake/lib/prserv/serv.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index a7639c8..0507485 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -1,7 +1,6 @@
 import os,sys,logging
-import signal, time, atexit, threading
+import signal, time
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
-import xmlrpclib
 import threading
 import Queue
 
-- 
1.9.1



Return-Path: <ola.x.nilsson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5D46778F72
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 09:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id B098B1806E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:06 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id YSumm5Wq8sRY for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:06 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id ABD23182F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81AB01A065
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 757F51A064
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
Received: from lnxolani1.se.axis.com (lnxolani1.se.axis.com [10.88.130.9])
	by thoth.se.axis.com (Postfix) with ESMTP id 6922F2B6D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
Received: by lnxolani1.se.axis.com (Postfix, from userid 20853)
	id 6090C40AAF; Mon, 21 Oct 2019 11:07:05 +0200 (CEST)
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Oct 2019 11:07:04 +0200
Message-Id: <20191021090705.31214-1-olani@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Subject: [PATCH 1/2] bitbake: prserv/serv: Use with while reading pidfile
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
X-List-Received-Date: Mon, 21 Oct 2019 09:07:06 -0000

Signed-off-by: Ola x Nilsson <olani@axis.com>
---
 lib/prserv/serv.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index be3acec3..2bc68904 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -379,9 +379,8 @@ def stop_daemon(host, port):
     ip = socket.gethostbyname(host)
     pidfile = PIDPREFIX % (ip, port)
     try:
-        pf = open(pidfile,'r')
-        pid = int(pf.readline().strip())
-        pf.close()
+        with open(pidfile) as pf:
+            pid = int(pf.readline().strip())
     except IOError:
         pid = None
 
-- 
2.11.0



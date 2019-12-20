Return-Path: <ola.x.nilsson@axis.com>
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
	by mail.openembedded.org (Postfix) with ESMTP id 0025E79CC0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2019 14:30:29 +0000 (UTC)
IronPort-SDR: 6n4DAxhLOKKNU36XkHiAPpf4RYoio4H1dXq8U8o4YIPQ0q7anoT+uv5zxRvaKVPAAEl1k6i/VT
	9w5FANuDsgqUs7uj0t61NYdwk+1DIfSJfWo1U5C8Pp/nix0owUKjlKPdhYArf4GHvgB5BLNEzv
	afQIWxfftXn7Z0AQcPf7+3eFIk6r0QoagTENfXeddAsBBKR0pKNHribHbVIXOeQvGaa4forNDb
	UZWuH+bZWty4Oh+BVAQlvU8gfDU9ifKbNVlrc7kwx0QjLXrbpVz0pA8Q3nVCqvELquzgrBgAyb
	OvM=
X-IronPort-AV: E=Sophos;i="5.69,336,1571695200"; 
   d="scan'208";a="3808695"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Dec 2019 15:23:19 +0100
Message-Id: <20191220142320.17724-1-olani@axis.com>
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
X-List-Received-Date: Fri, 20 Dec 2019 14:30:30 -0000

Signed-off-by: Ola x Nilsson <olani@axis.com>
---
 lib/prserv/serv.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 3124b079..708b2e0a 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -353,9 +353,8 @@ def start_daemon(dbfile, host, port, logfile):
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



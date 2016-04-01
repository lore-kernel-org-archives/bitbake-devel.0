Return-Path: <olof.johansson@axis.com>
X-Greylist: delayed 494 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 01 Apr 2016 14:58:02 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id E9575763F0
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 14:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 0D26B1833F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 16:49:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id P5zBobCBa+3x for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 16:49:48 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 713731828D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 16:49:48 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 546A3F11
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 16:49:48 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 49D6217CC
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 16:49:48 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by thoth.se.axis.com (Postfix) with ESMTP id 483BB10D2
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 16:49:48 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 3498F9C09E; Fri,  1 Apr 2016 16:49:48 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Apr 2016 16:49:48 +0200
Message-Id: <1459522188-4421-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] fetch2: BB_ALLOWED_NETWORKS should not care about port numbers
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
X-List-Received-Date: Fri, 01 Apr 2016 14:58:03 -0000

Bitbake would fail to classify the following URL as belonging to a
allowed network, because of the port number in the url.

 BB_ALLOWED_NETWORKS = "*.example.com"
 SRC_URI = "http://git.example.com:8080/foo.tar.gz"

Since protocols aren't specified in the BB_ALLOWED_NETWORKS variable,
it's reasonable to believe that this should work regardless of protocol
being used.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 288a1c8..5763a80 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1028,6 +1028,7 @@ def trusted_network(d, url):
     if not network:
         return True
 
+    network = network.split(':')[0]
     network = network.lower()
 
     for host in trusted_hosts.split(" "):
-- 
2.1.4



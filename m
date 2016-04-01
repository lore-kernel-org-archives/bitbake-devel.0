Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 588AE75A31
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 15:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 37F302E3A9
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id sMQCYJhSYEad for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:50 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id AA8682E3CC
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:48 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 95A1717CE
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:48 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 8AF74C6
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:48 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
	by seth.se.axis.com (Postfix) with ESMTP id 8734A1151
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 17:01:48 +0200 (CEST)
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)
	id 6CD719C09E; Fri,  1 Apr 2016 17:01:48 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Apr 2016 17:01:47 +0200
Message-Id: <1459522908-26650-1-git-send-email-olofjn@axis.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH v2 1/2] fetch2: BB_ALLOWED_NETWORKS should not care about port numbers
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
X-List-Received-Date: Fri, 01 Apr 2016 15:01:52 -0000

From: Olof Johansson <olof.johansson@axis.com>

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
index e8cea7f..c2ddebd 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1032,6 +1032,7 @@ def trusted_network(d, url):
     if not network:
         return True
 
+    network = network.split(':')[0]
     network = network.lower()
 
     for host in trusted_hosts.split(" "):
-- 
2.1.4



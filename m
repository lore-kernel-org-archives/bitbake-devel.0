Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F12B977487
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Dec 2016 17:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH5wWs001270; Wed, 21 Dec 2016 17:06:34 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oQPe7JzTGRmp; Wed, 21 Dec 2016 17:06:34 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6Tch001589
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Dec 2016 17:06:30 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cJkLV-0006uG-EV; Wed, 21 Dec 2016 17:06:29 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Dec 2016 17:06:21 +0000
Message-Id: <1482339985-26495-3-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 3/7] siggen: Fix clean_basepath to work with multiconfig
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
X-List-Received-Date: Wed, 21 Dec 2016 17:06:36 -0000

Tasknames can now start with "multiconfig:" which broke the virtual: comparison code and
lead to unpredictable checksums with nativesdk recipes. This adds in handling for
the new additional prefix which unbreaks nativesdk builds when using multiconfig.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 659d27d..4226c80 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -352,9 +352,14 @@ def dump_this_task(outfile, d):
     bb.parse.siggen.dump_sigtask(fn, task, outfile, "customfile:" + referencestamp)
 
 def clean_basepath(a):
+    mc = None
+    if a.startswith("multiconfig:"):
+        _, mc, a = a.split(":", 2)
     b = a.rsplit("/", 2)[1] + a.rsplit("/", 2)[2]
     if a.startswith("virtual:"):
         b = b + ":" + a.rsplit(":", 1)[0]
+    if mc:
+        b = b + ":multiconfig:" + mc
     return b
 
 def clean_basepaths(a):
-- 
2.7.4



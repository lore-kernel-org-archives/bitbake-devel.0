Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AEDAD65CAC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jun 2015 16:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5QGQlwE000446 for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jun 2015 17:26:47 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Wm8d_1sOtmvM for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jun 2015 17:26:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5QGQZUa000436
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jun 2015 17:26:46 +0100
Message-ID: <1435335995.10583.30.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 26 Jun 2015 17:26:35 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] codeparser: Add repr() methods
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
X-List-Received-Date: Fri, 26 Jun 2015 16:26:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

These aid when debugging parts of the codeparser cache since the 
object contents becomes identifiable.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 21a36f6..2d3574c 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -92,6 +92,9 @@ class pythonCacheLine(object):
         for c in sorted(self.contains.keys()):
             l = l + (c, hash(self.contains[c]))
         return hash(l)
+    def __repr__(self):
+        return " ".join([str(self.refs), str(self.execs), str(self.contains)]) 
+
 
 class shellCacheLine(object):
     def __init__(self, execs):
@@ -105,6 +108,8 @@ class shellCacheLine(object):
         self.__init__(execs)
     def __hash__(self):
         return hash(self.execs)
+    def __repr__(self):
+        return str(self.execs)
 
 class CodeParserCache(MultiProcessCache):
     cache_file_name = "bb_codeparser.dat"




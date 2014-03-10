Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 645066F58F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:59:28 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2A0xN3q028065 for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:59:24 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aDiIJ9TZK9nX for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:59:23 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2A0xFRE028052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 00:59:19 GMT
Message-ID: <1394413150.7883.21.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 17:59:10 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] server/process: Optimise latency when finishing idle functions
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
X-List-Received-Date: Mon, 10 Mar 2014 00:59:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When idle functions finish, its likely we have some other work
to do, so don't sleep in the select call but instead, skip it.
This removes small amounts of latency in common commands.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 07688a2..577c250 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -128,6 +128,7 @@ class ProcessServer(Process, BaseImplServer):
                 retval = function(self, data, False)
                 if retval is False:
                     del self._idlefuns[function]
+                    nextsleep = None
                 elif retval is True:
                     nextsleep = None
                 elif nextsleep is None:




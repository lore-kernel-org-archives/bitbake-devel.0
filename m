Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3FBA46E268
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Feb 2016 10:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1EAEPxt014414 for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Feb 2016 10:14:25 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3FHR3gTpuqQt for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Feb 2016 10:14:25 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1EAEMPn014411
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Feb 2016 10:14:23 GMT
Message-ID: <1455444862.16142.377.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 14 Feb 2016 10:14:22 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] taskdata: Fix traceback issue with missing provider
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
X-List-Received-Date: Sun, 14 Feb 2016 10:14:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If there is a missing provider and we're using "-k" mode alongside "-w",
we could get a traceback since there was no provider. Add tests to avoid this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index 6e4d149..9ae52d7 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -642,7 +642,9 @@ class TaskData:
             if prefix and not name.startswith(prefix):
                 continue
             if self.have_build_target(name):
-                provmap[name] = self.fn_index[self.get_provider(name)[0]]
+                provider = self.get_provider(name)
+                if provider:
+                    provmap[name] = self.fn_index[provider[0]]
         return provmap
 
     def dump_data(self):




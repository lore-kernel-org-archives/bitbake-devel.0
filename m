Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CB5A277057
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 11 Oct 2015 15:02:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9BF2EPI024497; Sun, 11 Oct 2015 16:02:14 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SzikMFVzh13P; Sun, 11 Oct 2015 16:02:14 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9BF1rll024481
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 11 Oct 2015 16:02:07 +0100
Message-ID: <1444554707.14364.13.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 11 Oct 2015 10:11:47 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.12.11-0ubuntu3 
Subject: [PATCH] command: Add getSetVariable command
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
X-List-Received-Date: Sun, 11 Oct 2015 15:02:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There are some use cases where we want to read a variable but also
set the variable to the value read, effectively locking in any
expansion of it. This adds such a command.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/command.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 31aa071..7c980a2 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -190,6 +190,16 @@ class CommandsSync:
         value = str(params[1])
         command.cooker.data.setVar(varname, value)
 
+    def getSetVariable(self, command, params):
+        """
+        Read the value of a variable from data and set it into the datastore
+        which effectively expands and locks the value.
+        """
+        varname = params[0]
+        result = self.getVariable(command, params)
+        command.cooker.data.setVar(varname, result)
+        return result
+
     def setConfig(self, command, params):
         """
         Set the value of variable in configuration




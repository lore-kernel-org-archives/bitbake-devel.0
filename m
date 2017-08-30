Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 81CC4782F7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 13:07:58 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7UD7vSS012427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 30 Aug 2017 14:07:58 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dn2ir-0006dM-D1; Wed, 30 Aug 2017 14:07:57 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 Aug 2017 14:07:56 +0100
Message-Id: <1504098476-25461-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Wed, 30 Aug 2017 14:07:58 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] command: Fix some bugs identified by BB_SERVER_TIMEOUT
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
X-List-Received-Date: Wed, 30 Aug 2017 13:08:00 -0000

The 'needconfig' flag was meant to be the default as most commands do need
it and the "False" cases were the exception. The code was written backwards
with a default False value. Invert this to match the intent, resulting in
the config being reparsed if metadata has changed.

Also ensure the second level configuration is parsed for the getLayerPriorities
command as otherwise it can return stale info.

With these changes:

BB_SERVER_TIMEOUT=100 oe-selftest -r bblayers.BitbakeLayers.test_bitbakelayers_add_remove

passes instead of fails.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index a923245..0d0354c 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -79,7 +79,7 @@ class Command:
                     return None, "Not able to execute not readonly commands in readonly mode"
             try:
                 self.cooker.process_inotify_updates()
-                if getattr(command_method, 'needconfig', False):
+                if getattr(command_method, 'needconfig', True):
                     self.cooker.updateCacheSync()
                 result = command_method(self, commandline)
             except CommandError as exc:
@@ -283,6 +283,7 @@ class CommandsSync:
     parseConfiguration.needconfig = False
 
     def getLayerPriorities(self, command, params):
+        command.cooker.parseConfiguration()
         ret = []
         # regex objects cannot be marshalled by xmlrpc
         for collection, pattern, regex, pri in command.cooker.bbfile_config_priorities:
-- 
2.7.4



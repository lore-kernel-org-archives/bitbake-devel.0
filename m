Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5D4946BD75
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:23:10 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1SHN6Ji004627 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:23:06 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jE9-uZrzSENh for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:23:06 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1SHN1Ul004623
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:23:03 GMT
Message-ID: <1393608174.31769.199.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Feb 2014 17:22:54 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch/git: Separate out an ls-remote function
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
X-List-Received-Date: Fri, 28 Feb 2014 17:23:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There is other code which can want to run ls-remote style commands with 
different parameters so split out the function.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index f7c26b3..1edcee4 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -317,22 +317,30 @@ class Git(FetchMethod):
         """
         return "git:" + ud.host + ud.path.replace('/', '.') + ud.unresolvedrev[name]
 
-    def _latest_revision(self, ud, d, name):
+    def __lsremote(self, ud, d, search):
         """
-        Compute the HEAD revision for the url
+        Run git ls-remote with the specified search string
         """
         if ud.user:
             username = ud.user + '@'
         else:
             username = ""
 
-        cmd = "%s ls-remote %s://%s%s%s refs/heads/%s refs/tags/%s^{}" % \
-              (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.unresolvedrev[name], ud.unresolvedrev[name])
+        cmd = "%s ls-remote %s://%s%s%s %s" % \
+              (ud.basecmd, ud.proto, username, ud.host, ud.path, search)
         if ud.proto.lower() != 'file':
             bb.fetch2.check_network_access(d, cmd)
         output = runfetchcmd(cmd, d, True)
         if not output:
             raise bb.fetch2.FetchError("The command %s gave empty output unexpectedly" % cmd, ud.url)
+        return output
+
+    def _latest_revision(self, ud, d, name):
+        """
+        Compute the HEAD revision for the url
+        """
+        search = "refs/heads/%s refs/tags/%s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
+        output = self.__lsremote(ud, d, search)
         return output.split()[0]
 
     def _build_revision(self, ud, d, name):




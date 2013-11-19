Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 369B96D798
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 13:20:38 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAJDKYwT010554 for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 13:20:34 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RQnKjjyjLzJX for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 13:20:34 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAJDKTm5010548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 13:20:30 GMT
Message-ID: <1384867226.16887.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Nov 2013 13:20:26 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] git: Use git branch for ancestor checks
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
X-List-Received-Date: Tue, 19 Nov 2013 13:20:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Using git merge-base for checking for ancestors is nice but required git 1.8.0
which is not in many distrbutions yet. We therefore revert to a more ugly
check using git branch --contains until such times as we can upgrade.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 99230c1..a901a44 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -283,12 +283,14 @@ class Git(FetchMethod):
 
     def _contains_ref(self, tag, branch, d):
         basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
-        cmd = "%s merge-base --is-ancestorlog %s %s" % (basecmd, tag, branch)
+        cmd =  "%s branch --contains %s --list %s 2> /dev/null | wc -l" % (basecmd, tag, branch)
         try:
             output = runfetchcmd(cmd, d, quiet=True)
         except bb.fetch2.FetchError:
             return False
-        return True
+        if len(output.split()) > 1:
+            raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
+        return output.split()[0] != "0"
 
     def _revision_key(self, url, ud, d, name):
         """




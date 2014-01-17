Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id A27CC6E74E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2014 12:02:16 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0HC2BJ6015012 for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2014 12:02:11 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YxXfEv8GkUrc for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2014 12:02:11 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0HC1XJN014994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2014 12:01:35 GMT
Message-ID: <1389960087.14987.115.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 17 Jan 2014 12:01:27 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2/gitsm: Use ud.basecmd instead of hardcoding git
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
X-List-Received-Date: Fri, 17 Jan 2014 12:02:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This allows FETCHCMD_git to override the fetcher command as the git fetcher does.

[YOCTO #5717]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index 4093f6e..9fdde46 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -51,9 +51,9 @@ class GitSM(Git):
         os.rename(ud.clonedir, gitdir)
         runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*true/bare = false/'", d)
         os.chdir(tmpclonedir)
-        runfetchcmd("git reset --hard", d)
-        runfetchcmd("git submodule init", d)
-        runfetchcmd("git submodule update", d)
+        runfetchcmd(ud.basecmd + " reset --hard", d)
+        runfetchcmd(ud.basecmd + " submodule init", d)
+        runfetchcmd(ud.basecmd + " submodule update", d)
         runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d)
         os.rename(gitdir, ud.clonedir,)
         bb.utils.remove(tmpclonedir, True)
@@ -73,6 +73,6 @@ class GitSM(Git):
         submodules = self.uses_submodules(ud, d)
         if submodules:
             runfetchcmd("cp -r " + ud.clonedir + "/modules " + ud.destdir + "/.git/", d)
-            runfetchcmd("git submodule init", d)
-            runfetchcmd("git submodule update", d)
+            runfetchcmd(ud.basecmd + " submodule init", d)
+            runfetchcmd(ud.basecmd + " submodule update", d)
 




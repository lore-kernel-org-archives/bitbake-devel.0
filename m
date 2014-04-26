Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8E0CE65DC0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Apr 2014 10:20:16 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s3QAKCp8001244 for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Apr 2014 11:20:12 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WPTpiB09KPh9 for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Apr 2014 11:20:12 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s3QAK9XP001223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Apr 2014 11:20:11 +0100
Message-ID: <1398507604.16672.239.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 26 Apr 2014 11:20:04 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2/git: Stop git from triggering fsync() calls
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
X-List-Received-Date: Sat, 26 Apr 2014 10:20:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We only ever clone other repositories, if there were a problem such as power
failure, we'd blow away data and rebuild. As such we don't need fsync(). With
filesystems like ext*, the fsync pushes nearly all the data out to disk
which impacts all running processes.

We therefore set a configuration parameter to disable the fsync() calls.

Also fixup a case where basecmd wasn't being used for no good reason.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index ecaaaf9..7c0c95c 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -124,7 +124,7 @@ class Git(FetchMethod):
             ud.branches[name] = branch
             ud.unresolvedrev[name] = branch
 
-        ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
+        ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git -c core.fsyncobjectfiles=0"
 
         ud.write_tarballs = ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") != "0") or ud.rebaseable
 
@@ -276,7 +276,7 @@ class Git(FetchMethod):
             os.symlink(ud.clonedir, indirectiondir)
             clonedir = indirectiondir
 
-        runfetchcmd("git clone %s %s/ %s" % (cloneflags, clonedir, destdir), d)
+        runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, cloneflags, clonedir, destdir), d)
         if not ud.nocheckout:
             os.chdir(destdir)
             if subdir != "":




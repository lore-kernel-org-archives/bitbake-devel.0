Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bruce.ashfield@windriver.com>) id 1S0g2K-0005E0-Q6
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 22:17:13 +0100
Received: from yow-bashfiel-l1.corp.ad.wrs.com
	(yow-bashfiel-d3.ottawa.windriver.com [128.224.147.67])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1NL8lOu023655;
	Thu, 23 Feb 2012 13:08:48 -0800 (PST)
From: Bruce Ashfield <bruce.ashfield@windriver.com>
To: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Date: Thu, 23 Feb 2012 16:08:42 -0500
Message-Id: <1330031322-22689-2-git-send-email-bruce.ashfield@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1330031322-22689-1-git-send-email-bruce.ashfield@windriver.com>
References: <1330031322-22689-1-git-send-email-bruce.ashfield@windriver.com>
Subject: [PATCH] fetch2/git: create bareclone option
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 23 Feb 2012 21:17:13 -0000

For similar reasons as the nocheckout option, packages that need
enhanced control over the checkout and branch creation on a repository
may want a complete mirror/bareclone created of the repository when
performing the unpack.

This is useful/required when a local respository is being used, but
local tracking branches have not been created for all branches that
a given recipe needs to manipulate. The standard git clone operations
will create remote branches for the branches that are local to the
source repository, but branches that are remote do not translate to
the destination repository. Doing a mirror/bare clone of the source,
makes all branches available to the repository.

This is a particular use case, but the ability to do a bare clone
creates great flexibility in recipe space, with no impact to recipes
that don't need this functionality.

To implement this, a new option 'bareclone' is craeted which creates
a mirror copy of the repository and leaves it bare in the unpacking
phase. A recipe that uses this option must both checkout and debare
the repository itself.

Signed-off-by: Bruce Ashfield <bruce.ashfield@windriver.com>
---
 lib/bb/fetch2/git.py |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index fb0260a..4e46ec8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -38,6 +38,12 @@ Supported SRC_URI options are:
    who has its own routine to checkout code.
    The default is "0", set nocheckout=1 if needed.
 
+- bareclone
+   Create a bare clone of the source code and don't checkout the source code
+   when unpacking. Set this option for the recipe who has its own routine to
+   checkout code and tracking branch requirements.
+   The default is "0", set bareclone=1 if needed.
+
 """
 
 #Copyright (C) 2005 Richard Purdie
@@ -95,6 +101,11 @@ class Git(FetchMethod):
 
         ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
 
+        # bareclone implies nocheckout
+        ud.bareclone = ud.parm.get("bareclone","0") == "1"
+        if ud.bareclone:
+            ud.nocheckout = 1
+  
         branches = ud.parm.get("branch", "master").split(',')
         if len(branches) != len(ud.names):
             raise bb.fetch2.ParameterError("The number of name and branch parameters is not balanced", ud.url)
@@ -220,7 +231,11 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        runfetchcmd("git clone -s -n %s/ %s" % (ud.clonedir, destdir), d)
+        cloneflags = "-s -n"
+        if ud.bareclone:
+            cloneflags += " --mirror"
+
+        runfetchcmd("git clone %s %s/ %s" % (cloneflags, ud.clonedir, destdir), d)
         if not ud.nocheckout:
             os.chdir(destdir)
             if subdir != "":
-- 
1.7.4.1




Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T2kyb-0002cP-Nf for bitbake-devel@lists.openembedded.org;
	Sat, 18 Aug 2012 17:30:13 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7IFICoY018713;
	Sat, 18 Aug 2012 16:18:12 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14272-09; Sat, 18 Aug 2012 16:18:08 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7IFI3lG018706
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 18 Aug 2012 16:18:04 +0100
Message-ID: <1345303083.27428.56.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 18 Aug 2012 16:18:03 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "Ashfield, Bruce" <Bruce.Ashfield@windriver.com>,
	"saul.wold" <saul.wold@intel.com>
Subject: [PATCH] fetch2/git: Work around git confusion between foo.git and foo repositories
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
X-List-Received-Date: Sat, 18 Aug 2012 15:30:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you have foo and foo.git in GITDIR, the two can end up being confused
by git with some horrible union of the two being cloned. This adds
a workaround to avoid this happening until git 1.7.9.2 onwards is
common enough for this to be removed. We use a symlink to hide
the directories we don't want git to know about.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 384007c..af7c623 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -245,7 +245,22 @@ class Git(FetchMethod):
         if ud.bareclone:
             cloneflags += " --mirror"
 
-        runfetchcmd("git clone %s %s/ %s" % (cloneflags, ud.clonedir, destdir), d)
+        # Versions of git prior to 1.7.9.2 have issues where foo.git and foo get confused
+        # and you end up with some horrible union of the two when you attempt to clone it
+        # The least invasive workaround seems to be a symlink to the real directory to
+        # fool git into ignoring any .git version that may also be present.
+        #
+        # The issue is fixed in more recent versions of git so we can drop this hack in future
+        # when that version becomes common enough.
+        clonedir = ud.clonedir
+        if not ud.path.endswith(".git"):
+            indirectiondir = destdir[:-1] + ".indirectionsymlink"
+            if os.path.exists(indirectiondir):
+                os.remove(indirectiondir)
+            os.symlink(ud.clonedir, indirectiondir)
+            clonedir = indirectiondir
+
+        runfetchcmd("git clone %s %s/ %s" % (cloneflags, clonedir, destdir), d)
         if not ud.nocheckout:
             os.chdir(destdir)
             if subdir != "":





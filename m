Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RsbqC-000755-Cn
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 16:11:20 +0100
Received: by opal (Postfix, from userid 111)
	id E235A1032F; Wed,  1 Feb 2012 15:03:45 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120201150345.E235A1032F@opal>
Date: Wed,  1 Feb 2012 15:03:45 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : fetch2/git: Add workaround for clone using alternates problem
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
X-List-Received-Date: Wed, 01 Feb 2012 15:11:20 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: d978e7b35550e3785c7c567ffe4c40a3c3947450
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=d978e7b35550e3785c7c567ffe4c40a3c3947450

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Tue Jan 31 14:09:24 2012 +0000

fetch2/git: Add workaround for clone using alternates problem

To quote my report of this to the git mailing list:
"""

I have a problem with git clone commands using alternates failing by
mixing up different repositories. I have a situation where I could end
up with both:

/srv/mirrors/repo
/srv/mirrors/repo.git

as bare clones.

I then try cloning "repo" with alternates with the command:

$ git clone -s -n /srv/mirrors/repo /tmp/foo
Cloning into /tmp/foo...
done.

$ cat /tmp/foo/.git/objects/info/alternates
/srv/mirrors/repo.git/objects

Note how I'm now referencing repo.git, not repo. This doesn't work as
expected giving some very bizarre results when actually using the
repository.

I appreciate this is a rather bizarre corner case but its one that is
breaking the build system I work with. Ideally people would use a
consistent URL for the same repository but we have an example where they
haven't and this really shouldn't break like this.

Looking at the code, the cause seems to be

clone.c:get_repo_path():
        static char *suffix[] = { "/.git", ".git", "" };

since its looking in order for:
 repo/.git (fails)
 repo.git (suceeds, incorrect)
 repo (never looked at)

I'm not sure what would break if that order were to change, swapping the
last two options.

I can "force" the issue by running:

git clone -s -n /srv/mirrors/repo/ /tmp/foo

but this results in the slightly odd looking:

$ cat /tmp/foo/.git/objects/info/alternates

/srv/mirrors/repo//objects

which does at least work.
"""

This patch adds the trailing slash to ensure the correct repository is
referenced at the expense of some ugliness in the alternates file.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/fetch2/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index d833714..fb0260a 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -220,7 +220,7 @@ class Git(FetchMethod):
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
 
-        runfetchcmd("git clone -s -n %s %s" % (ud.clonedir, destdir), d)
+        runfetchcmd("git clone -s -n %s/ %s" % (ud.clonedir, destdir), d)
         if not ud.nocheckout:
             os.chdir(destdir)
             if subdir != "":




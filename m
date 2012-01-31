Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RsEfi-0004NO-BY for bitbake-devel@lists.openembedded.org;
	Tue, 31 Jan 2012 15:26:59 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0VEJ2RA010048;
	Tue, 31 Jan 2012 14:19:02 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08817-06; Tue, 31 Jan 2012 14:18:59 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0VEIqCW010042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Jan 2012 14:18:54 GMT
Message-ID: <1328019536.13744.28.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 31 Jan 2012 14:18:56 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "Ashfield, Bruce" <Bruce.Ashfield@windriver.com>, "Hart,
	Darren" <darren.hart@intel.com>
Subject: [PATCH] fetch2/git: Add workaround for clone using alternates problem
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
X-List-Received-Date: Tue, 31 Jan 2012 14:26:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

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




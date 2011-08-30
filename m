Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QyVHe-0001RL-1x for bitbake-devel@lists.openembedded.org;
	Tue, 30 Aug 2011 22:51:46 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7UKksZe032160
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2011 21:46:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20955-06 for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2011 21:46:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7UKkjuX032113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2011 21:46:46 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 30 Aug 2011 21:46:32 +0100
Message-ID: <1314737192.5939.418.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/fetch2/git: Ensure .gitconfig file is ignored
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
X-List-Received-Date: Tue, 30 Aug 2011 20:51:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If a user has a ~/.gitconfig file, git fetch --all will reference it. To avoid
this we should run git fetch with an explicit url telling it to fetch all
references (which includes tags).

I'm assured this means git won't reference the file, see the discussion on the
git mailing list (subject Overriding ~/.gitconfig using GIT_CONFIG).

[YOCTO #1134]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 97bf086..ff7c33d 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -168,10 +168,11 @@ class Git(FetchMethod):
             os.chdir(ud.clonedir)
             runfetchcmd("tar -xzf %s" % (ud.fullmirror), d)
 
+        repourl = "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
-            clone_cmd = "%s clone --bare --mirror %s://%s%s%s %s" % \
-                  (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.clonedir)
+            clone_cmd = "%s clone --bare --mirror %s %s" % (ud.basecmd, repourl, ud.clonedir)
             bb.fetch2.check_network_access(d, clone_cmd)
             runfetchcmd(clone_cmd, d)
 
@@ -187,9 +188,9 @@ class Git(FetchMethod):
                 runfetchcmd("%s remote rm origin" % ud.basecmd, d) 
             except bb.fetch2.FetchError:
                 logger.debug(1, "No Origin")
-            
-            runfetchcmd("%s remote add --mirror origin %s://%s%s%s" % (ud.basecmd, ud.proto, username, ud.host, ud.path), d)
-            fetch_cmd = "%s fetch --all -t" % ud.basecmd
+
+            runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, repourl), d)
+            fetch_cmd = "%s fetch --prune %s refs/*:refs/*" % (ud.basecmd, repourl)
             bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             runfetchcmd(fetch_cmd, d)
             runfetchcmd("%s prune-packed" % ud.basecmd, d)





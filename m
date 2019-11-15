Return-Path: <ml@embed.me.uk>
X-Greylist: delayed 556 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 15 Nov 2019 09:47:12 UTC
Received: from g02sm02.soverin.net (unsecure-smtp.soverin.net [94.130.159.241])
	by mail.openembedded.org (Postfix) with ESMTP id B714C7FC16
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2019 09:47:12 +0000 (UTC)
Received: from soverin.net by soverin.net
From: ml@embed.me.uk
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Nov 2019 09:37:48 +0000
Message-Id: <20191115093748.61494-1-ml@embed.me.uk>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at g02sm02
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 20 Nov 2019 22:09:15 +0000
Cc: Jack Mitchell <jack@embed.me.uk>
Subject: [PATCH] fetch2/clearcase: fix python syntax warnings
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
X-List-Received-Date: Fri, 15 Nov 2019 09:47:13 -0000
Content-Transfer-Encoding: 8bit

From: Jack Mitchell <jack@embed.me.uk>

bitbake.git/lib/bb/fetch2/clearcase.py:148: SyntaxWarning: "is" with a literal. Did you mean "=="?
  if command is 'mkview':
bitbake.git/lib/bb/fetch2/clearcase.py:155: SyntaxWarning: "is" with a literal. Did you mean "=="?
  elif command is 'rmview':
bitbake.git/lib/bb/fetch2/clearcase.py:159: SyntaxWarning: "is" with a literal. Did you mean "=="?
  elif command is 'setcs':

Signed-off-by: Jack Mitchell <jack@embed.me.uk>
---
 lib/bb/fetch2/clearcase.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
index 3dd93ad6..e2934ef9 100644
--- a/lib/bb/fetch2/clearcase.py
+++ b/lib/bb/fetch2/clearcase.py
@@ -145,18 +145,18 @@ class ClearCase(FetchMethod):
 
         basecmd = "%s %s" % (ud.basecmd, command)
 
-        if command is 'mkview':
+        if command == 'mkview':
             if not "rcleartool" in ud.basecmd:
                 # Cleartool needs a -snapshot view
                 options.append("-snapshot")
             options.append("-tag %s" % ud.viewname)
             options.append(ud.viewdir)
 
-        elif command is 'rmview':
+        elif command == 'rmview':
             options.append("-force")
             options.append("%s" % ud.viewdir)
 
-        elif command is 'setcs':
+        elif command == 'setcs':
             options.append("-overwrite")
             options.append(ud.configspecfile)
 
-- 
2.24.0



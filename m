Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rep.dot.nop@gmail.com>) id 1Rss31-0004lJ-0V
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Feb 2012 09:29:39 +0100
Received: by werc1 with SMTP id c1so1829474wer.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Feb 2012 00:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
	bh=G5Cbp/y2D3Kz/Bw/mFW1k0JVnyIcQXcNOegrZOa1eNk=;
	b=MY3oo4XY01tcNqVOg3JIaveY0X09Jiu5Kfwjs8AZzUUB8leBgivQ9ELw3g8RF/noQT
	wekYpayrNbwCSr3I8B82AaP3n17l9ruMeoNAAaH4SBqERtFr+dKgbTQIXXloL/Dh7aJq
	3geJQzAoDbGkQwG0vIFwqdY0Vh/IoYCzFnv/A=
Received: by 10.216.134.37 with SMTP id r37mr715172wei.38.1328170903315;
	Thu, 02 Feb 2012 00:21:43 -0800 (PST)
Received: from s42.loc (85-127-19-201.dynamic.xdsl-line.inode.at.
	[85.127.19.201])
	by mx.google.com with ESMTPS id fr8sm4890775wib.10.2012.02.02.00.21.42
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 02 Feb 2012 00:21:42 -0800 (PST)
Received: from cow by s42.loc with local (Exim 4.77)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1RsrvJ-0003NO-S0; Thu, 02 Feb 2012 09:21:41 +0100
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Feb 2012 09:21:16 +0100
Message-Id: <1328170876-12909-2-git-send-email-rep.dot.nop@gmail.com>
X-Mailer: git-send-email 1.7.8.3
In-Reply-To: <1328170876-12909-1-git-send-email-rep.dot.nop@gmail.com>
References: <1328170876-12909-1-git-send-email-rep.dot.nop@gmail.com>
Subject: [PATCH] setup.py: Install concurrent too
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
X-List-Received-Date: Thu, 02 Feb 2012 08:29:39 -0000

I was getting:
Traceback (most recent call last):
  File "/scratch/src/oe/bitbake/build/scripts-2.7/bitbake", line 39, in <module>
    from bb import cooker
  File "/scratch/src/oe/bitbake/build/lib/bb/cooker.py", line 35, in <module>
    from concurrent import futures
ImportError: No module named concurrent
Command exited with non-zero status 1

Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
---
 setup.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/setup.py b/setup.py
index 3f9899e..e86ddd1 100755
--- a/setup.py
+++ b/setup.py
@@ -54,7 +54,8 @@ setup(name='bitbake',
       requires = ["ply", "progressbar", "futures"],
       package_dir = {"": "lib"},
       packages = ["bb.server", "bb.parse.parse_py", "bb.parse", "bb.fetch",
-                  "bb.fetch2", "bb.ui.crumbs", "bb.ui", "bb.pysh", "bb", "prserv"],
+                  "bb.fetch2", "bb.ui.crumbs", "bb.ui", "bb.pysh", "bb",
+                  "prserv", "concurrent", "concurrent.futures"],
       py_modules = ["codegen"],
       scripts = ["bin/bitbake", "bin/bitbake-layers", "bin/bitbake-diffsigs", "bin/bitbake-prserv"],
       data_files = [("share/bitbake", glob("conf/*") + glob("classes/*")),
-- 
1.7.8.3




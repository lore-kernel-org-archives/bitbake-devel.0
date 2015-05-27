Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C769772D64
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 16:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RGUlji024798 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:30:47 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kOl-6cDFtibu for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:30:47 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4RGUVtP024779
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 May 2015 17:30:42 +0100
Message-ID: <1432744231.404.50.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 May 2015 17:30:31 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] BBHandler: Drop cwd from search path
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
X-List-Received-Date: Wed, 27 May 2015 16:30:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Whilst bitbake has done this for a long time, the behaviour of resolving
class files against cwd is not desirable. This can be seen during
base configuration parsing when looking for base.bbclass where a dependency
on cwd is added. If cwd then changes, the cache is invalid and triggers a 
re-parse.

The only real option is to drop this entry and if files can't be found, we
fix BBPATH in the cases where it needs fixing. I didn't find any in the 
random selection of layers I tested parsing locally.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 56d4672..85c27c2 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -76,8 +76,7 @@ def inherit(files, fn, lineno, d):
             file = os.path.join('classes', '%s.bbclass' % file)
 
         if not os.path.isabs(file):
-            dname = os.path.dirname(fn)
-            bbpath = "%s:%s" % (dname, d.getVar("BBPATH", True))
+            bbpath = d.getVar("BBPATH", True)
             abs_fn, attempts = bb.utils.which(bbpath, file, history=True)
             for af in attempts:
                 if af != abs_fn:




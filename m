Return-Path: <Javier.Viguera@digi.com>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
	[216.82.251.6])
	by mail.openembedded.org (Postfix) with ESMTP id AA6327838B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Nov 2017 11:40:54 +0000 (UTC)
Received: from [216.82.249.147] by server-6.bemta-12.messagelabs.com id
	CD/A2-02224-7C55CF95; Fri, 03 Nov 2017 11:40:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRWlGSWpSXmKPExsXi5LtOQPdY6J9
	Ig9NvVSyuHw11YPQ4t3EFYwBjFGtmXlJ+RQJrxrY5vWwFz/kq3t3fz9zAOI2ni5GLQ0hgFaPE
	/Vt32CCc1YwSK6YuYYRw1jFKTNi3j6mLkZODTUBPYvKlJ8wgtoiAlkTP6bdAHRwcwgL+Ej/eq
	4CEWQRUJK52HWEDsXkFbCRWrXnCAmJLCMhLLP6+EyouKHFyJkScWUBC4uCLF2AjhYB6Dy69zA
	hTv2nzWfYJjLyzkLTMQtKygJFpFaN6cWpRWWqRrpFeUlFmekZJbmJmjq6hoZFebmpxcWJ6ak5
	iUrFecn7uJkZg8DAAwQ7GtjnOhxglOZiURHk9Q/5ECvEl5adUZiQWZ8QXleakFh9ilOHgUJLg
	XQCSEyxKTU+tSMvMAYYxTFqCg0dJhNcSJM1bXJCYW5yZDpE6xWjM0XHz7h8mjmczXzcwC7Hk5
	eelSonzxoKUCoCUZpTmwQ2CxdclRlkpYV5GoNOEeApSi3IzS1DlXzGKczAqCfPuAZnCk5lXAr
	fvFdApTECnzOYAO6UkESEl1cC4eu2W+zv0jYOvv4vzrp99W+DLnslPHFk/djGuL+jrEp8+i+V
	u5LuF4vMkZ39s+RBoJ77x4sLGLJ6bxh1qb1X/2L971HN05ftHLRKLFC9slzKxXSl4cv4iIdbl
	uwzLjl/iSZt04L1Y/H2DHHMT9/SmF8Hz3h3qYItTnn1DY9sL17edc5lbo7zVlFiKMxINtZiLi
	hMBMHe++KoCAAA=
X-Env-Sender: Javier.Viguera@digi.com
X-Msg-Ref: server-10.tower-29.messagelabs.com!1509709253!46725883!2
X-Originating-IP: [66.77.174.16]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11862 invoked from network); 3 Nov 2017 11:40:54 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
	by server-10.tower-29.messagelabs.com with SMTP;
	3 Nov 2017 11:40:54 -0000
Received: from MTK-SMS-XCH02.digi.com (10.10.8.196) by MCL-VMS-XCH01.digi.com
	(10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.361.1;
	Fri, 3 Nov 2017 06:40:53 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH02.digi.com
	(10.10.8.196) with Microsoft SMTP Server (TLS) id 14.3.361.1;
	Fri, 3 Nov 2017 06:40:52 -0500
Received: from log-cln-jviguera.digi.com (10.101.2.54) by
	dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
	14.3.361.1; Fri, 3 Nov 2017 12:40:50 +0100
From: Javier Viguera <javier.viguera@digi.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 3 Nov 2017 12:40:44 +0100
Message-ID: <20171103114044.25545-1-javier.viguera@digi.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
X-Originating-IP: [10.101.2.54]
Subject: [1.30][PATCH] Replace deprecated git branch parameter "--set-upstream"
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
X-List-Received-Date: Fri, 03 Nov 2017 11:40:54 -0000
Content-Type: text/plain

From: Andre Rosa <andre.rosa@lge.com>

Since 2017-08-17 (git version 2.14.1.473.g3ec7d702a) using deprecated
git branch parameter "--set-upstream" causes a fetcher error. Replace
it by "--set-upstream-to".

https://git.kernel.org/pub/scm/git/git.git/commit/?id=52668846ea2d41ffbd87cda7cb8e492dea9f2c4d
says, it's deprecated since 2012-08-30 so hopefully all still supported
host distributions have new enough git to support "--set-upstream-to".

ERROR: PACKAGE do_unpack: Fetcher failure: ...;
git -c core.fsyncobjectfiles=0 branch --set-upstream master origin/master failed with exit code 128, output:
fatal: the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead.

ERROR: PACKAGE do_unpack: Function failed: base_do_unpack

Signed-off-by: Andre Rosa <andre.rosa@lge.com>
Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 2ab50074c1a6c56a8a178755de108447d7b7acaf)
Signed-off-by: Javier Viguera <javier.viguera@digi.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 526668bc23c6..c226887a74ac 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -274,7 +274,7 @@ class Git(FetchMethod):
                 branchname =  ud.branches[ud.names[0]]
                 runfetchcmd("%s checkout -B %s %s" % (ud.basecmd, branchname, \
                             ud.revisions[ud.names[0]]), d)
-                runfetchcmd("%s branch --set-upstream %s origin/%s" % (ud.basecmd, branchname, \
+                runfetchcmd("%s branch %s --set-upstream-to origin/%s" % (ud.basecmd, branchname, \
                             branchname), d)
             else:
                 runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d)


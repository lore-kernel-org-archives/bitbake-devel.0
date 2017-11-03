Return-Path: <Javier.Viguera@digi.com>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
	[216.82.251.3])
	by mail.openembedded.org (Postfix) with ESMTP id 0D60B6FFFE
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Nov 2017 11:40:23 +0000 (UTC)
Received: from [216.82.251.44] by server-3.bemta-12.messagelabs.com id
	15/5B-02038-9A55CF95; Fri, 03 Nov 2017 11:40:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeJIrShJLcpLzFFi42Jx8l0noLsy9E+
	kwbIPjBbXj4Y6MHqc27iCMYAxijUzLym/IoE1Y2pXC3PBc76KndeOMzYwTuPpYuTiEBJYySjR
	M+MHE4SzjlHizdZNQA4nB5uAnsTkS0+YQWwRAS2JntNv2UBsYQF/idUrPoLFWQRUJCa9mcMIY
	vMK2EgsnveFBcSWEJCXWPx9JxtEXFDi5MwnYHFmAQmJgy9egPUKAfUeXHqZEaZ+0+az7BMYeW
	YhaZmFpGUBI9MqRo3i1KKy1CJdEwu9pKLM9IyS3MTMHF1DQyO93NTi4sT01JzEpGK95PzcTYz
	AMKlnYGDcwfhpf/QhRkkOJiVRXs+QP5FCfEn5KZUZicUZ8UWlOanFhxhlODiUJHj5gGEnJFiU
	mp5akZaZAwxYmLQEB4+SCO8HkFbe4oLE3OLMdIjUKUZjjo6bd/8wcTyb+bqBWYglLz8vVUqc9
	xFIqQBIaUZpHtwgWCRdYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMuwdkCk9mXgncvldApz
	ABnTKbA+yUkkSElFQDY+WNGefDbeXuC52fLlqyYfeB0nvLuWYs17s1y6xfcuWk9ADB6dJCseb
	LJ8mfzLir9SfsfNsOL9dTx7fdrCpIkxLraGhakT7RUYZ3yZX3804lr7f3mhXMKhK+X654rcTH
	ExN7ChLFFEpWTQnn4ur+XvpEZY/3p/fK//ZJ/lIwXuDWZu33w7UhXomlOCPRUIu5qDgRANuEx
	fqfAgAA
X-Env-Sender: Javier.Viguera@digi.com
X-Msg-Ref: server-13.tower-200.messagelabs.com!1509709224!38597245!1
X-Originating-IP: [66.77.174.16]
X-StarScan-Received: 
X-StarScan-Version: 9.4.45; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20885 invoked from network); 3 Nov 2017 11:40:24 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
	by server-13.tower-200.messagelabs.com with SMTP;
	3 Nov 2017 11:40:24 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
	(10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.361.1;
	Fri, 3 Nov 2017 06:40:22 -0500
Received: from log-cln-jviguera.digi.com (10.101.2.54) by
	dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
	14.3.361.1; Fri, 3 Nov 2017 12:40:20 +0100
From: Javier Viguera <javier.viguera@digi.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 3 Nov 2017 12:40:14 +0100
Message-ID: <20171103114014.25478-1-javier.viguera@digi.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
X-Originating-IP: [10.101.2.54]
Subject: [1.28][PATCH] Replace deprecated git branch parameter "--set-upstream"
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
X-List-Received-Date: Fri, 03 Nov 2017 11:40:24 -0000
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
index 9bd87ad25cc3..5ac7e9ad4106 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -289,7 +289,7 @@ class Git(FetchMethod):
                 branchname =  ud.branches[ud.names[0]]
                 runfetchcmd("%s checkout -B %s %s" % (ud.basecmd, branchname, \
                             ud.revisions[ud.names[0]]), d)
-                runfetchcmd("%s branch --set-upstream %s origin/%s" % (ud.basecmd, branchname, \
+                runfetchcmd("%s branch %s --set-upstream-to origin/%s" % (ud.basecmd, branchname, \
                             branchname), d)
             else:
                 runfetchcmd("%s checkout %s" % (ud.basecmd, ud.revisions[ud.names[0]]), d)


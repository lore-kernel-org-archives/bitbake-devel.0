Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 19B23758DB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 13:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8TD8Fer003526 for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 14:08:15 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id a_MPkKlLvsFq for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 14:08:15 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8TD7xvt003519
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 14:08:10 +0100
Message-ID: <1443532079.5162.28.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 29 Sep 2015 14:07:59 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] cookerdata: Rename BBPKGS -> BBTARGETS
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
X-List-Received-Date: Tue, 29 Sep 2015 13:08:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

BBPKGS is a confusing name from before we tried to straighten out our
terminology. Its also a mostly unknown variable that isn't in wide use.

I've been asked about it recently and before people start relying more
heavily on it, I'd like to rename it BBTARGETS which better describes
what it does. Its not currently in the manuals, I'd prefer to document
it under the better name. I've not provided any migration path for the
variable since I believe its unused currently.

It allows the targets to built to be specified from a conf file in
addition to those on the commandline.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index f19c283..a3fa552 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -63,9 +63,9 @@ class ConfigParameters(object):
             raise Exception("Unable to set configuration option 'cmd' on the server: %s" % error)
 
         if not self.options.pkgs_to_build:
-            bbpkgs, error = server.runCommand(["getVariable", "BBPKGS"])
+            bbpkgs, error = server.runCommand(["getVariable", "BBTARGETS"])
             if error:
-                raise Exception("Unable to get the value of BBPKGS from the server: %s" % error)
+                raise Exception("Unable to get the value of BBTARGETS from the server: %s" % error)
             if bbpkgs:
                 self.options.pkgs_to_build.extend(bbpkgs.split())
 




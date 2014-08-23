Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C1C0362252
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Aug 2014 08:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7N8MaCg011276 for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Aug 2014 09:22:36 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kRb-AQaFpJh3 for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Aug 2014 09:22:36 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7N8MYpg011268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Aug 2014 09:22:35 +0100
Message-ID: <1408782155.5457.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 23 Aug 2014 09:22:35 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] siggen: Fix a subtle bug in hash calculation for shared work tasks
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
X-List-Received-Date: Sat, 23 Aug 2014 08:22:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


With a shared work task like gcc, the task can be run from a variety of
different recipes which may have different virtual extensions in place.

Depending on whether gcc-runtime or nativesdk-gcc-runtime's do_preconfigure
task is called for example will change the sorting of the task hashes due
to the way clean_basename currently works.

The correct thing to do here is sort on the base filename first, then any
extension when ordering the hashes. This means we do account for things
like recipes with both a native and non-native dependency but we also fix
the shared work case where we don't care whether it was a virtual version
or not.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 933311c..548f50d 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -295,7 +295,7 @@ def dump_this_task(outfile, d):
 
 def clean_basepath(a):
     if a.startswith("virtual:"):
-        b = a.rsplit(":", 1)[0] + ":" + a.rsplit("/", 1)[1]
+        b = a.rsplit("/", 1)[1] + ":" + a.rsplit(":", 1)[0]
     else:
         b = a.rsplit("/", 1)[1]
     return b




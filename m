Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4947B73694
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jul 2015 11:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6LBHKeh018203 for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jul 2015 12:17:20 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JGSp97LteyzQ for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jul 2015 12:17:20 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6LBH7H7018177
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jul 2015 12:17:19 +0100
Message-ID: <1437477427.821.70.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 21 Jul 2015 12:17:07 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Use deepcopy for overridedata
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
X-List-Received-Date: Tue, 21 Jul 2015 11:17:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

dbus sets RDEPENDS_dbus-ptest_class-target = "X". nativesdk as
BBCLASSEXTEND was expanding and setting various RDEPENDS variables
which were clearing overrides queued against RDEPENDS. The problem
was that this was leaking into other data contexts such as the
target case. This was because overridedata was a shallow copy.

Replacing the shallow copy with a deep copy avoids this problem of
leakage between the data stores at a small performance penalty.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index dcf082d..86cdeb5 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -806,7 +806,7 @@ class DataSmart(MutableMapping):
 
         data.overrides = None
         data.overridevars = copy.copy(self.overridevars)
-        data.overridedata = copy.copy(self.overridedata)
+        data.overridedata = copy.deepcopy(self.overridedata)
 
         return data
 




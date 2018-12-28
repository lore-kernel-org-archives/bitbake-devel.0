Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id B05226C4E7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Dec 2018 17:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 8BD0818441;
	Fri, 28 Dec 2018 18:32:16 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id XEJRjCFVjI_E; Fri, 28 Dec 2018 18:32:16 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 00DED183A9;
	Fri, 28 Dec 2018 18:32:16 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D395D1E076;
	Fri, 28 Dec 2018 18:32:15 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 689391E07A;
	Fri, 28 Dec 2018 18:31:21 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP;
	Fri, 28 Dec 2018 18:31:21 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 5C77C2310;
	Fri, 28 Dec 2018 18:31:21 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id wBSHVKlV026124;
	Fri, 28 Dec 2018 18:31:20 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id wBSHVKaK026123;
	Fri, 28 Dec 2018 18:31:20 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Dec 2018 18:30:40 +0100
Message-Id: <20181228173040.26029-2-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20181228173040.26029-1-pkj@axis.com>
References: <20181228173040.26029-1-pkj@axis.com>
X-TM-AS-GCONF: 00
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] bitbake-diffsigs: Support recursive deps with signature files
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
X-List-Received-Date: Fri, 28 Dec 2018 17:32:16 -0000

Follow dependent hash changes recursively also when specifying two
signature files explicitly. Previously this was only done when using the
--task option.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/bin/bitbake-diffsigs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index b0869e1143..fa430bb3b3 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -188,7 +188,9 @@ else:
         sys.exit(1)
     try:
         if not options.dump and options.sigdatafile1 and options.sigdatafile2:
-            output = bb.siggen.compare_sigfiles(options.sigdatafile1, options.sigdatafile2, color=color)
+            with bb.tinfoil.Tinfoil() as tinfoil:
+                tinfoil.prepare(config_only=True)
+                output = bb.siggen.compare_sigfiles(options.sigdatafile1, options.sigdatafile2, recursecb, color=color)
         elif options.sigdatafile1:
             output = bb.siggen.dump_sigfile(options.sigdatafile1)
         else:
-- 
2.12.0



Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D3BAA6AC7B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 05:39:04 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s645d6VL008823
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 Jul 2014 22:39:06 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.169.1;
	Thu, 3 Jul 2014 22:39:06 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 3 Jul 2014 22:39:05 -0700
Message-ID: <29052f940ce9526083a09d3ce4e665a5aa9e0db1.1404452300.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1404452300.git.liezhi.yang@windriver.com>
References: <cover.1404452300.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake-user-manual-intro.xml: update for dump-signatures
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
X-List-Received-Date: Fri, 04 Jul 2014 05:39:05 -0000
Content-Type: text/plain

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 .../bitbake-user-manual-intro.xml                  |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index ae267b4..e4025a8 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -471,11 +471,13 @@
        -D, --debug           Increase the debug level. You can specify this more
                              than once.
        -n, --dry-run         Don't execute, just go through the motions.
-       -S DUMP_SIGNATURES, --dump-signatures=DUMP_SIGNATURES
+       -S SIGNATURE_HANDLER, --dump-signatures=SIGNATURE_HANDLER
                              Dump out the signature construction information, with
-                             no task execution. Parameters are passed to the
-                             signature handling code, use 'none' if no specific
-                             handler is required.
+                             no task execution. The SIGNATURE_HANDLER can be none
+                             or printdiff, while none means only dump the
+                             signature, printdiff means compare the dumped
+                             signature with the cached one.
+
        -p, --parse-only      Quit after parsing the BB recipes.
        -s, --show-versions   Show current and preferred versions of all recipes.
        -e, --environment     Show the global or per-package environment complete
-- 
1.7.9.5



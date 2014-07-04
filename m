Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 899986AC7B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 05:39:04 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s645d5XX019278
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 Jul 2014 22:39:05 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.169.1;
	Thu, 3 Jul 2014 22:39:05 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 3 Jul 2014 22:39:04 -0700
Message-ID: <c16e5647966901f79b9520ba0565220ebcd0fa3d.1404452300.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1404452300.git.liezhi.yang@windriver.com>
References: <cover.1404452300.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] bitbake: update help message for dump-signatures
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
X-List-Received-Date: Fri, 04 Jul 2014 05:39:04 -0000
Content-Type: text/plain

The bitbake -S had been updated which always reuires an argument, so
update the help info:
- Add the two args in the help message: none and printdiff

- Use type="choice" so that we can get more friendly error messages,
  for example:
  bitbake: error: option -S: invalid choice: 'printdiffX' (choose from 'none', 'printdiff')

- dump-signatures=DUMP_SIGNATURES -> dump-signatures=SIGNATURE_HANDLER

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index b3acbe1..5c25a9d 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -139,8 +139,8 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-n", "--dry-run", help = "Don't execute, just go through the motions.",
                    action = "store_true", dest = "dry_run", default = False)
 
-        parser.add_option("-S", "--dump-signatures", help = "Dump out the signature construction information, with no task execution. Parameters are passed to the signature handling code, use 'none' if no specific handler is required.",
-                   action = "append", dest = "dump_signatures", default = [])
+        parser.add_option("-S", "--dump-signatures", help = "Dump out the signature construction information, with no task execution. The SIGNATURE_HANDLER can be none or printdiff, while none means only dump the signature, printdiff means compare the dumped signature with the cached one.",
+                   action = "append", dest = "dump_signatures", default = [], type="choice", choices=("none", "printdiff"), metavar="SIGNATURE_HANDLER")
 
         parser.add_option("-p", "--parse-only", help = "Quit after parsing the BB recipes.",
                    action = "store_true", dest = "parse_only", default = False)
-- 
1.7.9.5



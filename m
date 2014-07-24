Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id B164F707D4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Jul 2014 08:22:43 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s6O8MhjV022241
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Jul 2014 01:22:44 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.169.1;
	Thu, 24 Jul 2014 01:22:43 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 Jul 2014 01:22:42 -0700
Message-ID: <43deea90c1d8d3d4a1e41b61fbbe1412951f1eb0.1406189837.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1406189837.git.liezhi.yang@windriver.com>
References: <cover.1406189837.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: remove choices for dump-signatures
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
X-List-Received-Date: Thu, 24 Jul 2014 08:22:52 -0000
Content-Type: text/plain

The SIGNATURE_HANDLER can be defined by the user, so we can't use choices.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 39aa3ec..b8acd6e 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -140,7 +140,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                    action = "store_true", dest = "dry_run", default = False)
 
         parser.add_option("-S", "--dump-signatures", help = "Dump out the signature construction information, with no task execution. The SIGNATURE_HANDLER parameter is passed to the handler. Two common values are none and printdiff but the handler may define more/less. none means only dump the signature, printdiff means compare the dumped signature with the cached one.",
-                   action = "append", dest = "dump_signatures", default = [], type="choice", choices=("none", "printdiff"), metavar="SIGNATURE_HANDLER")
+                   action = "append", dest = "dump_signatures", default = [], metavar="SIGNATURE_HANDLER")
 
         parser.add_option("-p", "--parse-only", help = "Quit after parsing the BB recipes.",
                    action = "store_true", dest = "parse_only", default = False)
-- 
1.7.9.5



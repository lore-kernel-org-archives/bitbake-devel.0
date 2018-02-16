Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 63EE56FFCD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Feb 2018 04:44:53 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w1G4isL8017906
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Feb 2018 20:44:55 -0800
Received: from dreyna-Precision-T5600.corp.ad.wrs.com (147.11.200.210) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Thu, 15 Feb 2018 20:44:40 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 15 Feb 2018 20:26:01 -0800
Message-ID: <8b13dce6692fcf4469a117276e5dd6374cc59860.1518754951.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1518754951.git.David.Reyna@windriver.com>
References: <cover.1518754951.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.200.210]
Subject: [PATCH 1/2] toaster: do not fail on optional 'custom.xml' file
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
X-List-Received-Date: Fri, 16 Feb 2018 04:44:53 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Explicitly capture and ignore errors when trying to load the optional
'custom.xml' fixture file.

[YOCTO #12554]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/management/commands/checksettings.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 582114a..823c6f1 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -107,7 +107,10 @@ class Command(BaseCommand):
                                 action="ignore",
                                 message="^.*No fixture named.*$")
                             print("Importing custom settings if present")
-                            call_command("loaddata", "custom")
+                            try:
+                                call_command("loaddata", "custom")
+                            except:
+                                print("NOTE: optional fixture 'custom' not found")
 
                         # we run lsupdates after config update
                         print("\nFetching information from the layer index, "
-- 
2.7.4



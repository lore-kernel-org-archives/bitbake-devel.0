Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id B893974744
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 May 2018 03:31:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w4T3Vxt3014297
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 May 2018 20:32:00 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Mon, 28 May 2018 20:31:59 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 28 May 2018 20:26:57 -0700
Message-ID: <edf8c162e67fb734b25b8802d001b604b4188550.1527564213.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1527564213.git.David.Reyna@windriver.com>
References: <cover.1527564213.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 1/2] bitbake: toaster: do not fail on optional 'custom.xml' file
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
X-List-Received-Date: Tue, 29 May 2018 03:32:00 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Explicitly capture and ignore errors when trying to load the optional
'custom.xml' fixture file.

[YOCTO #12554]

(Bitbake rev: 132458939d3987ebc58685397714af3d6d5cd8fd)

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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
1.9.1



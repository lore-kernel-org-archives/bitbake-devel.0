Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 29EF2781C2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Sep 2017 04:10:39 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v844AeXO024242
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 3 Sep 2017 21:10:41 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sun, 3 Sep 2017 21:10:40 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 3 Sep 2017 21:02:21 -0700
Message-ID: <6c9a8f71644c7fdfe6766d311064c8889f311280.1504496902.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1504496902.git.David.Reyna@windriver.com>
References: <cover.1504496902.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/3] toaster: missing ToasterSetting import
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
X-List-Received-Date: Mon, 04 Sep 2017 04:10:40 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

The file "lsupdates.py" is missing the import of 'ToasterSetting',
and that breaks setting up and updating Toaster and its database.

[YOCTO #12036]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/management/commands/lsupdates.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index fac5733..54b4fab 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -24,6 +24,7 @@ from django.core.management.base import BaseCommand
 from orm.models import LayerSource, Layer, Release, Layer_Version
 from orm.models import LayerVersionDependency, Machine, Recipe
 from orm.models import Distro
+from orm.models import ToasterSetting
 
 import os
 import sys
-- 
1.9.1



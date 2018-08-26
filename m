Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id CB88179392
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 22:36:55 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w7QMavfO024343
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Aug 2018 15:36:57 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 26 Aug 2018 15:36:56 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 26 Aug 2018 15:33:29 -0700
Message-ID: <c25e1ccf6c3cc0a60ec04fef485da151b6fb14e7.1535322629.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535322629.git.David.Reyna@windriver.com>
References: <cover.1535322629.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 6/9] toaster/checksettings: allow CUSTOM_XML_ONLY setting through env
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
X-List-Received-Date: Sun, 26 Aug 2018 22:36:56 -0000
Content-Type: text/plain

From: Awais Belal <awais_belal@mentor.com>

This change allows the CUSTOM_XML_ONLY toaster setting to be
provided through the environment so the user can do this without
mingling with the settings.xml, for scenarios where modifying
settings.xml is not achievable.

[YOCTO #12891]

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/management/commands/checksettings.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 823c6f1..14298d9 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -74,8 +74,9 @@ class Command(BaseCommand):
                         print("Loading default settings")
                         call_command("loaddata", "settings")
                         template_conf = os.environ.get("TEMPLATECONF", "")
+                        custom_xml_only = os.environ.get("CUSTOM_XML_ONLY")
 
-                        if ToasterSetting.objects.filter(name='CUSTOM_XML_ONLY').count() > 0:
+                        if ToasterSetting.objects.filter(name='CUSTOM_XML_ONLY').count() > 0 or (not custom_xml_only == None):
                             # only use the custom settings
                             pass
                         elif "poky" in template_conf:
-- 
1.9.1



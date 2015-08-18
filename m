Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id F400E76A11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:29:05 +0000 (UTC)
Received: by wibhh20 with SMTP id hh20so113619249wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=0wY6Y3dzQ6XGAZA1uigU5Jho5C5YktbPS2Hii2nkTVU=;
	b=BhfRoqUSdDRYs5a0lLPugtNiJOmJ+XRtjURPHUaH4GvIT7BiSf0+C/+sPk2o4Psgzw
	rM90KKp3d0iPT1sBMYfmYpa9OShz2QcSyg2vfTLFY3oU+cMU1t2kNeFOtJejcZAjP1zq
	0z+6PDPKu1LVRFy5IWy12EnDmCONC5WPUwOls0C1ECS0B5Pm+QxT6W4bHOeMHSYNDg+T
	W3YPCdeVekP8e5JwcATQL8jhiI9spq2vdQcd8y78XgeUUBFJEvQuPTf/FZQi+tkTrOKY
	+0xKI6VKU6n/H1mXAX89IpupkP/S4WrE9gBZdg85fXFc0XthL1SmMNeioM+AYG6y0+s6
	qujA==
X-Gm-Message-State: ALoCoQkfnpwIaGfa5RF2VEnCDsDiCYg0JzAhWYlCTqF2TUccdY4H1MnK4Lou2EQi5k5yzzPMdoxg
X-Received: by 10.194.184.232 with SMTP id ex8mr15005625wjc.42.1439915345753; 
	Tue, 18 Aug 2015 09:29:05 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	m4sm27105267wjb.37.2015.08.18.09.29.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:29:05 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:48 +0100
Message-Id: <6f0b90695fda95b68886a7ce1b2f6262ae0002a2.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
	<1fe62e1463b715f7631e925ddea135a7b8dd2f6b.1439915029.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439915029.git.michael.g.wood@intel.com>
References: <cover.1439915029.git.michael.g.wood@intel.com>
Subject: [PATCH 02/14] bitbake: toaster: checksettings: fix guesspath initialization
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
X-List-Received-Date: Tue, 18 Aug 2015 16:29:06 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Object fields need to be instantiated in the constructor.
Fixed prompted by pylint.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/management/commands/checksettings.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 508335f..2978db2 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -17,6 +17,9 @@ class Command(NoArgsCommand):
     args = ""
     help = "Verifies that the configured settings are valid and usable, or prompts the user to fix the settings."
 
+    def __init__(self, *args, **kwargs):
+        super(Command, self).__init__(*args, **kwargs)
+        self.guesspath = DN(DN(DN(DN(DN(DN(DN(__file__)))))))
 
     def _find_first_path_for_file(self, startdirectory, filename, level = 0):
         if level < 0:
@@ -83,7 +86,6 @@ class Command(NoArgsCommand):
 
 
     def _verify_build_environment(self):
-        self.guesspath = DN(DN(DN(DN(DN(DN(DN(__file__)))))))
         # refuse to start if we have no build environments
         while BuildEnvironment.objects.count() == 0:
             print(" !! No build environments found. Toaster needs at least one build environment in order to be able to run builds.\n" +
-- 
2.1.4



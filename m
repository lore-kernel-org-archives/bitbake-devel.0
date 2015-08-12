Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 895EE76777
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 10:33:49 +0000 (UTC)
Received: by wijp15 with SMTP id p15so211720448wij.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 03:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Tl0VZQUDmOaHlRBSRSHannHVoxBiboRamtcAoUzfXeM=;
	b=Bt1jF1ZHnanaX3iGF4ZXIkM/LTwJy2KBJ411uiddvyyP6VqG3VugbWXYpR0NsJOX2N
	QE2lYCqwbmD9tj0fVAeJCBtaAeoXWeBhsCOZ15nrRxTNzbGEMGFlqV9AOnxzHeKFVoNh
	t+3Mz6d9xH5B7851D7hotPla7JexWmaMu2KJwST+XFGcPULXeXxQo0VNCPcQ4R2XIqJG
	me8R+dvUz+V5ximqSkr00CVDyLtuDSZCI5PrBYnBGWamyck0cg0bwVU/Q/nBUs1s+uIU
	pHduO5G+NhntvIzm03JmSb6Ul8/5SWb6JFCvPgzK3Q9efp9Hdnt4qZ4WE9PaVZESU7mr
	CpdQ==
X-Gm-Message-State: ALoCoQkYhlOWRSJ0OSp12jDqx2OWWly8N3zz02HwIL7mgefiyCWStzx1Tc9H3c10Ry3xjXctpiDr
X-Received: by 10.180.221.140 with SMTP id qe12mr5877290wic.54.1439375629224; 
	Wed, 12 Aug 2015 03:33:49 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id wx9sm7262934wjb.6.2015.08.12.03.33.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 12 Aug 2015 03:33:48 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Aug 2015 11:33:42 +0100
Message-Id: <a77a9b3c3d6a971349ce6068fb7f91115e70bdcf.1439375393.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1439375393.git.michael.g.wood@intel.com>
References: <cover.1439375393.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439375393.git.michael.g.wood@intel.com>
References: <cover.1439375393.git.michael.g.wood@intel.com>
Subject: [PATCH 1/2] Fix typo in set up script output
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
X-List-Received-Date: Wed, 12 Aug 2015 10:33:51 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Removing an spurious 'it' when setting the
build directory. Thanks to Scott Rifenbark for
finding the typo!

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/management/commands/checksettings.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 3002e4c..9a508b4 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -133,7 +133,7 @@ class Command(NoArgsCommand):
                 def _update_builddir():
                     suggesteddir = self._get_suggested_builddir(be)
                     if len(suggesteddir) > 0:
-                        be.builddir = raw_input("Toaster needs to know where it your build directory is located.\n The build directory is where all the artifacts created by your builds will be stored. Toaster suggests \"%s\".\n Press Enter to select \"%s\" or type the full path to a different directory: " % (suggesteddir, suggesteddir))
+                        be.builddir = raw_input("Toaster needs to know where your build directory is located.\n The build directory is where all the artifacts created by your builds will be stored. Toaster suggests \"%s\".\n Press Enter to select \"%s\" or type the full path to a different directory: " % (suggesteddir, suggesteddir))
                     else:
                         be.builddir = raw_input("Toaster needs to know where is your build directory.\n The build directory is where all the artifacts created by your builds will be stored. Type the full path to the directory (for example: \" %s/build\")" % os.environ.get('HOME','/tmp/'))
                     if len(be.builddir) == 0 and len(suggesteddir) > 0:
-- 
2.1.4



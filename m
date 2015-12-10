Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f170.google.com (mail-pf0-f170.google.com
	[209.85.192.170])
	by mail.openembedded.org (Postfix) with ESMTP id 98148606A8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:01 +0000 (UTC)
Received: by pfdd184 with SMTP id d184so40697223pfd.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=rtDhoVKN/NCZhBFDu+sEpcO/sT3qpclcWis0PE6HYrw=;
	b=iKua9PAV2/blK6tKzhAonSWQQgLK4M3zU8HgtuNSQnDwlhqsTTeBoCk5QMxuTRN9cX
	8zbedVmJS2a5t1n8d7aUmLnXvYwoxHU1tZmI6l9lUhE27fnY4JVH1M7um06KnwQ8gZMV
	en53zIzXVTYy985n4n7sosalESrAcBrCTK0BUnOEvWO6m/lngksRJ28iux3w188vXY5o
	RuSJH/v6hUj+At99PNWS970P1l4qZCW8zYi8oDoPdP48psoT7Y47dhFFVEA+IyJto/qP
	6ywVAmF2zDlbgmDxJcYFpQ/H1mAnBqkWsa62WHeh8oY9XPjE2yv+Kk9OXiif20p77iKa
	SoDA==
X-Received: by 10.98.8.3 with SMTP id c3mr3554165pfd.89.1449719581993;
	Wed, 09 Dec 2015 19:53:01 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:01 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:28 -0800
Message-Id: <794096c1b434adbb68706e5732891ec91aecfe01.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 03/18] toaster: Fix references to app paths
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:01 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

The buildinfohelper runs outside of Django, but still needs
access to our Django app classes.

Previously, the imports referenced the toaster.* app, which worked
fine. But in Django 1.8, this causes an error about the same
module being loaded multiple times from different paths.

Change the paths to our Django modules so they don't cause
this error to be thrown. We can do this as we've added our
application libraries to sys.path in the buildinfohelper anyway.

[YOCTO #8364]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 1d41bba..c099551 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -33,14 +33,14 @@ def _configure_toaster():
     sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'toaster'))
 _configure_toaster()
 
-from toaster.orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage, HelpText
-from toaster.orm.models import Target_Image_File, BuildArtifact
-from toaster.orm.models import Variable, VariableHistory
-from toaster.orm.models import Package, Package_File, Target_Installed_Package, Target_File
-from toaster.orm.models import Task_Dependency, Package_Dependency
-from toaster.orm.models import Recipe_Dependency
-
-from toaster.orm.models import Project
+from orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage, HelpText
+from orm.models import Target_Image_File, BuildArtifact
+from orm.models import Variable, VariableHistory
+from orm.models import Package, Package_File, Target_Installed_Package, Target_File
+from orm.models import Task_Dependency, Package_Dependency
+from orm.models import Recipe_Dependency
+
+from orm.models import Project
 from bldcontrol.models import BuildEnvironment, BuildRequest
 
 from bb.msg import BBLogFormatter as formatter
-- 
1.9.1



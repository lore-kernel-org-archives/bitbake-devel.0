Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
	[209.85.192.182])
	by mail.openembedded.org (Postfix) with ESMTP id 39F26606A8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 03:53:02 +0000 (UTC)
Received: by pfnn128 with SMTP id n128so40736609pfn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Dec 2015 19:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=orUNXOnI9ZYH+vuzxj8accy5hkFgBq7Nig6rYFZjIrk=;
	b=rDpcz8S1fwCTyJTXFHvmyMoqSi/PEKAMtK2Qa3Cpy18KgFPX76HeCDgu5ohjkEQmVu
	7DexBv+eYCoZO22ip7KpUfzt852qNsYVatnIdLP95evgAalPVyQihv+cX5ynZwom8gKo
	6A0fz05TcK8UX/Vb0lAkEMvaM2SfENZ1m93Nh+0RfSfja2Z7hswJfBter3vZ50rJvuj/
	Qhzin4Mp9JHZQXyPfepfQGI/ae8oIXFyBzuNfgVgc64kZp0n9Oy2X50SaJRF8UrMdL42
	9v9R2ugV7hHnktB1ZUCkrLpPGcgmJy9E+6zLcSNmJO7Xnf6dWFYyYRfFaizs8Qs07ozN
	F8+g==
X-Received: by 10.98.13.211 with SMTP id 80mr3542083pfn.112.1449719583828;
	Wed, 09 Dec 2015 19:53:03 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	c20sm14761349pfd.17.2015.12.09.19.53.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 09 Dec 2015 19:53:03 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Dec 2015 19:56:30 -0800
Message-Id: <a08061f287d0f07a2e602e23fcab90d3985670fe.1449719707.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
References: <f49f7e1b41ee18a9959be3f3e12856980d58a18b.1449719707.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449719707.git.avery.brian@gmail.com>
References: <cover.1449719707.git.avery.brian@gmail.com>
Subject: [PATCH 05/18] toaster: Start Django machinery for database access
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
X-List-Received-Date: Thu, 10 Dec 2015 03:53:03 -0000

From: Elliot Smith <elliot.smith@intel.com>

buildinfohelper, with the new import paths for our Django models
and Django 1.8, was not getting an active connection to the database.

In buildinfohelper, call django.setup() explicitly to make sure
that the database connection is ready and models can be queried
and saved.

[YOCTO #8364]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 87e03e7..04ce23a 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -24,6 +24,7 @@ import os
 os.environ["DJANGO_SETTINGS_MODULE"] = "toaster.toastermain.settings"
 
 
+import django
 from django.utils import timezone
 
 
@@ -33,6 +34,8 @@ def _configure_toaster():
     sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'toaster'))
 _configure_toaster()
 
+django.setup()
+
 from orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage, HelpText
 from orm.models import Target_Image_File, BuildArtifact
 from orm.models import Variable, VariableHistory
-- 
1.9.1



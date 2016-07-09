Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id 3455E607A4
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Jul 2016 00:52:54 +0000 (UTC)
Received: by mail-pa0-f68.google.com with SMTP id dx3so8949712pab.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jul 2016 17:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=obVN/zN4SbalXS1hWjqffKN3LtXusus2mKzcZscSLRw=;
	b=uPDGMnkAZJUiJkYZKkfkqlfpoy6qUsiAHLltdXre9O5JPBRw5OpDTh23Mv2H4PHqlu
	vHM1X0QYaomlcgZC6fLBSZPk1fsOQVoO6m8jbPTy00sQo/kh1SRmzJcgokef7kJYXr21
	wvQGKRtwc+76QelrJrV9Z59LE+4YTJYKtPrbz+YsfWpVeLoUmYCALK1wTyE0zI3IHHCR
	A5vdL65UiFkQwB4RIN69PcgndNOVx2MiADlwhVUyZJ8Z96OtvX4FKp/1LvuX27eNeRcm
	swndE+LnFU+luRlkjWIyncjRrllG6JRAlHh8b4HxPcSmJgTToJVW3MQeT+N94cEeo792
	XaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=obVN/zN4SbalXS1hWjqffKN3LtXusus2mKzcZscSLRw=;
	b=D+FHI1sin6oJjbGcuCZLvvsc4+QmZ6UO4U20J7g4WX3ST4Lt8P8a17XNCJYj27MeR3
	59JnMA4FEhHuXAAgVUic74hBmgOLQzPRDRLselB4T7rrJYAA8UptiDeSThBn6a/htPUj
	BFi+f5qBLlG2tJWFncCsYxnqGDHJgDldE/sy4JggK0rf5KyTo91TkSG4Y7d28Kufnbee
	NVRjLXCTCqyYvonlLfdda2FuIODQhnA9uLvcvmH/G9QAIVPeP5oerdS1QMwUB394ISuy
	I5jSw61841kMpy5k3vAqIa1yru7Av28S6MJq6smLkJ49bCbfZjuR7VNUy7XLPUMM9ELG
	gq+g==
X-Gm-Message-State: ALyK8tJ+sb6Rr0jcs1jS/oAJvyfykP1JSKO5mR+bodgBKBHhN1bxyvPQCWaWAo8Nk+tb9w==
X-Received: by 10.66.52.11 with SMTP id p11mr14423387pao.155.1468025575048;
	Fri, 08 Jul 2016 17:52:55 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id bm8sm213836pad.10.2016.07.08.17.52.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 08 Jul 2016 17:52:54 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jul 2016 17:52:46 -0700
Message-Id: <b0b46f566ffda1c686e32df3aaf04fcb224df2e8.1468024992.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
References: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
In-Reply-To: <cover.1468024992.git.brian.avery@intel.com>
References: <cover.1468024992.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 6/7] buildinfohelper: fix retrieval of targets
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
X-List-Received-Date: Sat, 09 Jul 2016 00:52:54 -0000

From: Elliot Smith <elliot.smith@intel.com>

When buildinfohelper records the targets for a build, it looks
up any existing targets for a build and creates them if they
are not present. This is because in the case of Toaster-triggered
builds, the Target objects have already been created (inside
triggerBuild()) and don't need to be recreated; but in the case
of cli builds, the Target objects have to be created by
buildinfohelper.

The issue is that the code for retrieving an existing target for
a build only looks for Targets with a matching target and build,
e.g. Targets for build X with target "core-image-minimal". But it
is perfectly legitimate to call bitbake with a command like
"bitbake core-image-minimal:do_populate_sdk
core-image-minimal:do_populate_sdk_ext". In such a case, the
code which looks for matching targets finds two objects, as it
doesn't filter by task.

Add the task into the filter for the Target so that only one
Target object is be returned. Note that a command
line like "bitbake recipe:task recipe:task" will still cause an
error as bitbake doesn't de-duplicate the command line arguments
and will run the recipe:task combination twice.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index a5b2237..e1b59c3 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -201,6 +201,10 @@ class ORMWrapper(object):

     @staticmethod
     def get_or_create_targets(target_info):
+        """
+        NB get_or_create() is used here because for Toaster-triggered builds,
+        we already created the targets when the build was triggered.
+        """
         result = []
         for target in target_info['targets']:
             task = ''
@@ -210,13 +214,10 @@ class ORMWrapper(object):
                 task = task[3:]
             if task == 'build':
                 task = ''
-            obj, created = Target.objects.get_or_create(build=target_info['build'],
-                                                        target=target)
-            if created:
-                obj.is_image = False
-                if task:
-                    obj.task = task
-                obj.save()
+
+            obj, _ = Target.objects.get_or_create(build=target_info['build'],
+                                                  target=target,
+                                                  task=task)
             result.append(obj)
         return result

--
1.9.1


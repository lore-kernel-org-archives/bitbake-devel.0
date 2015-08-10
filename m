Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id 56E44768CE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:25 +0000 (UTC)
Received: by wibhh20 with SMTP id hh20so160532611wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=M0OW7vS7whv/B7VNWB2IyEIswHglzgW2sIDYXxAYS+s=;
	b=YppEl5RHmmiQrJfN4TUVgdxURousrdz1bCnVYdPdKVE3mDkmYynFyNIeii08ab8jjj
	DhNi1L+GluOraYO3VBf4sj/UxTVUH51wZLc8Jcj0/Q403kQvVsLPLBONFftDfJWpJF0o
	VKUcVDSxgmZPytUUZUz1Knj+3ByINdSvKwarEaJEYXKLJ70li6kaxe3mTHhPHTJrs50+
	zPUrcREFST05q6qZVbuxpcsoGAPLn47Jifs6HQWBqGqZyBKor6noe5ASR9ipoJCkjhDx
	CPHM6OgSvYQ98blt92UqYnR2apFgcz+L+qHPcHMEIq8UZgwT4YS5OahKOcpH/9aVsO6x
	0RKg==
X-Gm-Message-State: ALoCoQkupfVPFWfRbsxSMy8fhOS257p9H+L578WnyCDpgtHvi13uV1ChcmWkuzenH8ukyX4QU6xX
X-Received: by 10.180.8.234 with SMTP id u10mr26279859wia.4.1439227645106;
	Mon, 10 Aug 2015 10:27:25 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:24 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:10 +0100
Message-Id: <cbbda5d8a7a308226522379128b5d4fe41855e28.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
	<dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 03/11] toaster: get rid of AllProjectsViewTestCase
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
X-List-Received-Date: Mon, 10 Aug 2015 17:27:27 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed AllProjectsViewTestCase class as it had one method 'setUp'
and used as a parent for another class AllProjectsViewTestCase.

Moved setUp method to AllProjectsViewTestCase.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index a9edd54..6f3930d 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -7,7 +7,7 @@ import json
 
 PROJECT_NAME = "test project"
 
-class ProvisionedProjectTestCase(TestCase):
+class AllProjectsViewTestCase(TestCase):
 
     def setUp(self):
         self.bbv = BitbakeVersion.objects.create(\
@@ -18,9 +18,6 @@ class ProvisionedProjectTestCase(TestCase):
         self.project = Project.objects.create_project(name=PROJECT_NAME,
                                                       release=self.release)
 
-
-class AllProjectsViewTestCase(ProvisionedProjectTestCase):
-
     def test_get_base_call_returns_html(self):
         response = self.client.get(reverse('all-projects'), follow=True)
         self.assertEqual(response.status_code, 200)
-- 
2.1.4



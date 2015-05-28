Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id 354C375710
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:17:01 +0000 (UTC)
Received: by wizk4 with SMTP id k4so148653485wiz.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=jvYfzPd4PWsrTQOPz8+zofLNdsKTWSqmc3mjECdYSNE=;
	b=clZnNmHw6KRtL3Q//FzIBGfYyRweQtleKVdCYegw4oH9t8NVsZp6x3P629Vo8hlxwS
	Z7IcoQIG+BiITWw799umOTPf2lAjhVPHitIHx7aujvw1ecwu3qZ2IcjAR+5k3cC/oUom
	Y5gO6clatEZl8M7zCFyMmGG9kOgC12dZAtNvkDeub2CIuI822aJrYDlbE8q6FBqIDhxE
	GtRIYXso4rB5loZjYzHoqwlBw7ftRP6As+6pJKl9p0aBM5U80dXrV8sJ9hfNZyz/FfgN
	Ohjssbn6yCrNoyR+tuZnT0UpB9UmS9HkqSoAG0QrACkAN8PyQgA8OVkZEq9dNyI4kNqf
	5NLg==
X-Gm-Message-State: ALoCoQnnFt/1jRTTN3WY6fBzb7MMSFKpfBC8qOVn9uj5/6NX9KUBS7LQ7Ob/zp9lVF875UysCBjM
X-Received: by 10.194.78.14 with SMTP id x14mr5668207wjw.48.1432822622707;
	Thu, 28 May 2015 07:17:02 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id dg8sm3581901wjc.9.2015.05.28.07.17.01
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:17:01 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CD50F56130A; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:09 +0100
Message-Id: <a23611fa88db0fe75988335d463e8c34d835db45.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 15/22] toastergui: tests for the all-projects API point
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
X-List-Received-Date: Thu, 28 May 2015 14:17:02 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch adds Django tests that verify that the 'all-projects'
page returns a valid HTML page when invoked normally, containing
the project name; and valid JSON containing API-needed fields
if the GET parameter `format` is set to "json"

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/tests.py | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 lib/toaster/toastergui/tests.py

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
new file mode 100644
index 0000000..8a78a41
--- /dev/null
+++ b/lib/toaster/toastergui/tests.py
@@ -0,0 +1,36 @@
+from django.test import TestCase
+from django.core.urlresolvers import reverse
+from orm.models import Project, Release, BitbakeVersion, Build
+
+class AllProjectsViewTestCase(TestCase):
+    TEST_PROJECT_NAME = "test project"
+
+    def setUp(self):
+        bbv, created = BitbakeVersion.objects.get_or_create(name="test bbv", giturl="/tmp/", branch="master", dirpath="")
+        release, created = Release.objects.get_or_create(name="test release", bitbake_version = bbv)
+        Project.objects.create_project(name=AllProjectsViewTestCase.TEST_PROJECT_NAME, release=release)
+
+    def test_get_base_call_returns_html(self):
+        response = self.client.get(reverse('all-projects'), follow=True)
+        self.assertEqual(response.status_code, 200)
+        self.assertTrue(response['Content-Type'].startswith('text/html'))
+        self.assertTemplateUsed(response, "projects.html")
+        self.assertTrue(AllProjectsViewTestCase.TEST_PROJECT_NAME in response.content)
+
+    def test_get_json_call_returns_json(self):
+        response = self.client.get(reverse('all-projects'), {"format": "json"}, follow=True)
+        self.assertEqual(response.status_code, 200)
+        self.assertTrue(response['Content-Type'].startswith('application/json'))
+        try:
+            import json
+            data = json.loads(response.content)
+        except:
+            self.fail("Response %s is not json-loadable" % response.content)
+
+        self.assertTrue("list" in data)
+        self.assertTrue(AllProjectsViewTestCase.TEST_PROJECT_NAME in map(lambda x: x["name"], data["list"]))
+        self.assertTrue("id" in data["list"][0])
+        self.assertTrue("xhrProjectDataTypeaheadUrl" in data["list"][0])
+        self.assertTrue("projectPageUrl" in data["list"][0])
+        self.assertTrue("xhrProjectEditUrl" in data["list"][0])
+        self.assertTrue("projectBuildUrl" in data["list"][0])
-- 
1.9.1



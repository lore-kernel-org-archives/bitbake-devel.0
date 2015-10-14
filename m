Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id 869A277087
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 14:44:19 +0000 (UTC)
Received: by wijq8 with SMTP id q8so85084123wij.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 07:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=NtFCZmqjlD5sMi8UWXmDTxYFDc0v9Giko5o5atEFlEM=;
	b=Fv4gCYTpQvj5M++c1C+xVSOmJRIDjxTcdOPEONYixhXfdrn6/bNX+dEUlE0DXUbvww
	8soN2E3KxewnWOVGd57egVM96vAM7I2FbHfOVZNSy5hc+Ipl/9NHaTD10BzDSHO4j8lB
	FAzA4un+phdWVmUJvYFZx83VV49dsJoXX5XfyFzkwTyLuVKVvQg4uhLBfsUiEcHM1vON
	wfTsSvhoMZX62pCmYF1HMuDXwBdc0QbFZsEQeUBHyfOTBDVMXG8zKO+zzKanE+EcfbiB
	ophZSQhfDr1HiI1TIVf6RaC9WTZroJbk1dlJqruQ/kQZE/uKRsu2tmH1PQRpG8ea/c8C
	vfHA==
X-Gm-Message-State: ALoCoQldkOdj3pf/DPYHsOsW0eo+ig5V5yBsvQ7R/exMuZOWyh4hK7h7FlhZRd/M3nmYB3PpcSaI
X-Received: by 10.194.239.167 with SMTP id vt7mr4367361wjc.110.1444833836141; 
	Wed, 14 Oct 2015 07:43:56 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	p7sm10466970wjf.26.2015.10.14.07.43.55
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 14 Oct 2015 07:43:55 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 15:43:45 +0100
Message-Id: <b0c83d6ff1f019eeffc0c2add5b721daa28c091e.1444830820.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <b6b577253c245392800ea5e78391d11cef8eb8c8.1444830820.git.michael.g.wood@intel.com>
References: <cover.1444830820.git.michael.g.wood@intel.com>
	<b6b577253c245392800ea5e78391d11cef8eb8c8.1444830820.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1444830820.git.michael.g.wood@intel.com>
References: <cover.1444830820.git.michael.g.wood@intel.com>
Subject: [PATCH 3/3] toaster: Test that exception isn't thrown by project page
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
X-List-Received-Date: Wed, 14 Oct 2015 14:44:21 -0000

From: Elliot Smith <elliot.smith@intel.com>

Add a test which checks that an exception is no longer thrown
for the /toastergui/project/X page for the default project.

Note that we still get a spinning dialogue box on this page
because the default project has no configuration to display,
but at least it doesn't fail altogether.

[YOCTO #8277]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 95790a2..e652b98 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -574,3 +574,33 @@ class ProjectBuildsDisplayTest(TestCase):
         response = self.client.get(url, follow=True)
         result = re.findall('bash:clean', response.content, re.MULTILINE)
         self.assertEqual(len(result), 3)
+
+class ProjectPageTests(TestCase):
+    """ Test project data at /project/X/ is displayed correctly """
+    CLI_BUILDS_PROJECT_NAME = 'Command line builds'
+
+    def test_command_line_builds_in_progress(self):
+        """
+        In progress builds should not cause an error to be thrown
+        when navigating to "command line builds" project page;
+        see https://bugzilla.yoctoproject.org/show_bug.cgi?id=8277
+        """
+
+        # add the "command line builds" default project; this mirrors what
+        # we do in migration 0026_set_default_project.py
+        default_project = Project.objects.create_project(self.CLI_BUILDS_PROJECT_NAME, None)
+        default_project.is_default = True
+        default_project.save()
+
+        # add an "in progress" build for the default project
+        now = timezone.now()
+        build = Build.objects.create(project=default_project,
+                                     started_on=now,
+                                     completed_on=now,
+                                     outcome=Build.IN_PROGRESS)
+
+        # navigate to the project page for the default project
+        url = reverse("project", args=(default_project.id,))
+        response = self.client.get(url, follow=True)
+
+        self.assertEqual(response.status_code, 200)
-- 
2.1.4



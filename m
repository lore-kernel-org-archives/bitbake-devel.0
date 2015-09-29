Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id B478E76903
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:03 +0000 (UTC)
Received: by pablk4 with SMTP id lk4so97504368pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=qC7WvMDJiz3x29kSIHTCpeMjvQjJLyiHXmhQ2xtrp3o=;
	b=eW5YmAD5vUR07SerVz0Pe52HuAlSmDfO9Q2wus+frd2am57kV7oHwEERlKKwhNhzBj
	WvbvadqbyPYNG3psnr0LCPeuMGd7wwu91xosqOt11hDHQ7q3dpdSOJzZl81aiDmYXJhi
	LYg1eiNR/QwpSUc1mzvV5udQPr1HKwbPloc0oOIzpYQBWTiM77YZ6rw0P3GXTsFa9CfC
	dUaDCuijTIlX6ritZ5v2Az6hPPL0u7gP+HmLl/NkQ08nE2fOSfC+gxeHxGvUrDsMlH12
	rUjibxKTpXqGu9VZGW41jYwt4ppW6rKX8IXvqt6Vm5A0Z+CKb1KOz9VpBz9x8h532LrQ
	OEOg==
X-Received: by 10.68.69.8 with SMTP id a8mr30323230pbu.144.1443501844244;
	Mon, 28 Sep 2015 21:44:04 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:03 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:21 -0700
Message-Id: <a99548c3eda5c614a3394705b9a7076fea769cd1.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 11/22] toaster: Fix indentation of jsunittests view
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:03 -0000

From: Michael Wood <michael.g.wood@intel.com>

Fix indentation to 4 spaces

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 95df60e..5ea6122 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2328,20 +2328,20 @@ if True:
         return wrapper
 
     def jsunittests(request):
-      """ Provides a page for the js unit tests """
-      bbv = BitbakeVersion.objects.filter(branch="master").first()
-      release = Release.objects.filter(bitbake_version=bbv).first()
+        """ Provides a page for the js unit tests """
+        bbv = BitbakeVersion.objects.filter(branch="master").first()
+        release = Release.objects.filter(bitbake_version=bbv).first()
 
-      name = "_js_unit_test_prj_"
+        name = "_js_unit_test_prj_"
 
-      # If there is an existing project by this name delete it. We don't want
-      # Lots of duplicates cluttering up the projects.
-      Project.objects.filter(name=name).delete()
+        # If there is an existing project by this name delete it. We don't want
+        # Lots of duplicates cluttering up the projects.
+        Project.objects.filter(name=name).delete()
 
-      new_project = Project.objects.create_project(name=name, release=release)
+        new_project = Project.objects.create_project(name=name, release=release)
 
-      context = { 'project' : new_project }
-      return render(request, "js-unit-tests.html", context)
+        context = { 'project' : new_project }
+        return render(request, "js-unit-tests.html", context)
 
     from django.views.decorators.csrf import csrf_exempt
     @csrf_exempt
-- 
1.9.1



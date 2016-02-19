Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f180.google.com (mail-pf0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id 4362A731DB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Feb 2016 05:16:04 +0000 (UTC)
Received: by mail-pf0-f180.google.com with SMTP id c10so45996369pfc.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Feb 2016 21:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=JIUikse8RrK1vWiPAeM/vcq3z1aLWxquE920B+o/QSg=;
	b=v92hkOm3WzRYPQfzCFfX7Iz/YtqCD7A+P7JbdHvPbP7pxKohq23CQo57USikMd3wQZ
	niSzo5v2yQ8JSW950V4ckHnZnHJTCBR7+qZBz68BL1kl+H6ClCMzcUWfy9XgmUvwjROY
	PQVKf5T48iPoKDG2Q4pfusqnTcRw4Jxpd9O0QdmRZAMehq++lmUEPBqFDOGPyNxL4gVw
	sVykgOaarO4VLVFWOF0TiuyDJkmlvGBRWrnXT0jXhwjedmmwMGDQ6cU7/TbCEJKedW1y
	dO0MLSt9vk/qoF4eiUxljuBCmCVcK8DVZgbGbqGnKSdlLExTuKiBnNZmkyL/480lNCiQ
	c1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=JIUikse8RrK1vWiPAeM/vcq3z1aLWxquE920B+o/QSg=;
	b=XeWE331TutxxBOCOl7uCCiqIOSjPFLSAxwVT331DJeHYdS5zLAuI1PP36UML+AFE7X
	1bZSfqy/bZw4VYlSN8Xtpngm4DWPgMu+CrxdStMiRKC055UQRzQ5DLF4zINZuBHTygTA
	q0a0Kv57uimoYN38ti/5ewbb+0ES1+2czS/SVHExbOPARH+mKaBG2xhzN7500QaIbhTX
	3DTolKOobgeJi1gwuyTyZdIjsxi1sJS2MOFttLOTsPn0c4lqd8lu/ssilnJEgOqHwsvK
	7Yjae/mSsnE3DewB6XqZsWv5vG22wRgpVW9tbJDtgZBij+6SP1FC3o+7jhHpSpfGR6NY
	Qoow==
X-Gm-Message-State: AG10YOT/fftN6PQCqBW2GhyyK2fIQ/JXXkFgI8b0/O1wZOhL1eB2E1wfcF3gM1bLu6AK5A==
X-Received: by 10.98.8.200 with SMTP id 69mr15752209pfi.39.1455858965387;
	Thu, 18 Feb 2016 21:16:05 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ml5sm13317073pab.2.2016.02.18.21.16.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 18 Feb 2016 21:16:04 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Feb 2016 21:21:52 -0800
Message-Id: <c0fe43b9bb8a82ecfc2ed72ad9b39f435fe3b707.1455859137.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1074d09d9af22d962880d1ba7791b85eecfeac08.1455859137.git.avery.brian@gmail.com>
References: <1074d09d9af22d962880d1ba7791b85eecfeac08.1455859137.git.avery.brian@gmail.com>
In-Reply-To: <cover.1455859137.git.avery.brian@gmail.com>
References: <cover.1455859137.git.avery.brian@gmail.com>
Subject: [PATCH 5/5] toaster: toastergui Fix invalid char test and implementation
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
X-List-Received-Date: Fri, 19 Feb 2016 05:16:05 -0000

From: Michael Wood <michael.g.wood@intel.com>

This test was passing but because the assertion was the wrong way round
and should have expected the first one to pass and second one to fail,
in reality both were failing as the method for checking the invalid char
was incorrect.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tests.py | 2 +-
 lib/toaster/toastergui/views.py | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 1b6e78d..4e420ea 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -155,7 +155,7 @@ class ViewTests(TestCase):
         response = self.client.post(reverse('xhr_importlayer'), args)
         data = json.loads(response.content)
         self.assertEqual(response.status_code, 200)
-        self.assertNotEqual(data["error"], "ok")
+        self.assertEqual(data["error"], "ok")
 
         #Test to verify import of a layer successful
         args['name'] = "meta-oe"
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index dfa256e..13489af 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2185,8 +2185,11 @@ if True:
         layers_added = [];
 
         # Rudimentary check for any possible html tags
-        if "<" in request.POST:
-          return HttpResponse(jsonfilter({"error": "Invalid character <"}), content_type = "application/json")
+        for val in request.POST.values():
+            if "<" in val:
+                return HttpResponse(jsonfilter(
+                    {"error": "Invalid character <"}),
+                    content_type="application/json")
 
         prj = Project.objects.get(pk=request.POST['project_id'])
 
-- 
1.9.1



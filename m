Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 9814E768F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:29 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so35113947wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=pDXSzfd1cuogNjZMni/kYGypw12aJ1EfWqaBiM5/w0I=;
	b=iHMxpQiK9zAaq6svQKlLdaFGLFQpm/sry8+F37MyVjEncNPgjIjsoxnBzv5wcOxult
	eYhDOg2uRQkLAR8WvfswE8WG3QOYi/SnNyO2h+JHuHCsMrmknkrlGNdNIZOGwK2Ig47O
	lIwlnCoPVvqHcdcUlbdAP5yXM2eiIW2R+MO0ibNOQVakpeOKAHXFswHxarfPxH+jR880
	ZSZzdUEbu2IunS366g9PkKutfjyn07N3F/maUAIjBA0zjvFNHB2qm6ZMRp02RXaDPZOp
	NK8gUyM9c9GzE+nOifslR6UlGamMGZBT42VAwkHdWviVsdBuDFT3tiX+nRCGsv9x6v4f
	9lMw==
X-Gm-Message-State: ALoCoQl7FIyUXPE44nPcfuX3dnUM4oROh+Qlw1y5wb0HzPf4IHRoEHWAfZOIPRneaxd2WSo4JNpo
X-Received: by 10.194.110.132 with SMTP id ia4mr35662491wjb.103.1439227649443; 
	Mon, 10 Aug 2015 10:27:29 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.28
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:28 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:15 +0100
Message-Id: <708fbd8f94a0f66ea03c782505a7e71070dd2433.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
	<dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 08/11] toaster: don't catch json.load exceptions
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
X-List-Received-Date: Mon, 10 Aug 2015 17:27:32 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

It doesn't make sense to catch json.load exceptions in the
testing code. If API throws traceback it's better to see
it instead of error message.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 1ed83dc..723348d 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -82,10 +82,7 @@ class ViewTests(TestCase):
         self.assertEqual(response.status_code, 200)
         self.assertTrue(response['Content-Type'].startswith('application/json'))
 
-        try:
-            data = json.loads(response.content)
-        except:
-            self.fail("Response %s is not json-loadable" % response.content)
+        data = json.loads(response.content)
 
         self.assertTrue("error" in data)
         self.assertEqual(data["error"], "ok")
@@ -113,10 +110,8 @@ class ViewTests(TestCase):
             self.assertEqual(response.status_code, 200)
             self.assertTrue(response['Content-Type'].startswith('application/json'))
 
-            try:
-                data = json.loads(response.content)
-            except:
-                self.fail("Response %s is not json-loadable" % response.content)
+            data = json.loads(response.content)
+
             self.assertTrue("error" in data)
             self.assertEqual(data["error"], "ok")
             self.assertTrue("results" in data)
-- 
2.1.4



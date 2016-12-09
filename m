Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 4A4466013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:07 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id f82so32577815wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=nmGEtCoD669xY+oem3ghbv4YojjLSj2jGqTY/w58E/I=;
	b=0WtP/FtFfyp7UlEvvM9criBnv9xTmrj8nDdY8y23gLcfU0joORXjel8rrRj+XIT8DG
	QxsHG6RXZRbw301/pQ0ck8lqttxFkDuc/kdOz40Q03iB0okVRi1pNwcgC5aDsbHRvbxs
	5JAlkb+uO9clmHawPTWgT6obw6Qfw02sLEalrQdJ2XQ4OeLHthzhaQ7ahFa0iJQ1ur6I
	HbWwg1TEoI5LN0fV1nN+c50AayYcuMvpu9RSba2tFG/hkgNIf+bft4hHFOHpymTKzV9i
	IuUYmWDC835n+agOD63Jzog6SuYNYl/ib4JGb+lUrm93+aEuhezHgGYYXarg0DF7Z7jG
	S3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=nmGEtCoD669xY+oem3ghbv4YojjLSj2jGqTY/w58E/I=;
	b=HfrAWSbtSCup7fztOX8OrU9rsNusNvpeD1dPf6qE/0KbSZhamxjRE399qiV8Q7WuL2
	3Qyuwn+02uvw18SS/7gV975OdTYoKPAtqjKcPJ9bE3/lxK5ZpvdcIHOBF6HDsvNwH8Zt
	2xDHs/ZcK5qiZJ4ms0kRNGNIcqw8XkBfkgbD9KF/8rnCbFlZFnGkD25m61+2VqL5cqQS
	Fr9F26RXa3PRbPheCAXfjtSu1s+XMzTstsva5OYySEuWDENazSw1mKbPOQHewiYbQu2m
	Kl2ffrv97Ppum83wddZc0t7b3yX9XGBtaupKmLWmq2TFsWFD3lPen8/34hvN4aLAkNqc
	lIGA==
X-Gm-Message-State: AKaTC00hgDqUDp1UWOiN1QQty0RkgDo6ahNUPXBcpkMrAX9eOO57yj94/oEStZ8yczccQ0k+
X-Received: by 10.28.141.18 with SMTP id p18mr7254741wmd.31.1481302388976;
	Fri, 09 Dec 2016 08:53:08 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:08 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:47 +0000
Message-Id: <1481302375-7985-7-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 06/14] toaster: tests Update import layer test to use new Layer add api
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:09 -0000

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/views/test_views.py | 45 ++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/views/test_views.py
index c20b3fe..1463077 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -142,35 +142,36 @@ class ViewTests(TestCase):
             # from each of the urls
             self.assertTrue(results)
 
-    def test_xhr_import_layer(self):
-        """Test xhr_importlayer API"""
+    def test_xhr_add_layer(self):
+        """Test xhr_add API"""
         # Test for importing an already existing layer
-        args = {'vcs_url': "git://git.example.com/test",
-                'name': "base-layer",
-                'git_ref': "c12b9596afd236116b25ce26dbe0d793de9dc7ce",
-                'project_id': self.project.id,
-                'local_source_dir': "",
-                'dir_path': "/path/in/repository"}
-        response = self.client.post(reverse('xhr_importlayer'), args)
+        api_url = reverse('xhr_layer', args=(self.project.id,))
+
+        layer_data = {'vcs_url': "git://git.example.com/test",
+                      'name': "base-layer",
+                      'git_ref': "c12b9596afd236116b25ce26dbe0d793de9dc7ce",
+                      'project_id': self.project.id,
+                      'local_source_dir': "",
+                      'add_to_project': True,
+                      'dir_path': "/path/in/repository"}
+
+        layer_data_json = json.dumps(layer_data)
+
+        response = self.client.put(api_url, layer_data_json)
         data = json.loads(response.content.decode('utf-8'))
         self.assertEqual(response.status_code, 200)
         self.assertEqual(data["error"], "ok")
 
-        # Test to verify import of a layer successful
-        args['name'] = "meta-oe"
-        response = self.client.post(reverse('xhr_importlayer'), args)
-        data = json.loads(response.content.decode('utf-8'))
-        self.assertTrue(data["error"], "ok")
-
-        # Test for html tag in the data
-        args['<'] = "testing html tag"
-        response = self.client.post(reverse('xhr_importlayer'), args)
-        data = json.loads(response.content.decode('utf-8'))
-        self.assertNotEqual(data["error"], "ok")
+        self.assertTrue(
+            layer_data['name'] in
+            self.project.get_all_compatible_layer_versions().values_list(
+                'layer__name',
+                flat=True),
+            "Could not find imported layer in project's all layers list"
+        )
 
         # Empty data passed
-        args = {}
-        response = self.client.post(reverse('xhr_importlayer'), args)
+        response = self.client.put(api_url, "{}")
         data = json.loads(response.content.decode('utf-8'))
         self.assertNotEqual(data["error"], "ok")
 
-- 
2.7.4



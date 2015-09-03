Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id B2D1477049
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 00:24:33 +0000 (UTC)
Received: by pacwi10 with SMTP id wi10so27089231pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Sep 2015 17:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=H8UvvRnQZkI7mVahV5cttHcMxuFBndoAwtwD9OhkJ20=;
	b=PKAK5R9YRWaRgButPoM8NnQbZErA4tU1JSbQz1xwnx2AoyxmxmuKBIQX7LDxdopFwr
	SYnHYbJ4xeN8MWffnq22l+EAwBMiHMS8qXclYf3RReZOpRgl1g50evQw7Sv+B8JZVF8S
	rHcADJx+x0A+M87VJJ520ZNoOaQ8CWaTkz3roTVECnYP+M7lrxwJXzYwasnNqLLMSxWc
	GCHUkohOWsr6QTNdM6bG2ABskNf+mITlDJAxa1Nidl7RoYCI8ebXGbAnHfsZKvs/GIw1
	FUvmHQ2s/eXtw3/mQNzhMYGXXT0hyztGsDkVoHeRg+F8dprs3WUGRX3iEl61v+/4kgZW
	zEOQ==
X-Received: by 10.68.195.231 with SMTP id ih7mr62136193pbc.26.1441239873434;
	Wed, 02 Sep 2015 17:24:33 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw3sm22972308pbc.30.2015.09.02.17.24.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Sep 2015 17:24:32 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Sep 2015 17:25:11 -0700
Message-Id: <a226f99ceb186f8959db55e1f4bc916bc5a02235.1441239229.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
References: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
In-Reply-To: <cover.1441239229.git.avery.brian@gmail.com>
References: <cover.1441239229.git.avery.brian@gmail.com>
Subject: [PATCH 5/6] toaster: Fix test for projects page JSON
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
X-List-Received-Date: Thu, 03 Sep 2015 00:24:36 -0000

From: Elliot Smith <elliot.smith@intel.com>

The tests expect data to be returned in a particular format,
which doesn't include is_default or the num_builds fields
added to support default project improvements.

Add the extra fields so the tests pass again.

[YOCTO #7932]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tests.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index 85e27fe..7acf4bc 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -40,6 +40,7 @@ class ViewTests(TestCase):
                                          bitbake_version=bbv)
         self.project = Project.objects.create_project(name=PROJECT_NAME,
                                                       release=release)
+
         layersrc = LayerSource.objects.create(sourcetype=LayerSource.TYPE_IMPORTED)
         self.priority = ReleaseLayerSourcePriority.objects.create(release=release,
                                                                   layer_source=layersrc)
@@ -86,10 +87,10 @@ class ViewTests(TestCase):
 
         self.assertEqual(sorted(data["rows"][0]),
                          ['bitbake_version_id', 'created', 'id',
-                          'layersTypeAheadUrl', 'name', 'projectBuildsUrl',
-                          'projectPageUrl', 'recipesTypeAheadUrl',
-                          'release_id', 'short_description', 'updated',
-                          'user_id'])
+                          'is_default', 'layersTypeAheadUrl', 'name',
+                          'num_builds', 'projectBuildsUrl', 'projectPageUrl',
+                          'recipesTypeAheadUrl', 'release_id',
+                          'short_description', 'updated', 'user_id'])
 
     def test_typeaheads(self):
         """Test typeahead ReST API"""
-- 
1.9.1



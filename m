Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 7F5C177043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:12 +0000 (UTC)
Received: by pablk4 with SMTP id lk4so97507982pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=V09ZxJaAFLZUQFIgHQBtNdcBkF0wLMKQryEJGcfCAOc=;
	b=p8lzGVM6ml55FAhjqR3mmB0gbih2Xb/9C4LZbT40rg1DGer5aZuToERJi51gApcid7
	MoCNnPmrdTvdniJ4d5B5CDvYX1yb8ySLRA1PH0ueQIlwiwnOrTeAE4HMACd+I9MJK3UE
	og9HWnWEDSgQhQGOf0FUWZZng4k1Jw6bdNcbKtFIFQA2Yr6Q/g3UysTG2he+stIx8/tO
	cBOmKcJWpBCopxS0I+MMFEPgLb4HQzGppBmtfm8bayUQamabl7AUNGumeb8AspFlJyDc
	aTzypPD/WVWY5R0ctIZH6ItJKDo8y/GY8s6h1fkQNZ/bABMUTQ9WKyJt5OortuVIDhHX
	faYA==
X-Received: by 10.68.254.99 with SMTP id ah3mr30521081pbd.15.1443501852789;
	Mon, 28 Sep 2015 21:44:12 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:12 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:31 -0700
Message-Id: <b002d5fe6b0f343507af0447833bd2f166bcb57a.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 21/22] Revert "bitbake: toaster: don't re-create Target objects"
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:13 -0000

From: Michael Wood <michael.g.wood@intel.com>

This delete followed up the foreign keys and deleted things that were
not expected to be deleted.

This reverts commit 08000eb27eb8413686fb2c8daf14d234a8bff83a.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index e036ef6..9fdde29 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -162,6 +162,8 @@ class ORMWrapper(object):
             build.bitbake_version=build_info['bitbake_version']
             build.save()
 
+            Target.objects.filter(build = build).delete()
+
         else:
             build = Build.objects.create(
                                     project = prj,
@@ -182,6 +184,19 @@ class ORMWrapper(object):
 
         return build
 
+    def create_target_objects(self, target_info):
+        assert 'build' in target_info
+        assert 'targets' in target_info
+
+        targets = []
+        for tgt_name in target_info['targets']:
+            tgt_object = Target.objects.create( build = target_info['build'],
+                                    target = tgt_name,
+                                    is_image = False,
+                                    )
+            targets.append(tgt_object)
+        return targets
+
     def update_build_object(self, build, errors, warnings, taskfailures):
         assert isinstance(build,Build)
         assert isinstance(errors, int)
@@ -911,7 +926,7 @@ class BuildInfoHelper(object):
         target_information['targets'] = event._pkgs
         target_information['build'] = build_obj
 
-        self.internal_state['targets'] = Target.objects.filter(build=target_information['build'])
+        self.internal_state['targets'] = self.orm_wrapper.create_target_objects(target_information)
 
         # Save build configuration
         data = self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0]
-- 
1.9.1



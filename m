Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id D763F77063
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:09 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so198606287pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=g0lH8fnleS/O94Yxo9pX76hkGvS+bftGlDMN6wDUvGQ=;
	b=wNwlpvmIxCXGZ9MiysAAEap0m3DlizZ5p4sUCmu3SsQEuAHxqZ4M3ADUPLsnBC3ObJ
	IL5FAGVhn/qvN6Pxck+lbp61YDTJlXn5JGrRue8qqzi9E1E3YK4E6JLV6JPZMF4hMVss
	i9FhfNfcifuCyd2h1SDNkLw1r6Iql02z33j4k8Nynf9O/Ci+pOJyrPfFBEltboksbxMl
	umjO9IDi39zRwXjIEr/LuRptSSChvu3upPpqCsN4paLDRnuhuYI3TAz0c0OPvC2KH9w/
	74ADvc4mqt4eavsBD4+Bxs0c0vDZAW5qPWXk24POJoG5nJbT86Igp3RWEIyT8xZNYmgT
	P2kg==
X-Received: by 10.69.2.227 with SMTP id br3mr31218070pbd.9.1443501850355;
	Mon, 28 Sep 2015 21:44:10 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:09 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:28 -0700
Message-Id: <1a0e3e74aecfbdcd5abce94836c925f67fb113ee.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 18/22] toaster: Prioroitise the layer more generic vcs reference over the sha
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:10 -0000

From: Michael Wood <michael.g.wood@intel.com>

When we do a build we update the last commit value that the layer was built at
However in future builds we do want to use the named reference rather
than the commit sha, e.g. master/fido

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 8d7388e..e0b31a9 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1155,12 +1155,12 @@ class Layer_Version(models.Model):
         return project.compatible_layerversions(layer_name = self.layer.name)
 
     def get_vcs_reference(self):
-        if self.commit is not None and len(self.commit) > 0:
-            return self.commit
         if self.branch is not None and len(self.branch) > 0:
             return self.branch
         if self.up_branch is not None:
             return self.up_branch.name
+        if self.commit is not None and len(self.commit) > 0:
+            return self.commit
         return ("Cannot determine the vcs_reference for layer version %s" % vars(self))
 
     def get_detailspage_url(self, project_id):
-- 
1.9.1



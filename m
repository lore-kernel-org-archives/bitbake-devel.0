Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id D5DE8770B9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Oct 2015 21:18:15 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so87167133pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 01 Oct 2015 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=hdt1EdaLLZgGfdeoL+lVBp4wgSBav0Gz/QaxBsMo3B4=;
	b=kIi1MNyuisjIADibsvmfsMsnslFDYhcpiqtoDZb2TN1brG4uwx04k8Zc5xOPCjWqnw
	qWhpk3OcY+DT5ngmAykkracvCNQ7+wghGoc78WePYjcx1Y5eIXiktCiwiKUqNv0vLLPp
	byEgGL5y9bAJEMMn/Km3H/flpbtcoMpOfUx+S2F9gvuGH12oo05sipGCXyMebKXIb67g
	TGKoEw5RKiO+1t3aWQxSYPrE1J07U8W+Gmvc5OJAi27n/h56rJF9+Z4P6qLR3Qtxpm3h
	ZFum9PlzM8RfoKKycvmUxb9Cd/ZsiwwFPDZz5Ci5kF5qpqZNc5jZ6ORoMmyQaJKF22PD
	W5OA==
X-Received: by 10.66.190.6 with SMTP id gm6mr14935790pac.27.1443734295897;
	Thu, 01 Oct 2015 14:18:15 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ej3sm8513411pbd.13.2015.10.01.14.18.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 01 Oct 2015 14:18:15 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  1 Oct 2015 14:19:57 -0700
Message-Id: <3143235ff04998bad4a2af3e8fe0361664f65aa2.1443734209.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4e02220a11fd454fc46c90d287ae3f3e847751b3.1443734209.git.avery.brian@gmail.com>
References: <4e02220a11fd454fc46c90d287ae3f3e847751b3.1443734209.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443734209.git.avery.brian@gmail.com>
References: <cover.1443734209.git.avery.brian@gmail.com>
Subject: [PATCH 2/2] toaster: exclude recipes with empty names
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
X-List-Received-Date: Thu, 01 Oct 2015 21:18:16 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Modified get_all_compatible_recipes function to exclude recipes
with empty names from the result queryset. This should stop UI
to show recipes with empty names in compatible recipes page.

[YOCTO #7969]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 89343f2..ad12dd4 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -253,7 +253,7 @@ class Project(models.Model):
         """ Returns QuerySet of all the compatible Recipes available to the
         project including ones from Layers not currently added """
         queryset = Recipe.objects.filter(
-            layer_version__in=self.get_all_compatible_layer_versions())
+            layer_version__in=self.get_all_compatible_layer_versions()).exclude(name__exact='')
 
         return queryset
 
-- 
1.9.1



Return-Path: <michael.g.wood@intel.com>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id D486765C89
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Jul 2015 16:58:25 +0000 (UTC)
Received: by wguu7 with SMTP id u7so68481016wgu.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Jul 2015 09:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mqRIKUd77VMxp8KR/EAD+FGTGBF9zIKrIRKCrzLTJQU=;
	b=RZBnrCdDk6Umk9nXrn4iM8sdY0QilIA7bopVAfKZlenIx5k7JwbRZrdNGZaKvLYhYq
	3Sb7JVk1sKnC+L1S/ZmKav+IFsrO6tWfC/kZUU7GPTLjzkKPWTd+6CI8cjtHswIEkTAR
	C1wHlrJmvapPIXg9ccAht64Zr23kdPrtiLjnkjsJ8xJMFFOhmGKvn4U19oJ/rqLAkfSG
	ypR1iUHY+wenBJqMZ1Pem2EtiUSFtQ1pjBK/UyQRJol8FxkFWBA9zeM+por7l1Op9XhV
	oQoBS6pEAnddP/W88DaqbYGPJ0ClACDXRJGFPjXmovF9R5CDfSwg3Hl2GkcLliQMxEi5
	B+vQ==
X-Gm-Message-State: ALoCoQltHJRk9r2wnaqBWUcdS76RVIyGBvWdcB4oUTug4XXK5hwZpLkfPOjAAxsBaeWbKFm4EM01
X-Received: by 10.194.57.170 with SMTP id j10mr58588931wjq.140.1435856305764; 
	Thu, 02 Jul 2015 09:58:25 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ka7sm9007084wjc.36.2015.07.02.09.58.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 02 Jul 2015 09:58:25 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Jul 2015 17:58:12 +0100
Message-Id: <1435856296-12531-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
References: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 1/5] bitbake: toaster: Partial Revert "fixes after html5 compliance testing"
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
X-List-Received-Date: Thu, 02 Jul 2015 16:58:28 -0000

Partial revert of bb commit 7aecb974d44d9bc711ffba5cc65e770811397fba

There were changes in this commit which broke the compatible layers
mechanism meaning that no layers, recipes or machines were showing.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bitbake/lib/toaster/orm/models.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index 7e8ab16..4ea75f2 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -180,9 +180,8 @@ class Project(models.Model):
         if release == None:
             release = self.release
         # layers on the same branch or layers specifically set for this project
-        queryset = Layer_Version.objects.filter(Q(project = self) | Q(build__project = self))
-        if release is not None:
-            queryset = queryset.filter(Q(up_branch__name = release.branch_name) & Q(project = None))
+        queryset = Layer_Version.objects.filter((Q(up_branch__name = release.branch_name) & Q(project = None)) | Q(project = self) | Q(build__project = self))
+
         if layer_name is not None:
             # we select only a layer name
             queryset = queryset.filter(layer__name = layer_name)
-- 
2.1.4



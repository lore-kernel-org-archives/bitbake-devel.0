Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 6F95D768F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:27:31 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so45694773wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=rz5tSYDOMAMe78kmolrFIDK3zYJvBJ5AQX63sJ1Z+tU=;
	b=F1H5NgTHDocEtX7Ty7YME9ImlhxhF403SOyE3yBy/d1lLvgWkgsXxg6ySPcFny7Gdu
	J0bSTFoiKYdth5SK9MOLZVhmcAYkjR1I6OxO8A36ArrIQQeHUVfLZLpCNLe85dJudDny
	NNHtxoJSjoEC2xcwmCQ4wEsNBEHL3NXSYnr9rAkwwahyuPrGvf1Lg9idTybjuFTRdv16
	5QpJiztTXCgeCYtNq0P7uu/o3nZ2rVYMaNnAYTmThb1szLSOgoQUcW2r0Lwj/ZR7rsIn
	0oeSlV1jbFqMghTCg7yoPKTXIFhnziv9ri+myLQdKPITPuwL6XCUWNphvy8TaqEQBMRr
	EekQ==
X-Gm-Message-State: ALoCoQkH4In0/S9vCDDrSzgku61MRgpm7EXUpB1jGxGLfaTd5+4o8b+aBpZ132IAUPng4CuNYASi
X-Received: by 10.181.13.169 with SMTP id ez9mr24953753wid.92.1439227651364;
	Mon, 10 Aug 2015 10:27:31 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	cw8sm30396731wjb.49.2015.08.10.10.27.30
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:27:30 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:27:17 +0100
Message-Id: <a36e974186765b9e61c77961f1586e95b37e97d2.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
	<dd3a557b5759abe26b64c22379333c25d83b8708.1439226591.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439226591.git.michael.g.wood@intel.com>
References: <cover.1439226591.git.michael.g.wood@intel.com>
Subject: [PATCH 10/11] toaster: fix pylint warning 'no space allowed'
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

Fixed pylint warning "No space allowed before/after bracket".

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/tests.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index d155849..bc10801 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -103,10 +103,10 @@ class ViewTests(TestCase):
         layers_url = reverse('xhr_layerstypeahead', args=(self.project.id,))
         prj_url = reverse('xhr_projectstypeahead')
 
-        urls = [ layers_url,
-                 prj_url,
-                 reverse('xhr_recipestypeahead', args=(self.project.id,)),
-                 reverse('xhr_machinestypeahead', args=(self.project.id,)),
+        urls = [layers_url,
+                prj_url,
+                reverse('xhr_recipestypeahead', args=(self.project.id,)),
+                reverse('xhr_machinestypeahead', args=(self.project.id,)),
                ]
 
         def basic_reponse_check(response, url):
@@ -147,7 +147,7 @@ class ViewTests(TestCase):
             results = False
 
             for typeing in list(string.ascii_letters):
-                response = self.client.get(url, { 'search' : typeing })
+                response = self.client.get(url, {'search': typeing})
                 results = basic_reponse_check(response, url)
                 if results:
                     break
-- 
2.1.4



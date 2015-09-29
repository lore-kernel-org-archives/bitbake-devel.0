Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 1466D77043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:10 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so198606604pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=W40947NBxWfdXjun/fUZMAkK1GqtN2KljkVLcPp1+H0=;
	b=K0Y7EPuDbc9CgqMH1mMRUtrOsVCN8OteUAgqU3XXBIHC44mfdsx7SY9PZcbs5FKj5U
	2ZOIWl1GPsIFOj/yhpygfycmfM5iYyJQS+HST12HjOd4E/aq04B/zUEELev2pydZIU1Y
	/5hQRbC5fWAP4ordZ6bVZiuQ6iEOmcBY99jEaQZrQVjALSRz9TWATYAozZ2HXeDb20QW
	4+aaBX+uxA+rUStj+cwH3jYO5KpHKwEXi+bfURmq6lOmwHJQdZIwPCI03RQuFQ5EeTAy
	GJQj9h8I0F0Sibty8iqhYHE+nvl6zgqiCqrlmt4CkuzUK8aX0t1r4TIzqnk/cQdp4vlO
	xIpQ==
X-Received: by 10.68.65.2 with SMTP id t2mr30081763pbs.75.1443501851098;
	Mon, 28 Sep 2015 21:44:11 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:10 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:29 -0700
Message-Id: <39d34f0ba3e217c031ea7f80d6217cf2222a57b6.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 19/22] toaster: tables show all recipes in the layerdetails even duplicates
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

For some layers we have multiple recipes for the same software with
differing versions. Change to showing all versions and add a version
column to the table instead.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/tables.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 1526d59..3354072 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -403,8 +403,8 @@ class LayerRecipesTable(RecipesTable):
 
 
     def setup_queryset(self, *args, **kwargs):
-        RecipesTable.setup_queryset(self, *args, **kwargs)
-        self.queryset = self.queryset.filter(layer_version__pk=int(kwargs['layerid']))
+        self.queryset = \
+                Recipe.objects.filter(layer_version__pk=int(kwargs['layerid']))
 
         self.static_context_extra['in_prj'] = ProjectLayer.objects.filter(Q(project=kwargs['pid']) & Q(layercommit=kwargs['layerid'])).count()
 
@@ -418,6 +418,8 @@ class LayerRecipesTable(RecipesTable):
         self.add_column(title="Description",
                         field_name="get_description_or_summary")
 
+        self.add_column(title="Version",
+                        field_name="version")
 
         build_recipe_template ='<button class="btn btn-block build-recipe-btn" data-recipe-name="{{data.name}}" {%if extra.in_prj == 0 %}disabled="disabled"{%endif%}>Build recipe</button>'
 
-- 
1.9.1



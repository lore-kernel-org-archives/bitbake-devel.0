Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
	[74.125.82.174])
	by mail.openembedded.org (Postfix) with ESMTP id 0DBAB6FB38
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:35 +0000 (UTC)
Received: by mail-we0-f174.google.com with SMTP id t60so3616992wes.19
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=FV7od/9DZF2PrI6X+Zu7zf+RYl93PAQEPtyLEDE3I1g=;
	b=ZAntnKULJHeSZj3xLCmI3qgyx64NC4QtNcvlxaXG7Uj5qDIYt6/1VJ3Ho7ZMnFEPW3
	2LQGcYOV2ThlVgnoHIOq1EPcbi2Ux8la05ZIevUVRWYbwh+6sKu5yEXkss/4fXbX89LR
	fI6rsgu8G2JwrOBAGsJ+M3P2MxgZeMAV9WBqDZ6R+rx2ZDC9lh67GiYTufzoB1d2Uzci
	WQFVTI08lVsZy/ZcO2Yd60J86vjUnbXfoQiWa+NueFDRBXR7g4R8cCyVZMqJvBik3xUg
	fCyc6WS6VOr3u3NlsIFVPt+BYxfZ+YadndS1xYo7taxLrx4oigcJvYIyj1lHBzYZnEm6
	UgEA==
X-Gm-Message-State: ALoCoQmoZ31AQsKTGrVbFSLUun4YB+DQBEANEdtRJGd/n2SXSnskb6FLAPgoh25pxGlv1Xers+bu
X-Received: by 10.180.87.162 with SMTP id az2mr16703290wib.23.1395686256403;
	Mon, 24 Mar 2014 11:37:36 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id mw3sm41444872wic.7.2014.03.24.11.37.33
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:34 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id C394556155E; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:22 +0000
Message-Id: <560569d0e1e5de694bc19d09bdf98890af54a6d6.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 12/18] toaster: add search by section to all recipe page
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:36 -0000

From: David Reyna <David.Reyna@windriver.com>

Add the 'section' to the searchable columns list for the recipe model.

[YOCTO #5993]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index c5fe69b..bb018a9 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -261,7 +261,7 @@ class Package_File(models.Model):
     size = models.IntegerField()
 
 class Recipe(models.Model):
-    search_allowed_fields = ['name', 'version', 'file_path', 'license', 'layer_version__layer__name', 'layer_version__branch', 'layer_version__commit', 'layer_version__layer__local_path']
+    search_allowed_fields = ['name', 'version', 'file_path', 'section', 'license', 'layer_version__layer__name', 'layer_version__branch', 'layer_version__commit', 'layer_version__layer__local_path']
     name = models.CharField(max_length=100, blank=True)
     version = models.CharField(max_length=100, blank=True)
     layer_version = models.ForeignKey('Layer_Version', related_name='recipe_layer_version')
-- 
1.8.3.2



Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
	[74.125.82.175])
	by mail.openembedded.org (Postfix) with ESMTP id 3921973B4D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:50 +0000 (UTC)
Received: by wevl61 with SMTP id l61so15353423wev.10
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=iRMgCH7ge7FgoJbOMX6lIlYjpAZMBANCrPWTef3tmoU=;
	b=iRSxlkGTOPkp/rmB4PIGpFfeAKeO1t61fefuodpTOpUeVo0ToECWynnHQzZzDiyfmA
	AnU55cnbklcpv5zM/dQLP0fG0lH7YloMqUaBRCaqNqaKF68CRNNTxqAnt/OxOjwYlint
	98GpQgE5omgKIpqqgyH2j0WLNJW0FJQSWl2BeeD50y5v22GQsF4gJJy+949X0DZLVzJs
	zfjDAxPnZ8d+jBZTEQhc88+QziGTluROYo2db6IkJ+xi8rxeuknyQnpnQLE9YuzCEUWD
	63UedD8EewgCiuiQ6v6uVmxA5DpNZzww2RlG6mrbFMSKfRMqqJwDNJsI3jwE2LmXKbf7
	o6Fg==
X-Gm-Message-State: ALoCoQnMKRvMsR2nenyOs7QFN6XAcIFPCDxXVF+dXgxotV5s2GotlAw1MXVmEcJFGbaLRQw+pLy0
X-Received: by 10.194.143.20 with SMTP id sa20mr32819962wjb.75.1426157211914; 
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id dj5sm9420736wjb.28.2015.03.12.03.46.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:50 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 6B460561FFD; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:40 +0000
Message-Id: <a5cfe3122eff72ba621693a30206ad0c278e9bdd.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 07/17] toastergui: update search fields
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:51 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We update the search fields for the machine suggestions
and recipes tables.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py       | 2 +-
 lib/toaster/toastergui/views.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 80e6d92..b941d4a 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -528,7 +528,7 @@ class Package_File(models.Model):
     size = models.IntegerField()
 
 class Recipe(models.Model):
-    search_allowed_fields = ['name', 'version', 'file_path', 'section', 'description', 'license', 'layer_version__layer__name', 'layer_version__branch', 'layer_version__commit', 'layer_version__layer__local_path', 'layer_version__layer_source__name']
+    search_allowed_fields = ['name', 'version', 'file_path', 'section', 'summary', 'description', 'license', 'layer_version__layer__name', 'layer_version__branch', 'layer_version__commit', 'layer_version__layer__local_path', 'layer_version__layer_source__name']
 
     layer_source = models.ForeignKey('LayerSource', default = None, null = True)  # from where did we get this recipe
     up_id = models.IntegerField(null = True, default = None)                    # id of entry in the source
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 5b481cb..90d47c6 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2378,7 +2378,7 @@ if toastermain.settings.MANAGED:
                     queryset_all = queryset_all.filter(layer_version__in =  prj.projectlayer_equivalent_set()).order_by("name")
 
                 search_token = request.GET.get('value','')
-                querysetall = queryset_all.filter(Q(name__icontains=search_token) | Q(description__icontains=search_token))
+                queryset_all = queryset_all.filter(Q(name__icontains=search_token) | Q(description__icontains=search_token))
 
                 return HttpResponse(jsonfilter({ "error":"ok",
                         "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ "]"}, queryset_all[:8])
-- 
1.9.1



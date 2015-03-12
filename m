Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 58B0673B41
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:48 +0000 (UTC)
Received: by wivr20 with SMTP id r20so19145466wiv.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=gBJ7FS6ju48pIvmgYznK4Ct/ATOzbi68sJLr2uBDZlU=;
	b=W3O8mlakkASVs1sniavkIer9tfpeQvBDK2UJFHuV2txUTNB0Bmqgg/KdAKbJzwvWAV
	nfusH6Tg7riTl8nOx89Qh37+zG3//xFgYhJ+SjQc6i4FzgjuWTMy/2z7Fx7K6SzIHuJf
	Ahw/DvPB7XUAVNvAs81nKR5JmSDyeAitm1GeMSf5YX8AE+rDQCWgmsBDEZBPq95Oc2vq
	DkX5rIJ/KsPI53i/glOab+OwoiqTsER3nFyi7420YKsxF2caYa6WWHckfXgFQrPxLNtf
	SEtOk4wnDiv7hIeBq+/T09ZEtYTUSBrdeVfcGNyxmUYqa5r9OGvF4Mj/GagXb2/g3ik5
	0p5Q==
X-Gm-Message-State: ALoCoQn8/ZqH0OazPhtPdaeJq4ZWCFG4HB7pKNzLT23xf43WGJy6fTdQemnALT2Yfy4I14hP+SZD
X-Received: by 10.194.236.200 with SMTP id uw8mr83915723wjc.10.1426157209980; 
	Thu, 12 Mar 2015 03:46:49 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id w8sm9459651wja.4.2015.03.12.03.46.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:49 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 67AB0561BD2; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:38 +0000
Message-Id: <c0705fff5fda9f59f01463170a483fe08aeff7a9.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 05/17] toastergui: improve performance in the all targets page
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:49 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch improves performance in the all targets display
by computing the preffered layer only for displayed targets,
instead of computing for all targets.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9f1fbca..5b481cb 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2752,21 +2752,21 @@ if toastermain.settings.MANAGED:
 
         queryset_with_search = _get_queryset(Recipe, queryset_all, None, search_term, ordering_string, '-name')
 
-        # get unique values for 'name' and 'version', and select the maximum ID for each entry (the max id is the newest one)
+        # get unique values for 'name', and select the maximum ID for each entry (the max id is the newest one)
         queryset_with_search_maxids = queryset_with_search.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')
 
-        queryset_with_search = queryset_with_search.filter(id__in=queryset_with_search_maxids).select_related('layer_version', 'layer_version__layer')
+        queryset_with_search = queryset_with_search.filter(id__in=queryset_with_search_maxids).select_related('layer_version', 'layer_version__layer', 'layer_version__up_branch')
 
-        objects = list(queryset_with_search)
-        for e in objects:
-            e.preffered_layerversion = e.layer_version.get_equivalents_wpriority(prj)[0]
 
         # retrieve the objects that will be displayed in the table; targets a paginator and gets a page range to display
-        target_info = _build_page_range(Paginator(objects, request.GET.get('count', 10)),request.GET.get('page', 1))
+        target_info = _build_page_range(Paginator(queryset_with_search, request.GET.get('count', 10)),request.GET.get('page', 1))
+
+        for e in target_info.object_list:
+            e.preffered_layerversion = e.layer_version.get_equivalents_wpriority(prj)[0]
 
 
         context = {
-            'projectlayerset' : jsonfilter(map(lambda x: x.layercommit.id, prj.projectlayer_set.all())),
+            'projectlayerset' : jsonfilter(map(lambda x: x.layercommit.id, prj.projectlayer_set.all().select_related("layercommit"))),
             'objects' : target_info,
             'objectname' : "targets",
             'default_orderby' : 'name:+',
-- 
1.9.1



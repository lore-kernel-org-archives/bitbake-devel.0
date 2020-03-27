Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 by mx.groups.io with SMTP id smtpd.web11.174.1585349540288656524
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Mar 2020 15:52:20 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.146.13, mailfrom: david.reyna@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 02RMqKfH006843
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 Mar 2020 15:52:20 -0700 (PDT)
Received: from honig-Precision-T5600.corp.ad.wrs.com (147.11.209.184) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Mar 2020 15:52:19 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 3/4] toaster: FieldError loading Reverse runtime dependencies
Date: Fri, 27 Mar 2020 15:51:01 -0700
Message-ID: <d2dc88704f8b9ae39623c784f09068fd22dea564.1585348962.git.david.reyna@windriver.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585348962.git.david.reyna@windriver.com>
References: <cover.1585348962.git.david.reyna@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When selecting reverse runtime dependencies, filter on simply 'depends_on'
instead of the obsolete 'depends_on__name' or 'depends_on__size'.

[YOCTO #13717]

Signed-off-by: Ahmed.Hossam <Ahmed.Hossam@opensynergy.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index ae1973ff24..9a5e48e3bb 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1191,7 +1191,7 @@ def package_included_reverse_dependencies(request, build_id, target_id, package_
         return _redirect_parameters( 'package_included_reverse_dependencies', request.GET, mandatory_parameters, build_id = build_id, target_id = target_id, package_id = package_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Package_File)
 
-    queryset = Package_Dependency.objects.select_related('depends_on__name', 'depends_on__size').filter(depends_on=package_id, target_id=target_id, dep_type=Package_Dependency.TYPE_TRDEPENDS)
+    queryset = Package_Dependency.objects.select_related('depends_on').filter(depends_on=package_id, target_id=target_id, dep_type=Package_Dependency.TYPE_TRDEPENDS)
     objects = _get_queryset(Package_Dependency, queryset, filter_string, search_term, ordering_string, 'package__name')
 
     package = Package.objects.get(pk=package_id)
-- 
2.20.1


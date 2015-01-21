Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
	[74.125.82.174])
	by mail.openembedded.org (Postfix) with ESMTP id B7F0172CF2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:22:17 +0000 (UTC)
Received: by mail-we0-f174.google.com with SMTP id x3so11153461wes.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=FXUQGwq8+9VKshdJr7q8+Sj4QCuoz64u0LATBn2BjKQ=;
	b=a0P8fKqx3k1KDsecRSMmSpHCJO1eb5elWkuERWkuM3G5zxlH4E7kjud+liyXCjBdXZ
	bDo96WTi0sosmbPV4CQNHVUHccvlWsbpATCtI+5+nwEdJCyYUoh95LLUy3Ha4FHkrCpC
	OCQD0MTsKzHkatiYquoJybb/FJ5oSClayiFTInV4upuhOBTCsENgnhWPU9Sij432txnx
	KzLX5fmZQFQmBs5QC5f/y2jrmjf1HzKUgP9nM1Wx1XfMQIWIIlRR4Fbi09xLs0bXga/i
	bryOk1UHrv63rLIwg8CxvKKbItlH0bEi+eVOOKijOie0VHcvYB08wfl5HaSkYjbN0h6m
	nlHg==
X-Gm-Message-State: ALoCoQnUtdZrZLJtZisUv7FzwwG1WJWORg4BuC7sgRj8tS4rcW1gV45kHcQT09vLyOUaexUBZSTU
X-Received: by 10.180.91.107 with SMTP id cd11mr59551269wib.58.1421864537338; 
	Wed, 21 Jan 2015 10:22:17 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ud4sm8304179wib.0.2015.01.21.10.22.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:22:16 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E12EC563FA9; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:31 +0000
Message-Id: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 01/12] toastergui: save cookie for orderby/page size settings
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:18 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We save the current settings as cookies on the server side
for the layers, targets and machines pages under Project pages.

[YOCTO #6961]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/targets.html |  2 --
 lib/toaster/toastergui/views.py               | 15 +++++++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/templates/targets.html b/lib/toaster/toastergui/templates/targets.html
index cc339fb..590ecb9 100644
--- a/lib/toaster/toastergui/templates/targets.html
+++ b/lib/toaster/toastergui/templates/targets.html
@@ -39,7 +39,6 @@
 
 {% include "basetable_top.html" %}
     {% for o in objects %}
-    {% if o.name %}
     <tr class="data">
         <td class="target">
                 {{o.name}}
@@ -79,7 +78,6 @@
             </a>
         </td>
     </tr>
-    {% endif %}
     {% endfor %}
 {% include "basetable_bottom.html" %}
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 5fcad63..4d00fbd 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2560,7 +2560,10 @@ if toastermain.settings.MANAGED:
             ]
         }
 
-        return render(request, template, context)
+        response = render(request, template, context)
+        _save_parameters_cookies(response, pagesize, orderby, request)
+
+        return response
 
     def layerdetails(request, layerid):
         template = "layerdetails.html"
@@ -2626,7 +2629,7 @@ if toastermain.settings.MANAGED:
         (filter_string, search_term, ordering_string) = _search_tuple(request, Recipe)
 
         prj = Project.objects.get(pk = request.session['project_id'])
-        queryset_all = Recipe.objects.filter(Q(layer_version__up_branch__name= prj.release.name) | Q(layer_version__build__in = prj.build_set.all()))
+        queryset_all = Recipe.objects.filter(Q(layer_version__up_branch__name= prj.release.name) | Q(layer_version__build__in = prj.build_set.all())).filter(name__regex=r'.{1,}.*')
 
         queryset_with_search = _get_queryset(Recipe, queryset_all, None, search_term, ordering_string, '-name')
 
@@ -2711,8 +2714,10 @@ if toastermain.settings.MANAGED:
                     }
                 }, ]
 
+        response = render(request, template, context)
+        _save_parameters_cookies(response, pagesize, orderby, request)
 
-        return render(request, template, context)
+        return response
 
     def machines(request):
         template = "machines.html"
@@ -2783,8 +2788,10 @@ if toastermain.settings.MANAGED:
 
             ]
         }
+        response = render(request, template, context)
+        _save_parameters_cookies(response, pagesize, orderby, request)
 
-        return render(request, template, context)
+        return response
 
 
     def get_project_configvars_context():
-- 
1.9.1



Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id E8AB272CED
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:22:19 +0000 (UTC)
Received: by mail-wg0-f51.google.com with SMTP id l18so19271400wgh.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=qBtl3JcFnaPXHZgx1i++j48QoixG0qWq7MXdBp/cP7Q=;
	b=jINaznTGSvP1RvpjSMLE/O2KOgG2RAbP1YlX+E5gDK+aI8aMEcFvj7g8zjeUQ7WR1x
	rEMSpvIWVzk9pa1fwKfQxvabW3s/xSOOcEFWz5c0Mb45Tf9hFlnqUmt2cgsq7kcU2wPJ
	a+mISWSa9guGV5s9uOZ4zCsvWK1y8xv4Gg77yOFQTq3D41CuoeJlJ9BacGcrCPfa2GK3
	763ZlXOrOStSeRUqeEZOy5Y4Fa8Fq0RCC6Eoi/lhBy7Wo/iR0+CGxUpeBQQodhcEZKTC
	Y0Hl2yUwQQgeWZfaMu4OBALc5AMcfh3Xz91J32JH6jKNVD3x0i2UJH/94Qp43rWS/+y+
	yJXQ==
X-Gm-Message-State: ALoCoQk5m9vDi0bE8sUSuV73tg4RzW84+Y5ribrdJzhJXrSE0GCurukv5OCHFFroP6nfOoHvg3iX
X-Received: by 10.180.212.113 with SMTP id nj17mr3434853wic.54.1421864539733; 
	Wed, 21 Jan 2015 10:22:19 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id cs8sm8313933wib.1.2015.01.21.10.22.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:22:17 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E5FE9564071; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:34 +0000
Message-Id: <2e2776b288ff58e0f09d3fa7d15c1d975414e585.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 04/12] toastergui: "Run again" button in build pages
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:21 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the "Run again" button for the completed builds.

[YOCTO #7173]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/projectapp.js            | 2 +-
 lib/toaster/toastergui/templates/managed_mrb_section.html | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 0bdc55a..74471a1 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -339,7 +339,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
     $scope.buildExistingTarget = function(targets) {
         var oldTargetName = $scope.targetName;
         $scope.targetName = targets.map(function(v,i,a){return v.target}).join(' ');
-        $scope.targetNamedBuild();
+        $scope.buildNamedTarget();
         $scope.targetName = oldTargetName;
     }
 
diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index d4959a0..da5a3f7 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -53,8 +53,8 @@
               <span class="lead{%if not MANAGED or not build.project%} pull-right{%endif%}">
                 Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
               </span>
-          {% if MANAGED and build.project %}
-              <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick="scheduleBuild({% url 'xhr_projectbuild' build.project.id as bpi%}{{bpi|json}}, {{build.project.name|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})">Run again</a>
+          {% if build.project %}
+              <button class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' build.project.id as bpi%}{{bpi|json}}, {{build.project.name|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
           {% endif %}
             </div>
     {%endif%}
-- 
1.9.1



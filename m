Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 07A0773B48
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:50 +0000 (UTC)
Received: by wghk14 with SMTP id k14so15364121wgh.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=uZxrzHRYtO+qBQVUj00dtRoOgS4OMu45yZUfA9b66Ts=;
	b=bi+GxUZgZFQ/8CKWP8Cmz3NQAVnoUhrqRHrnleAhX7VEuCiX2FBknH2D82GzcLbjns
	FgrzUxx4bjSZA49yJIxuwQHtp/sqq/xFsOhHh0ZiV7+WmE72YykI8tvuHM4Ad4khdZvw
	1bHCzKCc86cmcWXBOkcOXQ3JZBsZFmszEzDUPLdDqHONLDHc/PybQ8qlSSxbsfGRaCic
	vnaWbYaHbU9895pwL1Dxld33RssrKJFFDqYHFlvbPTumnwuTRU0oLjpaRaaetBibD5sq
	dZ1nSgVeB5TM3vsJ2iFT7dJRawZEf8amGKH02UDvhe72ZXx5SUvu65FDHqUibD1ismPN
	qQdw==
X-Gm-Message-State: ALoCoQnYRjJ/pm40eDL2fil8mGkG0iFQ7A+ntXsMJo3xJ+u6/cSK1MSJ/gVs21EXuJpuzK9mn3H6
X-Received: by 10.194.122.98 with SMTP id lr2mr88084011wjb.115.1426157211284; 
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	nd15sm10115172wic.8.2015.03.12.03.46.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:50 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 604095618E3; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:34 +0000
Message-Id: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 01/17] toastergui: project page - consistent error display
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

We modify the project page to provide a consistent view of the
build errors. The display is now similar with the
managed_mrb_section and links point to the buildrequest
detail view.

[YOCTO #7188]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/project.html | 50 +++++++++++++++------------
 lib/toaster/toastergui/views.py               |  5 ++-
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 54590ee..039601f 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -130,29 +130,35 @@ vim: expandtab tabstop=2
         <switch ng-switch="b.status">
 
           <case ng-switch-when="failed">
-            <div class="lead span3"> <span ng-repeat="t in b.targets" ng-include src="'target_display'"></span></div>
-            <div >
-                <button class="btn pull-right btn-danger" ng-click="buildExistingTarget(b.targets)">Run again</button>
+            <div class="lead span3">
+              <a ng-class="{'succeeded': 'success', 'failed': 'error'}[b.status]" href="{[b.br_page_url]}">
+                <span ng-repeat="t in b.targets" ng-include src="'target_display'"></span>
+              </a>
             </div>
-            <div class="row-fluid">
-              <div class="air well" ng-repeat="e in b.errors">
-                    <pre>{[e.msg]}</pre>
-                  <ngif ng-if="e.msg.indexOf('Nothin') == 0">
-                    <div ng-repeat="t in getTargetNameFromErrorMsg(e.msg)">
-                     <p class="lead">The target <strong>{[t]}</strong> is not provided by any of your project layers.</p>
-                     <p> Your build has failed because the target <strong>{[t]}</strong> is not provided by any of your project layers.</p>
-                     <ngif ng-if="layersForTargets[t].length > 0">
-                       <p>The following layers provide this target. You could add one of them to your project.</p>
-                       <button class="btn btn-danger add-layer-with-dependencies" ng-repeat="l in layersForTargets[t]" ng-click="layerAddById(l.id)">Add {[l.name]}</button>
-                     </ngif>
-                    </div>
-                  </ngif>
-                  <ngif ng-if="e.msg.indexOf('Nothin') != 0">
-                    <p>
-                    Please contact your system administrator to help troubleshoot this error.
-                    </p>
-                  </ngif>
-              </div>
+            <div class="span2 lead">
+              <ngif ng-if="b.updated - todaydate > 0">
+                 {[b.updated|date:'HH:mm']}
+              </ngif>
+              <ngif ng-if="b.updated - todaydate < 0">
+                 {[b.updated|date:'dd/MM/yy HH:mm']}
+              </ngif>
+            </div>
+            <div class="span2">
+              <ngif ng-if="b.errors.length">
+                <span>
+                  <i class="icon-minus-sign red lead"></i>
+                  <a href="{[b.br_page_url]}#errors" class="lead error">{[b.errors.length]}
+                  <ng-pluralize count="b.errors.length" when="{'1':'error','other':'errors'}"></ng-pluralize></a>
+                </span>
+              </ngif>
+            </div>
+            <div class="span2">
+              <!-- we don't have warnings in this case -->
+            </div>
+            <div> <span class="lead">Build time: {[b.command_time|timediff]}</span>
+                <button class="btn pull-right" ng-class="{'succeeded':  'btn-success', 'failed': 'btn-danger'}[b.status]"
+                    ng-click="buildExistingTarget(b.targets)">Run again</button>
+
             </div>
           </case>
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 8034cfc..1e9df3f 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -66,7 +66,10 @@ def _project_recent_build_list(prj):
             "id":  x.pk,
             "targets" : map(lambda y: {"target": y.target, "task": y.task }, x.brtarget_set.all()),
             "status": x.get_state_display(),
-            "errors": map(lambda y: {"type": y.errtype, "msg": y.errmsg, "tb": y.traceback}, x.brerror_set.exclude(errmsg__contains="Command Failed")),
+            "errors": map(lambda y: {"type": y.errtype, "msg": y.errmsg, "tb": y.traceback}, x.brerror_set.all()),
+            "updated": x.updated.strftime('%s')+"000",
+            "command_time": (x.updated - x.created).total_seconds(),
+            "br_page_url": reverse('buildrequestdetails', args=(x.project.id, x.pk) ),
             "build" : map( lambda y: {"id": y.pk,
                         "status": y.get_outcome_display(),
                         "completed_on" : y.completed_on.strftime('%s')+"000",
-- 
1.9.1



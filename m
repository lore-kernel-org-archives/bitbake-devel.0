Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
	[209.85.192.180])
	by mail.openembedded.org (Postfix) with ESMTP id B10D4736F1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:05 +0000 (UTC)
Received: by pdbfp1 with SMTP id fp1so34717121pdb.9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=e63KUxp3Qa4nlLOE+xL25YBjMJLEoi6lV+L6mlBHdrI=;
	b=ADC84ZexHn1ZchlSr/m2UmE6xL39vdEyikrqHycZNhdbMS76aSnUzw3GW/Tpv3zKdH
	sABG9WrCQArNnlXxCkJcPXYbZPGDhviEHCaqqBHd/aou/AaTFnX9msL5YUI0UsiPXEfk
	k4U/cu5uelzZfcXr/JmAOIA1Od6xoBM/S1sARVu8u70KfCFjX0Z/gMZN855WPE//SvrU
	FbwJcuagD5njRk1vb0rDihcj/2iXQWBEoCVLISpADG84GBzRdnlpr1ZJxh+6QD4V8ad5
	YcS5UuACK7Ei8DV6kLJrilM5EDv+BU8OOFleHBGYcvuKb5Afxs/EwjvYTPbqFvslfwiI
	2xDA==
X-Gm-Message-State: ALoCoQk/dKGbKFQ69xdaZ5f+n/UY/jghYEUHCLn6X65nN51Vwp/bIwn+NdQU6RQr8x1nlrc8ln5x
X-Received: by 10.68.168.101 with SMTP id zv5mr5384969pbb.104.1424798466472;
	Tue, 24 Feb 2015 09:21:06 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id v2sm39530239pdm.77.2015.02.24.09.21.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:05 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 914E25617F6; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:50 +0000
Message-Id: <12913819c63d92bcd34ee7765413252e3fa22a3a.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 02/12] toaster: layerdetails summary/descriptions to be searchable
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:05 -0000

From: Michael Wood <michael.g.wood@intel.com>

Allow the descriptions of the machine summary and layer description to
be searchable in their respective tables.

[YOCTO #7199]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html |  2 +-
 lib/toaster/toastergui/views.py                    | 42 +++++++++++++---------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index c162c8b..6c803ff 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -257,7 +257,7 @@
                           <i class="icon-question-sign get-help" title="The recipe version and revision"></i>
                           Target version
                         </th>
-                        <th class="span4">Description</th>
+                        <th class="span4">Summary</th>
                         <th class="span2">Build target</th>
                       </tr>
                     </thead>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index be74c10..196e66e 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2622,31 +2622,39 @@ if toastermain.settings.MANAGED:
 
         layer_version = Layer_Version.objects.get(pk = layerid)
 
+        targets_query = Recipe.objects.filter(layer_version=layer_version)
+
         # Targets tab query functionality
         if request.GET.has_key('targets_search'):
-            targets = Paginator(Recipe.objects.filter(layer_version=layer_version,name__icontains=request.GET['targets_search']).order_by("name"), limit)
-        else:
-            targets = Paginator(Recipe.objects.filter(layer_version=layer_version).order_by("name"), limit)
+            targets_query = targets_query.filter(
+                Q(name__icontains=request.GET['targets_search']) |
+                Q(summary__icontains=request.GET['targets_search']))
+
+        targets = Paginator(targets_query.order_by("name"), limit)
 
         if request.GET.has_key("tpage"):
-          try:
-              targets = targets.page(request.GET['tpage'])
-          except EmptyPage:
-              targets = targets.page(targets.num_pages)
+            try:
+                targets = targets.page(request.GET['tpage'])
+            except EmptyPage:
+                targets = targets.page(targets.num_pages)
         else:
             targets = targets.page(1)
 
+        machines_query = Machine.objects.filter(layer_version=layer_version)
+
         # Machines tab query functionality
         if request.GET.has_key('machines_search'):
-          machines = Paginator(Machine.objects.filter(layer_version=layer_version,name__icontains=request.GET['machines_search']).order_by("name"), limit)
-        else:
-          machines = Paginator(Machine.objects.filter(layer_version=layer_version).order_by("name"), limit)
+            machines_query = machines_query.filter(
+                Q(name__icontains=request.GET['machines_search']) |
+                Q(description__icontains=request.GET['machines_search']))
+
+        machines = Paginator(machines_query.order_by("name"), limit)
 
         if request.GET.has_key("mpage"):
-          try:
-            machines = machines.page(request.GET['mpage'])
-          except EmptyPage:
-            machines = machines.page(machines.num_pages)
+            try:
+                machines = machines.page(request.GET['mpage'])
+            except EmptyPage:
+                machines = machines.page(machines.num_pages)
         else:
             machines = machines.page(1)
 
@@ -2787,9 +2795,9 @@ if toastermain.settings.MANAGED:
         # Now we need to weed out the layers which will appear as duplicated
         # because they're from a layer source which doesn't need to be used
         for machine in queryset_all:
-           to_rm = machine.layer_version.get_equivalents_wpriority(prj)[1:]
-           if len(to_rm) > 0:
-             queryset_all = queryset_all.exclude(layer_version__in=to_rm)
+            to_rm = machine.layer_version.get_equivalents_wpriority(prj)[1:]
+            if len(to_rm) > 0:
+               queryset_all = queryset_all.exclude(layer_version__in=to_rm)
 
         machine_info = _build_page_range(Paginator(queryset_all, request.GET.get('count', 100)),request.GET.get('page', 1))
 
-- 
1.9.1



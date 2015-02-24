Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
	[209.85.192.178])
	by mail.openembedded.org (Postfix) with ESMTP id BC7FB73733
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:04 +0000 (UTC)
Received: by pdbfp1 with SMTP id fp1so34702904pdb.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=pKqK3/E2eWxqWZQjnwjdNJMyazPTi9zEq9rhTFx5Lbk=;
	b=mLJSr+QhyBWKBHvjjwgu4jjA5S3UiHim49/k/MR9Jx06det+wmaK8GUSUg6Za1eIXA
	ZomobWjbHCPmoiHb2bpLxLjub+J2Mt7jbG+57KUFh39tDsHKyqEmRiWnUy0aSHZx2X3o
	m8jlNpkHk9yoOVxSENtKSLoafcA4lxok0K4i0qE6p4os0FnuhctG+oVLYimCSX+dCazb
	aSonR2ezOeIQioO5TeMKuAYDQGJlPfSw9mvN4bZmXciOuvljPGhrnwJHqoKTgW4oHRoU
	L70pBHH8t+SFpofeEI0B5FnbgiqcPaD+E2jWJG8v7eg57dJN34ENM2+6dHakXVFSuSh1
	hCjQ==
X-Gm-Message-State: ALoCoQlnMkTEWApwIOvWddY/2U5UFK7BnRotZZWuEGOfQ2RYopf1nO9hLImxAuOnucHSoyhwl5lD
X-Received: by 10.66.63.72 with SMTP id e8mr29814096pas.3.1424798466054;
	Tue, 24 Feb 2015 09:21:06 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	cq5sm36431578pbc.79.2015.02.24.09.21.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:04 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 943BC561810; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:52 +0000
Message-Id: <803b7803bd8bcc1e20fc77467ed21ea32dc58a47.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 04/12] toaster: layerdetails Fix pagination controls
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:04 -0000

From: Michael Wood <michael.g.wood@intel.com>

Bring the pagination controls into line with others in toaster by
limiting the number of page buttons to 5

[YOCTO #7195]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/layerdetails.html |  4 ++--
 lib/toaster/toastergui/views.py                    | 20 ++------------------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 49c62c6..1f48c65 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -287,7 +287,7 @@
                       {%else%}
                       <li class="disabled"><a href="#">&laquo;</a></li>
                       {%endif%}
-                      {% for i in targets.paginator.page_range %}
+                      {% for i in targets.page_range %}
                       <li {%if i == targets.number %} class="active" {%endif%}><a href="?tpage={{i}}#targets">{{i}}</a></li>
                       {% endfor %}
                       {%if targets.has_next%}
@@ -418,7 +418,7 @@
                       {%else%}
                       <li class="disabled"><a href="#">&laquo;</a></li>
                       {%endif%}
-                      {% for i in machines.paginator.page_range %}
+                      {% for i in machines.page_range %}
                       <li {%if i == machines.number %} class="active" {%endif%}><a href="?mpage={{i}}#machines">{{i}}</a></li>
                       {% endfor %}
                       {%if machines.has_next%}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 196e66e..0284b1a 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2630,15 +2630,7 @@ if toastermain.settings.MANAGED:
                 Q(name__icontains=request.GET['targets_search']) |
                 Q(summary__icontains=request.GET['targets_search']))
 
-        targets = Paginator(targets_query.order_by("name"), limit)
-
-        if request.GET.has_key("tpage"):
-            try:
-                targets = targets.page(request.GET['tpage'])
-            except EmptyPage:
-                targets = targets.page(targets.num_pages)
-        else:
-            targets = targets.page(1)
+        targets = _build_page_range(Paginator(targets_query.order_by("name"), limit), request.GET.get('tpage', 1))
 
         machines_query = Machine.objects.filter(layer_version=layer_version)
 
@@ -2648,15 +2640,7 @@ if toastermain.settings.MANAGED:
                 Q(name__icontains=request.GET['machines_search']) |
                 Q(description__icontains=request.GET['machines_search']))
 
-        machines = Paginator(machines_query.order_by("name"), limit)
-
-        if request.GET.has_key("mpage"):
-            try:
-                machines = machines.page(request.GET['mpage'])
-            except EmptyPage:
-                machines = machines.page(machines.num_pages)
-        else:
-            machines = machines.page(1)
+        machines = _build_page_range(Paginator(machines_query.order_by("name"), limit), request.GET.get('mpage', 1))
 
         context = {
             'layerversion': layer_version,
-- 
1.9.1



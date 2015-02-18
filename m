Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com
	[74.125.82.172])
	by mail.openembedded.org (Postfix) with ESMTP id D4A90735CC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:11:09 +0000 (UTC)
Received: by wesk11 with SMTP id k11so3038961wes.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=WjrmXcqVpg2HHNiUheV6tzstCDc6LK8384+1dqmat+0=;
	b=SxYVTcSOxh8Qt91aFJyJH6DD7ckjDpAkHvZ+VopbeTpdg+X6MB1Fk60e6kMg7pkCAH
	w3kmryatAYY2gm24KEbt07Q/sGbzwszFy6ualrnbN4SSVU7fSSbWjFEjSP+A3fjMbqMU
	HDRBJTvXb6YFR7mVtZJFYhtjeY6G99EoRAG9/O7a/mcEx3sJPjTjkIKh+yJ1FjPCD92Y
	9+b5Dk1hr30Jg8CZl1vB1VRdYgamYutc88EYhu4BfuM2kJVlfqy35do2gBQFfFGvzAjQ
	gYjJeDfjyvH2ZpEwLhOXFDRr9RRv2kiJk8SgTFsgrofcTBCA/6ipnDLwWruZ5uvEy+Lf
	q0rA==
X-Gm-Message-State: ALoCoQkK0GWvULYC22nEoxSlxNj3IOtTcwQoZD4HqpeBywe7JYkk7pijCeMI4PNhCnoup25ahouf
X-Received: by 10.180.10.71 with SMTP id g7mr8018464wib.26.1424286670442;
	Wed, 18 Feb 2015 11:11:10 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id j6sm26155640wiz.17.2015.02.18.11.11.08
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:11:09 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 50869561FE7; Wed, 18 Feb 2015 19:11:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:11:04 +0000
Message-Id: <605298ff3ce919127003dadef95798472327f943.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
References: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424286571.git.alexandru.damian@intel.com>
References: <cover.1424286571.git.alexandru.damian@intel.com>
Subject: [PATCH 10/10] toaster: importlayer Remove description input field
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
X-List-Received-Date: Wed, 18 Feb 2015 19:11:10 -0000

From: Michael Wood <michael.g.wood@intel.com>

This wasn't required or working due to a typo and adds ambiguity between
the summary and description. The correct method for changing the description
or summary is via the layerdetails page.

[YOCTO #7190]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js   | 1 -
 lib/toaster/toastergui/templates/importlayer.html | 6 ------
 lib/toaster/toastergui/views.py                   | 3 ---
 3 files changed, 10 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index e782bda..9d54286 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -136,7 +136,6 @@ function importLayerPageInit (ctx) {
         name: layerNameInput.val(),
         vcs_url: vcsURLInput.val(),
         git_ref: gitRefInput.val(),
-        summary:  $("#layer-summary").val(),
         dir_path: $("#layer-subdir").val(),
         project_id: ctx.projectId,
         layer_deps: layerDepsCsv,
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index a4d8ee1..1196e0c 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -84,12 +84,6 @@
                             </div>
                           </div>
 
-                          <label class="project-form" for="layer-description">Layer description
-                            <span class="muted">(optional)</span>
-                            <span class="icon-question-sign get-help" title="A short layer explanation" />
-                          </label>
-                          <textarea id="layer-description" class="input-xxlarge"></textarea>
-
                     </fieldset>
                     <fieldset class="air">
                         <legend>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index bf148e2..be74c10 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2422,9 +2422,6 @@ if toastermain.settings.MANAGED:
             if layer_created:
                 layer.layer_source = layer_source
                 layer.vcs_url = post_data['vcs_url']
-                if post_data.has_key('summary'):
-                    layer.summary = layer.description = post_data['summary']
-
                 layer.up_date = timezone.now()
                 layer.save()
             else:
-- 
1.9.1



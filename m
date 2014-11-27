Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 1F963723A5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:12 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id y19so6947713wgg.28
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=5fk0tNwlqfLC/cWLBGPrQLKvbRbvBBmZUrJcCskGpAY=;
	b=HF3TK/riA/Bdof9g1lrdGHNuEEdCNMD7bjLkfGC1hiSNrq6vcdR6wINUMWVhbYeoSW
	vEW58BkUMaLt2eTh6f3VOlBXZldHiSf/fb3t2RokqPrYbaB2YqM/QF9/d/z2Z4sVPs3J
	CQTeNpD2mNWG57twJN/rNEv4TBsWKTKHLrK8//here+EXvrWmTARuS3+fvvnuEsBQw/G
	o6QDtgkK6/ufAK2yIw9b5hXmre3ju6O4GNy6T5n6BcxY2Xp6q3x7iQMQLIi0ZdVqyu4E
	CoFTAl+d7YxcU9Z1iMT4sFqhdIn2ZawMZCUuVLsEB1xTj7PulTrKYvvb0q5U4LpLCW8U
	h64Q==
X-Gm-Message-State: ALoCoQlQPLYtj1j0NFKok9KPK9OoOAAF8JBVxPqohtcug8PG40P7mEousfPN4Si8E8/gZO3vvRYf
X-Received: by 10.194.2.244 with SMTP id 20mr61418358wjx.4.1417108093272;
	Thu, 27 Nov 2014 09:08:13 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id e16sm2795445wik.2.2014.11.27.09.08.10
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0DC635641F9; Thu, 27 Nov 2014 17:08:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:08:02 +0000
Message-Id: <d1cd8b229c402fae3499e35415ad79c0e11ee517.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Subject: [PATCH 11/14] toaster: fix padding of build notifications
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:13 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In managed mode, we show the name of the project in the build
notifications of the all builds page. The way we show the
project requires modifying the default padding of the .alert
class. This patch makes sure the padding modification is
only applied in managed mode, i.e., when the project name
needs to be shown.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/css/default.css     | 4 ++++
 lib/toaster/toastergui/templates/mrb_section.html | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index dcb8e34..199c753 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -136,6 +136,10 @@ select { width: auto; }
 .new-build .alert { margin-top: 10px; }
 .new-build .alert p { margin-top: 10px; }
 
+/* styles for showing the project name in build mode */
+.project-name { padding-top: 0; }
+.project-name .label { font-weight: normal; margin-bottom: 5px; margin-left: -15px; padding: 5px; }
+
 /* Remove bottom margin for forms inside modal dialogs */
 #dependencies_modal_form { margin-bottom: 0px; }
 
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 33afb7b..73031e2 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -12,9 +12,9 @@
   </div>
   <div id="latest-builds">
   {% for build in mru %}
-    <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}" style="padding-top: 0;">
+    <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%} {% if MANAGED and build.project %}project-name{% endif %} ">
     {% if MANAGED and build.project %}
-       <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-danger{%else%}label-info{%endif%}" style="font-weight: normal; margin-bottom: 5px; margin-left:-15px; padding-top:5px;"> {{build.project.name}} </span>
+       <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-danger{%else%}label-info{%endif%}"> {{build.project.name}} </span>
     {% endif %}
 
         <div class="row-fluid">
-- 
1.9.1



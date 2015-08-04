Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 9E0877646E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 15:07:39 +0000 (UTC)
Received: by wibud3 with SMTP id ud3so181488350wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 04 Aug 2015 08:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	bh=1+5N3saZwBg2mVHBzwnWBb9GhHS2U7rewcpXq0MDIsQ=;
	b=loEtb9DUuWwgX8B4KZ+s+L/Xw/5mMAYNClF+MCA1Lf1fI4rJQxgoQLqgr7PgdHmwdp
	7yM8wuzPaK2wLrctWKKeL3AytM6SnZ+feyeFDz3NogCqR1Cz5U3r2JBRTIkscvxXb5Ul
	ajx4xpEP162Hgmgv3U4iglCnOk/3zjA8Uiv/rwLKBanULgu7thglDpjXW4WhF7Kdfvza
	IUj0Q2n4mjmEpYefQ0Jj5pFj+TyQkkwDihkaudUcg70i5Eene/GctuxxbnDNUOUo60rd
	llK0u8yzhh5ZpGUuLh0z3FEAD1HdnHr3H9ycVCkvP6kpxraPkn+cXIrWugHzA5UoWos9
	RoCw==
X-Gm-Message-State: ALoCoQkbJY2Mlhbg0bqSVjj17qHhl02T78/F3xs42b/n7zyH0VhR5njzgA47AcSgSxLDIHvLv8/p
X-Received: by 10.180.10.164 with SMTP id j4mr9021542wib.29.1438700859568;
	Tue, 04 Aug 2015 08:07:39 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	gm20sm2314260wjc.17.2015.08.04.08.07.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 04 Aug 2015 08:07:38 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 16:07:07 +0100
Message-Id: <1438700831-26829-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
References: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
MIME-Version: 1.0
Subject: [PATCH 2/6] bitbake: toastergui: breadcrumb fixes
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
X-List-Received-Date: Tue, 04 Aug 2015 15:07:42 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Belen Barros Pena <belen.barros.pena@intel.com>

Make sure that we use the correct html entity
for the breadcrumb dividers, and remove the
'all builds' item from the history pages: all
breadcrumbs should now have the project name as
their first element, since the 'all builds' page
can be reached using the global naviation in the
top bar.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/basebuilddetailpage.html | 3 +--
 lib/toaster/toastergui/templates/basebuildpage.html       | 3 +--
 lib/toaster/toastergui/templates/layerdetails.html        | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basebuilddetailpage.html b/lib/toaster/toastergui/templates/basebuilddetailpage.html
index d324c90..8657845 100644
--- a/lib/toaster/toastergui/templates/basebuilddetailpage.html
+++ b/lib/toaster/toastergui/templates/basebuilddetailpage.html
@@ -6,14 +6,13 @@
 <!-- Breadcrumbs -->
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
-            <li><a href="{% url 'all-builds' %}">All builds</a></li>
             <li><a href="{% url 'project' build.project.id %}">{{build.project.name}}</a></li>
             <li><a href="{%url 'builddashboard' build.pk%}">{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} ({{build.completed_on|date:"d/m/y H:i"}})</a></li>
             {% block localbreadcrumb %}{% endblock %}
         </ul>
         <script>
         $( function () {
-            $('#breadcrumb > li').append("<span class=\"divider\">→</span>");
+            $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
             $('#breadcrumb > li:last').addClass("active");
             $('#breadcrumb > li:last > span').remove();
         });
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 105ad85..f399ba4 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -8,7 +8,6 @@
 <!-- Breadcrumbs -->
     <div class="section">
         <ul class="breadcrumb" id="breadcrumb">
-            <li><a href="{% url 'all-builds' %}">All builds</a></li>
             <li><a href="{% url 'project' build.project.id %}">{{build.project.name}}</a></li>
             <li>
             {% block parentbreadcrumb %}
@@ -21,7 +20,7 @@
         </ul>
         <script>
         $( function () {
-            $('#breadcrumb > li').append("<span class=\"divider\">→</span>");
+            $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
             $('#breadcrumb > li:last').addClass("active");
             $('#breadcrumb > li:last > span').remove();
 	    console.log("done");
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 2f875eb..f7f5685 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -9,10 +9,10 @@
   <ul class="breadcrumb">
     <li>
       <a href="{% url 'project' project.id %}">{{project.name}}</a>
-      <span class="divider">→</span>
+      <span class="divider">&rarr;</span>
     </li>
     <li><a href="{% url 'projectlayers' project.id %}">Compatible layers</a>
-      <span class="divider">→</span>
+      <span class="divider">&rarr;</span>
     </li>
     <li>
       {{layerversion.layer.name}} ({{layerversion.get_vcs_reference|truncatechars:13}})
-- 
2.1.4



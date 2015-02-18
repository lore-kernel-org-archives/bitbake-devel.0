Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id BF78B735C5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:11:07 +0000 (UTC)
Received: by mail-wg0-f46.google.com with SMTP id a1so3057163wgh.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=NCnDgvOAnlagujha1eMXisRC+S2q8i1x228MXy/OJjI=;
	b=Uh1fkdTuPVx9dpHSmwCWLmh7GmmJ0uMgF5uxIFpqlg4BLZldh14Vh92DNPhW+BXBfA
	GVuAGID9kOKQpDN0sUmTGrzWBB2E6oJAH/3QMjPoGtibn7sOz1aAMEZZ06M3+Q42P6pG
	BiifSc40ylO0CO5JYpXPCmxAfhztDtbx8yvzXEsoOqL8ImhhbJvkiZKJDSnrvNoSJC85
	6of5WrbmlZhEu/wu9MDltBczW+Wptn0liRYAdPoftc2Qhgfmtsu3V2FIo5EpNmyaPOfk
	K3IoXAZNQRDeOlbrv7DKKgHEMJvk9HRx4dEjSVAVve5QDaD4FQOpX42xbBRmRnGs5FZE
	n9rg==
X-Gm-Message-State: ALoCoQlUkTS2VvMQobdisaan5DCRnwssHykg7J7gTuzH9MYYml0X1ZZYdhIGPw88fs8wjUV8Dit4
X-Received: by 10.180.73.205 with SMTP id n13mr3043665wiv.64.1424286669087;
	Wed, 18 Feb 2015 11:11:09 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	mb20sm26075575wic.18.2015.02.18.11.11.06
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:11:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 4D2EC561F97; Wed, 18 Feb 2015 19:11:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:11:02 +0000
Message-Id: <8365f19191d0ec5901c79b7afd5005f7a546fe74.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
References: <fad80e36c9da663b000cdf2cb3c75440c6431d84.1424286571.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424286571.git.alexandru.damian@intel.com>
References: <cover.1424286571.git.alexandru.damian@intel.com>
Subject: [PATCH 08/10] toasterui: style the Toaster version information
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

From: Belen Barros Pena <belen.barros.pena@intel.com>

In debug mode, we show the Toaster version and mode in the
top bar. Display them inside a tooltip that appears when
you hover over a nice info icon to make them less conspicuous.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/css/default.css | 22 ++++------------------
 lib/toaster/toastergui/templates/base.html    | 13 ++++++-------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index 41b73cc..86cf67a 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -2,24 +2,10 @@
 .logo img { height: 30px; width: auto !important; }
 .logo { padding-top: 4px !important; padding-bottom:0px !important; }
 
-/* style the version text */
-.version-text {
-	color: #AAA;
-	font-size: 0.6em;
-	display: table-footer-group;
-	padding: 0px;
-	margin: 1px 1px 1px 1px;
-}
-
-.version-brand, .version-brand:hover, a.version-brand:focus  {
-    color: #777;
-    display: block;
-    float: left;
-    font-size: 20px;
-    font-weight: 200;
-    padding: 00px 0px;
-    text-shadow: 0 1px 0 #fff;
-}
+/* style the version information */
+.brand > a { color: #777; }
+.brand > a:hover { color: #999; text-decoration: none; }
+.icon-info-sign.get-help { color: #777; font-size: 16px; margin-left: 5px;}
 
 /* Style the breadcrumb */
 .breadcrumb { display: inline-block; background-color: transparent; }
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 6f249bc..695ca5d 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -58,13 +58,12 @@
 <div class="navbar navbar-static-top">
     <div class="navbar-inner">
             <a class="brand logo" href="#"><img src="{% static 'img/logo.png' %}" class="" alt="Yocto logo project"/></a>
-            <a class="brand" href="/">Toaster</a>
-            {% if DEBUG %}
-            <div style="display: inline;" class="version-brand">
-              <p class="version-text">version {{TOASTER_VERSION}}</p>
-              <p class="version-text">{%if MANAGED%}managed{%else%}interactive{%endif%} mode</p>
-            </div>
-            {% endif %}
+            <span class="brand">
+                <a href="/">Toaster</a>
+                {% if DEBUG %}
+                    <i class="icon-info-sign get-help heading-help" data-placement="bottom" title="Version: {{TOASTER_VERSION}} <br /> Mode: {%if MANAGED%}build{%else%}analysis{%endif%}"></i>
+                {% endif %}
+            </span>
             <a class="pull-right manual" target="_blank" href="http://www.yoctoproject.org/documentation/toaster-manual">
                 <i class="icon-book"></i>
                 Toaster manual
-- 
1.9.1



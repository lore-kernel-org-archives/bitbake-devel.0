Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 9BB1365CBC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 17:08:17 +0000 (UTC)
Received: by wmww144 with SMTP id w144so126850726wmw.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Nov 2015 09:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel_com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mNcotYC76piLN8PxukOGt2oiEdC+lxZG4tIYgIoq798=;
	b=flDQaLfDXJ5jEJHzOkiYDgxVn5D5uwYiVv4K/QQyLzLMxaZoy6B/o0yZy4yI7HI6j5
	t4L6sqIu4MvJvlO3iJl251VRdcErnfDyxKzBpL3nBy/7pF2tTJr0KhnYZ0GaST/kbqxj
	K8VAljD7NVBf4J9IMhLGz5tqUaGtQCUxMnB0mMLOyrGreSy6CeDqggDJp5a2YY67MFd8
	dcxAImg1tuiMkr4nrQISH0Bda5Yy/7WTSDnauc0Yz/o/4Cmh/JEGcBozquAOJlSj4XUj
	gsPiskPU21xTvBKKWrmf0hrz6KYTGxoMmGNlf3cXSfiabxkUmxcA38DpH5ViII/rX+LS
	cDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mNcotYC76piLN8PxukOGt2oiEdC+lxZG4tIYgIoq798=;
	b=gadeQcGcWPjHHaLhhDAvtd4UrgJA2F/zEgPT0x7GPc46Gh4/IgFoxbOMYxZh9gL1wE
	jXpUA4U+hHgGci+GVWeMQFWq9LZ8oogeURXz6TFRRbfPyN5KHz9fBkDyoX3OXPE2MIGc
	QtlfnytXN2YXblNvD4Yn2GIBZUllvgCU8G0sY7fD7P69g8FQlHegxxZkAR1YcXzzSZdZ
	iNXNo/sGAYFMqZ4ZxYCCWYt8jKPudRA7OeOY/dh8xN2dkHYQ/BePGET6JPT3UcShPdGe
	fviOnHeisjXC4Hltp79akVdVbUIcivN8wB793/peTXmzATrATgSaeZHmNgStcPxl28F/
	ELkw==
X-Gm-Message-State: ALoCoQmCl36AtTsI81rRNnW5F7OCgVjThrvSSfsi1wTjUS5YNv6kXYhHMldOzhwdVIVqGHd4eQCj
X-Received: by 10.28.143.144 with SMTP id r138mr6423692wmd.100.1447175297004; 
	Tue, 10 Nov 2015 09:08:17 -0800 (PST)
Received: from dorado.Home ([90.199.203.61])
	by smtp.gmail.com with ESMTPSA id w4sm4465345wje.49.2015.11.10.09.08.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 10 Nov 2015 09:08:16 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Nov 2015 17:08:03 +0000
Message-Id: <1447175283-24245-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1447175283-24245-1-git-send-email-michael.g.wood@intel.com>
References: <1447175283-24245-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/2] toaster: builds pages Fix the download cooker log link
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
X-List-Received-Date: Tue, 10 Nov 2015 17:08:17 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The 'all builds' page was missing the download icon next to the outcome
icon, which allows you to download a build log from the 'all builds' page.

This patch brings it back. It also adds a check in the project builds page
to make sure the download icon only appears if the build generates a cooker
log, since builds that fail at the build request stage do not generate a
cooker log.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/builds.html        |  8 +++++++-
 lib/toaster/toastergui/templates/projectbuilds.html | 11 ++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/lib/toaster/toastergui/templates/builds.html b/lib/toaster/toastergui/templates/builds.html
index a27a121..c3cc266 100644
--- a/lib/toaster/toastergui/templates/builds.html
+++ b/lib/toaster/toastergui/templates/builds.html
@@ -62,7 +62,13 @@
         {% for build in objects %}
         <tr class="data" data-table-build-result="{{ build.id }}">
             <td class="outcome">
-                <a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a> &nbsp;
+                <a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a>
+                {% if build.cooker_log_path %}
+                  &nbsp;
+                  <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
+                    <i class="icon-download-alt" title="Download build log"></i>
+                  </a>
+                {% endif %}
             </td>
             <td class="target">
                 {% for t in build.target_set.all %}
diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index bb38284..3402fc4 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -63,11 +63,12 @@
         {% for build in objects %} {# if we have a build, just display it #}
         <tr class="data">
             <td class="outcome"><a href="{% url "builddashboard" build.id %}">{%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}</a>
-                   {% if build.project %}
-                        &nbsp; <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
-                            <i class="icon-download-alt" title="" data-original-title="Download build log"></i>
-                        </a>
-                    {% endif %}
+              {% if build.cooker_log_path %}
+                &nbsp;
+                <a href="{% url 'build_artifact' build.id "cookerlog" build.id %}">
+                  <i class="icon-download-alt" title="Download build log"></i>
+                </a>
+              {% endif %}
             </td>
 
             <td class="target">
-- 
2.5.0



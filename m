Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
	[74.125.82.169])
	by mail.openembedded.org (Postfix) with ESMTP id 9361F6F906
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:17 +0000 (UTC)
Received: by mail-we0-f169.google.com with SMTP id w62so5120410wes.28
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=i7axdewx54Ad2mPCC1P2Kpz9WAWNlU8w8m4DcWCaI7k=;
	b=AyJYOzRTYdbjCWadWdrYDl/mtnIyP7rls0TKzPCvKMfJFRPEfoZhW7eISzV8y/yltF
	1fQiLJP9ynwK6xlnk8cpkWZe3OJ5Hd9vac8Uk6IzlY5HeChObxuG4p6+GNGMRzEJh8aT
	LTajwpZjmMEELRZY1mev+b3NL7372JtfZW4zvIVFlmtTkcOkdEBba3xy5v0vNJ2HxJcj
	TUkYRRvGyFHBoTsYjSPdVMcDBl4sKdfgwK5VvjTqaLtmL4ihdRgrc+tnOA0U23Kx2Hk8
	TMrhqdZcB1aCD01vbSmM6GGXSWu5NJza0FnF8g3hgL+i+71kMPFGtZAn9oiOF/fMfrBP
	4R/Q==
X-Gm-Message-State: ALoCoQkIpKuOE1CTjEbgUBjdaI8DahwpaPmbla0+8B0+PZKuPjxsVSH42j/yIXtPtQWmTFTgU+NB
X-Received: by 10.180.77.129 with SMTP id s1mr13727004wiw.56.1396284438524;
	Mon, 31 Mar 2014 09:47:18 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t5sm13863103wjw.15.2014.03.31.09.47.15
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:16 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 155565603BA; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:08 +0100
Message-Id: <6a7f7d992f4cbefba0aa0b606647651eecdf11d5.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Subject: [PATCH 08/14] toaster: Small tweaks to the packages included interface
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:19 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

* Capitalise correctly the label "Reverse runtime dependencies"

* Change dependency popover labels to match the rest of the
interface

* Make sure that dependency links go to the initial tab
of the installed package details pages

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/package_included_tabs.html | 2 +-
 lib/toaster/toastergui/templates/target.html                | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/templates/package_included_tabs.html b/lib/toaster/toastergui/templates/package_included_tabs.html
index 5a97ba3..3ea4915 100644
--- a/lib/toaster/toastergui/templates/package_included_tabs.html
+++ b/lib/toaster/toastergui/templates/package_included_tabs.html
@@ -27,7 +27,7 @@
     {% endif %}
             <a href="{% url 'package_included_reverse_dependencies' build.id target.id package.id %}">
                 <i class="icon-question-sign get-help" data-toggle="tooltip" title="The package runtime reverse dependencies (i.e. which other packages in this image depend on this package). Reverse dependencies reflect only the 'depends' dependency type"></i>
-                Reverse Runtime dependencies ({{reverse_count}})
+                Reverse runtime dependencies ({{reverse_count}})
             </a>
         </li>
     </ul>
diff --git a/lib/toaster/toastergui/templates/target.html b/lib/toaster/toastergui/templates/target.html
index ceffada..5db0c0c 100644
--- a/lib/toaster/toastergui/templates/target.html
+++ b/lib/toaster/toastergui/templates/target.html
@@ -93,10 +93,10 @@
             {% with deps_count=deps|length %}
             {% if deps_count > 0 %}
             <a class="btn"
-                title="<a href='{% url "package_included_dependencies" build.id target.id package.id %}'>{{package.name}}</a> depends on"
+                title="<a href='{% url "package_included_dependencies" build.id target.id package.id %}'>{{package.name}}</a> dependencies"
                 data-content="<ul class='unstyled'>
                   {% for i in deps|dictsort:'depends_on.name' %}
-                    <li><a href='{% url "package_included_dependencies" build.pk target.id i.depends_on.pk %}'>{{i.depends_on.name}}</a></li>
+                    <li><a href='{% url "package_included_detail" build.pk target.id i.depends_on.pk %}'>{{i.depends_on.name}}</a></li>
                   {% endfor %}
                 </ul>">
                 {{deps_count}}
@@ -110,10 +110,10 @@
             {% with rdeps_count=rdeps|length %}
             {% if rdeps_count > 0 %}
             <a class="btn"
-                title="<a href='{% url "package_included_reverse_dependencies" build.id target.id package.id %}'>{{package.name}}</a> is brought in by"
+                title="<a href='{% url "package_included_reverse_dependencies" build.id target.id package.id %}'>{{package.name}}</a> reverse dependencies"
                 data-content="<ul class='unstyled'>
                   {% for i in rdeps|dictsort:'package.name' %}
-                    <li><a href='{% url "package_included_dependencies" build.id target.id i.package.id %}'>{{i.package.name}}</a></li>
+                    <li><a href='{% url "package_included_detail" build.id target.id i.package.id %}'>{{i.package.name}}</a></li>
                   {% endfor %}
                 </ul>">
                 {{rdeps_count}}
-- 
1.9.1



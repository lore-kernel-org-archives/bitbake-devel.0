Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 3A5E86EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:05 +0000 (UTC)
Received: by mail-wg0-f51.google.com with SMTP id k14so2492448wgh.22
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=GX6V882tLiBpEto5eAlGqrk0Py+ykMfYHPCCiGPEpiY=;
	b=lw9osy0COIR3yrzQDECKxA7io8PXp2MyYJaGs9sUUyqwRMo1QhkiVxgoYOUw+Xw6iJ
	sY6V1L5etYHR+iHC9ZlGJicGygaHTu1XpkEE55RCx6VHvnyCbFD64pnzA5IhoGYFDFGE
	4+2U9+MedWKOTkOpLMUqzpNTHHdXn83cdWPUC1pALxtw3pFsS3ZVFdqR9fR84dmLVu3C
	52V/kYqJYKMEt742RJ0ErIWdp60sEoAkLWnkhHsT13qh+ipOPO81WEUxfyFQig1wmzZQ
	9tVynuMoskzcn0iuaEN3HdBt5Jr1bP3WqCjBGz06AOeKGzXbOOVzU3RyvkvglX6HgdPp
	kceQ==
X-Gm-Message-State: ALoCoQkU0ILgK1tNgk/AQTJmtoAWyQvpH0ksT7yLHZOcfhIzfB912yG1uet7pC9vU236vu7KqGxu
X-Received: by 10.181.13.40 with SMTP id ev8mr3670670wid.0.1394819946563;
	Fri, 14 Mar 2014 10:59:06 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id t6sm36755437wix.4.2014.03.14.10.59.03
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:05 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 14A12561141; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:49 +0000
Message-Id: <cc478b3b0befc0c8fce93d896074f8d07eaac362.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 08/19] toaster: Amend help text in package_built_detail.html
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:08 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Matching the help text in the tabs to the design specification.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/package_built_detail.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/package_built_detail.html b/lib/toaster/toastergui/templates/package_built_detail.html
index b50ef53..d8f0b75 100644
--- a/lib/toaster/toastergui/templates/package_built_detail.html
+++ b/lib/toaster/toastergui/templates/package_built_detail.html
@@ -8,11 +8,11 @@
             {# Not included case #}
             <ul class="nav nav-pills">
                 <li class="active"> <a href="#">
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Shows the files produced by this package."></i>
+                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Files that would be added to a root file system if you were to include {{package.name}} in an image"></i>
                     Generated files ({{packageFileCount}})
                 </a></li>
                 <li class=""><a href="{% url 'package_built_dependencies' build.id package.id %}">
-                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Shows the runtime packages required by this package."></i>
+                    <i class="icon-question-sign get-help" data-toggle="tooltip" title="Projected runtime dependencies if you were to include {{package.name}} in an image"></i>
                     Runtime dependencies ({{dependency_count}})
                 </a></li>
             </ul>
-- 
1.8.3.2



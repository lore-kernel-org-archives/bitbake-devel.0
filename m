Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 83D5B73D70
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 14:47:44 +0000 (UTC)
Received: by wgso17 with SMTP id o17so83645944wgs.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 07:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=CAfprTBq9Zr2rX/RcsRkZ/DrB1oyLa2Y0QI9oIrxN+o=;
	b=HQKRWQ4uhiXdX1uueN7XGB6FWZLSl5D0ulvX5sudzpfy0KVHARcv7dCtNCqNeEGUSp
	Q0I+k31qohKZ8qRV+xO/NB+02bcu99xsIjo9GnVYMdqezr7fYUNIZN/tnoHZrkOrADqg
	r2+eSPAjKLbmjapK/bdugMbQQe2oUjaQ1hnfV9a5Q8GLlEtiM0Vx+QLuT/tmJKc9dgea
	rwYVEZx00n3UdnAbr2GHDumKON6pssW89Dg7RYQQZu8fkltZ1E0QsDIjfpQQ4ABvrD29
	XXOgt3QO2xtFP9hHSWICznCPxVMvDmzmh6lxsDPFBAfR74D0towG9MXP4ZR2Y8MajgUX
	ey7g==
X-Gm-Message-State: ALoCoQk9mT7aIAc6sn9xI6bPHTEC91MCzfVAaX4W1yCFWdgXTcnY3jU54PJX5res+8eg1uoSgqGO
X-Received: by 10.180.88.72 with SMTP id be8mr5914664wib.45.1429195666086;
	Thu, 16 Apr 2015 07:47:46 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id o6sm20321715wiz.24.2015.04.16.07.47.43
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 07:47:44 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CCBA05611B8; Thu, 16 Apr 2015 15:47:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 15:47:41 +0100
Message-Id: <6f13eb2018c2cc76ee5e6bd59f3ba162fbb695ec.1429195580.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
References: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1429195580.git.alexandru.damian@intel.com>
References: <cover.1429195580.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 8/8] toaster: date range filter for project builds page
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
X-List-Received-Date: Thu, 16 Apr 2015 14:47:46 -0000

From: David Reyna <David.Reyna@windriver.com>

Port date range filter initialization code to the project builds page.

[YOCTO #7578]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/projectbuilds.html | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index 07595f23..18b2495 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -6,8 +6,24 @@
 <li>Project builds</li>
 {% endblock %}
 
+{% block extraheadcontent %}
+<link rel="stylesheet" href="/static/css/jquery-ui.min.css" type='text/css'>
+<link rel="stylesheet" href="/static/css/jquery-ui.structure.min.css" type='text/css'>
+<link rel="stylesheet" href="/static/css/jquery-ui.theme.min.css" type='text/css'>
+<script src="/static/js/jquery-ui.min.js"></script>
+<script src="/static/js/filtersnippet.js"></script>
+{% endblock %}
+
 {% block projectinfomain %}
 
+<script>
+    // initialize the date range controls
+    $(document).ready(function () {
+        date_init('created','{{last_date_from}}','{{last_date_to}}','{{dateMin_created}}','{{dateMax_created}}','{{daterange_selected}}');
+        date_init('updated','{{last_date_from}}','{{last_date_to}}','{{dateMin_updated}}','{{dateMax_updated}}','{{daterange_selected}}');
+    });
+</script>
+
     <div class="page-header">
       <h1>
         {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
-- 
1.9.1



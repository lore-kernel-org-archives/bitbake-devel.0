Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id C9CDE758DC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:40:12 +0000 (UTC)
Received: by wiga1 with SMTP id a1so50822747wig.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=TjSMXdtecSiX17msKOmApUiELzKx7khkvAefXsuxW0Y=;
	b=NNMXGyxW8psS6g2MWMXX/qZoihsK4CbQPO4RN6CFpS89Ad4TMF5YJImT8Uywr6iPzt
	/HNJ6Sp2b79p85DaFc8TldGzQ4eFopdOdsrXpx5wuTz6FVTby9nN+AScs4Y7zsDPZVHO
	xAiri2ibgin9Yvdh85dovllyvIapk2srSh3MQHCeRhutkVey80ioUoHrIBIyQTsgTwcW
	0PpHyMgiJxCD/Knc0cKgmoepOSWCwxrxk804Zpiijd7P64uzR/G2V7Vp4HdP7JGXOFFg
	uOj8xyomgXMvYdTHMAU7DNxNcnWkexn/EtBA/JM6gqfepjh3nthrusedGB7TSmYx2SOL
	0JTg==
X-Gm-Message-State: ALoCoQkH6I39yBrDVL3yZQHfyl66CS7d3WKLhCBA35xi+o4gF17Pp9Al4F8+L42b3hLfApoH18zv
X-Received: by 10.180.39.131 with SMTP id p3mr9305676wik.82.1433947213631;
	Wed, 10 Jun 2015 07:40:13 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	hn7sm14850521wjc.16.2015.06.10.07.40.12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:40:12 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 28E5A561271; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:39:06 +0100
Message-Id: <978ab17033ec48ee0a82016b7e4d6a2fe5d21dbb.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 18/19] toaster: Add global ajaxError handler
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
X-List-Received-Date: Wed, 10 Jun 2015 14:40:13 -0000

From: Michael Wood <michael.g.wood@intel.com>

If any ajax calls fail and debug is enabled log the error to the console.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js | 5 +++++
 lib/toaster/toastergui/static/js/table.js      | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index c379833..667aca2 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -503,6 +503,11 @@ $(document).ready(function() {
       $("#loading-notification").fadeOut();
     });
 
+    $(document).ajaxError(function(event, jqxhr, settings, errMsg){
+      console.warn("Problem with xhr call");
+      console.warn(errMsg);
+      console.warn(jqxhr.responseText);
+    });
 
     function check_for_duplicate_ids () {
       /* warn about duplicate element ids */
diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 45c6184..1072c75 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -53,11 +53,6 @@ function tableInit(ctx){
               tableData: tableData,
               tableParams: tableParams
           }, null, libtoaster.dumpsUrlParams(tableParams));
-        },
-
-        error: function (_data) {
-          console.warn("Call failed");
-          console.warn(_data);
         }
     });
   }
-- 
1.9.1



Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id EA88F7250F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:28 +0000 (UTC)
Received: by mail-wg0-f53.google.com with SMTP id l18so8830946wgh.40
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=XZbrhG0sWKzdrX04a52qbpFnUK/7fUii6vPx3C/hydM=;
	b=N2vDPDcBvPdE3Bw3Zm+7iqjj3q2v0YaOzmV0SrXU2afSiI2GDz+bdJZFLmj0NRQjoi
	limx4XJEK2j/ZnlyyGIKGpTZwiLL5jSJT7NA7/owPjbRsdHpOxXBW6LQ6GVVqqph33HI
	zybnqgHXbm0BwaDReGsXHcxpegmg9M92mKDZ+51U7FwuCvoZDzIgb3WhNdNBIoia4WOC
	lEKM0k8TQvzFzUrRRVqtDAB81YEH7V39M5gB3CKuKxNCSWslX9yK4Wgv0dg9n29tEOxQ
	1asYeAXPnWejxEmZXCJMDpdR1HtrGtip/PCTqyWOwvwSECc83eQC1+hMOOl7x1zqxhJC
	J+1g==
X-Gm-Message-State: ALoCoQl5z+q7p/lpRg4tIH8mvZ5lva0afN50TMJyZD1ETSpbcKDWOLHo9HZNe6ywJof14nXtEO24
X-Received: by 10.180.20.209 with SMTP id p17mr6888103wie.13.1418384729366;
	Fri, 12 Dec 2014 03:45:29 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id a14sm1619944wib.22.2014.12.12.03.45.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:26 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 5069E566259; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:16 +0000
Message-Id: <c23736003b788f2b45ae7cbcd7c7250ead2e5724.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Subject: [PATCH 17/18] toaster: Change the full stop to a colon
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:29 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the import layers notification for multiple layers
there was a full stop where there should be a colon.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/projectapp.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 741038d..bb97f32 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -599,7 +599,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
             text = "You have imported <strong><a href=\""+$scope.urls.layer+
               imported.imported_layer.id+"\">"+imported.imported_layer.name+
               "</a></strong> and added <strong>"+(imported.deps_added.length+1)+
-              "</strong> layers to your project. <strong>"+links+"</strong>";
+              "</strong> layers to your project: <strong>"+links+"</strong>";
           }
 
             $scope.displayAlert($scope.zone2alerts, text, "alert-info");
-- 
1.9.1



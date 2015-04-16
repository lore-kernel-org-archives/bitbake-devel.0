Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id A64F973D54
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 14:47:44 +0000 (UTC)
Received: by wiun10 with SMTP id n10so100148992wiu.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 07:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=7PYh2qaEF6kwb4YdnB/d4BS9thMWjKkmV8/BJeNHW4Y=;
	b=Sv+LcNh5tbGoBB5NvdUgi5IRL2i9pjOyrjH/Bdqupt7T+Jlst4M7v98IRhFvylnTwV
	pMLoW87AzD2pgYCOdomgI8ZgLai28DNLIWznIj51BJjLUnvUNV1xBTnjbmZ7IYeuJKXZ
	OjNL1S9bn0/uJcFGNPOzbJIr1hviyv7xAo+DBMtjow4+FJMQFZJHdiyWgj5c72woBo3G
	YhPhi5Qg3gA3R2WdeJJYVSTh1xUacmKzBGRTeQZloUAkf9tco/uTHYuL9OWpikGSt7/h
	ms9MZvikd6i+VFYISAjHoblOrq8iAPALwBCfOLU7jm7JoW3cuKASKNYM2W6PVw2bxM/R
	lvng==
X-Gm-Message-State: ALoCoQkz+R2q1ko8eN8OCztmsKjmBN0oZyTj4ejfCtVFSBoxQr5lKNuxl/C/jszZSiy5s4u7FKGB
X-Received: by 10.194.174.225 with SMTP id bv1mr61547166wjc.101.1429195665143; 
	Thu, 16 Apr 2015 07:47:45 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id cs4sm5555362wjb.31.2015.04.16.07.47.43
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 07:47:44 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C779D560DDD; Thu, 16 Apr 2015 15:47:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 15:47:39 +0100
Message-Id: <d11649cac0eed2b9c911b40be13f04bc4f593132.1429195580.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
References: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1429195580.git.alexandru.damian@intel.com>
References: <cover.1429195580.git.alexandru.damian@intel.com>
Subject: [PATCH 6/8] toasterui: remove 'targets' from project notification
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

From: Belen Barros Pena <belen.barros.pena@intel.com>

Remove the last remnant of the "targets" wording, which was
lurking in the notification we show you when you create
a project.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/projectapp.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 0b6e012..d52ba73 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -692,7 +692,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                     "Your project <strong>" + $scope.project.name +
                     "</strong> has been created. You can now <a href=\""+ $scope.urls.layers +
                     "\">add layers</a> and <a href=\""+ $scope.urls.targets +
-                    "\">select targets</a> you want to build.", "alert-success");
+                    "\">select recipes</a> you want to build.", "alert-success");
         });
 
         _cmdExecuteWithParam("/machineselected", function () {
-- 
1.9.1



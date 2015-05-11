Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 6E27773FDA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 10:59:58 +0000 (UTC)
Received: by widdi4 with SMTP id di4so100441458wid.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 03:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=17mr08mlQv7ftH39o/zOGDVGmSWeOcHav5IbWRdC/hw=;
	b=iImHVL40XvDqjGwD/U6c3Lw3SR33EEMyFKjRAghDi3lOrruli9cLEzaufprhlWRjqI
	pzVn6m7YBJUMeFrXklsb748mXkZkoHV8E0Dl0i/KjlhWTaHXXzgFTdd3R0wwN7UBh1ya
	EzYFYJgtmc6QT5nbQQmjw3yfl5YUOwsekd3wnC0/CU1uN2Jl9C4k9vJjOSJDsPT4X6Wi
	JkQEwML7ceBmHZRPrwIBEBvR7aRN3F2gtDk6/ZiVPRABGucamhIb+Yup3KdbR4zHXoNO
	r4Hm6nJemYyd5WJN0fr0ZycKvBWyg3klV/cV85Eu2+I9Rq2ujclNUKP47//jiO37RfRD
	n7qg==
X-Gm-Message-State: ALoCoQmNhPp3d85tR1NU+k6cgEfg4HJbeJIU70qmWfCPEE5/mRNcwHNipZjyTFyEu9mf9Xsg399S
X-Received: by 10.180.82.97 with SMTP id h1mr18473587wiy.26.1431341999728;
	Mon, 11 May 2015 03:59:59 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	a18sm22238897wja.46.2015.05.11.03.59.58
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 03:59:59 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id ED6A8560466; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:38 +0100
Message-Id: <758a143f5ffdd24f7cf8219c4ee97f4c7d4ec9f9.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
References: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Subject: [PATCH 07/11] toastergui: Consider task name when restarting a build
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
X-List-Received-Date: Mon, 11 May 2015 10:59:59 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

'Run again' button now restarts the build using target:task if task
was specified for the build.

[YOCTO #7442]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/projectapp.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 43436c5..a3309c7 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -357,7 +357,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
     };
 
     $scope.buildExistingTarget = function(targets) {
-         $scope.buildTargetList(targets.map(function(v){return v.target;}));
+         $scope.buildTargetList(targets.map(function(v){return ((v.task) ? v.target + ":" + v.task : v.target);}));
     };
 
     $scope.buildTargetList = function(targetlist) {
-- 
1.9.1



Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 15AA5758A4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:33:55 +0000 (UTC)
Received: by wicgi11 with SMTP id gi11so71393592wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ASNvtrtWkRi1qQLUsp3VvImdGD3wOShwY49IUvBP2j0=;
	b=bBku9XT0/wEF/UxFe/IkFjfUlYA5qtqY/qLdJhYTllLVEEtCyqc0VibeAjcC46WMmo
	8vJ2nOTD+JAGQxSs8P4BZVHTx+4uwoGPJ/mUw8HtjDplDTCja9A/9xO5AFRC/F406Tjv
	H7SxYGC6VfsQcU+LOOm9ryiFlCa5MxpkyH2pGJGrvsx6rK3qj2/P9bbAy95ue6fVHMAI
	jChF0WWFELS2s2H0rK0EuFp7Njq8G0PWryPasPBkkMuAZ04jLBST9zfr+QDv8ZuQ2cNJ
	ZX7/qQieKrxEgxkzeSm+nYrgLLZC2BxMZFtoOKxZqRTWYptIFqqP3cNLsWnUMbAKQumu
	nDEA==
X-Gm-Message-State: ALoCoQl/Su+ah6DoG7/m8ajDKnZwazG/5TJSuoGWHMMEiLQ6Cg5eDQYfUJXvYLRA+mC7AxG0WL+g
X-Received: by 10.180.87.105 with SMTP id w9mr4461914wiz.32.1435228436679;
	Thu, 25 Jun 2015 03:33:56 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	lj14sm6905295wic.18.2015.06.25.03.33.55
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:33:55 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B63ED56172B; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:38 +0100
Message-Id: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 01/23] toastergui: fix angular error
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
X-List-Received-Date: Thu, 25 Jun 2015 10:33:58 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Due to invalid identification of builds in the array update
code (by id and status), we could end up with multiple entries
sharing the same primary id, visible in the UI as an angular error.

We modify the code to identify the builds exclusively by id.

[YOCTO #7611]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/projectapp.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 44e244d..b2e65c5 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -341,7 +341,7 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                     var toDelete = [];
                     // step 1 - delete entries not found
                     $scope.builds.forEach(function (elem) {
-                        if (-1 == _data.builds.findIndex(function (elemX) { return elemX.id == elem.id && elemX.status == elem.status; })) {
+                        if (-1 == _data.builds.findIndex(function (elemX) { return elemX.id == elem.id; })) {
                             toDelete.push(elem);
                         }
                     });
-- 
1.9.1



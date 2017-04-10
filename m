Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 9957777D6E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 13:39:27 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v3ADdNbp012315
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 06:39:28 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.216.91) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Mon, 10 Apr 2017 06:39:24 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 10 Apr 2017 06:29:55 -0700
Message-ID: <5f4c677c7395c7671a0ef53b9dd56adb3b22f691.1491830925.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1491830925.git.David.Reyna@windriver.com>
References: <cover.1491830925.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.216.91]
Subject: [PATCH 1/1] toaster: Toaster filters are broken
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
X-List-Received-Date: Mon, 10 Apr 2017 13:39:27 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

A syntax fix inadvertantly broke the Toaster filter feature.

[YOCTO #11317]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/static/js/table.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index 9db3902..1bbc8d1 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -708,7 +708,7 @@ function tableInit(ctx){
             if (action) {
               // Setup the current selected filter; default to 'all' if
               // no current filter selected
-              var radioInput = action.find('input[name]="filter"]');
+              var radioInput = action.find('input[name="filter"]');
               if ((tableParams.filter &&
                   tableParams.filter === radioInput.val()) ||
                   filterActionData.action_name == 'all') {
-- 
1.9.1



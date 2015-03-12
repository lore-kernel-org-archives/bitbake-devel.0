Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 88E6073B66
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:54 +0000 (UTC)
Received: by widfb4 with SMTP id fb4so2795289wid.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=H07AgaCvdXg1YwMjvkgqkOXkOA6qV93eddWT37187cA=;
	b=k6bc1HKcwrb2pPtMw9eE9iIApmd3TbFDQNvIUV19aPMgBUMjZmyo+GS+1Hblb0BF1C
	WUIENKnqH4G7XuVaFLbFXOLbMpzf+Et0rZ7a8NhlUJ+ktsDeVjjqYhsp++6aR7KImf4N
	RHmSu635DmH933MvpQLQ8zgZKu9L3Df09F822B6TzPNb2RIe+9F1eKMKjva8kPpKd7Dx
	5/sfLtVGRGwjyryeA+6EZQkJ6pdauvWT7cKlU4V6MIJquSgY345DQ/86lV60g9VLXbIJ
	uxKlwAx7g4drcxusrhh+ibgxpSIdYtPR16/n/5tFNGYuu0N1HdVHsHFY5J+TRmqsSXmd
	vn2Q==
X-Gm-Message-State: ALoCoQno1xt85S9hwsgckvqSigC+Oyp4jqrvQ+xOQjM+MzKFJwlezJcH8VY5C3NcMyburRkjIzRI
X-Received: by 10.180.106.197 with SMTP id gw5mr38130152wib.58.1426157215345; 
	Thu, 12 Mar 2015 03:46:55 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id uo6sm9388881wjc.49.2015.03.12.03.46.52
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:54 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 7A2CB5627E6; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:50 +0000
Message-Id: <5620bc0b86987f0c7d7fcfa125856cefb4ba8605.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 17/17] toaster: Fix the orderkey to match the column
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:56 -0000

From: Michael Wood <michael.g.wood@intel.com>

If the orderkey doesn't map to the current sort value then when hiding
the column the sort doesn't get removed.

[YOCTO #7262]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 807bf9b..fe016cc 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1401,7 +1401,7 @@ def bpackage(request, build_id):
                 'qhelp':'The Git branch of the layer providing the recipe that builds the package',
                 'orderfield': _get_toggle_order(request, "recipe__layer_version__branch"),
                 'ordericon':_get_toggle_order_icon(request, "recipe__layer_version__branch"),
-                'orderkey' : 'recipe__layer_version__layer__branch',
+                'orderkey' : 'recipe__layer_version__branch',
                 'clclass': 'recipe__layer_version__branch', 'hidden': 1,
             },
             {
-- 
1.9.1



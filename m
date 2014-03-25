Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
	[209.85.212.178])
	by mail.openembedded.org (Postfix) with ESMTP id 7A7B06FB02
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 18:02:36 +0000 (UTC)
Received: by mail-wi0-f178.google.com with SMTP id bs8so887697wib.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 11:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=s+xtFgfAz0Ztla8i4pKfzehg22tq2Zo+IJvUHldJH/0=;
	b=ROI+Yxcfp8XG2Xe+q3WIVynyzSw+Or22FEbPOfVHXCI44bRVhnUDfobxwBH2fX1Uex
	Gopxhlsc+uW0OvlS227/mZhHIKYUoJV9j8XpNUUOUe7WIosxbMBij747FuKLoRP0PVFu
	6wP5wuN+WIrRnGXjWvGGMC4SgeDUuJG0UB0BFCivQ2VW6mRco9i4SXn33ioa7EcqoZC4
	6N/lS3+6J4Pb3le4LmKYdr8m6W24qF1vcP+VzYLgPKyMhx7L0kpDYYDhTkR4M2P5muOB
	lJVL+Id8ii/pg/uoH1vVGfU4VxjMbnzJKs4iV3eUcVqi5BaxxwjyWutsUpTbPQZc1QdJ
	CbHg==
X-Gm-Message-State: ALoCoQmEQk4zJnrX38vhzeTRvJJmW4THoAntBYrOD3YL+Mz1Yaz7U9MqNjNkMwoCJG2GsNk57iuJ
X-Received: by 10.180.106.168 with SMTP id gv8mr23967190wib.19.1395770557836; 
	Tue, 25 Mar 2014 11:02:37 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fb6sm52514044wib.2.2014.03.25.11.02.35
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 25 Mar 2014 11:02:35 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 93905560A05; Tue, 25 Mar 2014 17:51:14 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Mar 2014 17:51:11 +0000
Message-Id: <15878e69aa8891a1a79a3b058d096db5a762e840.1395769683.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7cdff1413429eb64bae7522e587b42f850aa0fe0.1395769683.git.alexandru.damian@intel.com>
References: <7cdff1413429eb64bae7522e587b42f850aa0fe0.1395769683.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395769683.git.alexandru.damian@intel.com>
References: <cover.1395769683.git.alexandru.damian@intel.com>
Subject: [PATCH 3/5] toaster: Fix help text typos
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
X-List-Received-Date: Tue, 25 Mar 2014 18:02:40 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Fix a couple of typos in the help text of the builds
and recipes tables.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/views.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 3e59138..92814ce 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -317,7 +317,7 @@ def builds(request):
                             }
                 },
                 {'name': 'Warnings', 'clclass': 'warnings_no',
-                 'qhelp': "How many warnigns were encountered during the build (if any)",
+                 'qhelp': "How many warnings were encountered during the build (if any)",
                  'orderfield': _get_toggle_order(request, "warnings_no", True),
                  'ordericon':_get_toggle_order_icon(request, "warnings_no"),
                  'filter' : {'class' : 'warnings_no',
@@ -942,26 +942,26 @@ def recipes(request, build_id):
             },
             {
                 'name':'Layer',
-                'qhelp':'The name of the layer prodiving the recipe',
+                'qhelp':'The name of the layer providing the recipe',
                 'orderfield': _get_toggle_order(request, "layer_version__layer__name"),
                 'ordericon':_get_toggle_order_icon(request, "layer_version__layer__name"),
                 'clclass': 'layer_version__layer__name', 'hidden': 0,
             },
             {
                 'name':'Layer branch',
-                'qhelp':'The Git branch of the layer prodiving the recipe',
+                'qhelp':'The Git branch of the layer providing the recipe',
                 'orderfield': _get_toggle_order(request, "layer_version__branch"),
                 'ordericon':_get_toggle_order_icon(request, "layer_version__branch"),
                 'clclass': 'layer_version__branch', 'hidden': 1,
             },
             {
                 'name':'Layer commit',
-                'qhelp':'The Git commit of the layer prodiving the recipe',
+                'qhelp':'The Git commit of the layer providing the recipe',
                 'clclass': 'layer_version__layer__commit', 'hidden': 1,
             },
             {
                 'name':'Layer directory',
-                'qhelp':'Location in disk of the layer prodiving the recipe',
+                'qhelp':'Location in disk of the layer providing the recipe',
                 'orderfield': _get_toggle_order(request, "layer_version__layer__local_path"),
                 'ordericon':_get_toggle_order_icon(request, "layer_version__layer__local_path"),
                 'clclass': 'layer_version__layer__local_path', 'hidden': 1,
-- 
1.8.3.2



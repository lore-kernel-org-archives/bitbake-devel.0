Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
	[74.125.82.175])
	by mail.openembedded.org (Postfix) with ESMTP id 2DFB96FB2F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:31 +0000 (UTC)
Received: by mail-we0-f175.google.com with SMTP id q58so3621706wes.20
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ckMoBtNWK0W3Z8WH3L424vpkli/BlolnlUkRVUXZzyo=;
	b=FHf1kI22JZcUGYz+Nsr07qpD49twJtWNqZAXDJOgT42K1oYV+0VgZbreOihjpoZgtF
	I/A0rOzklHeulU/ZPPD3JHtV1beJZalNQYV2mxJyF5eJ8Ymd13iy8chUjJ0g9KM6kbJi
	xcnoNv4LSnOW9mXzgCuzRWwcMTjm3Ed/N9BapMdaKFg7GKT4CUOxVSPP+zPY8Dnh6Lmp
	cQZe/EAsM8Rz3MW/v2aZ5E4SPCS2TsXv8PdUMlcfrst8jdz/5qdgrS/CkYH2+2Knabeo
	ycrFuhl9+HJw+OdrzvmMrT7P8YxXaYGQW0klkjyeqUVrvmkJikGH90NVVK33MFhgLMP0
	Vzcg==
X-Gm-Message-State: ALoCoQm1buMC54cDLVxCjmOFX5/cNkI/gjN2W75wgk4ZU/xwtSjIv6FexaaCr+GT3+llrt5K+y8S
X-Received: by 10.180.11.36 with SMTP id n4mr17020409wib.4.1395686252224;
	Mon, 24 Mar 2014 11:37:32 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id jd2sm41561584wic.9.2014.03.24.11.37.30
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:31 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B5F6356121D; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:15 +0000
Message-Id: <3d69f5cdf154df83e7a487e1b609bb8f7b5b6df2.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 05/18] toaster: fix package size 1st sort order
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:32 -0000

From: Dave Lerner <dave.lerner@windriver.com>

[YOCTO #5914]

On the pages with tables listing packages with a size column, change the
first click sort order on the size column so that packages are sorted in
decreasing order instead of increasing order.  It is more likely that
the user sorts this page data by size because the user is interested in
those packages consuming the most disk space.

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
---
 lib/toaster/toastergui/views.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a4bd9d6..3f6b93e 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -448,7 +448,7 @@ def target(request, build_id, target_id):
                 {
                     'name':'Size',
                     'qhelp':'The size of the package',
-                    'orderfield': _get_toggle_order(request, "size"),
+                    'orderfield': _get_toggle_order(request, "size", True),
                     'ordericon':_get_toggle_order_icon(request, "size"),
                     'clclass': 'package_size',
                     'hidden' : 0,
@@ -1128,7 +1128,7 @@ def bpackage(request, build_id):
             {
                 'name':'Size',
                 'qhelp':'The size of the package',
-                'orderfield': _get_toggle_order(request, "size"),
+                'orderfield': _get_toggle_order(request, "size", True),
                 'ordericon':_get_toggle_order_icon(request, "size"),
                 'clclass': 'size', 'hidden': 0,
             },
-- 
1.8.3.2



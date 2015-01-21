Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com
	[74.125.82.172])
	by mail.openembedded.org (Postfix) with ESMTP id 85D0372C31
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:21:58 +0000 (UTC)
Received: by mail-we0-f172.google.com with SMTP id k11so44610907wes.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=in/Gs1Wbziyxkz4UOgocUXoIBfxU9QiwqPQkmQW5jKg=;
	b=UpENQIC3S2ES7F4MEa+txTiQZkbaUdOWGKAQNLITMA/RvIZYIo8T6KKeBC430CfO5M
	SBGdgwQhOGpYl/33G90XmKIT8xkoeLIqX/njfqof2BO7c+naOdRkzAdDuC/ct+0Lh2Yn
	omTS0rYs0AP2EUn41KlEMGNPLzkXARAXcAAkKGlQ3uQhx4x0iqGS1aRB9Z2YLfUsYCCU
	XWQS/KGSbQ+3xquIck0FXdPi4Vzpf4x+8FKG4GHJDWlaXR4eQoj6Yg2K7S0DjZfBvCwc
	0axdlnIc91JB5ebzp3C24jg9X/qx+ydwEpZg4BkK7cL24254qfzG27JTE00a1rx9hag7
	+5TQ==
X-Gm-Message-State: ALoCoQkmuEIL/jhSOxxpuqcyEMyP01JLboJLUMUG26r86rB4UQcpOOb/DYeI5atqZeAoWp33rpKH
X-Received: by 10.194.60.70 with SMTP id f6mr86555567wjr.109.1421864518736;
	Wed, 21 Jan 2015 10:21:58 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id c10sm825205wjy.4.2015.01.21.10.21.56
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:21:57 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id F2D0356411D; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:42 +0000
Message-Id: <3b7041e0e145dae9ed01af78d6a49de3195c6a03.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 12/12] toastergui: enable re-ordering when columns are hidden
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch enables table re-ordering when a sorted-by column is hidden.
This is default functionality in toaster table pages, but was not
enabled for all columns in this situation.

[YOCTO #7125]
[YOCTO #7022]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index f84b120..e718ced 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -513,6 +513,7 @@ eans multiple licenses exist that cover different parts of the source',
         'qhelp'      : 'The name of the recipe building the package',
         'orderfield' : _get_toggle_order( request, "recipe__name" ),
         'ordericon'  : _get_toggle_order_icon( request, "recipe__name" ),
+        'orderkey'   : "recipe__name",
         'clclass'    : 'recipe_name',
         'hidden'     : 0,
         }
@@ -527,6 +528,7 @@ eans multiple licenses exist that cover different parts of the source',
         'qhelp'      : 'The name of the layer providing the recipe that builds the package',
         'orderfield' : _get_toggle_order( request, "recipe__layer_version__layer__name" ),
         'ordericon'  : _get_toggle_order_icon( request, "recipe__layer_version__layer__name" ),
+        'orderkey'   : "recipe__layer_version__layer__name",
         'clclass'    : 'layer_name',
         'hidden'     : 1,
         }
@@ -535,6 +537,7 @@ eans multiple licenses exist that cover different parts of the source',
         'qhelp'      : 'The Git branch of the layer providing the recipe that builds the package',
         'orderfield' : _get_toggle_order( request, "recipe__layer_version__branch" ),
         'ordericon'  : _get_toggle_order_icon( request, "recipe__layer_version__branch" ),
+        'orderkey'   : "recipe__layer_version__branch",
         'clclass'    : 'layer_branch',
         'hidden'     : 1,
         }
@@ -576,6 +579,7 @@ eans multiple licenses exist that cover different parts of the source',
             'qhelp':'Location in disk of the layer providing the recipe that builds the package',
             'orderfield' : _get_toggle_order( request, "recipe__layer_version__layer__local_path" ),
             'ordericon'  : _get_toggle_order_icon( request, "recipe__layer_version__layer__local_path" ),
+            'orderkey'   : "recipe__layer_version__layer__local_path",
             'clclass'    : 'layer_directory',
             'hidden'     : 1,
         }
@@ -2527,6 +2531,7 @@ if toastermain.settings.MANAGED:
                     'qhelp': "Where the layer is coming from, for example, if it's part of the OpenEmbedded collection of layers or if it's a layer you have imported",
                     'orderfield': _get_toggle_order(request, "layer_source__name"),
                     'ordericon': _get_toggle_order_icon(request, "layer_source__name"),
+                    'orderkey' : "layer_source__name",
                     'filter': {
                         'class': 'layer',
                         'label': 'Show:',
@@ -2675,23 +2680,27 @@ if toastermain.settings.MANAGED:
                     'hidden': 1,
                     'orderfield': _get_toggle_order(request, "section"),
                     'ordericon': _get_toggle_order_icon(request, "section"),
+                    'orderkey': "section",
                 },
                 {   'name': 'License',
                     'clclass': 'license',
                     'hidden': 1,
                     'orderfield': _get_toggle_order(request, "license"),
                     'ordericon': _get_toggle_order_icon(request, "license"),
+                    'orderkey': "license",
                 },
                 {   'name': 'Layer',
                     'clclass': 'layer',
                     'orderfield': _get_toggle_order(request, "layer_version__layer__name"),
                     'ordericon': _get_toggle_order_icon(request, "layer_version__layer__name"),
+                    'orderkey': "layer_version__layer__name",
                 },
                 {   'name': 'Layer source',
                     'clclass': 'source',
                     'qhelp': "Where the target is coming from, for example, if it's part of the OpenEmbedded collection of targets or if it's a target you have imported",
                     'orderfield': _get_toggle_order(request, "layer_source__name"),
                     'ordericon': _get_toggle_order_icon(request, "layer_source__name"),
+                    'orderkey': "layer_source__name",
                     'filter': {
                         'class': 'target',
                         'label': 'Show:',
@@ -2778,6 +2787,7 @@ if toastermain.settings.MANAGED:
                     'qhelp': "Where the machine is coming from, for example, if it's part of the OpenEmbedded collection of machines or if it's a machine you have imported",
                     'orderfield': _get_toggle_order(request, "layer_source__name"),
                     'ordericon': _get_toggle_order_icon(request, "layer_source__name"),
+                    'orderkey': "layer_source__name",
                     'filter': {
                         'class': 'machine',
                         'label': 'Show:',
-- 
1.9.1



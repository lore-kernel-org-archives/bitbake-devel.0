Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id AB14673B54
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:52 +0000 (UTC)
Received: by wggx12 with SMTP id x12so15337290wgg.13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=5TSCDa7fKZU7N2Awt5XtNkI+b3A3MyHpDvcezJMNDbA=;
	b=A3e0KoWTglUxQ+RyO03J53QSPEF+F9O2VXymc8E7rOTWpMGUjzOp/bQ6a3iyKN7AZn
	5ENnJukA0kLoFItXRmY+8k3fIrKAZACDSIxoWMQ8MTVqUjg6n/VFVMpBMKCHB7KsJeo4
	4uTC4AwuvkRhaHVUNdVxts7HIUfWd6IhKofzAdGS7Htc7g6YrxB+Dv8ihGeUBoNL7M9c
	L/Rb8443dimL3KGTLJxtRWcXBdcKo4Rx/xXS2jxX5je8HXm/qjKiFcimYEo4uygE9cLo
	bYKtTCsNdCryL9JXT8v1/S6kW2JhB4gVpFsPOdx7DNaYRsi4ySo+Lqyu6Sv1r7r3+uQC
	whtw==
X-Gm-Message-State: ALoCoQlaYV7kZz1Icyd1d+VTg7pFlaE6s7TZavAoB/NtmLXE63qjkYTu3sVFj6HAVS8BE5fRQrX0
X-Received: by 10.194.177.195 with SMTP id cs3mr83893155wjc.141.1426157213673; 
	Thu, 12 Mar 2015 03:46:53 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ga8sm10107969wib.11.2015.03.12.03.46.51
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 72E35562666; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:45 +0000
Message-Id: <c3cb8d9ca044379d9b8af07ee12656b43f9fc933.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 12/17] toasterui: relative recipe paths
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

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We modify the toasterui to log relative recipe paths
in order to maintain consistency with data fetched from
the layer sources.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index ae2ac9f..cf8c444 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -221,6 +221,9 @@ class ORMWrapper(object):
         assert 'layer_version' in recipe_information
         assert 'file_path' in recipe_information
 
+        if recipe_information['file_path'].startswith(recipe_information['layer_version'].layer.local_path):
+            recipe_information['file_path'] = recipe_information['file_path'][len(recipe_information['layer_version'].layer.local_path):].lstrip("/")
+
         recipe_object, created = self._cached_get_or_create(Recipe, layer_version=recipe_information['layer_version'],
                                      file_path=recipe_information['file_path'])
         if created and must_exist:
@@ -289,7 +292,10 @@ class ORMWrapper(object):
                     # we matched the BRLayer, but we need the layer_version that generated this BR; reverse of the Project.schedule_build()
                     for pl in buildrequest.project.projectlayer_set.filter(layercommit__layer__name = brl.name):
                         if pl.layercommit.layer.vcs_url == brl.giturl :
-                            return pl.layercommit.layer
+                            layer = pl.layercommit.layer
+                            layer.local_path = layer_information['local_path']
+                            layer.save()
+                            return layer
 
             raise Exception("Unidentified layer %s" % pformat(layer_information))
 
-- 
1.9.1



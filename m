Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 4E1AA7646B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 11:21:50 +0000 (UTC)
Received: by wijp15 with SMTP id p15so131343849wij.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 04:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=LdUuxUHwk4imeOQ72N1Ef2a/i13GiDnC/rbsf/T7x8U=;
	b=MY/MS1E4kHGnutHgeqHs9kK+zwUo+UjUlrgIlkL8p7+IvCBiV9IAySOEkNJ9xtlTSH
	gadVbfg2mOINSFm8hsUFuoFKfQlMXUi9Nf/2fZluKgMuwmwXMAQo9hNn9RnYqliRPDEj
	uRSXkxplaNb9K4fDIKKZ51i0G22HI8xNd654oINTOWjLuhmqNAknyWcV4tgrGQVLgeql
	U/E1XCCpP/jlcZzV8qVKia0kkSnA0g5HNI/hcm5HNnZOAESy0vyryam8JacbCT7DWIzb
	ibczdvrAIhjelCzxpD4g69K2Dh6HDcv8OLG1ctmSAN2zul/rCPoZ1ws/1aWhPonqKSid
	9nDg==
X-Gm-Message-State: ALoCoQkEop7K8uS/il7ye44jDlmEjPDmnk9Fg69sN7enYEKBuFCULUXh86UUbvwnbZOORgjdP+iB
X-Received: by 10.194.2.51 with SMTP id 19mr46019245wjr.40.1439205709902;
	Mon, 10 Aug 2015 04:21:49 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	c11sm13292834wib.1.2015.08.10.04.21.49
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 04:21:49 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 12:21:32 +0100
Message-Id: <ab68f53563c7ce51cb687cae16bc97013bbcf512.1439205232.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
	<1e8409b1d3149ca2483e5581c5428e58b6fadefe.1439205232.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1439205232.git.michael.g.wood@intel.com>
References: <cover.1439205232.git.michael.g.wood@intel.com>
Subject: [PATCH 09/11] toaster: add header to orm/test.py
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
X-List-Received-Date: Mon, 10 Aug 2015 11:21:50 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added header and module docstring.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/tests.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index a57a62c..99f4fa0 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -1,3 +1,26 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2013-2015 Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+"""Test cases for Toaster ORM."""
+
 from django.test import TestCase, TransactionTestCase
 from orm.models import LocalLayerSource, LayerIndexLayerSource, ImportedLayerSource, LayerSource
 from orm.models import Branch
-- 
2.1.4



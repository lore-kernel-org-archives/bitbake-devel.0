Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0C75476486
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 12:58:28 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 15 Jan 2016 04:58:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,299,1449561600"; d="scan'208";a="881987220"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2016 04:58:29 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 3460A6A4004
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 05:46:24 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 13:00:59 +0200
Message-Id: <4fb8fadba3b65951c3c26cce2da53b5db8fd53ec.1452855461.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1452855461.git.ed.bartosh@linux.intel.com>
References: <cover.1452855461.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 16/23] toaster: toastergui: serialise decimals correctly
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
X-List-Received-Date: Fri, 15 Jan 2016 12:58:28 -0000

From: Elliot Smith <elliot.smith@intel.com>

The conversion of some ToasterTable Build object querysets to
JSON caused a serialisation error. This is because one of the
fields in the queryset was of type decimal.Decimal, and our
serialiser didn't know what to do with it.

Add a clause to check for decimal fields and serialise them
so that correct JSON can be generated.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/views.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index fbae36c..3e8a66b 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -43,6 +43,7 @@ from django.utils.html import escape
 from datetime import timedelta, datetime
 from django.utils import formats
 from toastergui.templatetags.projecttags import json as jsonfilter
+from decimal import Decimal
 import json
 from os.path import dirname
 from functools import wraps
@@ -145,6 +146,8 @@ def objtojson(obj):
         return obj.total_seconds()
     elif isinstance(obj, QuerySet) or isinstance(obj, set):
         return list(obj)
+    elif isinstance(obj, Decimal):
+        return str(obj)
     elif type(obj).__name__ == "RelatedManager":
         return [x.pk for x in obj.all()]
     elif hasattr( obj, '__dict__') and isinstance(obj, Model):
-- 
2.1.4



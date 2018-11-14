Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id AEA4E6C3B3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 09:35:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wAE9ZErI004533
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 01:35:15 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Wed, 14 Nov 2018 01:35:14 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Nov 2018 17:46:38 +0800
Message-ID: <7a25548fdd324e89b75289fda6723c1d372e9385.1542188647.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542188647.git.liezhi.yang@windriver.com>
References: <cover.1542188647.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/6] bitbake: data_smart: Add original traceback to ExpansionError
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
X-List-Received-Date: Wed, 14 Nov 2018 09:35:13 -0000
Content-Type: text/plain

This can make it print clearer errors, for exmaple:

Add Runtime_error to 'def oe_import(d)"

 16 def oe_import(d):
 17     import sys
 18     Runtime_error
[snip]

* Before the patch:
  $ bitbake -p
  ERROR: Unable to parse /buildarea1/lyang1/poky/bitbake/lib/bb/data_smart.py
  Traceback (most recent call last):
    File "/buildarea1/lyang1/poky/bitbake/lib/bb/data_smart.py", line 430, in DataSmart.expandWithRefs(s='${@oe_import(d)}', varname='OE_IMPORTED[:=]'):
                   except Exception as exc:
      >                raise ExpansionError(varname, s, exc) from exc

  bb.data_smart.ExpansionError: Failure expanding variable OE_IMPORTED[:=], expression was ${@oe_import(d)} which triggered exception NameError: name 'Runtime_error' is not defined

  This error message has two problems:
  - "Unable to parse data_smart.py": This isn't the real cause.
  - It pionts to "raise ExpansionError(varname, s, exc) from exc" which isn't clear enough.

* After the patch:
  $ bitbake -p
  ERROR: Unable to parse OE_IMPORTED[:=]
  Traceback (most recent call last):
    File "OE_IMPORTED[:=]", line 1, in <module>
    File "/buildarea1/lyang1/poky/meta/classes/base.bbclass", line 18, in oe_import(d=<bb.data_smart.DataSmart object at 0x7f9257e7a0b8>):
           import sys
      >    Runtime_error

  bb.data_smart.ExpansionError: Failure expanding variable OE_IMPORTED[:=], expression was ${@oe_import(d)} which triggered exception NameError: name 'Runtime_error' is not defined

This one is more clearer than before.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/data_smart.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 6b94fc4..efa5a79 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -427,7 +427,8 @@ class DataSmart(MutableMapping):
             except bb.parse.SkipRecipe:
                 raise
             except Exception as exc:
-                raise ExpansionError(varname, s, exc) from exc
+                tb = sys.exc_info()[2]
+                raise ExpansionError(varname, s, exc).with_traceback(tb) from exc
 
         varparse.value = s
 
-- 
2.7.4



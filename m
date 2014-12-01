Return-Path: <ross.burton@intel.com>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 5833D7226F
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Dec 2014 20:50:41 +0000 (UTC)
Received: by mail-wg0-f46.google.com with SMTP id a1so7000821wgh.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 01 Dec 2014 12:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=Ag9eYS+rjGGA2c0HEEfiVEd/MOeFVrblGUub0tv29Rs=;
	b=iSzQ4PZCPPNL79ieMXPj/toxGhux48t3yrLF7RRd02tKrG+ddvafnfcCK3wSb1Z8z4
	R443holxb8G9K+N1Uv+txP+L/34+fmmqupMrDFADS2xEQDfEukYyOmy14AKeORcV7qRq
	fnIeWVoAjZd79i/zdLy48rmVE0hJXJ+zi9/DmIPaDZ54e0rhWG0PMoYpC3Us1rgvGKKC
	HDu51SHFsD9JhabDuHmzLIC+Wvqyiv6QB+Ys1KBsJh7JCDU0wxdZ0pbhbgmdROdEzBLj
	05L9OOxqmuSRThV+qKGxFr8RAyCpY4kq/c/gTA4Z6YEij20dUdhyf1Wf/rEbM3GXFZQk
	ZU8Q==
X-Gm-Message-State: ALoCoQlvnltiWhnvwryEBewK3bwc42T8WpROkvml8kDgF31NtWDzUSeA6qZvmqzlPAZkfOV+L1vl
X-Received: by 10.194.235.193 with SMTP id uo1mr95374233wjc.105.1417467042031; 
	Mon, 01 Dec 2014 12:50:42 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by mx.google.com with ESMTPSA id
	ex8sm29079709wjd.41.2014.12.01.12.50.40
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 01 Dec 2014 12:50:41 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Dec 2014 20:50:14 +0000
Message-Id: <1417467014-26415-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] data: rename defaultval to _defaultval
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
X-List-Received-Date: Mon, 01 Dec 2014 20:50:44 -0000

The defaultval field is intended to be internal and the only use of that field
outside of data.py is to skip over it when iterating over a value's flags.

For clarity and convenience, rename the field to _defaultval so that it is
considered internal and not exposed through the data API.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/data_smart.py |    6 +++---
 bitbake/lib/bb/parse/ast.py  |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 9a42a17..31ce9a5 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -589,7 +589,7 @@ class DataSmart(MutableMapping):
             self._makeShadowCopy(var)
         self.dict[var][flag] = value
 
-        if flag == "defaultval" and '_' in var:
+        if flag == "_defaultval" and '_' in var:
             self._setvar_update_overrides(var)
 
         if flag == "unexport" or flag == "export":
@@ -605,8 +605,8 @@ class DataSmart(MutableMapping):
         if local_var is not None:
             if flag in local_var:
                 value = copy.copy(local_var[flag])
-            elif flag == "_content" and "defaultval" in local_var and not noweakdefault:
-                value = copy.copy(local_var["defaultval"])
+            elif flag == "_content" and "_defaultval" in local_var and not noweakdefault:
+                value = copy.copy(local_var["_defaultval"])
         if expand and value:
             # Only getvar (flag == _content) hits the expand cache
             cachename = None
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 4e5a06e..af42a0c 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -128,7 +128,7 @@ class DataNode(AstNode):
         if 'flag' in groupd and groupd['flag'] != None:
             flag = groupd['flag']
         elif groupd["lazyques"]:
-            flag = "defaultval"
+            flag = "_defaultval"
 
         loginfo['op'] = op
         loginfo['detail'] = groupd["value"]
-- 
1.7.10.4



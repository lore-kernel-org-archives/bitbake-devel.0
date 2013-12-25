Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2BA746B230
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Dec 2013 02:19:33 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rBP2JYIY008054
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 18:19:34 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 24 Dec 2013 18:19:33 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 24 Dec 2013 21:19:27 -0500
Message-ID: <eb8fbbd711c3604f8b63ee0421357f0ad7c4c9bc.1387937195.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1387937195.git.liezhi.yang@windriver.com>
References: <cover.1387937195.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/4] bitbake: data: Fix output inconsistencies for emit_var
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
X-List-Received-Date: Wed, 25 Dec 2013 02:19:33 -0000
Content-Type: text/plain

From: Richard Purdie <richard.purdie@linuxfoundation.org>

VAL = ""     (not shown)
VAL = " "    (shown as "")
VAL = " x"   (shown as "x")

would all show up rather differently to what would be expected in the
bitbake -e output. This fixes things so they appear consistently.

The output for running some shell functions may also change slightly
but shouldn't change in a way that is likely to cause problems.

[YOCTO #5507]

(Bitbake master rev: fcba5ef0053dc0ef5360e4912609e5d52f5046b0)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/data.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index 349fcfe..bdd1e79 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -214,7 +214,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
         o.write('unset %s\n' % varExpanded)
         return 0
 
-    if not val:
+    if val is None:
         return 0
 
     val = str(val)
@@ -229,7 +229,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
 
     # if we're going to output this within doublequotes,
     # to a shell, we need to escape the quotes in the var
-    alter = re.sub('"', '\\"', val.strip())
+    alter = re.sub('"', '\\"', val)
     alter = re.sub('\n', ' \\\n', alter)
     o.write('%s="%s"\n' % (varExpanded, alter))
     return 0
-- 
1.7.10.4



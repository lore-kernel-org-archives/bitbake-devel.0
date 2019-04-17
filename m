Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 47D527D359
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 11:03:20 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x3HB31Ob015387
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 04:03:11 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Wed, 17 Apr 2019 04:02:50 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 17 Apr 2019 19:01:50 +0800
Message-ID: <87140bbe8b707885d87e3847b44ed8852cafb935.1555498609.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1555498609.git.liezhi.yang@windriver.com>
References: <cover.1555498609.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/3 V2] bb: siggen: Make dump_sigfile and compare_sigfiles print uuid4
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
X-List-Received-Date: Wed, 17 Apr 2019 11:03:20 -0000
Content-Type: text/plain

This can make people easier to understand bitbake-diffsigs/dumpsig's output,
otherwise, it's hard to know it is a random uuid unless look into the code.

E.g.:
$ bitbake bc-native -ccleansstate -Snone
$ bitbake bc-native -ccleansstate -Snone
$ bitbake-diffsigs tmp/stamps/x86_64-linux/bc-native/1.07.1-r0.do_cleansstate.sigdata.*

* Before:
  Taint (by forced/invalidated task) changed from nostamp:fe79d162-c4a8-4174-8007-f6d4aa09abdc to nostamp:28192187-5021-40c1-9e21-45483b62c910

* Now:
  Taint (by forced/invalidated task) changed from nostamp(uuid4):fe79d162-c4a8-4174-8007-f6d4aa09abdc to nostamp(uuid4):28192187-5021-40c1-9e21-45483b62c910

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/siggen.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 09c9c8a..89bf533 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -633,6 +633,10 @@ def compare_sigfiles(a, b, recursecb=None, color=False, collapsed=False):
     a_taint = a_data.get('taint', None)
     b_taint = b_data.get('taint', None)
     if a_taint != b_taint:
+        if a_taint.startswith('nostamp:'):
+            a_taint = a_taint.replace('nostamp:', 'nostamp(uuid4):')
+        if b_taint.startswith('nostamp:'):
+            b_taint = b_taint.replace('nostamp:', 'nostamp(uuid4):')
         output.append(color_format("{color_title}Taint (by forced/invalidated task) changed{color_default} from %s to %s") % (a_taint, b_taint))
 
     return output
@@ -705,7 +709,11 @@ def dump_sigfile(a):
             output.append("Hash for dependent task %s is %s" % (dep, a_data['runtaskhashes'][dep]))
 
     if 'taint' in a_data:
-        output.append("Tainted (by forced/invalidated task): %s" % a_data['taint'])
+        if a_data['taint'].startswith('nostamp:'):
+            msg = a_data['taint'].replace('nostamp:', 'nostamp(uuid4):')
+        else:
+            msg = a_data['taint']
+        output.append("Tainted (by forced/invalidated task): %s" % msg)
 
     if 'task' in a_data:
         computed_basehash = calc_basehash(a_data)
-- 
2.7.4



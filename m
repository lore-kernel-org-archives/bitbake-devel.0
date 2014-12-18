Return-Path: <rich.tollerton@ni.com>
X-Greylist: delayed 1952 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 18 Dec 2014 01:43:56 UTC
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
	by mail.openembedded.org (Postfix) with ESMTP id 6382D72503
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Dec 2014 01:43:56 +0000 (UTC)
Received: from us-aus-mgwout2.amer.corp.natinst.com (nb-snip2-1338.natinst.com
	[130.164.19.135])
	by us-aus-skprod2.natinst.com (8.14.5/8.14.5) with ESMTP id
	sBI1BPZs011355 for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Dec 2014 19:11:25 -0600
Received: from weregild.amer.corp.natinst.com ([130.164.14.198])
	by us-aus-mgwout2.amer.corp.natinst.com (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2014121719112517-1243305 ;
	Wed, 17 Dec 2014 19:11:25 -0600 
From: Richard Tollerton <rich.tollerton@ni.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Dec 2014 19:11:18 -0600
Message-Id: <1418865078-10484-2-git-send-email-rich.tollerton@ni.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418865078-10484-1-git-send-email-rich.tollerton@ni.com>
References: <1418865078-10484-1-git-send-email-rich.tollerton@ni.com>
X-MIMETrack: Itemize by SMTP Server on US-AUS-MGWOut2/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 12/17/2014 07:11:25 PM,
	Serialize by Router on US-AUS-MGWOut2/AUS/H/NIC(Release
	8.5.3FP6|November 21, 2013) at 12/17/2014 07:11:25 PM,
	Serialize complete at 12/17/2014 07:11:25 PM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.13.68, 1.0.33,
	0.0.0000
	definitions=2014-12-17_07:2014-12-17, 2014-12-17,
	1970-01-01 signatures=0
Subject: [PATCH] data: escape '$' in shell variable assignment
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
X-List-Received-Date: Thu, 18 Dec 2014 01:44:04 -0000

Running bitbake inside make results in the exported environment variable
MAKEOVERRIDES="${-*-command-variables-*-}", which the shell chokes on
when trying to expand it. But of course, it probably shouldn't have been
trying to expand it in the first place -- so just escape the dollar
sign.

Signed-off-by: Richard Tollerton <rich.tollerton@ni.com>
---
 lib/bb/data.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 6c8d644..e9d8290 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -242,6 +242,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
     # to a shell, we need to escape the quotes in the var
     alter = re.sub('"', '\\"', val)
     alter = re.sub('\n', ' \\\n', alter)
+    alter = re.sub('\\$', '\\\\$', alter)
     o.write('%s="%s"\n' % (varExpanded, alter))
     return 0
 
-- 
2.1.3



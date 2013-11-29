Return-Path: <nathan.rossi@xilinx.com>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
	by mail.openembedded.org (Postfix) with ESMTP id 1F4DD6D5A1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Nov 2013 05:19:21 +0000 (UTC)
Received: from mail130-tx2-R.bigfish.com (10.9.14.236) by
	TX2EHSOBE011.bigfish.com (10.9.40.31) with Microsoft SMTP Server id
	14.1.225.22; Fri, 29 Nov 2013 05:19:19 +0000
Received: from mail130-tx2 (localhost [127.0.0.1])	by
	mail130-tx2-R.bigfish.com (Postfix) with ESMTP id BC4441C00E8;
	Fri, 29 Nov 2013 05:19:19 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:149.199.60.83; KIP:(null); UIP:(null); IPV:NLI;
	H:xsj-gw1; RD:unknown-60-83.xilinx.com; EFVD:NLI
X-SpamScore: 0
X-BigFish: VPS0(zz4015Izz1f42h2148h208ch1ee6h1de0h1fdah2073h2146h1202h1e76h1d1ah1d2ah1fc6hzz1de098h8275bh1de097hz2fh95h839hd24hf0ah119dh1288h12a5h12a9h12bdh12e5h137ah139eh13b6h1441h14ddh1504h1537h162dh1631h1758h1898h18e1h1946h19b5h1b0ah224fh1d0ch1d2eh1d3fh1dc1h1dfeh1dffh1e1dh1e23h1fe8h1ff5h2218h2216h226dh2327h2336h906i1155h)
Received-SPF: pass (mail130-tx2: domain of xilinx.com designates 149.199.60.83
	as permitted sender) client-ip=149.199.60.83;
	envelope-from=nathan.rossi@xilinx.com; helo=xsj-gw1 ;
	helo=xsj-gw1 ; 
Received: from mail130-tx2 (localhost.localdomain [127.0.0.1]) by mail130-tx2
	(MessageSwitch) id 1385702357200179_11932;
	Fri, 29 Nov 2013 05:19:17 +0000 (UTC)
Received: from TX2EHSMHS044.bigfish.com (unknown [10.9.14.228])	by
	mail130-tx2.bigfish.com (Postfix) with ESMTP id 2A78F1A004B;
	Fri, 29 Nov 2013 05:19:17 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by TX2EHSMHS044.bigfish.com
	(10.9.99.144) with Microsoft SMTP Server id 14.16.227.3;
	Fri, 29 Nov 2013 05:19:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-smtp1)	by
	xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
	<nathan.rossi@xilinx.com>)	id
	1VmGU0-0006bY-Mb; Thu, 28 Nov 2013 21:19:16 -0800
From: Nathan Rossi <nathan.rossi@xilinx.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 29 Nov 2013 15:19:11 +1000
X-Mailer: git-send-email 1.7.9.5
X-RCIS-Action: ALLOW
MIME-Version: 1.0
Message-ID: <fc56b436-2f80-4db5-a39c-672ddfa04224@TX2EHSMHS044.ehs.local>
X-OriginatorOrg: xilinx.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-Mailman-Approved-At: Fri, 29 Nov 2013 18:03:35 +0000
Cc: Nathan Rossi <nathan.rossi@xilinx.com>, meta-xilinx@yoctoproject.org
Subject: [PATCH] cooker: Fix support for wildcards in bbappend filenames
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
X-List-Received-Date: Fri, 29 Nov 2013 05:19:22 -0000
Content-Type: text/plain

The 'bbappend in f' incorrectly compares the current recipe with the avaliable
bbappends recipes. This comparsion causes unrequested bbappend files to be
appended, e.g. in the case of 'libgcc_4.8.bb', the bbappends for 'libgcc_4.8.bb'
and 'gcc_4.8.bb' are added to the filelist (because 'gcc_4.8.bb' is contained in
the 'libgcc_4.8.bb' string) which in turn causes the gcc_4.8.bbappend files to
be appended to the libgcc_4.8 recipe.

This should be a 'bbappend == f' to match the previous implementation of this
function, such that if no wildcard is present the recipe names must match
exactly.

This issue was introduced by commit 31bc9af9cd56e7b318924869970e850993fafc5f,
which it related to [YOCTO #5411].

Signed-off-by: Nathan Rossi <nathan.rossi@xilinx.com>
---

This patch resolves an issue that is seen in the meta-xilinx yocto layer. In the
layer we add appends for both gcc and libgcc, as such we get a duplication of
configuration.

Please let me know if this patch is expected, or if the change to the bbappend
naming has changed such that the layer needs to be fixed.

Thanks,
Nathan

---
 lib/bb/cooker.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1f494ee..b36ed6f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1486,7 +1486,7 @@ class CookerCollectFiles(object):
         filelist = []
         f = os.path.basename(fn)
         for bbappend in self.appendlist:
-            if bbappend in f or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
+            if (bbappend == f) or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
                 self.appliedappendlist.append(bbappend)
                 for filename in self.appendlist[bbappend]:
                     filelist.append(filename)
-- 
1.7.9.5




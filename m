Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4599A77EFE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jun 2017 12:38:13 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v57CcCMu014264
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 7 Jun 2017 13:38:13 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dIaE0-0000ks-Qj; Wed, 07 Jun 2017 13:38:12 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Jun 2017 13:38:11 +0100
Message-Id: <1496839091-2864-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Wed, 07 Jun 2017 13:38:14 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] cookerdata: Implement LAYERSERIES_COMPAT and LAYERSERIES_CORENAMES
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
X-List-Received-Date: Wed, 07 Jun 2017 12:38:14 -0000

Currently, someone trying a master branch of any given layer may
or may not find it works with the version of OE-Core that they
have picked.

This patchset introduces LAYERSERIES_CORENAMES and
LAYERSERIES_COMPAT_<layername> with the intention of allowing layers
to indicate which versions of the core project they're compatible with.

In general the master branch will use the next release codename as
the value of LAYERSERIES_CORENAMES, meaning that the waterfall model
of layer releases is supported with layers updating their
LAYERSERIES_COMPAT_ values as they branch for release.

Both variables support multiple strings and a given layer is accepted
if there is overlap of any one value. This means a layer can be compatible
with multiple core versions.

Setting LAYERSERIES_COMPAT_ will be required by the Yocto Project
Compatible v2 standard but the system will not error if its not set at this
point.

This should make it clear when a given layer is unmaintained and untested
with new releaes of OE-Core, a common user pain point.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index aa96f54..256e4f3 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -360,6 +360,13 @@ class CookerDataBuilder(object):
             if invalid:
                 bb.fatal("BBFILES_DYNAMIC entries must be of the form <collection name>:<filename pattern>, not:\n    %s" % "\n    ".join(invalid))
 
+            layerseries = set((data.getVar("LAYERSERIES_CORENAMES") or "").split())
+            for c in collections:
+                compat = set((data.getVar("LAYERSERIES_COMPAT_%s" % c) or "").split())
+                if compat and not (compat & layerseries):
+                    bb.fatal("Layer %s is not compatible with the core layer which only supports these series: %s (layer is compatible with %s)"
+                              % (c, " ".join(layerseries), " ".join(compat)))
+
         if not data.getVar("BBPATH"):
             msg = "The BBPATH variable is not set"
             if not layerconf:
-- 
2.7.4



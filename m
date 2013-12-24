Return-Path: <zhenhua.luo@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe005.messaging.microsoft.com [216.32.180.31])
	by mail.openembedded.org (Postfix) with ESMTP id 767066A5A2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 08:07:08 +0000 (UTC)
Received: from mail144-va3-R.bigfish.com (10.7.14.240) by
	VA3EHSOBE002.bigfish.com (10.7.40.22) with Microsoft SMTP Server id
	14.1.225.22; Tue, 24 Dec 2013 08:07:09 +0000
Received: from mail144-va3 (localhost [127.0.0.1])	by
	mail144-va3-R.bigfish.com (Postfix) with ESMTP id 3BA903000AA	for
	<bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 08:07:09 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: 0
X-BigFish: VS0(zzzz1f42h2148h208ch1ee6h1de0h1fdah2073h2146h1202h1e76h2189h1d1ah1d2ah1fc6hzz1de098h8275bh1de097hz2dh2a8h839hd24he5bhf0ah1288h12a5h12a9h12bdh12e5h1354h137ah139eh13b6h1441h1504h1537h162dh1631h1758h1898h18e1h1946h19b5h1ad9h1b0ah1b2fh2222h224fh1fb3h1d0ch1d2eh1d3fh1dfeh1dffh1e23h1fe8h1ff5h2218h2216h226dh22d0h2327h2336h1155h)
Received: from mail144-va3 (localhost.localdomain [127.0.0.1]) by mail144-va3
	(MessageSwitch) id 1387872427225713_4001;
	Tue, 24 Dec 2013 08:07:07 +0000 (UTC)
Received: from VA3EHSMHS029.bigfish.com (unknown [10.7.14.237])	by
	mail144-va3.bigfish.com (Postfix) with ESMTP id 284CD42004D;
	Tue, 24 Dec 2013 08:07:07 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by VA3EHSMHS029.bigfish.com
	(10.7.99.39) with Microsoft SMTP Server (TLS) id 14.16.227.3;
	Tue, 24 Dec 2013 08:07:00 +0000
Received: from tx30smr01.am.freescale.net (10.81.153.31) by
	039-SN1MMR1-002.039d.mgd.msft.net (10.84.1.15) with Microsoft SMTP
	Server (TLS) id 14.3.158.2; Tue, 24 Dec 2013 08:06:59 +0000
Received: from localhost.localdomain (B19537-03.ap.freescale.net
	[10.193.20.127])	by tx30smr01.am.freescale.net (8.14.3/8.14.0) with
	ESMTP id rBO86soJ021591;	Tue, 24 Dec 2013 01:06:57 -0700
From: Zhenhua Luo <zhenhua.luo@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 24 Dec 2013 16:06:32 +0800
Message-ID: <1387872393-4567-2-git-send-email-zhenhua.luo@freescale.com>
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
References: <1387872393-4567-1-git-send-email-zhenhua.luo@freescale.com>
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-FOPE-CONNECTOR: Id%0$Dn%FREESCALE.MAIL.ONMICROSOFT.COM$RO%1$TLS%0$FQDN%$TlsDn%
Cc: b40290@freescale.com, b40527@freescale.com
Subject: [PATCH 1/2] bitbake: fetch2/git: Add sanity check for SHA validity of tag
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
X-List-Received-Date: Tue, 24 Dec 2013 08:07:08 -0000
Content-Type: text/plain

The change add the sanity check for SHA valididy when tag is defined in SRC_URI,
the check is useful for rebased git tree in which the referred commit is not valid
in branch and is saved in tag.

Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
---
 lib/bb/fetch2/git.py | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index bd107db..1c2d5d3 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -116,6 +116,15 @@ class Git(FetchMethod):
             ud.branches[name] = branch
             ud.unresolvedrev[name] = branch
 
+        tags = ud.parm.get("tag", "").split(',')
+        if len(tags) != len(ud.names):
+            raise bb.fetch2.ParameterError("The number of name and tag parameters is not balanced", ud.url)
+        ud.tags = {}
+        for name in ud.names:
+            tag = tags[ud.names.index(name)]
+            ud.tags[name] = tag
+            ud.unresolvedrev[name] = tag
+
         ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git"
 
         ud.write_tarballs = ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") != "0") or ud.rebaseable
@@ -218,7 +227,10 @@ class Git(FetchMethod):
         os.chdir(ud.clonedir)
         for name in ud.names:
             if not self._contains_ref(ud, d, name):
-                raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
+                if ud.tags[name]: 
+                    raise bb.fetch2.FetchError("Unable to find revision %s in tag %s even from upstream" % (ud.revisions[name], ud.tags[name]))
+                else:
+                    raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
 
     def build_mirror_data(self, ud, d):
         # Generate a mirror tarball if needed
@@ -288,6 +300,18 @@ class Git(FetchMethod):
         return True
 
     def _contains_ref(self, ud, d, name):
+        if len(ud.tags[name]) != 0:
+            cmd =  "%s tag --contains %s --list %s 2> /dev/null | wc -l" % (
+                ud.basecmd, ud.revisions[name], ud.tags[name])
+            try:
+                output = runfetchcmd(cmd, d, quiet=True)
+            except bb.fetch2.FetchError:
+                return False
+            if len(output.split()) > 1:
+                raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
+            else:
+                return output.split()[0] != "0"
+
         cmd =  "%s branch --contains %s --list %s 2> /dev/null | wc -l" % (
             ud.basecmd, ud.revisions[name], ud.branches[name])
         try:
@@ -296,7 +320,8 @@ class Git(FetchMethod):
             return False
         if len(output.split()) > 1:
             raise bb.fetch2.FetchError("The command '%s' gave output with more then 1 line unexpectedly, output: '%s'" % (cmd, output))
-        return output.split()[0] != "0"
+        else:
+            return output.split()[0] != "0"
 
     def _revision_key(self, ud, d, name):
         """
-- 
1.8.4.2




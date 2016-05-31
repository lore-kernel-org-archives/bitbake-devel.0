Return-Path: <fabien.proriolpatch@kazoe.org>
X-Greylist: delayed 313 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 31 May 2016 13:24:25 UTC
Received: from ksn.kazoe.org (ns363339.ip-91-121-179.eu [91.121.179.62])
	by mail.openembedded.org (Postfix) with ESMTP id B45F47715A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 May 2016 13:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=kazoe.org; s=dkim;
	t=1464700181; bh=wC+WWZgmdQ9nAc6xwasjl6lUOKLA5f3Fsi+9zK93tnI=;
	h=From:To:Cc:Subject:Date:From;
	b=fRGTP10o2QdtwKByyFg65dEAFR//PDSlS3x8kbPc7iIiA7b0Zoanilfn0yf7yfeMi
	Rn+LrEfC/d5ab8ITT9C6EuyQMemkNJQqcvsVSdynPqeNCsGU/PEBTjKORwKn7F/XMo
	f/ZZBDetnZqBjCbvBINCfZHuB8IfD4uvP6SwrlIk=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=kazoe.org; s=dkim;
	t=1464700184; bh=wC+WWZgmdQ9nAc6xwasjl6lUOKLA5f3Fsi+9zK93tnI=;
	h=From:To:Cc:Subject:Date:From;
	b=Dr0Hrv0QVbTx6FDMpWMfsHh9J3PzQg6lRvrHPp8K1s17bUS0gp4cwCF1LRhfGwCuP
	ZANFpm9IX6YGCVYpBI4ykFtktfTOAeVW7ROo/fmFI00mHlB3ceaWYVD0CFR+c0cvbe
	69edAXBektI0uqeBBa4pn0nAp1paYSrIcMZUWmy0=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=kazoe.org; s=dkim;
	t=1464700184; bh=wC+WWZgmdQ9nAc6xwasjl6lUOKLA5f3Fsi+9zK93tnI=;
	h=From:To:Cc:Subject:Date:From;
	b=Tgq+9rcr5d1eSzguE8UT5QYkmuIk5meqkYcP8MrOAd0HOm0eGSrhn94vcvM636XKE
	wSqNxf1Q6tC8Mk91W6uTcPBj5tecsLGhXKX7oeTxByBuULOCiY5+xoBLWdRlwxG5YX
	hTc8oRH17Mhmh5gMGSQnxL8Njow9NDo1YpeAsOZs=
From: fabien.proriolpatch@kazoe.org
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 May 2016 15:18:04 +0200
Message-Id: <1464700684-24169-1-git-send-email-fabien.proriolpatch@kazoe.org>
X-Mailer: git-send-email 2.7.3
Cc: Fabien Proriol <fabien.proriol@jdsu.com>, rpurdie@rpsys.net
Subject: [PATCH] bb.fetch.git: add a way to avoid git protocol, and force http or https mirrors
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
X-List-Received-Date: Tue, 31 May 2016 13:24:29 -0000

From: Fabien Proriol <fabien.proriol@jdsu.com>

This patch add the possibility to bitbake to avoid git protocol to fetch sources.
This is usefull in some network with firewall blocking git port.

When BB_GIT_PROTOCOL_FIREWALL is set, the PROTOCOL_MIRRORS table is used to find the new protocol (http or https) and the new host (if different) to used.

BB_GIT_PROTOCOL_FIREWALL can also contains a list of host accepted. This is usefull for exemple, if we use local git repository inside the network.

Exemple usage:
    # Avoid all git protocol
    BB_GIT_PROTOCOL_FIREWALL = "1"

    # Avoid git protocol, except for srv1 and srv2 in local network
    BB_GIT_PROTOCOL_FIREWALL = "srv1.mydomain.com;srv2.mydomain.com"

Signed-off-by: Fabien Proriol <fabien.proriol@jdsu.com>
---
 bitbake/lib/bb/fetch2/git.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 526668b..27dde60 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -76,6 +76,20 @@ from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
 
+PROTOCOL_MIRRORS = {
+    "sourceware.org": {"protocol":"http"},
+    "github.com": {"protocol":"https"},
+    "git.sv.gnu.org": {"protocol":"https", "host":"git.savannah.gnu.org/r"},
+    "anongit.freedesktop.org": {"protocol":"http"},
+    "anonscm.debian.org": {"protocol":"https", "host":"anonscm.debian.org/git"},
+    "git.gnome.org": {"protocol":"https", "host":"git.gnome.org/browse"},
+    "git.yoctoproject.org": {"protocol":"http", "host":"git.yoctoproject.org/git"},
+    "git.kernel.org": {"protocol":"https"},
+    "git.denx.de": {"protocol":"http"},
+    "git.lttng.org": {"protocol":"http"},
+    "git.infradead.org":  {"protocol":"https", "host":"github.com/eva-oss"},
+}
+
 class Git(FetchMethod):
     """Class to fetch a module or modules from git repositories"""
     def init(self, d):
@@ -102,6 +116,12 @@ class Git(FetchMethod):
         else:
             ud.proto = "git"
 
+        firewall = d.getVar("BB_GIT_PROTOCOL_FIREWALL", True)
+        if firewall:
+            self.git_firewall = firewall.split(";")
+        else:
+            self.git_firewall = None
+
         if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
             raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
 
@@ -315,6 +335,16 @@ class Git(FetchMethod):
             username = ud.user + '@'
         else:
             username = ""
+
+        if (ud.proto == "git") and (self.git_firewall):
+            if not ud.host in self.git_firewall:
+                if ud.host.strip() in PROTOCOL_MIRRORS.keys():
+                    ud.proto = PROTOCOL_MIRRORS[ud.host]["protocol"]
+                    if "host" in PROTOCOL_MIRRORS[ud.host].keys():
+                        ud.host = PROTOCOL_MIRRORS[ud.host]["host"]
+                else:
+                    raise bb.fetch2.FetchError("Unknown protocol mirror for %s (%s)" % (ud.host.strip(), ud.path))
+
         return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
 
     def _revision_key(self, ud, d, name):
-- 
2.7.3


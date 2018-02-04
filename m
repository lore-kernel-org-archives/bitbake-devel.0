Return-Path: <zboszor@pr.hu>
Received: from mail7.pr.hu (mail7.pr.hu [87.242.0.7])
	by mail.openembedded.org (Postfix) with ESMTP id B9686605C2
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  4 Feb 2018 08:36:34 +0000 (UTC)
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
	by frontdoor.pr.hu with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <zboszor@pr.hu>) id 1eiFmw-0001m3-CK
	for bitbake-devel@lists.openembedded.org;
	Sun, 04 Feb 2018 09:36:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pr.hu;
	s=pr20170203; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kY/+s7D6WmiZXHg11uyvHCrRWM726jRD6zNPNWDbH8U=;
	b=LyNv6lL7FMMPiipY3dEQT652+M
	LfNtOz39qWj2gU/tEkpfRM4kQ8fpySvkyt4eXWPO1TS7hegwhWOSEvrPe/moC002L52tSpUk51yl1
	ZgBRtjWCCLIXGsqbxgEpm1iXOeaUVoNTnY7DN/xHSOtMamIEBQDq+dbBE76EnyT1KUa5bnBaLswxD
	pjpdayuHhwj7XgBJV/g/g19YnayFwUqLrc0KPYhtlJVeHsiE2TC0E/+MDYtFGOIqNpGzd5I3xOYGS
	BY5gPz6mUqhXQsInCI+iGP5GKJr7EOjvW8l8NwMb+dM4vYGqs29vD+r7yo7VWxoM0ywtpSkPIsYTe
	vmz6st9A==;
Received: from [88.132.200.166] (helo=localhost.localdomain.com)
	by mail.pr.hu with esmtpa (Exim 4.89) (envelope-from <zboszor@pr.hu>)
	id 1eiFmp-000778-7b; Sun, 04 Feb 2018 09:36:33 +0100
From: =?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?= <zboszor@pr.hu>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  4 Feb 2018 09:36:15 +0100
Message-Id: <20180204083615.8431-1-zboszor@pr.hu>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <6c003a37-1455-4a3c-4b67-9a212cda5292@pr.hu>
References: <6c003a37-1455-4a3c-4b67-9a212cda5292@pr.hu>
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 88.132.200.166 (failed)
X-Spam-Score: 0.6 (/)
X-Scan-Signature: f863141675028d675eb61fc829984e23
X-Spam-Tracer: backend.mail.pr.hu 0.6 20180204083633Z
Subject: [PATCH] fetch2/npm.py: Fix inverted condition to prevent infinite loop
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
X-List-Received-Date: Sun, 04 Feb 2018 08:36:35 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

At least the cli-color node module has dependencies that have
cyclic dependency among themselves. npm.py is prepared to deal
with such a case but the condition is handled only for downloading
or not a dependency again, but then it goes checking the its
dependency which causes an infinite loop in _getdependencies().
Make this function simply return when a dependency is already
downloaded and only download and check its dependencies when not.

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 lib/bb/fetch2/npm.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index b5f148ca..730c346a 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -195,9 +195,11 @@ class Npm(FetchMethod):
         outputurl = pdata['dist']['tarball']
         data[pkg] = {}
         data[pkg]['tgz'] = os.path.basename(outputurl)
-        if not outputurl in fetchedlist:
-            self._runwget(ud, d, "%s --directory-prefix=%s %s" % (self.basecmd, ud.prefixdir, outputurl), False)
-            fetchedlist.append(outputurl)
+        if outputurl in fetchedlist:
+            return
+
+        self._runwget(ud, d, "%s --directory-prefix=%s %s" % (self.basecmd, ud.prefixdir, outputurl), False)
+        fetchedlist.append(outputurl)
 
         dependencies = pdata.get('dependencies', {})
         optionalDependencies = pdata.get('optionalDependencies', {})
-- 
2.14.3



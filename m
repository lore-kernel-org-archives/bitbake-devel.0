Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f176.google.com (mail-ea0-f176.google.com
	[209.85.215.176])
	by mail.openembedded.org (Postfix) with ESMTP id D6AB56B880
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 14:54:58 +0000 (UTC)
Received: by mail-ea0-f176.google.com with SMTP id h14so1158446eaj.21
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 06:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=f6Bxfitrxyn841khaHlReTqVqlKvsSdD0RgnOkQmy88=;
	b=eZ9mUDguuU2RHulRAl8aCur+dUN+/Q8HMbKoqdFq54VurHJxc7Nhn1GkJlgnBE5dH+
	iIOSCHuMGqpmddd0Z2bQmFtubtNAW3TARvN6LcaP13t/dlTeiudrp2z+M1k3HYd0UD2E
	dGSiLrd3shKUXUy2ahpDATAMNQjH+cKV0iN4Y4ksd8PYaeTSt9sBFJZoR+BDAWkPSoQj
	5h68K4hYTZaNMHsLLfNuJv7chExw4PkGwZaYhqNxDx1KR2w4oakNg2R8mDM1SzyjVfdH
	Z0EmmYzW4hihWErmKknRgGkdoOJ/D5BbESg2fNweRvlTEEvjZgYO+ZgWxrkFmViSOHyx
	VfiA==
X-Received: by 10.14.202.196 with SMTP id d44mr1881098eeo.87.1389884099146;
	Thu, 16 Jan 2014 06:54:59 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id m47sm18776466eey.7.2014.01.16.06.54.58
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Jan 2014 06:54:58 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Jan 2014 15:55:19 +0100
Message-Id: <1389884119-3694-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389880881-4209-1-git-send-email-Martin.Jansa@gmail.com>
References: <1389880881-4209-1-git-send-email-Martin.Jansa@gmail.com>
Subject: [PATCHv3] fetch2: Don't allow '/' in user:pass, fix branch containing '@'
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
X-List-Received-Date: Thu, 16 Jan 2014 14:54:59 -0000

* currently decode_url regexp parses branch=@foo as username so it ends like this:
  - ('git', '', 'foo', 'git.openembedded.org/bitbake;branch=', '', {})
  + ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'})
* http://hg.python.org/cpython/file/2.7/Lib/urlparse.py also assumes
  that there is at least one '/' as separator between netloc and path,
  params, so it looks reasonable to prevent including '/' in username

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/tests/fetch.py     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9499a91..8f195f2 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -329,7 +329,7 @@ def decodeurl(url):
     user, password, parameters).
     """
 
-    m = re.compile('(?P<type>[^:]*)://((?P<user>.+)@)?(?P<location>[^;]+)(;(?P<parm>.*))?').match(url)
+    m = re.compile('(?P<type>[^:]*)://((?P<user>[^/]+)@)?(?P<location>[^;]+)(;(?P<parm>.*))?').match(url)
     if not m:
         raise MalformedUrl(url)
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4bcff54..e134a31 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -407,7 +407,8 @@ class URLHandle(unittest.TestCase):
     datatable = {
        "http://www.google.com/index.html" : ('http', 'www.google.com', '/index.html', '', '', {}),
        "cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', '', {'module': 'familiar/dist/ipkg'}),
-       "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', {'tag': 'V0-99-81', 'module': 'familiar/dist/ipkg'})
+       "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', {'tag': 'V0-99-81', 'module': 'familiar/dist/ipkg'}),
+       "git://git.openembedded.org/bitbake;branch=@foo" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'})
     }
 
     def test_decodeurl(self):
-- 
1.8.5.2



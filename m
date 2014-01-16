Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
	[209.85.215.177])
	by mail.openembedded.org (Postfix) with ESMTP id 04FC06B880
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 14:53:42 +0000 (UTC)
Received: by mail-ea0-f177.google.com with SMTP id n15so1188060ead.22
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=h1wM5ulLgcdl1mnXGff8psPbYD7H7tdrlCBwCfaa8Uo=;
	b=CWzQJaKGD25g8mFHz4kpHmkJ/wW0pOiSD8UYAbGJJZcxZaoOzHxrPuQAZWIfB/r+e3
	ib64bcmTTgBojoBLvrDvcoOXvqg0UnZj1FRBi/b8fWrZ77rQnMh/WPmR90ms5JxPQe0Y
	wbmw6G/v7C02SBHPHKeZwBHj5fASFjvIO5JG4HsiCW+BCsj7ERj1kFNu3uYzEQsFyB8o
	v4VDmLNNecLx15fdgq68llVwgL7UL/LG71oz3b+YRvAxL+ReL5yWhAkkngXrW7lnntih
	XiMn0im7GNQp87YA0GImjeJlY7kuxZ38fqCK5Xg6fysAEYYEOrmMbQ6pXtoLDYXhXeA4
	jOvQ==
X-Received: by 10.15.53.129 with SMTP id r1mr1564558eew.111.1389884023245;
	Thu, 16 Jan 2014 06:53:43 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id z46sm18771615een.1.2014.01.16.06.53.42
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Jan 2014 06:53:42 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Jan 2014 15:54:02 +0100
Message-Id: <1389884042-23531-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389880881-4209-1-git-send-email-Martin.Jansa@gmail.com>
References: <1389880881-4209-1-git-send-email-Martin.Jansa@gmail.com>
Cc: Martin Jansa <martin.jansa@lge.com>
Subject: [PATCHv2] fetch2: Don't allow '/' in user:pass, fix branch containing '@'
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
X-List-Received-Date: Thu, 16 Jan 2014 14:53:43 -0000

From: Martin Jansa <martin.jansa@lge.com>

* currently decode_url regexp parses branch=@foo as username so it ends like this:
  - ('git', '', 'foo', 'git.openembedded.org/bitbake;branch=', '', {})
  + ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'})
* http://hg.python.org/cpython/file/2.7/Lib/urlparse.py also assumes
  that there is at least one '/' as separator between netloc and path,
  params, so it looks reasonable to prevent including '/' in username

Signed-off-by: Martin Jansa <martin.jansa@lge.com>
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



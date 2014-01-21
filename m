Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f182.google.com (mail-ea0-f182.google.com
	[209.85.215.182])
	by mail.openembedded.org (Postfix) with ESMTP id 6845F6E70F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 15:46:30 +0000 (UTC)
Received: by mail-ea0-f182.google.com with SMTP id r15so3030529ead.13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 07:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=+ZSMjVdV6DaDZp1DRxJnsxO4I1ASiBvxzXQeFfWURAU=;
	b=zrVkcERTBdTRNhq+zZhe02OevwXESnQir3fa6yCe8Dh+RugYUXorIXvR+hRS4seyq9
	5j53T+nOXlygoMFNLmJrv568CnFGQLpUcrhvzUvgW3C5QKqhRQCAMRp6eMhvGOSaZonK
	nHClm8dotOBtTWQIdtSX2vCc7OjuCGGkKRUBgUVtvK0NP9r3jo8hxBdNsBuaKoOOW0jZ
	t5lLMgo7A4XwcQHeOsW+WSTKP2exlNyouan3nicH6iYXCpevTM9fK76qnASra56+wSa5
	NfojnjgADeMlYr6dj+Si5dkUXzpwfmoX4iRG64io239PZ70VncWGCdsX/ayTe4F7Z1YT
	7uew==
X-Received: by 10.15.99.201 with SMTP id bl49mr16606272eeb.53.1390319191125;
	Tue, 21 Jan 2014 07:46:31 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id i2sm16104060eem.6.2014.01.21.07.46.30
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Jan 2014 07:46:30 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Jan 2014 16:46:28 +0100
Message-Id: <1390319188-21978-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.5.3
Subject: [PATCH][1.20] fetch2: Don't allow '/' in user:pass, fix branch containing '@'
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
X-List-Received-Date: Tue, 21 Jan 2014 15:46:31 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* currently decode_url regexp parses branch=@foo as username so it ends like this:
  - ('git', '', 'foo', 'git.openembedded.org/bitbake;branch=', '', {})
  + ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'})
* http://hg.python.org/cpython/file/2.7/Lib/urlparse.py also assumes
  that there is at least one '/' as separator between netloc and path,
  params, so it looks reasonable to prevent including '/' in username

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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
1.8.5.3



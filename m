Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f177.google.com (mail-ea0-f177.google.com
	[209.85.215.177])
	by mail.openembedded.org (Postfix) with ESMTP id B46BF6E22B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 14:01:03 +0000 (UTC)
Received: by mail-ea0-f177.google.com with SMTP id n15so1163274ead.36
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 06:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=Upn9k92DwDTLmv4oPyE+zIFGBhx9zYo9nBFQF8KmRe8=;
	b=HOLeVEHCYeNOmeC3Kw98jVwHjG60Lj/HQTGpyyH0umTHqHRW8VH818Xt3m3p0ZdEdX
	WQpPWhTSL7+xOaT+I/za3ziFC6NuqrX2qP5yR9kSgckDGQIcMZwU5lRjaDm2MjReMxeN
	YhT3A5VSYS0mL7nkorSzLihit3JCZpkd9CefdKN5K1gdLCzoQxftVGfHopxK3uXFX4/C
	VDzFsHKryzYG+Tt4zkdTnmBZJgebNVDWxLLaDrLcTKeViItkTAfqZ2GzQevGvwDP6uUG
	pd38nBpCYCov8ir0pB+P1PiuNOoLy7D7VjiazN4D/tbON/Jh2bj6umQGJ91/yDLACHIS
	42Pw==
X-Received: by 10.14.100.4 with SMTP id y4mr12676662eef.40.1389880864309;
	Thu, 16 Jan 2014 06:01:04 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id z46sm18380539een.1.2014.01.16.06.01.03
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Jan 2014 06:01:03 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Jan 2014 15:01:21 +0100
Message-Id: <1389880881-4209-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.5.2
Cc: Martin Jansa <martin.jansa@lge.com>
Subject: [RFC][PATCH] tests/fetch.py: Add test for branch containing '@'
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
X-List-Received-Date: Thu, 16 Jan 2014 14:01:05 -0000

From: Martin Jansa <martin.jansa@lge.com>

* currently decode_url regexp parses branch=@foo as username so it ends like this:
  - ('git', '', 'foo', 'git.openembedded.org/bitbake;branch=', '', {})
  + ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'})

Signed-off-by: Martin Jansa <martin.jansa@lge.com>
---
 lib/bb/tests/fetch.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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



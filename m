Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by mail.openembedded.org (Postfix) with ESMTP id 0017F6B96C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 15:30:03 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id z6so4783695wmi.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Mar 2019 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KC7rQXgLn+ex5YMEim1NvxqlFr3yes9kCgTaR4kXRBk=;
	b=No0FvgNFYxq38qvz5WVFEI/sLNkhI26BrCun1jAwsPvzUdSI/8p7os+uco0TY4mOtb
	97BOXuLDNZbgd32JJQF5C4+J2bTG4r6OPxbp62Slb/Z4IhpLeK3VL2TAkCSb90p48QhY
	PnNDQmPaoxQrN9MzLA4ka9+dy9o6xoaQE12LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KC7rQXgLn+ex5YMEim1NvxqlFr3yes9kCgTaR4kXRBk=;
	b=D4raG8nKob26e4rzfCBCUtoMwxpvk0660SpJU2tichPnaJT/WlPFAl2WWW/jYffGUu
	f6h+15ZHqmR8IulMM0/tN7OKP+CTVlhjtMoQY21yt3CDr9KnL0fL+eunSsChdeqE6BD5
	pjEPYEAD/jkKM+99+t3ZU4SvIMkghlGVsH34ZOERtdVNVN94cI62k6wuwe0MPmF4++Hh
	gK+6v9tw3pFodD1J8pUum1sGpBuS5lQHO5qDPQlP7aVlsTYRaK9V6el2QL1mbVdk8594
	daDwMneF9wwbVWKddOhLScTZ0+2StmcLo9UWcRlYRcg8CfWL9PH0eMDL9DfJAy/ElpFz
	UCVg==
X-Gm-Message-State: APjAAAWEyuzEgRp1OwgzGdJPs8XPCorRkTNA2dVOF+48MXiefgIS8iyQ
	f5o9dqJniK+sZVHEHkgItDheLd2KTHCKJw==
X-Google-Smtp-Source: APXvYqxIPJ3vNd4pyUcL8UdRUF4xCSM5esZoVGqOS8COhvazfZ9W4TOehRupN/tgf3FeH20BMI8Ukw==
X-Received: by 2002:a1c:c707:: with SMTP id x7mr3057532wmf.149.1553009404318; 
	Tue, 19 Mar 2019 08:30:04 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g8sm14446149wrw.22.2019.03.19.08.30.02
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Mar 2019 08:30:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Mar 2019 15:29:58 +0000
Message-Id: <20190319153002.17984-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/5] fetch2/wget: Cleanup module imports
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
X-List-Received-Date: Tue, 19 Mar 2019 15:30:04 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 3addb219d5..8ec5731b0c 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -33,11 +33,14 @@ import logging
 import errno
 import bb
 import bb.progress
+import socket
+import http.client
 import urllib.request, urllib.parse, urllib.error
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
+from   bb.fetch2 import FetchConnectionCache
 from   bb.utils import export_proxies
 from   bs4 import BeautifulSoup
 from   bs4 import SoupStrainer
@@ -132,10 +135,6 @@ class Wget(FetchMethod):
         return True
 
     def checkstatus(self, fetch, ud, d, try_again=True):
-        import urllib.request, urllib.error, urllib.parse, socket, http.client
-        from urllib.response import addinfourl
-        from bb.fetch2 import FetchConnectionCache
-
         class HTTPConnectionCache(http.client.HTTPConnection):
             if fetch.connection_cache:
                 def connect(self):
@@ -252,7 +251,7 @@ class Wget(FetchMethod):
                         pass
                     closed = False
 
-                resp = addinfourl(fp_dummy(), r.msg, req.get_full_url())
+                resp = urllib.response.addinfourl(fp_dummy(), r.msg, req.get_full_url())
                 resp.code = r.status
                 resp.msg = r.reason
 
@@ -326,7 +325,7 @@ class Wget(FetchMethod):
                 add_basic_auth(ud.user + ':' + ud.pswd, r)
 
             try:
-                import netrc, urllib.parse
+                import netrc
                 n = netrc.netrc()
                 login, unused, password = n.authenticators(urllib.parse.urlparse(uri).hostname)
                 add_basic_auth("%s:%s" % (login, password), r)
-- 
2.20.1



Return-Path: <ross.burton@intel.com>
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com
	[209.85.128.176])
	by mail.openembedded.org (Postfix) with ESMTP id 67E3D601A5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 29 Jul 2017 17:23:35 +0000 (UTC)
Received: by mail-wr0-f176.google.com with SMTP id k71so111379762wrc.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 29 Jul 2017 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=Znj/SExElS17JoFWzq0V0679nNkzRgnjFnNXeYstEK8=;
	b=J6aekmkwm7X2U9F6GnFoV/juDWaLO4A2uwdJhhxNTCUm1b7djEHG1EcDDIlzoXbV61
	t8XxCqJUlOAKHxuCFxJrMJjL2EvEs1M0u48Cumo4UBrcLKpsGhYkyx+/1wvtVEtzAxiF
	RyX5s2az6xZR+DaFxtR+4x1yPaRbwT7Faec8g3EAgbohRWWjTXNEiKoEqU/t1ELr4nYk
	28B3UaEO9pzaoQ61Z300dv2EdKLY2YSj+ntYKjDglbMiFabcmh6G1YO4YpzK7oSQ7TVZ
	+Kr5BTNlstK4+0BGoY9Y1H0xTitL/PbFnaajCR7aT2+EvXs6yxFBzYio+klTLD6YEHjM
	9tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=Znj/SExElS17JoFWzq0V0679nNkzRgnjFnNXeYstEK8=;
	b=sRmTXZsdsLtVfD5LWh5WHJd5+g4Excs8PxS+0umir4DgaGpemYLaX94/go9i+dS5ez
	C7Me9+VB3Khi2Pq7YRV8ltoG3ZqpjTNbkDSjMKLVTwt9cOPnNobDSlexGkZWnc5QaaPJ
	jtWreDJwJ97t/2GMAChwW0XZBwKALy+Xhrt2y02sTyM3QOyvPdGyE5nB/N1BVX8UKbxF
	QU5p3Hd0774s/u9JfQ8NqSGBZuOSvGMDyYCXywxvQ4JiwSQLD0jlpf4Khj/6RR/hv6EW
	6E2c5j8ewVYfjEHQosjBD60ruRlm0hdMouTrbf2JzVbB4IAr0IzLjcfcvABHU2+550Fq
	Wclw==
X-Gm-Message-State: AIVw112ZmUtgPpx+kpBKW2Smc3eTZ3CNim1/Svnkc8dPtEDhKkriB7Kk
	RJ+d3kNDB5KmZROJf0A=
X-Received: by 10.223.169.203 with SMTP id b69mr3819757wrd.80.1501349016748;
	Sat, 29 Jul 2017 10:23:36 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	v41sm9501117wrc.65.2017.07.29.10.23.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 29 Jul 2017 10:23:35 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 29 Jul 2017 18:23:33 +0100
Message-Id: <20170729172333.12918-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] wget: fix FusionForge workaround
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
X-List-Received-Date: Sat, 29 Jul 2017 17:23:36 -0000

My previous assertion about FusionForge appears to have been wrong, or
FusionForge has changed behaviour, or both.

FusionForge now mandates that downloads have the Accept header set, despite that
header being optional, and returns a 406 Not Acceptable error if it isn't set.
As we were pretending that 406 was actually 405 (Moved) and tried to handle it as a
redirect this results in an infinite loop until Python kills the recursion.

Delete the handling of 406 as 405, and pass Accept: */* in the headers.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 8ee9769d39b..7c49c2b1282 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -283,11 +283,6 @@ class Wget(FetchMethod):
             """
             http_error_403 = http_error_405
 
-            """
-            Some servers (e.g. FusionForge) returns 406 Not Acceptable when they
-            actually mean 405 Method Not Allowed.
-            """
-            http_error_406 = http_error_405
 
         class FixedHTTPRedirectHandler(urllib.request.HTTPRedirectHandler):
             """
@@ -316,7 +311,9 @@ class Wget(FetchMethod):
             uri = ud.url.split(";")[0]
             r = urllib.request.Request(uri)
             r.get_method = lambda: "HEAD"
-
+            # Some servers (FusionForge, as used on Alioth) require that the
+            # optional Accept header is set.
+            r.add_header("Accept", "*/*")
             def add_basic_auth(login_str, request):
                 '''Adds Basic auth to http request, pass in login:password as string'''
                 import base64
-- 
2.11.0



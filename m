Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 839D1605FE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 09:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4C9swwY031110 for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:54:58 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ULWCeQD3KYKD for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:54:58 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4C9ss8S031107
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:54:55 +0100
Message-ID: <1463046893.9746.3.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 May 2016 10:54:53 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Fix log message syntax
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
X-List-Received-Date: Thu, 12 May 2016 09:55:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Ensure we pass the string parameter correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ca1f84c..151664c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2161,7 +2161,7 @@ class CookerParser(object):
             self.error += 1
             etype, value, tb = sys.exc_info()
             if hasattr(value, "recipe"):
-                logger.error('Unable to parse %s', value.recipe,
+                logger.error('Unable to parse %s' % value.recipe,
                             exc_info=(etype, value, exc.traceback))
             else:
                 # Most likely, an exception occurred during raising an exception



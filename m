Return-Path: <mcrowe@brightsign.biz>
X-Greylist: delayed 902 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 24 Feb 2017 16:35:14 UTC
Received: from relay.appriver.com (relay101a.appriver.com [207.97.230.14])
	by mail.openembedded.org (Postfix) with ESMTP id B616D77515
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Feb 2017 16:35:14 +0000 (UTC)
X-Note-AR-ScanTimeLocal: 02/24/2017 11:20:13 AM
X-Policy: brightsign.biz  - brightsign.biz
X-Policy: brightsign.biz  - brightsign.biz
X-Primary: mcrowe@brightsign.biz
X-Note: This Email was scanned by AppRiver SecureTide
X-Note: SecureTide Build: 9/27/2016 9:09:05 PM UTC
X-Virus-Scan: V-
X-Note-SnifferID: 0
X-Note: TCH-CT/SI:0-102/SG:1 2/24/2017 11:20:01 AM
X-GBUdb-Analysis: 0, 213.210.30.29, Ugly c=0.555345 p=-1 Source White
X-Signature-Violations: 0-0-0-2907-c
X-Note: Spam Tests Failed: 
X-Country-Path: ->PRIVATE->United Kingdom->United States
X-Note-Sending-IP: 213.210.30.29
X-Note-Reverse-DNS: elite.brightsigndigital.co.uk
X-Note-Return-Path: mcrowe@brightsign.biz
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: G273 G274 G275 G276 G280 G281 G409 
X-Note: Encrypt Rule Hits: 
X-Note: Mail Class: VALID
X-Note: Headers Injected
Received: from [213.210.30.29] (HELO elite.brightsigndigital.co.uk)
	by relay.appriver.com (CommuniGate Pro SMTP 6.1.7)
	with ESMTPS id 117463425; Fri, 24 Feb 2017 11:20:13 -0500
Received: from chuckie.brightsign ([172.30.1.25] helo=chuckie)
	by elite.brightsigndigital.co.uk with esmtp (Exim 4.84_2)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1chIbM-0006BP-7p; Fri, 24 Feb 2017 16:20:12 +0000
Received: from mac by chuckie with local (Exim 4.84_2)
	(envelope-from <mcrowe@brightsign.biz>)
	id 1chIbM-0005vv-76; Fri, 24 Feb 2017 16:20:12 +0000
From: Mike Crowe <mac@mcrowe.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2017 16:20:04 +0000
Message-Id: <1487953204-19709-1-git-send-email-mac@mcrowe.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] process: stop bb.process.communicate mixing bytes and str return types
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
X-List-Received-Date: Fri, 24 Feb 2017 16:35:15 -0000

Python3 regards b"" as False so it is not being converted to a string by
d0f904d407f57998419bd9c305ce53e5eaa36b24. This confusingly causes three
different potential types for each member of the returned tuple.

Let's just assume that everything that's not None is a bytes object and
convert it to a string.

Signed-off-by: Mike Crowe <mac@mcrowe.com>
---
 lib/bb/process.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/process.py b/lib/bb/process.py
index c62d7bc..a4a5599 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -162,9 +162,9 @@ def run(cmd, input=None, log=None, extrafiles=None, **options):
         stdout, stderr = _logged_communicate(pipe, log, input, extrafiles)
     else:
         stdout, stderr = pipe.communicate(input)
-        if stdout:
+        if not stdout is None:
             stdout = stdout.decode("utf-8")
-        if stderr:
+        if not stderr is None:
             stderr = stderr.decode("utf-8")
 
     if pipe.returncode != 0:
-- 
2.1.4



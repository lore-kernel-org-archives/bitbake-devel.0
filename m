Return-Path: <garbados@gmail.com>
Received: from mail-pf0-f171.google.com (mail-pf0-f171.google.com
	[209.85.192.171])
	by mail.openembedded.org (Postfix) with ESMTP id 5F676607A5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 20:27:20 +0000 (UTC)
Received: by mail-pf0-f171.google.com with SMTP id p189so61324490pfp.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=zNY5dpJpHyAvAQJyQ+RagNPTasVN99a4gWOVrWS6R2E=;
	b=sqNglrmry1oSS3/fwfYBEkUWFGNsrO2ACLL4sUrhTWKsVPGBS4RMKDBtwVTRVxbiyq
	41ktHuquhh2eTWH/MbOdFmaV40VfFjGE63eI7NHC0YhUa/oLLwmO/Dva3/f1n/3Th0AZ
	LxDEHwxJ4HoNQwOjViXH0z8iJu1FVb1ZIwKrhw/ZVB7o7RHXFbfl0LZEFvulHPJJQOwB
	VuafDSMONhuZxP71uw6Nr4TfsDY3LAguDl11L2Qv70a3p9CZ8xx5vv9nu+M+v9qKm/mS
	tDmZNz3YfhfvdII3Zg4KxNjJ0QGcUTzFBUNuqfbDkT+kPFcuW/73ZEjhSRF4bMdK3VL3
	vSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=zNY5dpJpHyAvAQJyQ+RagNPTasVN99a4gWOVrWS6R2E=;
	b=m5Ekl//F9ORTEvFXG6k83BdF5RN8pFRPbg2qw9Gfq5q0b9JxmFdFiMfvVuuSTPPO5W
	POxN1iQZuBtAkrYIjMrHmWs5NSa3kVv0pFsK6M8gVcPX5MXGFKGjoQye35RQiNmPAbbW
	5OZgu+hfJKK+Figf6y63egJl7YwWkJn5VxFvmd6mNm19eMPLy/5yxWAJho/Q/mYA5aje
	F6TEiohUjLmTLvp6IKJGWwo8sRv6+2Z0MA/etBEmSH4QwWU8j0EBk4gYuBF3kBEPaG7x
	pXYeRBkEUamL/BJr26P+USED2tGveOxeBwizQSsqyjWIDpmCItRMuHUkb9Y6f2nSb80x
	u8Gg==
X-Gm-Message-State: AFeK/H2dOHS05yVLKniO5Tlj5vCVjKSnylvX1zYH4SutenUFvk/YbwDFhU0B52aPzGOVXg==
X-Received: by 10.84.237.22 with SMTP id s22mr50445550plk.145.1490128042022;
	Tue, 21 Mar 2017 13:27:22 -0700 (PDT)
Received: from deus.apple.sh.pie ([2601:1c2:303:6b0:757e:1e0c:8cc1:6db4])
	by smtp.gmail.com with ESMTPSA id
	o5sm41372994pgj.66.2017.03.21.13.27.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 21 Mar 2017 13:27:20 -0700 (PDT)
From: Diana Thayer <garbados@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Mar 2017 13:27:05 -0700
Message-Id: <1490128025-7864-1-git-send-email-garbados@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] bug 9962: improve -v, -D documentation
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
X-List-Received-Date: Tue, 21 Mar 2017 20:27:23 -0000

Per bug-9962, expanded and clarified documentation
for -v, --verbose and -D, --debug.

Signed-off-by: Diana Thayer <garbados@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-intro.xml | 16 +++++++++++++---
 lib/bb/main.py                                        | 15 +++++++++++++--
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
index 7248a0b..5bbfc67 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
@@ -504,9 +504,19 @@
                              Read the specified file before bitbake.conf.
        -R POSTFILE, --postread=POSTFILE
                              Read the specified file after bitbake.conf.
-       -v, --verbose         Output more log message data to the terminal.
-       -D, --debug           Increase the debug level. You can specify this more
-                             than once.
+       -v, --verbose         Enable tracing of shell tasks (with 'set -x').
+                             Also print bb.note(...) messages to stdout (in
+                             addition to writing them to ${T}/log.do_<task>).
+       -D, --debug           Increase the debug level. You can specify this
+                             more than once. -D sets the debug level to 1,
+                             where only bb.debug(1, ...) messages are printed
+                             to stdout; -DD sets the debug level to 2, where
+                             both bb.debug(1, ...) and bb.debug(2, ...)
+                             messages are printed; etc. Without -D, no debug
+                             messages are printed. Note that -D only affects
+                             output to stdout. All debug messages are written
+                             to ${T}/log.do_taskname, regardless of the debug
+                             level.
        -n, --dry-run         Don't execute, just go through the motions.
        -S SIGNATURE_HANDLER, --dump-signatures=SIGNATURE_HANDLER
                              Dump out the signature construction information, with
diff --git a/lib/bb/main.py b/lib/bb/main.py
index b3cd2cf..8c948c2 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -174,10 +174,21 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           help="Read the specified file after bitbake.conf.")
 
         parser.add_option("-v", "--verbose", action="store_true", dest="verbose", default=False,
-                          help="Output more log message data to the terminal.")
+                          help="Enable tracing of shell tasks (with 'set -x'). "
+                               "Also print bb.note(...) messages to stdout (in "
+                               "addition to writing them to ${T}/log.do_<task>).")
 
         parser.add_option("-D", "--debug", action="count", dest="debug", default=0,
-                          help="Increase the debug level. You can specify this more than once.")
+                          help="Increase the debug level. You can specify this "
+                               "more than once. -D sets the debug level to 1, "
+                               "where only bb.debug(1, ...) messages are printed "
+                               "to stdout; -DD sets the debug level to 2, where "
+                               "both bb.debug(1, ...) and bb.debug(2, ...) "
+                               "messages are printed; etc. Without -D, no debug "
+                               "messages are printed. Note that -D only affects "
+                               "output to stdout. All debug messages are written "
+                               "to ${T}/log.do_taskname, regardless of the debug "
+                               "level.")
 
         parser.add_option("-q", "--quiet", action="count", dest="quiet", default=0,
                           help="Output less log message data to the terminal. You can specify this more than once.")
-- 
2.7.4



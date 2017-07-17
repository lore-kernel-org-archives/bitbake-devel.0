Return-Path: <patrick.ohly@intel.com>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
	[209.85.218.48])
	by mail.openembedded.org (Postfix) with ESMTP id 6CCFC77BE0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Jul 2017 13:25:15 +0000 (UTC)
Received: by mail-oi0-f48.google.com with SMTP id 191so117475728oii.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Jul 2017 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=47LhJ2lkM5y7lRXBRMg1g/wS9gfrvyMV4cVQWBGconA=;
	b=iCOoH/231brt8o4nuTbUlTNCWBoBBOxCf2Ge+I8t3hbP9PtsZEirgnyjTdkHlTU/1/
	JP/BjOI+y1c//3rvhxK2PKmWSjukDDYnh6qv67wF+Kpyn9CzkQE0rB8p2hd1i+gE53Nh
	whM2JHG1vMZ7r3bJntVDYPi6lje7munK/WCHHnKqCqFTPQLctFWbvgKEDcIfIKj71ssF
	03VlL3L7I1UdlH157wvGaJC6cQkh5mWUmByvmHqhNAB9ie4zVzwGctnwInx2RTnngPZr
	yQpyw+cnM7380Q1QwqcW/fJpos2+gBwTobnEzSlndKe56UzdWMdPuXVpsL8n/jLzb9Fh
	pJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=47LhJ2lkM5y7lRXBRMg1g/wS9gfrvyMV4cVQWBGconA=;
	b=VQRYKB5084SRN16uX19URjb0ByGnfpd4CL27qcf+T5/zg36Ym9koHeF84lyYWnCsgP
	ofrHHClk+rVn/ilwmSXW40pf9hCEUIBq0VGNtlXr8YfDY/jS78uk9XLz34NFtmLFJ3Pi
	2cVsP84JaqgO9LsULj4REmMBu2KlFbC3WCgZRswTDhEtMoHrj0KT3xVFIpt9ryIUkHF+
	mWQjUMrA5JQrriLL1rpz/LS5exqSBPgqh+YU8QgLPhgyW2cTN4v0yfgJ/5bQFcQgbcw7
	UIgL1hOhIZw1clXoNwbkUJZx0Ii0Qi3lxRazsI3xgz4EWaZ1tLFBfgtC1BNXdGYDQstH
	S2mg==
X-Gm-Message-State: AIVw113qkrdMI0Ze0jJYOdOmyV8C3e5lAH4bjAK4xC04IWC1hnmhm4hl
	CAMK7sqJEezXCCFlzlU=
X-Received: by 10.202.96.139 with SMTP id u133mr8201276oib.159.1500297916916; 
	Mon, 17 Jul 2017 06:25:16 -0700 (PDT)
Received: from pohly-desktop.fritz.box (p5DE8FBAD.dip0.t-ipconnect.de.
	[93.232.251.173]) by smtp.gmail.com with ESMTPSA id
	n189sm19115329oih.0.2017.07.17.06.25.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 17 Jul 2017 06:25:15 -0700 (PDT)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Jul 2017 15:25:10 +0200
Message-Id: <ee5feb9953bd03e475beb6cff356afd8251d95e0.1500297842.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.11.0
Subject: [PATCH] fetch2/wget.py: improve error handling during sstate check
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
X-List-Received-Date: Mon, 17 Jul 2017 13:25:16 -0000

When the sstate is accessed via HTTP, the existence check can fail due
to network issues, in which case bitbake silently continues without
sstate.

One such network issue is an HTTP server like Python's own SimpleHTTP
which closes the TCP connection despite an explicit "Keep-Alive" in
the HTTP request header. The server does that without a "close" in the
HTTP response header, so the socket remains in the connection cache,
leading to "urlopen failed: <urlopen error [Errno 9] Bad file
descriptor>" (only visible in "bitbake -D -D" output) when trying to
use the cached connection again.

The connection might also get closed for other reasons (proxy,
timeouts, etc.), so this is something that the client should be able
to handle.

This is achieved by checking for the error, removing the bad
connection, and letting the check_status() method try again with a new
connection. It is necessary to let the second attempt fail
permanently, because bad proxy setups have been observed to also lead
to such broken connections. In that case, we need to abort for real
after trying twice, otherwise a build would just hang forever.

[YOCTO #11782]

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/fetch2/wget.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index ae0ffa8..208ee9b 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -30,6 +30,7 @@ import tempfile
 import subprocess
 import os
 import logging
+import errno
 import bb
 import bb.progress
 import urllib.request, urllib.parse, urllib.error
@@ -206,8 +207,21 @@ class Wget(FetchMethod):
                     h.request(req.get_method(), req.selector, req.data, headers)
                 except socket.error as err: # XXX what error?
                     # Don't close connection when cache is enabled.
+                    # Instead, try to detect connections that are no longer
+                    # usable (for example, closed unexpectedly) and remove
+                    # them from the cache.
                     if fetch.connection_cache is None:
                         h.close()
+                    elif isinstance(err, OSError) and err.errno == errno.EBADF:
+                        # This happens when the server closes the connection despite the Keep-Alive.
+                        # Apparently urllib then uses the file descriptor, expecting it to be
+                        # connected, when in reality the connection is already gone.
+                        # We let the request fail and expect it to be
+                        # tried once more ("try_again" in check_status()),
+                        # with the dead connection removed from the cache.
+                        # If it still fails, we give up, which can happend for bad
+                        # HTTP proxy settings.
+                        fetch.connection_cache.remove_connection(h.host, h.port)
                     raise urllib.error.URLError(err)
                 else:
                     try:

base-commit: 4a14b44b3e4fad3a3e5e53461aa8ba9929a515b8
-- 
git-series 0.9.1


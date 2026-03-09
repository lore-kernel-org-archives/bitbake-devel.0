Return-Path: <pascal.eberhard@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59051F4180D
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 23:31:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28508.1773099105364651423
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 16:31:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20201202 header.b=cBx7vTrZ;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: devnull+pascal.eberhard.se.com@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8EE0F43B3C;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C39EC2BC9E;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773099104;
	bh=Gedtx1s8QCFLRBtxBzgtGmQWx3BTCNPq/TpibUmkpGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cBx7vTrZ7D3K94naV+Ofb2tfwUHnqcgoOXJMl687PMtoIxrEIrsAx0WCDcyPF7Yok
	 7WYwER1qgJRg/98iNNxNy7+m53yjj1JulPAOrHeBecf/xyXGmfug26Au0MKL+nBV6L
	 SvvATIj3a2/l5LXVW3Dmlhed0s50HZNBz78mP0LJjs/+K4lKE0ypWie8lbbz4yxIZ5
	 JvU7vqKntcE7md6bZgbZYnUddfaOthzseiChLPPqBQ1fl5Tzhi/21REO8uSkBM6dYV
	 ubLrPFJ4g2PCSyMYZPVj5FyX1Y/+WI1V+3EkG0Tg5IUbL48GxhLJmw3RzmyfdP09Um
	 0Q1WWiTqqlkhQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BA3F3C277;
	Mon,  9 Mar 2026 23:31:44 +0000 (UTC)
From: Pascal Eberhard via B4 Relay <devnull+pascal.eberhard.se.com@kernel.org>
Date: Tue, 10 Mar 2026 00:29:38 +0100
Subject: [PATCH v2 1/4] fetch2: add curl method to fetch web content
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-add_alt_fetch_method_curl-v2-1-4789639b28f1@se.com>
References: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
In-Reply-To: <20260310-add_alt_fetch_method_curl-v2-0-4789639b28f1@se.com>
To: bitbake-devel@lists.openembedded.org
Cc: Pascal Eberhard <pascal.eberhard@se.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773099103; l=7321;
 i=pascal.eberhard@se.com; s=20260304; h=from:subject:message-id;
 bh=yb76WcTlje9CTcQKALnQhfM8wIKHvARpJCjPybI9J1k=;
 b=8hwOnC08Amg914qFvfUp0uABVXCyZZ9RQthdPL3g2ANF5VWvUgB9rnU/oiPtJFLlh2GSPVneH
 0Z49DkLRfL7BL02IOQbBg5gpJ/bQK+madBbUxeh5WipxELGSil7UzdT
X-Developer-Key: i=pascal.eberhard@se.com; a=ed25519;
 pk=J7TbFctjt1RVuN5K0juhf/w1E9bAfSeoQ/JG1vV9mWg=
X-Endpoint-Received: by B4 Relay for pascal.eberhard@se.com/20260304 with
 auth_id=661
X-Original-From: Pascal Eberhard <pascal.eberhard@se.com>
Reply-To: pascal.eberhard@se.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 23:31:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19136

From: Pascal Eberhard <pascal.eberhard@se.com>

curl fetch method is an alternative fetch method for web downloads. It
is based on curl cmdline tool and provides the same http, https, ftp
and ftps protocols as wget. It supports some new features as well such
as hostname resolution by the proxy when using SOCKS5 proxy.

Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
---
 lib/bb/fetch2/curl.py | 162 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/lib/bb/fetch2/curl.py b/lib/bb/fetch2/curl.py
new file mode 100644
index 000000000..ad32372fb
--- /dev/null
+++ b/lib/bb/fetch2/curl.py
@@ -0,0 +1,162 @@
+"""
+BitBake 'Fetch' implementations for web downloads based on curl.
+
+curl fetch method is an alternative to existing wget method and can be enabled
+by setting bitbake variable:
+  BB_FETCH_METHOD_HTTP = "curl"
+
+curl fetch method provides new features such as hostname resolution by the
+proxy itself when using SOCKS5 proxy. It can be set with environment variable:
+  all_proxy="socks5h://...""
+"""
+
+# Copyright (C) 2026, Schneider Electric
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Based on the wget fetcher method, Copyright 2003 Holger Schurig
+
+import os
+import re
+import shlex
+import tempfile
+
+import bb
+import bb.fetch2
+import bb.progress
+import bb.utils
+from bb.data_smart import DataSmart
+from bb.fetch2 import FetchData, FetchError, logger, runfetchcmd
+from bb.fetch2.wget import Wget
+
+
+class CurlProgressHandler(bb.progress.LineFilterProgressHandler):
+    """
+    Extract progress information from curl commandline output.
+    Note: relies on --progress-bar being specified on the curl command line.
+    """
+
+    def __init__(self, d: DataSmart):
+        super(CurlProgressHandler, self).__init__(d)
+        # Send an initial progress event so the bar gets shown
+        self._fire_progress(0)
+
+    def writeline(self, line: str):
+        matches = re.findall(r' ([\d]+)\.\d%', line)
+        if matches:
+            progress = int(matches[0])
+            self.update(progress)
+            return False
+        return True
+
+
+class Curl(Wget):
+    """
+    Class to fetch urls via curl cmdline tool.
+    The code not related to the cmdline is the same between wget and curl.
+    Curl class inherits Wget class to avoid code duplication.
+    """
+
+    def is_enabled(self, d) -> bool:
+        """
+        curl method is enabled when BB_FETCH_METHOD_HTTP = "curl" only.
+        """
+        method_http: str = d.getVar("BB_FETCH_METHOD_HTTP")
+        return method_http == "curl"
+
+    def supports(self, ud: FetchData, d: DataSmart) -> bool:
+        """
+        Check if a given url can be fetched with curl.
+        """
+        if not self.is_enabled(d):
+            return False
+        if ud.type not in ['http', 'https', 'ftp', 'ftps']:
+            return False
+        logger.debug2("Fetch method 'curl' enabled")
+        return True
+
+    def urldata_init(self, ud: FetchData, d: DataSmart):
+        if 'protocol' in ud.parm:
+            if ud.parm['protocol'] == 'git':
+                raise bb.fetch2.ParameterError("Invalid protocol - if you wish to fetch from a git repository using http, you need to instead use the git:// prefix with protocol=http", ud.url)
+
+        if 'downloadfilename' in ud.parm:
+            ud.basename: str = ud.parm['downloadfilename']
+        else:
+            ud.basename: str = os.path.basename(ud.path)
+
+        ud.localfile = ud.basename
+        if not ud.localfile:
+            ud.localfile = ud.host + ud.path.replace("/", ".")
+
+        # --retry 1: equivalent to --tries=2 of wget.
+        # --speed-limit 1 --speed-time 100 --connect-timeout 100: equivalent to --timeout=100 option of wget.
+        # --location: redo request on new location when a page as moved, indicated with 3xx response code.
+        # --fail: fails with exit code when server generates HTML error rather than writing HTML error to output.
+        self.basecmd: str = d.getVar("FETCHCMD_curl") or "/usr/bin/env curl --retry 1 --speed-limit 1 --speed-time 100 --connect-timeout 100 --location --fail"
+
+        if ud.type == 'ftp' or ud.type == 'ftps':
+            self.basecmd += " --ftp-pasv"
+
+        if not self.check_certs(d):
+            self.basecmd += " --insecure"
+
+    def _runcurl(self, ud: FetchData, d: DataSmart, command: str, quiet: bool, workdir: str = None):
+        progresshandler = CurlProgressHandler(d)
+
+        logger.debug2("Fetching %s using command '%s'" % (ud.url, command))
+        bb.fetch2.check_network_access(d, command, ud.url)
+        runfetchcmd(command + " --progress-bar", d, quiet, log=progresshandler, workdir=workdir)
+
+    def download(self, ud: FetchData, d: DataSmart):
+        """Fetch urls"""
+        fetchcmd: str = self.basecmd
+        dldir: str = os.path.realpath(d.getVar("DL_DIR"))
+        localpath: str = os.path.join(dldir, ud.localfile) + ".tmp"
+        bb.utils.mkdirhier(os.path.dirname(localpath))
+        fetchcmd += " --output %s" % shlex.quote(localpath)
+
+        if ud.user and ud.pswd:
+            fetchcmd += " --anyauth"
+            if ud.parm.get("redirectauth", "1") == "1":
+                fetchcmd += f" --user={ud.user}:{ud.pswd}"
+
+        uri: str = ud.url.split(";")[0]
+        fetchcmd += f" --continue-at - '{uri}'"
+
+        self._runcurl(ud, d, fetchcmd, False)
+
+        # Sanity check since curl can pretend it succeed when it didn't
+        # Also, this used to happen if sourceforge sent us to the mirror page
+        if not os.path.exists(localpath):
+            raise FetchError(f"The fetch command returned success for url {uri} but {localpath} doesn't exist?!", uri)
+
+        if os.path.getsize(localpath) == 0:
+            os.remove(localpath)
+            raise FetchError(f"The fetch of {uri} resulted in a zero size file?! Deleting and failing since this isn't right.", uri)
+
+        # Try and verify any checksum now, meaning if it isn't correct, we don't remove the
+        # original file, which might be a race (imagine two recipes referencing the same
+        # source, one with an incorrect checksum)
+        bb.fetch2.verify_checksum(ud, d, localpath=localpath, fatal_nochecksum=False)
+
+        # Remove the ".tmp" and move the file into position atomically
+        # Our lock prevents multiple writers but mirroring code may grab incomplete files
+        os.rename(localpath, localpath[:-4])
+
+        return True
+
+    def _fetch_index(self, uri: str, ud: FetchData, d: DataSmart):
+        """
+        Run fetch checkstatus to get directory information
+        """
+        with tempfile.TemporaryDirectory(prefix="curl-index-") as workdir, tempfile.NamedTemporaryFile(dir=workdir, prefix="curl-listing-") as f:
+            fetchcmd: str = self.basecmd
+            fetchcmd += f" --output {f.name} '{uri}'"
+            try:
+                self._runcurl(ud, d, fetchcmd, True, workdir=workdir)
+                fetchresult = f.read()
+            except bb.fetch2.BBFetchException:
+                fetchresult = ""
+
+        return fetchresult

-- 
2.43.0




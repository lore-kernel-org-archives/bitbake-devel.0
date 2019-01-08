Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id BDA3E7C062
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jan 2019 23:40:37 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x08Nd2Gr019794
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 8 Jan 2019 15:39:12 -0800
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 8 Jan 2019 15:38:51 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 8 Jan 2019 18:38:46 -0500
Message-ID: <20190108233847.81353-3-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20190108233847.81353-1-mark.hatle@windriver.com>
References: <20190108233847.81353-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/3] gitsm.py: Add support for alternative URL formats from submodule files
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
X-List-Received-Date: Tue, 08 Jan 2019 23:40:37 -0000
Content-Type: text/plain

The following appear to be the git supported formats:

  proto://user:pass@host/path  (URI format)
  user@host:path (SSH format)
  /path or ./path or ../path (local file format)

We adjust the parsing to find out if we have a URI format or not.
When we are NOT in URI format, we do our best to determine SSH or
file format by looking for a ':' in the overall string.  If we find
a ':' we assume SSH format and adjust accordingly.

Note, in SSH format we simply replace the ':' with a '/' when constructing
the URL.  However, if the original path was ":/...", we don't want '//' so
we deal with this corner case as well.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 88609f0..0981bba 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -95,8 +95,21 @@ class GitSM(Git):
             module_hash = module_hash.split()[2]
 
             # Build new SRC_URI
-            proto = uris[module].split(':', 1)[0]
-            url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
+            if "://" not in uris[module]:
+                # It's ssh if the format does NOT have "://", but has a ':'
+                if ":" in uris[module]:
+                    proto = "ssh"
+                    if ":/" in uris[module]:
+                        url = "gitsm://" + uris[module].replace(':/', '/', 1)
+                    else:
+                        url = "gitsm://" + uris[module].replace(':', '/', 1)
+                else: # Fall back to 'file' if there is no ':'
+                    proto = "file"
+                    url = "gitsm://" + uris[module]
+            else:
+                proto = uris[module].split(':', 1)[0]
+                url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
+
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
             url += ";bareclone=1;nocheckout=1;nobranch=1"
-- 
1.8.3.1



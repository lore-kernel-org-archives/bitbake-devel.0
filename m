Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 7CFB571633
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 15:38:34 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 28 Aug 2015 08:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,425,1437462000"; d="scan'208";a="792908594"
Received: from abityuts-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.11.19])
	by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2015 08:38:18 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Aug 2015 16:37:38 +0100
Message-Id: <1440776258-21681-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Bian Naimeng <biannm@cn.fujitsu.com>
Subject: [PATCH] toaster: Support environments which have proxies set
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
X-List-Received-Date: Fri, 28 Aug 2015 15:38:34 -0000

From: Bian Naimeng <biannm@cn.fujitsu.com>

In an environment with a proxy which requires authentication, e.g. with
$http_proxy = 'http://user:password@ip:port', the following error
occurs when running Toaster:

  EE: Using proxy http://user:password@ip:port
  EE: could not connect to 'url', skipping update: 'error message'

This prevents Toaster from fetching layer, recipe and machine information
from remote repositories.

This patch allows Toaster to use the proxy settings from the
environment for HTTP/HTTPS requests.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/orm/models.py | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index 92fcaa7..58f76a8 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -817,42 +817,20 @@ class LayerIndexLayerSource(LayerSource):
         assert self.apiurl is not None
         from django.db import transaction, connection
 
-        import httplib, urlparse, json
+        import urllib2, urlparse, json
         import os
         proxy_settings = os.environ.get("http_proxy", None)
 
         def _get_json_response(apiurl = self.apiurl):
-            conn = None
             _parsedurl = urlparse.urlparse(apiurl)
             path = _parsedurl.path
-            query = _parsedurl.query
-            def parse_url(url):
-                parsedurl = urlparse.urlparse(url)
-                try:
-                    (host, port) = parsedurl.netloc.split(":")
-                except ValueError:
-                    host = parsedurl.netloc
-                    port = None
-
-                if port is None:
-                    port = 80
-                else:
-                    port = int(port)
-                return (host, port)
 
-            if proxy_settings is None:
-                host, port = parse_url(apiurl)
-                conn = httplib.HTTPConnection(host, port)
-                conn.request("GET", path + "?" + query)
-            else:
-                host, port = parse_url(proxy_settings)
-                conn = httplib.HTTPConnection(host, port)
-                conn.request("GET", apiurl)
-
-            r = conn.getresponse()
-            if r.status != 200:
-                raise Exception("Failed to read " + path + ": %d %s" % (r.status, r.reason))
-            return json.loads(r.read())
+            try:
+                res = urllib2.urlopen(apiurl)
+            except urllib2.URLError as e:
+                raise Exception("Failed to read %s: %s" % (path, e.reason))
+
+            return json.loads(res.read())
 
         # verify we can get the basic api
         try:
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.



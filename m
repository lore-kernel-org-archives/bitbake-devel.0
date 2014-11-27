Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 5C7327239E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:09 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id bs8so19051647wib.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=1UmijyWjyN2xy3Y5hzqVCZXeTYKE620WlfrJLh6Vpr4=;
	b=mPdW6tmwy+R5SC2PLT2rAzBkqBsm1fSn/o64lAftKoeiGYKs/mCW9JnE2ZKleD6uw/
	e5Rhr5tZyi8aKTsAVKNfDf3WXAnAn6vqV10WYDYFldeyTIjWhnfeh6/7yctbUACDYdt7
	r+QdP6ivAWiVZX7iWCsHRioD1/II/R+xE3G4CPcBebRImogHJMWFsr9c9/8y6PjpzV2/
	y6glW5GLHgcakMEZoOrSR/I1k5aByzS7rWr7mmb/Qsblaemld6ROCpx08aD34sL6TcQu
	Q7u/U3jG0c5D4lGxkXmI5O63hDEZUhqL+xoT8/IG/WkuEtDc+SkLCKk2ehp0Zy3/tlL8
	XUgw==
X-Gm-Message-State: ALoCoQmJBB5hlGejNlEko6I5ru6Ik5TMbdyTOWLMhSyEU4Xd2APlsty3D/xoqGp6eNY3zpsI2YbO
X-Received: by 10.180.92.234 with SMTP id cp10mr53762543wib.16.1417108089867; 
	Thu, 27 Nov 2014 09:08:09 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	mw7sm12411522wib.14.2014.11.27.09.08.07 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EFB57563B9C; Thu, 27 Nov 2014 17:08:06 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:07:52 +0000
Message-Id: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 01/14] toaster: use http proxies to fetch data
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:12 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Under some network configurations http proxies are used
for Internet access. This patch makes Toaster obey
the http_proxy environment variable when fetching
information from layer indexes.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index c90e047..99cc695 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -599,24 +599,41 @@ class LayerIndexLayerSource(LayerSource):
         assert self.apiurl is not None
         from django.db import IntegrityError
 
+        import httplib, urlparse, json
+        import os
+        proxy_settings = os.environ.get("http_proxy", None)
+
         def _get_json_response(apiurl = self.apiurl):
-            import httplib, urlparse, json
-            parsedurl = urlparse.urlparse(apiurl)
-            try:
-                (host, port) = parsedurl.netloc.split(":")
-            except ValueError:
-                host = parsedurl.netloc
-                port = None
+            conn = None
+            _parsedurl = urlparse.urlparse(apiurl)
+            path = _parsedurl.path
+            query = _parsedurl.query
+            def parse_url(url):
+                parsedurl = urlparse.urlparse(url)
+                try:
+                    (host, port) = parsedurl.netloc.split(":")
+                except ValueError:
+                    host = parsedurl.netloc
+                    port = None
+
+                if port is None:
+                    port = 80
+                else:
+                    port = int(port)
+                return (host, port)
 
-            if port is None:
-                port = 80
+            if proxy_settings is None:
+                host, port = parse_url(apiurl)
+                conn = httplib.HTTPConnection(host, port)
+                conn.request("GET", path + "?" + query)
             else:
-                port = int(port)
-            conn = httplib.HTTPConnection(host, port)
-            conn.request("GET", parsedurl.path + "?" + parsedurl.query)
+                host, port = parse_url(proxy_settings)
+                conn = httplib.HTTPConnection(host, port)
+                conn.request("GET", apiurl)
+
             r = conn.getresponse()
             if r.status != 200:
-                raise Exception("Failed to read " + parsedurl.path + ": %d %s" % (r.status, r.reason))
+                raise Exception("Failed to read " + path + ": %d %s" % (r.status, r.reason))
             return json.loads(r.read())
 
         # verify we can get the basic api
@@ -624,6 +641,8 @@ class LayerIndexLayerSource(LayerSource):
             apilinks = _get_json_response()
         except Exception as e:
             import traceback
+            if proxy_settings is not None:
+                print "EE: Using proxy ", proxy_settings
             print "EE: could not connect to %s, skipping update: %s\n%s" % (self.apiurl, e, traceback.format_exc(e))
             return
 
-- 
1.9.1



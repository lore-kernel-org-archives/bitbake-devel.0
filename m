Return-Path: <scott.murray@konsulko.com>
Received: from mail-it1-f180.google.com (mail-it1-f180.google.com
	[209.85.166.180])
	by mail.openembedded.org (Postfix) with ESMTP id DC2977C671
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 22:42:39 +0000 (UTC)
Received: by mail-it1-f180.google.com with SMTP id d125so3562077ith.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=wiCmy2HDwkb5vafHIfk9Dj5J7moK7AFLgOuJFIi/QS8=;
	b=eZqviZUUdh+ZNdcUEPJoET35wxuJTw2gPd7hgkj9V5w0KvVqq5VIR/94YrvQ8L8oCw
	5AYsfxydy/vgm4IiZof43GpbiLk5L/OLgWLW4KpVD+1GCJtEMVDRfi8mtYzY2AWG/MLR
	9E9uwc7Sm6pQbt1EBIbIyu2K1sFZsLhccSb5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=wiCmy2HDwkb5vafHIfk9Dj5J7moK7AFLgOuJFIi/QS8=;
	b=h1kugeXXC6j/qythxfFxJts1x+u3Vb+Xz3d4Ut7ZVBl/+lduz6zueS4gMrR87jxH7R
	gMqZfBsUgd+TDDFcLF5U1mixMMuyq2RyVRdES89+1uChNBBDyzNdsqIfDnzSGF2YxWAg
	xtG1ABH/jQFSiSsvElBHnbuDyeZfwi69KwhDq9iL6IyvUc3QMDMcuNqCH5Ro55p3skfc
	7LjKe0unPEGG/m+0XiYnK+LhtdxkZKi8x6Z6KKVKZxn4MGSfiEyO4ebA0WE1Tr2ecbYn
	3F8StUqGZBn2yPuObGoSb75Q7i8yEgGtuHImK34W2LEkpQ8WgjRBI1cuzGspg6NdOAxc
	QoMg==
X-Gm-Message-State: APjAAAUKC0PN8wE1UIgEJHgyxgsGlZG2u+m1O9r+J1l+9xTjscdDxNA/
	hByexSmVYtj3lb1IBDnyiCvEh5xfSmU=
X-Google-Smtp-Source: APXvYqwkjg5sIXhuGc2p5d1t7BvbYZR076wBdA8d9nScBkytL66P5VG35XohX+1EzrCMQoPNNRRVHA==
X-Received: by 2002:a24:ee8c:: with SMTP id b134mr96078iti.7.1552430560753;
	Tue, 12 Mar 2019 15:42:40 -0700 (PDT)
Received: from ghidorah.spiteful.org (69-165-244-87.cable.teksavvy.com.
	[69.165.244.87])
	by smtp.gmail.com with ESMTPSA id 25sm2843292iog.83.2019.03.12.15.42.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 12 Mar 2019 15:42:40 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Mar 2019 18:46:19 -0400
Message-Id: <20190312224627.12667-3-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190312224627.12667-1-scott.murray@konsulko.com>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
Subject: [1.40][PATCH 02/10] gitsm.py: Add support for alternative URL formats from submodule files
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
X-List-Received-Date: Tue, 12 Mar 2019 22:42:40 -0000

From: Mark Hatle <mark.hatle@windriver.com>

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit dcac05e7dc6b0c5f8e63d36ad105b7eab41f0016)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/fetch2/gitsm.py | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index b7959ff5..dd94186c 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -100,8 +100,21 @@ class GitSM(Git):
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
2.17.2



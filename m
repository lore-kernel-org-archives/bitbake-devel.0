Received: from sender4-op-o13.zoho.com (sender4-op-o13.zoho.com [136.143.188.13])
 by mx.groups.io with SMTP id smtpd.web12.9747.1624463600073731811
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Jun 2021 08:53:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=dwrobel@ertelnet.rybnik.pl header.s=ertelnet header.b=OV3A7PC5;
 spf=pass (domain: ertelnet.rybnik.pl, ip: 136.143.188.13, mailfrom: dwrobel@ertelnet.rybnik.pl)
ARC-Seal: i=1; a=rsa-sha256; t=1624463599; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=An/q2+FVkF01P7BPjLDIoU2ZCT/9bINpnHm4962ahOQQd1ghFXA4R/qFMh2Hpdre6R+oiH9cZW5vi0EhzWiJYN3Tjdar34IyOdLQr6JSlAVLhTF542RVINHFC/4NY2QbkEVkMtFswXWBQJCdo4iZnta6fOVmXFNTwDuCT/FbB1s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1624463599; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=XxR6zi5Sl+HrabgkFfQ6xbL6/flvZwU9dDb5E7MrENA=; 
	b=l4yafiOs7OTSZW2VLTJlL7KKmkdjnC1hylog5RqEm11F6lSqSwTzjLYvkDcwXi8LSksEVNdFvRvuo3GBivAZqscbvI4ThOrClNeQbZ74Iv3lVUrJv8c2NW7xAK8eSQEtolVYcIvfhYtIKdor1o5hQ9FD4eMoroGpOBt0zEhjxdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ertelnet.rybnik.pl;
	spf=pass  smtp.mailfrom=dwrobel@ertelnet.rybnik.pl;
	dmarc=pass header.from=<dwrobel@ertelnet.rybnik.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1624463599;
	s=ertelnet; d=ertelnet.rybnik.pl; i=dwrobel@ertelnet.rybnik.pl;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XxR6zi5Sl+HrabgkFfQ6xbL6/flvZwU9dDb5E7MrENA=;
	b=OV3A7PC5bbE7r75eomI1KTlUo1OdEnXvtjeU99sSximaEb/PoXU0MzBGa+ADhy4r
	V/s3GO813xD1QQ1Nng94hZoxwYLtyTZ7t/gMeE/tkHIxe2b4VfWoCbL2i8pXoVE3dty
	SF11cA+V5ts4BZgyPDC8TgkxwG7JapqbK65rhvTk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1624463596691542.1262521100331; Wed, 23 Jun 2021 08:53:16 -0700 (PDT)
Date: Wed, 23 Jun 2021 17:53:16 +0200
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
To: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Message-ID: <17a39935c7f.f690be7a82103.1176265347703762090@ertelnet.rybnik.pl>
In-Reply-To: 
Subject: [PATCH] bitbake: Fix automatic generation of variable dependencies
MIME-Version: 1.0
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Automatically generate variable dependencies also for:
    - "bb.utils.contains",
    - "base_contains"
    - "bb.utils.contains_any",
    - "bb.utils.filter".

This is to avoid situation in which some of the variables were
added automatically but not all of them like in the test example below:

RDEPENDS_${PN} += "\
    ${@bb.utils.contains(                                              \
        'BB_UTILS_CONTAINS_DROPBEAR',  '1',   'dropbear',   '', d)}    \
    ${@bb.utils.contains_any(                                          \
        'BB_UTILS_CONTAINS_ANY_EXPAT', ['1'], 'expat',      '', d)}    \
    ${@oe.utils.conditional(                                           \
        'OE_UTILS_CONDITIONAL_ZLIB',   '1',   'zlib',       '', d)}    \
    ${@bb.utils.filter('BB_UTILS_FILTER_WAYLAND_PROTOCOLS', 'xyz', d)} \

Signed-off-by: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
---
 lib/bb/cache.py      | 2 +-
 lib/bb/codeparser.py | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 27eb2717..2fe83ef3 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -26,7 +26,7 @@ import re
 
 logger = logging.getLogger("BitBake.Cache")
 
-__cache_version__ = "154"
+__cache_version__ = "155"
 
 def getCacheFile(path, filename, mc, data_hash):
     mcspec = ''
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 0cec452c..e00dc444 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -122,7 +122,7 @@ class CodeParserCache(MultiProcessCache):
     # so that an existing cache gets invalidated. Additionally you'll need
     # to increment __cache_version__ in cache.py in order to ensure that old
     # recipe caches don't trigger "Taskhash mismatch" errors.
-    CACHE_VERSION = 11
+    CACHE_VERSION = 12
 
     def __init__(self):
         MultiProcessCache.__init__(self)
@@ -225,10 +225,12 @@ class PythonParser():
                     if varname not in self.contains:
                         self.contains[varname] = set()
                     self.contains[varname].add(node.args[1].s)
+                    self.references.add(varname)
                 elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Str):
                     if varname not in self.contains:
                         self.contains[varname] = set()
                     self.contains[varname].update(node.args[1].s.split())
+                    self.references.add(varname)
                 elif name.endswith(self.getvarflags):
                     if isinstance(node.args[1], ast.Str):
                         self.references.add('%s[%s]' % (varname, node.args[1].s))
-- 
2.31.1


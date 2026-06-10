Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D06CD98C7
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 22:53:28 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33445.1781132007080319077
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 15:53:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=GZpCO7+t;
 spf=pass (domain: smile.fr, ip: 209.85.221.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so5470943f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781132005; x=1781736805; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7Z+52ZsMLn6kreMATMSA74FA0v92/MujOswIIy+QuE=;
        b=GZpCO7+t/yoSGkYzFnQCtbJji9ntsWTB27sADH1K7pmIYO1E5LrEBf5ttOLKneDRgC
         I223YK8RIHbUJt2JocdU3I6muzhoncwscNrx6BcR+8gXxTeIWGS0lV2jERlbYPuaPNYA
         CI1AIaIa143xLE1Nx/mgNnOasmcQoSuGeC07U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132005; x=1781736805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H7Z+52ZsMLn6kreMATMSA74FA0v92/MujOswIIy+QuE=;
        b=JQKS8cXSkGRUpupsPkmT8lnmCZBBpBwPvikHXcKR/xSIUF409OTaZOJQJnO0hfI+T5
         BWtXjVwaarM0adtRbZF9jwU7cXaY8r9Cv9drWWlminEk8dmXjJDZ9LqsmuJjGRIen3D5
         7mQ8UFx7mDMrZHNLdKKPi/Yy/tAHKT5/pnGjYvm2hqbZUN0KESdqahvFTcxCXmK7vPfs
         IE50mlILxWomXicxNHLSCfLh9oHiMjxtPAQGDm4KrJa/WUR8PVde7lO+b2L2nANbyi9h
         YHfG26500K2+76stZm5GCgGr1yNmEzUJi9HUvskJgWZZILN+8h0FAoif5zz/zlOy3VqB
         v33g==
X-Gm-Message-State: AOJu0YxPyCNPuUJq0Xx5h8Vy0Nuvk2zTyoMHfya7KpCLUk1N88W8opLL
	4VfLCNigkKVfhtpPHfvwGW8sxr3MXxGEIJJf2MQ44h5u+NYzoqJuumpaZlKn6gMI5CMHKh1+jqO
	BFORL
X-Gm-Gg: Acq92OHa48WkgbwHBV+o1nM7ov+px/RCOPqtMSWQAc7ha2aCVA3I4eTGSuM2oWYAkHp
	lQ6pTWzPRyZuMJdnIQ4lL4dViBUMO+baLw4SLQ9SAlakuQZaErq+WUEJTi/kdhzYEi/ewue9p03
	3cjzpgnwabbaLeG/WBON+VJ8Sn/ivGnPc/gA91MMqFHDBK/whddfX7X3MgmYSLwCZ2nbRF4tExm
	reOXlTrHlZ2VqKCHLloMgRok6KwwpQYXqOn+OlK8UHoCP7+Bd23ufYO2q7TXCnKWIkm+OIFbWH8
	CFwd8k5wBZCe1K32Uz3M5lLCuEqR0QfB5rxSaGpRby25GF8qwD/QiidWbdTPqwkZeRqyAesH3gQ
	8lntKQlmdR3N5JDqxRP9uvzB8JJOw4QM2Hvsnp7kOitWyu4FqXHJGI7TIi4ki38a//STXefu3LF
	hxganjHANxljXy02t00oGqlOBEVZxv2pMmBGqifNMZsCjmFLmebedQGqf181dLiuoi2D4DQdhew
	cKG3WVLqzHet+swe/uIw0IgGDINNCQLGNEYBm0=
X-Received: by 2002:a5d:5f47:0:b0:45e:f266:f4cb with SMTP id ffacd0b85a97d-460677cea88mr235385f8f.22.1781132005410;
        Wed, 10 Jun 2026 15:53:25 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00bb749f54eeb85d7b.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:bb74:9f54:eeb8:5d7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm132348771f8f.29.2026.06.10.15.53.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:53:24 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 6/6] fetch2: allow empty value for params while formatting URI string.
Date: Thu, 11 Jun 2026 00:53:08 +0200
Message-ID: <52b3bff42f17933595af48654098b172ea10baff.1781131922.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781131922.git.yoann.congal@smile.fr>
References: <cover.1781131922.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 22:53:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19653

From: hongxu <hongxu.jia@windriver.com>

While using PREMIRRORS to gets source code, recipe sbom-cve-check-update-nvd-native
do fetch failed:

$ bitbake sbom-cve-check-update-nvd-native  -cfetch -f
...
ERROR: sbom-cve-check-update-nvd-native-1.0-r0 do_fetch: Bitbake Fetcher Error: MalformedUrl('git:///path-to-premirror/git/github.com.fkie-cad.nvd-json-data-feeds.git;branch=main;protocol=file;destsuffix')
ERROR: Logfile of failure stored in: tmp/work/x86_64-linux/sbom-cve-check-update-nvd-native/1.0/temp/log.do_fetch.4135595
ERROR: Task (oe-core/meta/recipes-devtools/sbom-cve-check/sbom-cve-check-update-nvd-native.bb:do_fetch) failed with exit code '1'
...

In oe-core commit [1], destsuffix was configured to empty string through SRC_URI,
but in bitbake commit [2], it removed `=' from destsuffix in which value is empty,
and trigger MalformedUrl failure, see sbom-cve-check-update-nvd-native do_fetch log:

...log.do_fetch...
DEBUG: For url git://github.com/fkie-cad/nvd-json-data-feeds.git;branch=main;protocol=https;destsuffix= returning git:///path-to-premirror/git/github.com.fkie-cad.nvd-json-data-feeds.git;branch=main;protocol=file;destsuffix
...log.do_fetch...

This commit use function _query_str_join for query as usual (if a value is
None then it isn't a key-value pair, but a bare key.), and use function
_param_str_join for params to allow value is empty string and still key-value
pair, after applying this commit
...log.do_fetch...
DEBUG: For url git://github.com/fkie-cad/nvd-json-data-feeds.git;branch=main;protocol=https;destsuffix= returning git:///path-to-premirror/git/github.com.fkie-cad.nvd-json-data-feeds.git;branch=main;protocol=file;destsuffix=
...log.do_fetch...

$ bitbake-selftest -v bb.tests.fetch.URITest.test_uri
test_uri (bb.tests.fetch.URITest) ... ok

----------------------------------------------------------------------
Ran 1 test in 0.001s

OK

[1] https://github.com/openembedded/openembedded-core/commit/131e024a6688074347e08879718221fbfb69033f
[2] https://github.com/openembedded/bitbake/commit/eac583bd4c46f3bb9661852cb6a1448f16147ff1

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b3867e6d35ef57239c7ba961a00fa45577600301)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/__init__.py | 7 +++++--
 lib/bb/tests/fetch.py     | 6 +++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d913d7511..e0494b3cb 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -304,7 +304,7 @@ class URI(object):
 
     def _query_str(self):
         return (
-            ''.join(['?', self._param_str_join(self.query, "&")])
+            ''.join(['?', self._query_str_join(self.query, "&")])
             if self.query else '')
 
     def _param_str_split(self, string, elmdelim, kvdelim="="):
@@ -313,9 +313,12 @@ class URI(object):
             ret[k] = v
         return ret
 
-    def _param_str_join(self, dict_, elmdelim, kvdelim="="):
+    def _query_str_join(self, dict_, elmdelim, kvdelim="="):
         return elmdelim.join([kvdelim.join([k, v]) if v else k for k, v in dict_.items()])
 
+    def _param_str_join(self, dict_, elmdelim, kvdelim="="):
+        return elmdelim.join([kvdelim.join([k, v]) for k, v in dict_.items()])
+
     @property
     def hostport(self):
         if not self.port:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index cc133c1f5..e661ff0d8 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -292,8 +292,8 @@ class URITest(unittest.TestCase):
             'query': {},
             'relative': True
         },
-        "https://www.innodisk.com/Download_file?9BE0BF6657;downloadfilename=EGPL-T101.zip": {
-            'uri': 'https://www.innodisk.com/Download_file?9BE0BF6657;downloadfilename=EGPL-T101.zip',
+        "https://www.innodisk.com/Download_file?9BE0BF6657;downloadfilename=EGPL-T101.zip;someparam=": {
+            'uri': 'https://www.innodisk.com/Download_file?9BE0BF6657;downloadfilename=EGPL-T101.zip;someparam=',
             'scheme': 'https',
             'hostname': 'www.innodisk.com',
             'port': None,
@@ -303,7 +303,7 @@ class URITest(unittest.TestCase):
             'userinfo': '',
             'username': '',
             'password': '',
-            'params': {"downloadfilename" : "EGPL-T101.zip"},
+            'params': {"downloadfilename" : "EGPL-T101.zip", "someparam" : ""},
             'query': {"9BE0BF6657": None},
             'relative': False
         },


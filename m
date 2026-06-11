Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838D7CD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:11:55 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45177.1781183511864379377
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 06:11:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=CGS/erJr;
 spf=pass (domain: smile.fr, ip: 209.85.221.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-46019b190b6so6030384f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183510; x=1781788310; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7Z+52ZsMLn6kreMATMSA74FA0v92/MujOswIIy+QuE=;
        b=CGS/erJrZ+ar4RGwvQngTBOXnkVzFBgAmiPU5+TYfKIFTcW9gMAOpVPZnUfbDHaeW4
         sJdePpr5m6vKwKrb7uf4F6mMHQL3N1vA/BIuqDQtn+T6FuLa6Zw08VbVHmrN08blDZMz
         uVvs0kQtAw/GRcngqFmrR2kxPByoTxG64bMZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183510; x=1781788310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H7Z+52ZsMLn6kreMATMSA74FA0v92/MujOswIIy+QuE=;
        b=ISQmpMADkSRFEBVKdQGBkXF3wcz2X33kymJ637E6WvKtcWhNUyDV9PDrnqlRq0j+Ug
         QPbPbRzNGHQW3vCYWItS1a6pMxhqr/E3ovQ5IECX2WWFac+QmvX7RAXmKZPuyb+yQ1f1
         Yc4m2Dj7T64gqoc95hP9WZbFk3krLHEVbQcZietF95fpGdJZKpike8jcx28kTFxuJiUm
         0lYxkp8X9DbxL8ox3KTkYh34ziX5z1hbyAYhNxLHb3i8j3kOVBqMb7fqRUv4X3RZVc+7
         W/8Jz+6NzEbDlvyhAI6D+8oiy1GOEOMQhwaEXSF9NriLipx1avpSaiRShNXCLE3nlZu1
         zPQA==
X-Gm-Message-State: AOJu0YzTsrvnNP/BxV7zZ/XVWRPFxiL7Jdtn52xRikXPnd1tlMaKJTdy
	XP2BzJQ8mLweIJpaJ83wGiJ3kfgaywmUKmDJA3rbLSWQcXxqHlRN1z9+EiCrmmLnDRr+fnzpqOr
	qRg26
X-Gm-Gg: Acq92OF0Tb4UPOhOt2PDCZrNafULZyh8duFiMQBQhUqH5z4IaMHkOTaXCsBx/K6W277
	xSPxKU/MacFKYhx0Y2YMMWIhkR1XSRONClAiE3uTmXxBD5yaauE54UBSW4AD+Xv+l80sD1lRlE5
	60WXusktmEs4gw/wx91SlDyhhnMpT9w8GAnf5BufgjDKaVkiE9XE5zWUXoQbo8EwO4QIGsKn7+K
	39ph7KS0OMdkG62yx2NlRCo7jq64rBaMGNw7JtH06EB4yWQbomy2pPLcE2nXUpTFBtxNycgdq9y
	KipnwjC23f6QWGRRc9nebjBDQB/s9WuAdvbUBKQbt5SLaCLuEdNx4h3aFfMH8Wrb7xE6W2Mrw12
	wOZ3cQ1nyXS3CbB+2dicOVSQ516Bfwnid3zN3mjcDryEca1osbvPl1+asm1Ur/2D/3EEG9HOupJ
	UsN8nGy+5m6PR3fQbvUTTWJ4tKqCx+dlMyG3rKEpYvdqGdYahpKl8CuO+QN3zNGylhoTRqsWyXB
	VRVO9HsbTl6CzMwQ0pIZzBLWHML9yVBkkEBPiQ=
X-Received: by 2002:a05:6000:4013:b0:43f:dfb6:78e1 with SMTP id ffacd0b85a97d-4606758cf70mr4039324f8f.8.1781183510238;
        Thu, 11 Jun 2026 06:11:50 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm82048251f8f.28.2026.06.11.06.11.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:11:49 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH v2 6/8] fetch2: allow empty value for params while formatting URI string.
Date: Thu, 11 Jun 2026 15:11:28 +0200
Message-ID: <52b3bff42f17933595af48654098b172ea10baff.1781183212.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781183212.git.yoann.congal@smile.fr>
References: <cover.1781183212.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 13:11:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19666

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


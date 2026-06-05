Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40495CD6E6E
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 22:09:33 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5923.1780697362863903976
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 15:09:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=L36cPJip;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b09e4cccso17749845e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 15:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780697361; x=1781302161; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5bbzW5U3bjqYiMTj4pkGq2mSi01L581etCYv4nhpaM=;
        b=L36cPJip4D2jw77FB8kx/3xWd7z3CX4akdcK2xFRYdsG896xY99DtdmGkMYGhiRn9x
         Iqxx7xY0QWmvBVPQOj7msj+4IMkx7Z3Frzc4TVP7hKEZ4ykmwV6onaA0JGxe6I7K/gWs
         yTIaKqwaQ9ykTs+TYRUtQ5bg0GxKXfppjBIbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697361; x=1781302161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C5bbzW5U3bjqYiMTj4pkGq2mSi01L581etCYv4nhpaM=;
        b=aztQELMeIEDub1ly/miqjwOoVk9Wh7pXY5aQ0rRH3euf0aLprQB0NRYLqWwqAUoRj9
         q2yxWq/x89dv20fhT2+d5kTS8tHG5q8V5dC9CXyo41Et+Up0x7J4NlJGRuFevEqj/2+H
         lv8g2BkEZ1xBJ8bZv7QpoAHqvpC5rK9X4zJp8U9rAreaHCJ6rLrK/oOAdYrZvT2uyXuZ
         w2nArLBTiqBqeiKJIxCy8xvOfNkWO/PmKVWQ1yGhmeQA7uN90LYRV9cKCTg97zplQWfu
         096dS69912/0NYs1ppx5qQHgcaHf1cQ4tlUUW4zH1ppy/7xm/HG1O+ZGmav7s4mUOpO8
         ikDg==
X-Gm-Message-State: AOJu0Yy8rMWUU6hoMQApFLwm7RuV560qQKJjPdSZU3S1RWYJq4+nOO+W
	wQz1yiwCratPE0esKV6JuZXNbeI5O0WJK20HYgURLAyGq3exYC2JkCc5TioCFlaDOoS2E9JMJhI
	wSnsG
X-Gm-Gg: Acq92OErr1I/FRk3NtIS9bw5MV6JYGlZO2lcPu9r0jz58ou9nwrakKPhhbaUfwSi+K8
	D3iCKdc5Kv4/cr+Ky+fYeRE3F+i+uCnQ2pB5EQ0UAuiYDt57bjF9vdIiYfNstoOh+93IhYfYQvm
	zhFGJs5NeDMRCHWccir+dXyVahkLS5Wdzl6HK8Hc0MqhNiIj5++wT969QNIRffaCIVWsGBd2SSZ
	JHZlgLP48Edfk5l/RLy0aqEsECwv15rnWDfzCJntKxu3iEr8RjMq53xw+sNCof0ckLZp5+dCtCE
	4KIzCClbiCGuRkYakjQxqDq7SVXBo7mcaU7eIS+dQKCTIWZGqRelcdkk/+5DHFyZGXtm35ZLlCw
	xUuSKboc6mFQvL1vcJlosv7eHIE7zHN59amftLPgXwkGAxMov9OgYIgRKuRd4VhuOh3tklrcpcQ
	oSxoUJxITvXnfahMuteB6pISjxjdQt52kJAj+j2iwl4t6O0YYOPG2aDeLaQAJnRMNruoIAqdBSv
	VkqZAqzgxAi0qfKdTz1cUR18rA0up/cr3GSN+k=
X-Received: by 2002:a05:600c:45d1:b0:490:51e2:bc86 with SMTP id 5b1f17b1804b1-490c260a60bmr89265155e9.23.1780697361230;
        Fri, 05 Jun 2026 15:09:21 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd502sm182367015e9.11.2026.06.05.15.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:09:20 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 2/4] fetch2: validate striplevel parameter
Date: Sat,  6 Jun 2026 00:08:56 +0200
Message-ID: <ffaf63bba8e752e2e157a65afed5ddffbae2d434.1780696925.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780696925.git.yoann.congal@smile.fr>
References: <cover.1780696925.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 22:09:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19618

From: Anders Heimer <anders.heimer@est.tech>

The striplevel URL parameter is appended to tar_cmd, which is later run
through the shell. Validate it as a decimal count before using it in the
tar arguments.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 934fe718bfe29c7ec921e6b598d81ec2ebe8f7c7)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/__init__.py |  5 ++++-
 lib/bb/tests/fetch.py     | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index fc641655e..3d39a1eeb 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1542,7 +1542,10 @@ class FetchMethod(object):
         if unpack:
             tar_cmd = 'tar --extract --no-same-owner'
             if 'striplevel' in urldata.parm:
-                tar_cmd += ' --strip-components=%s' %  urldata.parm['striplevel']
+                striplevel = urldata.parm['striplevel']
+                if not striplevel.isdigit():
+                    raise UnpackError("Invalid striplevel parameter: %s" % striplevel, urldata.url)
+                tar_cmd += ' --strip-components=%s' % striplevel
             if file.endswith('.tar'):
                 cmd = '%s -f %s' % (tar_cmd, file)
             elif file.endswith('.tgz') or file.endswith('.tar.gz') or file.endswith('.tar.Z'):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 869a82a99..589a4655e 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -866,6 +866,16 @@ class FetcherLocalTest(FetcherTest):
 
         self.assertIn("does not contain supported data.tar* file", str(context.exception))
 
+    def assertInvalidStriplevel(self, value):
+        with self.assertRaises(bb.fetch2.UnpackError) as context:
+            self.fetchUnpack(['file://archive.tar;subdir=bar;striplevel=%s' % value])
+        self.assertIn("Invalid striplevel parameter", str(context.exception))
+
+    def test_local_striplevel_rejects_invalid_values(self):
+        for value in ("abc", "", "-1", "1\n", "1 2"):
+            with self.subTest(striplevel=repr(value)):
+                self.assertInvalidStriplevel(value)
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir = tempfile.mkdtemp(dir=self.tempdir,


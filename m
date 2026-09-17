Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5573AC982DD
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 22:17:21 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1873.1789683434765494600
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 15:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=2KvuD1eq;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so877275e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789683433; x=1790288233; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IbNm2GWtD3aZGg1aVHDtPUgwbtMwLOdA87VtMcfVh/g=;
        b=2KvuD1eqsuYGsRvpCWwVLwo2dnPDd8UYGuksbnjtZ1ULj4m/4DE72CBU7vE8UTIujR
         TZ1lkEGMc1VTFaJfo6SGQl52h3tZ+nv2O4hNR3clF4Gu/TCWlssw8lKGQX2KAGpTOvqD
         dwC2/BiZ1fFfL6YXZ3ZY/kKGHq98KiP+4TNFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683433; x=1790288233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IbNm2GWtD3aZGg1aVHDtPUgwbtMwLOdA87VtMcfVh/g=;
        b=kEoJxgCERpAoP7ZyMeBGmWPhwNbxuUFUliHj+EImSPl8++GY0DCqYu9HmNqz5T8fJd
         /DfvE4hdTwx5og8mxHKb5iU0u+xixbBFD1J4DjtDngP1e69BRAy/4DniW+gB50/FiveU
         QNGOVBR+z0FkIh/Tb5s8MR69OynMHfSlQgb3c9i5gjxHwsBarinkDDCJLAUv0myYGIJc
         GMrNi9N/OksS95qhbTegGzZrszyfdngFo8Hfkz2euavXnVmzkqMLpxKuzh/aN30CdepZ
         1dVDiWVgJ/+lZYpRHfxuWj1tYwDNqQL1v8lYQ3GMbfNJoRfPMpT7BUH3P+RRL/iIXJxn
         8f8w==
X-Gm-Message-State: AFuF++lfHhfwGlqNP4f0E7Ctuzfnmuk+jHcEJDifyjnY/Wjucd8I03M/
	xuyoWTg/Y0cA1CW5WV+uFWiLlizMBw6nTuw8ZLZjaqPuXltZELKCzEN4Lix8QL66HEd2BrP2qlo
	JmA8qqPI=
X-Gm-Gg: AYBFou2hZMjsuuhb8v2vthUpOT8f/HwGHLFfslk75QltqkNY5IZNWOUb3qmLSfPJ4Ce
	kaDqIev5NoORR7q0xVrnpYTePz8NX3KFf1uIM7ywKyJScm2zcDKLQ92W7ENrVLdJar3olEH5Sfc
	xtHOREr43Qx21G2iwY0ql7xdtuOUFfoczzSvB2rNZvubEmJCnSs+EuxiohUOLBZzKdeLmyh5UoD
	tKFGsRdTbKlSNBU4GOPKSXZOxtxnM9zdGFuFpEu+qtG3L+IU6Y3Wv8DZkAj0QbZi2swKLse90h/
	ZyMNVc7uBjo5xxobuVJPuC0pVi2F5RTLnxVuG+C9J9PfsWSm5LkrMG9JyWjEdQftLk/ELr0DRTc
	St6gFniludA33J+vbEtxJyORvL3efWwNDYEmE5ZcFZiNvbS8YxnGuzElIhDBmGJlBplY7J+J/wr
	uTZM420ztCc7I0sfK+J6bsTLiLUbckHT05VTx6/fZXqMuvLHIVNwV3a66MFU+jTOMdnkSgmHfQ+
	BLxdI7cBmsYKQYxk8mQN/hpBrRNcUR2Dnz4ohFI/3URXEnEDiOa4r/txLfg/+ffy7wIV+QTSEg=
X-Received: by 2002:a05:600c:3f0b:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49fc56aa68amr3374645e9.8.1789683432938;
        Thu, 17 Sep 2026 15:17:12 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm185737725e9.11.2026.09.17.15.17.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:17:12 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 2/7] fetch2/wget.py: add filter_regex parameter to latest_versionstring
Date: Fri, 18 Sep 2026 00:17:00 +0200
Message-ID: <9a668f8fff0266a51f49968968cccb2cfa52156c.1789683244.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789683244.git.yoann.congal@smile.fr>
References: <cover.1789683244.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 22:17:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20225

From: Chen Qi <Qi.Chen@windriver.com>

We want to be able to do stable version upgrade for recipes. For
example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.

To to this, we need an extra paramter to latest_versionstring
so that we are able to filter out the versions we need. Using regex
has the advantage of adapting to different version schemes.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b1c4a431b080ee328fbf21543258e226a464c118)
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/wget.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index fc83b301a..c292dfe7e 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -515,7 +515,7 @@ class Wget(FetchMethod):
 
         return fetchresult
 
-    def _check_latest_version(self, url, package, package_regex, current_version, ud, d):
+    def _check_latest_version(self, url, package, package_regex, current_version, ud, d, filter_regex=None):
         """
         Return the latest version of a package inside a given directory path
         If error or no version, return ""
@@ -538,6 +538,11 @@ class Wget(FetchMethod):
                 newver = self._parse_path(package_regex, str(line))
 
             if newver:
+                if filter_regex:
+                    # filter_regex is derived from PV, and uses . as separator
+                    # while upstream may be using _ as separator
+                    if not re.match(filter_regex, re.sub('_', '.', newver[1])):
+                        continue
                 bb.debug(3, "Upstream version found: %s" % newver[1])
                 if valid == 0:
                     version = newver
@@ -555,7 +560,7 @@ class Wget(FetchMethod):
 
         return ""
 
-    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d):
+    def _check_latest_version_by_dir(self, dirver, package, package_regex, current_version, ud, d, filter_regex=None):
         """
         Scan every directory in order to get upstream version.
         """
@@ -599,7 +604,7 @@ class Wget(FetchMethod):
                         ud.user, ud.pswd, {}])
 
                     pupver = self._check_latest_version(uri,
-                            package, package_regex, current_version, ud, d)
+                            package, package_regex, current_version, ud, d, filter_regex)
                     if pupver:
                         version[1] = pupver
 
@@ -660,7 +665,7 @@ class Wget(FetchMethod):
 
         return package_custom_regex_comp
 
-    def latest_versionstring(self, ud, d):
+    def latest_versionstring(self, ud, d, filter_regex=None):
         """
         Manipulate the URL and try to obtain the latest package version
 
@@ -701,11 +706,11 @@ class Wget(FetchMethod):
                 dirver_pn_regex = re.compile(r"%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
                     return (self._check_latest_version_by_dir(dirver,
-                        package, package_regex, current_version, ud, d), '')
+                        package, package_regex, current_version, ud, d, filter_regex), '')
 
             uri = bb.fetch.encodeurl([ud.type, ud.host, path, ud.user, ud.pswd, {}])
         else:
             uri = regex_uri
 
         return (self._check_latest_version(uri, package, package_regex,
-                current_version, ud, d), '')
+                current_version, ud, d, filter_regex), '')


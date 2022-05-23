Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7FC433F5
	for <webhook@archiver.kernel.org>; Mon, 23 May 2022 14:40:25 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.28419.1653316820760955472
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 May 2022 07:40:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=135unWeg;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.49,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f49.google.com with SMTP id
 o13-20020a17090a9f8d00b001df3fc52ea7so17706167pjp.3
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 May 2022 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0ybdaUkp+zU8rlXGmm8RdWiAh1u+E0AmcPmkbC30oQk=;
        b=135unWegUoTJqGzmrYDtFYWa28gBjS2F5D9+gtgp46OfH38SlLyaJD0Nu1hK70igfz
         tBMSUeFImdwwop4bNB8++XKsMLcUE4akNUF3IAoyC8SNqDzxOraixwYckVTlqsRraXXW
         ZxQhJjE2FJq0WhA3Jxgn+MjM0pykJd0gWwrqg/LRtHb2okkPwGn3H7OA+S3SBWI/yKQ4
         67aRB/Upv8d5Gc8cKradYy5+ejR5VcGCRKDHS5q9Ytsu600FXmq2IiHJubv8UVOFK3hg
         MUaL6hGDRY+izPVaoh3Vr8V9c5YxsLSHdVV3OOIm6NVUoXLv7vA6g0PIWcJemXcUSv+6
         xH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ybdaUkp+zU8rlXGmm8RdWiAh1u+E0AmcPmkbC30oQk=;
        b=29qf9UM8FCY/+PIuSapmDRXdsQ8JlfNoWhEUH//LO/6VxS0BHeMLeIBBog30cwq9pj
         CgnxZfHP9VFeoiEnPUMKvlbfInKpPEy4020XqpAhyubew+3qSz4vPoJMhIBsiNJii8iq
         K0rBRRLReGLX/FVISUOPPpa6YiZtlsZkslL0XUcEH0oQHru2GZKH6/S9sJ5ZUk3R2zN5
         cRLiMbjqwSHHuHygGEPTqdXRNsKTdpCYRKOkG/tQTBJRTsqwpD9UB4o1dgRVAcFemgsj
         Rh/I+TPoK7GunjbUVB8DwMhahFUuLkkMlh/cuJ1uuUuKcc5dum4kBPnc2gnHDifaf0Zs
         UQCQ==
X-Gm-Message-State: AOAM530FX0fonIL1b8HB6dC/VF8oWT0DNuMQREYmOx0ztHAw2KNIDPzt
	DRNSRxSEwhK46groap8wwF89PaurWdk74hNJ
X-Google-Smtp-Source: 
 ABdhPJymFO2zh3/6A0fPP5lrdSOQmfOLBFU+tMroE1dUYqUFqNzyCh8Je1lRLjBTQr+tk9CawBmOsw==
X-Received: by 2002:a17:90b:1bc6:b0:1df:cb4b:836e with SMTP id
 oa6-20020a17090b1bc600b001dfcb4b836emr26172563pjb.117.1653316819529;
        Mon, 23 May 2022 07:40:19 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 u4-20020a655c04000000b003c14af50623sm4865576pgr.59.2022.05.23.07.40.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:40:18 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/3] fetch2/osc: Small fixes for osc
 fetcher
Date: Mon, 23 May 2022 04:40:03 -1000
Message-Id: 
 <b0fe659e92b837b19233b0de8f578cb416031697.1653314792.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1653314792.git.steve@sakoman.com>
References: <cover.1653314792.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 May 2022 14:40:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13708

From: Gunjan Gupta <viraniac@gmail.com>

The current fetcher seemed to have some issues that made it difficult when
trying to use the same. This patch fixes the following

* Make consistent use of the path that needs to be used as oscdir
* The path mentioned in os.access in download function was not same as
  ud.moddir which would result into invoking of fetch command instead of
  update command even if directory already existed
* Before creating oscrc, make sure oscdir exists and create it if it does
  not exist
* Updated the configuration to use apiurl and added a new parameter to
  control whether http or https needs to be used to connect to apiurl

Signed-off-by: Gunjan Gupta <viraniac@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3ec78686f3c0ea2304097b86a965f9be4b0cb879)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/osc.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/osc.py b/lib/bb/fetch2/osc.py
index 99a529e5..eb0f82c8 100644
--- a/lib/bb/fetch2/osc.py
+++ b/lib/bb/fetch2/osc.py
@@ -36,6 +36,7 @@ class Osc(FetchMethod):
         # Create paths to osc checkouts
         oscdir = d.getVar("OSCDIR") or (d.getVar("DL_DIR") + "/osc")
         relpath = self._strip_leading_slashes(ud.path)
+        ud.oscdir = oscdir
         ud.pkgdir = os.path.join(oscdir, ud.host)
         ud.moddir = os.path.join(ud.pkgdir, relpath, ud.module)
 
@@ -49,7 +50,7 @@ class Osc(FetchMethod):
             else:
                 ud.revision = ""
 
-        ud.localfile = d.expand('%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), ud.path.replace('/', '.'), ud.revision))
+        ud.localfile = d.expand('%s_%s_%s.tar.gz' % (ud.module.replace('/', '.'), relpath.replace('/', '.'), ud.revision))
 
     def _buildosccommand(self, ud, d, command):
         """
@@ -86,7 +87,7 @@ class Osc(FetchMethod):
 
         logger.debug2("Fetch: checking for module directory '" + ud.moddir + "'")
 
-        if os.access(os.path.join(d.getVar('OSCDIR'), ud.path, ud.module), os.R_OK):
+        if os.access(ud.moddir, os.R_OK):
             oscupdatecmd = self._buildosccommand(ud, d, "update")
             logger.info("Update "+ ud.url)
             # update sources there
@@ -114,20 +115,23 @@ class Osc(FetchMethod):
         Generate a .oscrc to be used for this run.
         """
 
-        config_path = os.path.join(d.getVar('OSCDIR'), "oscrc")
+        config_path = os.path.join(ud.oscdir, "oscrc")
+        if not os.path.exists(ud.oscdir):
+            bb.utils.mkdirhier(ud.oscdir)
+
         if (os.path.exists(config_path)):
             os.remove(config_path)
 
         f = open(config_path, 'w')
+        proto = ud.parm.get('proto', 'https')
         f.write("[general]\n")
-        f.write("apisrv = %s\n" % ud.host)
-        f.write("scheme = http\n")
+        f.write("apiurl = %s://%s\n" % (proto, ud.host))
         f.write("su-wrapper = su -c\n")
         f.write("build-root = %s\n" % d.getVar('WORKDIR'))
         f.write("urllist = %s\n" % d.getVar("OSCURLLIST"))
         f.write("extra-pkgs = gzip\n")
         f.write("\n")
-        f.write("[%s]\n" % ud.host)
+        f.write("[%s://%s]\n" % (proto, ud.host))
         f.write("user = %s\n" % ud.parm["user"])
         f.write("pass = %s\n" % ud.parm["pswd"])
         f.close()
-- 
2.25.1



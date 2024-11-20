Return-Path: <bhstalel@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2441D743C5
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 19:08:36 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
 by mx.groups.io with SMTP id smtpd.web11.23146.1732129708178363346
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Nov 2024 11:08:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=La+tyOUX;
 spf=pass (domain: gmail.com, ip: 209.85.160.180, mailfrom: bhstalel@gmail.com)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4609acd6bf4so146091cf.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 11:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732129707; x=1732734507; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUKePqHIz/e5YIH7/oJ4WJp7RYqpM7+37WWpSR8ENWA=;
        b=La+tyOUXfJYd2Ga64Tzgc1SkKiA9L+qfyKb9NsHPSomvZw0zlh8N4S3YD486DT0MU2
         82NUPVHHte36/iduHkh04Halt7xbPKGbxmwSNFcBVGee0A7DViSWrcw+Yo8zKgUdt87A
         XHvVGkwqMQBEB6SJRVAeZ3l+KFCuuA7pDVSBP9qCsr8eh2TIoZ0JDHVoTUnwPpbLMyt3
         rSZQxziaYFI77vei+HgDRQzvYXczbueoM4YlgOHLdZRVaptxuj6DYfLevC0Ko7q2ViUe
         Hwdbn4qGPORWz/Ahn1de+hLjYRFfX6oOPjsORgTe2nZ7gxkGmASwJ0ebA5CZK9Clfv/Q
         xucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732129707; x=1732734507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUKePqHIz/e5YIH7/oJ4WJp7RYqpM7+37WWpSR8ENWA=;
        b=OivSAgDKoiUE1d/UNzDRL8kefUeV07YZFb8tCqu4Qxlq4UWJwFOyGTspRJvifM+qWU
         NEy/7DtI5w4+iRquKcUUIsJKnLcSM6qpIOLOBlZo+t6bHYd9m0MyH2ifr1DdUABhQ+wZ
         1CE34JGYDIMl9/Ha/qDkNT6xR1OguYQPKJGLgz9Be12HcggwqOPouEtqHWqOtPbQKdT6
         Db8MU5Q/h2DaUSD3U5gNqd6Ps20rdFcRNI9fV/gXrZCjKZeaDq2hod6RDvO6DtiHkPK9
         fPAcPf5t1LSwajbkqgWQBi5wJ3CzQe0Hy3A8fHwBYNnJo6HjOECKJs8kB90u/aiq1htK
         4l8w==
X-Gm-Message-State: AOJu0YweDrmWUugeY/QPDxw5DEgIcGIrRIRs3ji7Ao4W2h4v6icSD9R3
	uUoV0St1XiYHnH73L8wahs7ebRRAUM3NGGZ/0inZQL6yNIwAuU+WaT6Evw==
X-Gm-Gg: ASbGncvbq9/rXD4HT6BQd3kykzVstL/XXG2dQ2USqq0in3TtZF94cR3uxMv6vp6/Y8h
	czOZkRc52BdVlyjBqVJqWp+K4xfTdgFL7IYMeD4aLhSxOcYoCmDYN8kiF9kDtPA+2G3RPZ/TRZe
	mzaw0Tcei+GksBNOJZPm4e9PPWXXJBQ1+1ezlwcpShiQs6Y695gfbNy+bxP9zRyUOMOdph09SoW
	cv2OPHuF9qHukj0h9d8ACgleBtRYzqZkG9fYgV7dNVz
X-Google-Smtp-Source: AGHT+IHyAX5tDpKUGk3F+yiUmMd49NF2Ic/9hsBjgT4+PScxgHrfzviJh8taT/tBIm0eto2tJ941yA==
X-Received: by 2002:ac8:5903:0:b0:461:2416:13c3 with SMTP id d75a77b69052e-4652b44d0a7mr12738971cf.15.1732129707071;
        Wed, 20 Nov 2024 11:08:27 -0800 (PST)
Received: from bhstpc.. ([196.176.166.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646ac162b8sm13144541cf.88.2024.11.20.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:08:26 -0800 (PST)
From: Talel BELHAJSALEM <bhstalel@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Talel BELHAJSALEM <bhstalel@gmail.com>
Subject: [PATCH v2] bitbake-getvar: Catch NoProvider exception
Date: Wed, 20 Nov 2024 20:08:21 +0100
Message-ID: <20241120190821.7073-1-bhstalel@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 19:08:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16820

When the recipe provided by (-r, --recipe) is not found
tinfoil raises an exception that is not catched for
readability, example:

Traceback (most recent call last):
  File "/.../poky/bitbake/bin/bitbake-getvar", line 45, in <module>
    d = tinfoil.parse_recipe(args.recipe)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/.../poky/bitbake/lib/bb/tinfoil.py", line 633, in parse_recipe
    fn = self.get_recipe_file(pn)
         ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/.../poky/bitbake/lib/bb/tinfoil.py", line 550, in get_recipe_file
    raise bb.providers.NoProvider('Unable to find any recipe file matching "%s"' % pn)
bb.providers.NoProvider: Unable to find any recipe file matching "aaa"

Signed-off-by: Talel BELHAJSALEM <bhstalel@gmail.com>
---
 bitbake/bin/bitbake-getvar | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 20c0b696f7..1719824d95 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -16,6 +16,7 @@ bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
 sys.path[0:0] = [os.path.join(topdir, 'lib')]
 
+import bb.providers
 import bb.tinfoil
 
 if __name__ == "__main__":
@@ -40,7 +41,10 @@ if __name__ == "__main__":
     with bb.tinfoil.Tinfoil(tracking=True, setup_logging=not quiet) as tinfoil:
         if args.recipe:
             tinfoil.prepare(quiet=3 if quiet else 2)
-            d = tinfoil.parse_recipe(args.recipe)
+            try:
+                d = tinfoil.parse_recipe(args.recipe)
+            except bb.providers.NoProvider as e:
+                sys.exit(str(e))
         else:
             tinfoil.prepare(quiet=2, config_only=True)
             # Expand keys and run anonymous functions to get identical result to
-- 
2.43.0



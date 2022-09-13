Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37872C6FA82
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:40 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web08.5358.1663079233557791317
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=k7z1vjTq;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id d12so11990348plr.6
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=dSrI0ciGAGCjRFZn4zGSUh1ciGeoNRxQQcLbiDGRBPc=;
        b=k7z1vjTqfjJ4OYXC0CoG9NVn0GcIc87LQT5HyFvnhizm7eW8GmDzzCPUTTgSIimFiI
         NH7T29jpXPZtip6vaaM4nLSMn5OB/YmecmZyGKPUn0X5NQToLs7TUMi1pd0GgYB9zD6u
         EUlvnPctrOB81CfYz7xdxgpIevVXfXFAmJrRsX2gbVzlwBFsUUeBjipz1lJOurHYiqMB
         uANznTll9xSBuYXxOAlfQKoUrFHnBlHXacVJI3P3bqPhE2Rh/smrZ0yJFvSdkafcx7Io
         tGzsSG+1lgVYbknJuzoNGF+auI4DH35iJfXOsIHwAN85H9yk/SXf0Kn0MfVCQJYBQzTg
         7VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dSrI0ciGAGCjRFZn4zGSUh1ciGeoNRxQQcLbiDGRBPc=;
        b=mz1yr5w2daN11QwI1ZA7EGfNqDVJ3uH5e0BOxyWYeBX/RHf533lTxicSnao2bTVGEL
         KFKXrY6zQ3AmZJ5wz+c9u/sQrhcgyIg8yOZxfTPtDjeEvZrrn4Loi2vkMI1NSyPiRLLh
         sQ2z1ek7JBJNOVKHWsvdtJWQEahNuA8D7yNDTq6KYeaz4c02ET+3cfgE/VoXa6HMnAj2
         e80NfnisxEvQFA8xlb9uvVIoELiPOJGhVC08nIgLpuOE7wGGOnmFsbCYbgfhvI9lDx4l
         qhAYukyBhdfehmplvhximlY21uiozwNHWtAnUKZ4/nnwNGIBfDU1BMkElI6vd5xRZibe
         as9g==
X-Gm-Message-State: ACgBeo0Dl/+YKDQ1PWIdzWzpCFdNroaKvuLBlvKzU0EGu1aeun1JMklr
	sGVEM6yIBY98HUpnzU3woVkPCexMlosa4vB1
X-Google-Smtp-Source: 
 AA6agR5eQzUB9UirZfsIE0MCTcVoCGcrId2Uu8CPWR8lNU93b3S3y2a9bqnRXa07USUaKTqdTRvBQw==
X-Received: by 2002:a17:903:18b:b0:176:afb8:b4ab with SMTP id
 z11-20020a170903018b00b00176afb8b4abmr32264780plg.80.1663079253148;
        Tue, 13 Sep 2022 07:27:33 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:32 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 13/14] bb/utils: movefile: use the
 logger for printing
Date: Tue, 13 Sep 2022 04:26:43 -1000
Message-Id: 
 <8c96393391bc63a87719168f4c9e2b88b7969e15.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13974

From: Jose Quaresma <quaresma.jose@gmail.com>

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
(cherry picked from commit 274b2d7a2fa0b43b0b542cb5471ff832e692ea93)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/utils.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index e92d5feb..95b3c898 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -753,7 +753,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
         if not sstat:
             sstat = os.lstat(src)
     except Exception as e:
-        print("movefile: Stating source file failed...", e)
+        logger.warning("movefile: Stating source file failed...", e)
         return None
 
     destexists = 1
@@ -781,7 +781,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
             os.unlink(src)
             return os.lstat(dest)
         except Exception as e:
-            print("movefile: failed to properly create symlink:", dest, "->", target, e)
+            logger.warning("movefile: failed to properly create symlink:", dest, "->", target, e)
             return None
 
     renamefailed = 1
@@ -798,7 +798,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
         except Exception as e:
             if e.errno != errno.EXDEV:
                 # Some random error.
-                print("movefile: Failed to move", src, "to", dest, e)
+                logger.warning("movefile: Failed to move", src, "to", dest, e)
                 return None
             # Invalid cross-device-link 'bind' mounted or actually Cross-Device
 
@@ -810,13 +810,13 @@ def movefile(src, dest, newmtime = None, sstat = None):
                 bb.utils.rename(destpath + "#new", destpath)
                 didcopy = 1
             except Exception as e:
-                print('movefile: copy', src, '->', dest, 'failed.', e)
+                logger.warning('movefile: copy', src, '->', dest, 'failed.', e)
                 return None
         else:
             #we don't yet handle special, so we need to fall back to /bin/mv
             a = getstatusoutput("/bin/mv -f " + "'" + src + "' '" + dest + "'")
             if a[0] != 0:
-                print("movefile: Failed to move special file:" + src + "' to '" + dest + "'", a)
+                logger.warning("movefile: Failed to move special file:" + src + "' to '" + dest + "'", a)
                 return None # failure
         try:
             if didcopy:
@@ -824,7 +824,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
                 os.chmod(destpath, stat.S_IMODE(sstat[stat.ST_MODE])) # Sticky is reset on chown
                 os.unlink(src)
         except Exception as e:
-            print("movefile: Failed to chown/chmod/unlink", dest, e)
+            logger.warning("movefile: Failed to chown/chmod/unlink", dest, e)
             return None
 
     if newmtime:
-- 
2.25.1



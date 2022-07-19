Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FB8C433EF
	for <webhook@archiver.kernel.org>; Tue, 19 Jul 2022 09:40:18 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.38795.1658223616863173365
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Jul 2022 02:40:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=XPUWRkCx;
 spf=pass (domain: gmail.com, ip: 209.85.221.44,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id bk26so20704030wrb.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Jul 2022 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gWaC/E9QE6poNXDo5KxJ4ByrIOqHoDXgktyuUInmiyU=;
        b=XPUWRkCxTGKsbQ9ekTc3+s85ZIFdXExuGgCiRb3D1oNZbIKCw/G+iN6U+f8fLKbxj5
         bj7HdH18NYbJ1LY/Nl8IYOLg4OBcLyxqkKDMYvcMIgReppFbn7of/cQumYpjpNVoeyNk
         +TdmCoYGYG2xNLXUD8ZzquhMA1zkjMzqKW4+Zv48TvgREOuqeQQgl/VPl9SVJrbD3UuN
         +0Eqz02B/d03yIKzJFlYbVtwJIc1zIpMEPcXZTCqjPpeRcTjm63FMebQnohr3+lg87Dh
         u8LNjGOYB9TT8IFVlyF+YCRJT+S26e2Zur8EReXRdl0pYf1WcZaI7SomSwKaHc5QuSps
         LMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gWaC/E9QE6poNXDo5KxJ4ByrIOqHoDXgktyuUInmiyU=;
        b=UJ+3OfelVWBixjZA1EJ7+DcJcP4xOFFSnlSuZtHextHoLCR8jBCWgY2fSZvF75NyIa
         bzNO0+mEUYk5pcaIAbcZPeu3xCuMQNgBxbiZ3v7z/xthIuu93/vVAcFl/d3ehfVqdrmN
         Ve0OIbdRdOd3Li5M3zoTeZijVuj37uHzG5okjS5yNfwyxMm+TiTR/T2brYzB1kf5ikIv
         4Nifjbp/36IQA9w5M3WrSah0HipTOqxK16/TA/L5ORZz8WWFPFnfVQTZUtOxKTJ2J7il
         e2gNSpqn+VJ4rJlCFjoQht2Q2pxKlWGxPldofPPRT1eMfQ5JwurPJ5sfH3V0MSsnknG3
         1yWA==
X-Gm-Message-State: AJIora/Y9pwKCf0Ys4/ZCrQDwnYa7tWuICHzkuB5ZbX/ocuVkCkA8YRI
	Vqs1pOF+o78gCy9NhrdXHk+L0J2xKzI=
X-Google-Smtp-Source: 
 AGRyM1vTvea07q5F5MNdt3glq/TJ6l6vEImrjixEk5SCP/+yMuoYLlAI/jCvhGnaIj+P6JuBur25FQ==
X-Received: by 2002:a5d:5846:0:b0:21d:a98a:b236 with SMTP id
 i6-20020a5d5846000000b0021da98ab236mr26405715wrf.674.1658223614963;
        Tue, 19 Jul 2022 02:40:14 -0700 (PDT)
Received: from fio.lan (176.57.115.89.rev.vodafone.pt. [89.115.57.176])
        by smtp.gmail.com with ESMTPSA id
 t8-20020a5d49c8000000b0021e37fd6f32sm1290063wrs.112.2022.07.19.02.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:40:14 -0700 (PDT)
From: Jose Quaresma <quaresma.jose@gmail.com>
X-Google-Original-From: Jose Quaresma <jose.quaresma@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Jose Quaresma <jose.quaresma@foundries.io>
Subject: [bitbake-devel][PATCH] bb/utils: movefile: use the logger for
 printing
Date: Tue, 19 Jul 2022 10:40:11 +0100
Message-Id: <20220719094011.91956-1-jose.quaresma@foundries.io>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Jul 2022 09:40:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13833

Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
---
 lib/bb/utils.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d11da978..3abc4938 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -751,7 +751,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
         if not sstat:
             sstat = os.lstat(src)
     except Exception as e:
-        print("movefile: Stating source file failed...", e)
+        logger.warning("movefile: Stating source file failed...", e)
         return None
 
     destexists = 1
@@ -779,7 +779,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
             os.unlink(src)
             return os.lstat(dest)
         except Exception as e:
-            print("movefile: failed to properly create symlink:", dest, "->", target, e)
+            logger.warning("movefile: failed to properly create symlink:", dest, "->", target, e)
             return None
 
     renamefailed = 1
@@ -796,7 +796,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
         except Exception as e:
             if e.errno != errno.EXDEV:
                 # Some random error.
-                print("movefile: Failed to move", src, "to", dest, e)
+                logger.warning("movefile: Failed to move", src, "to", dest, e)
                 return None
             # Invalid cross-device-link 'bind' mounted or actually Cross-Device
 
@@ -808,13 +808,13 @@ def movefile(src, dest, newmtime = None, sstat = None):
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
@@ -822,7 +822,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
                 os.chmod(destpath, stat.S_IMODE(sstat[stat.ST_MODE])) # Sticky is reset on chown
                 os.unlink(src)
         except Exception as e:
-            print("movefile: Failed to chown/chmod/unlink", dest, e)
+            logger.warning("movefile: Failed to chown/chmod/unlink", dest, e)
             return None
 
     if newmtime:
-- 
2.37.1



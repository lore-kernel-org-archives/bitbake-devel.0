Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374FECD6E6D
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 13:34:54 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11720.1780580093217180323
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2026 06:34:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SQ+N/q9k;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b613a17bso7216365e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780580092; x=1781184892; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4Oy67000vqwBAteypMq6XQuxENgxORhY6i4QWCzP1Q=;
        b=SQ+N/q9kfjPM+Z5WZRwPagubFFy1BcYMOwSf+RL+PKk7iqoStPc/cJyxp3Ws9Y9/4f
         ILOA+Y8xoJjVgzoCFx+/8ySjDd4qqGptqtv+CWH4mbtRlDto9ej334QB4i3avS6VKLlB
         +SRdMGIUQwzuWlmOTh1TonbRONVvG4UCbvmIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580092; x=1781184892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4Oy67000vqwBAteypMq6XQuxENgxORhY6i4QWCzP1Q=;
        b=Wmo+pbwmt7tPPgzrFcbKLPMt6SCM9XOYZKZPG1Bwr5dpFi/DxpMR8y0csYvkI057uh
         Blgd+BQaHOD6Q+qrlvVIA5bQo9NSV4b/G0UTsaPzq5qn2Adxe50CKSKdQ1V77XP0a/a7
         +7hzD+SlqaxBcweja1G/BzR4OMPBtdiGgNPwXf9kwYdJHMzKOXQcusye/ESeeh8qVUo8
         Wr620PiROVRz+oefSH3Z4Bpp330dCK4cJbMt2QrqSDJwIkh0557F8KpacWUdwL4gHE64
         Cq4Oj8bN9AbzJEcynp+PPvw0qI19BjSvwfsXoYuJzpMjh8yjXCMx6jq6l+IdFTj5xmCx
         ha9g==
X-Gm-Message-State: AOJu0YwG7oDb61m7GdWBwXV9NkzEx024m4lvjUd0wFzj3c4ByqaeKMaP
	8QPZZ7ib4DQBOd0ItP/Li5toLKa0ZK7V+h5V7dK7EDiVgfYMLRK4AePQe7oSP6uITobmDGqzMAy
	BBXwg
X-Gm-Gg: Acq92OFMc5rULaLibvTXauIJWlCJU2PlrdUXY6tEdJNXTPw0d5nhMrm14aRjLgn15cE
	jpXS2m8g9fQMcpa0JPz5imJ+oli3bZGkH/nWK5MjA4C/Oi67NFkW8yg5OUu/Nz+Wv7Dk8IaD7as
	LCfikyFHvTXJ86LS4ciUbeajt61rz3GHrMiy8xnDxEvCDuhR12hupeZ+UHvoIU2har21CoKNZDF
	cCy6+OoPxXvT5oLz+KFFpnsbJd34CSL3N11sCSYypLVA7TZeDdZiuBqLOYoc0MBS/Z2a85PE35J
	xDuMXvKI4ifLHkm3OSjNpCdh91oFUM9YJX44MnllJuOudeKojOekjD2+0yFIE7XIm7V8hHM0jyc
	WxOwgQBBpKd8vdbZM45rThL+2tl6oJ6LlHc0wYkGNfi5TSv6X1jdpWx++nHkumqo98O5thkeTLe
	qwbwzF65QTs8rG8elBCSnYw+jxGbZMgM/XzdG2FmuiVIr8gfPMZZueJIvf8AVr20NGdTE1ioQAc
	w==
X-Received: by 2002:a05:600c:4e43:b0:490:be8e:c890 with SMTP id 5b1f17b1804b1-490be8ecff4mr41119695e9.13.1780580091454;
        Thu, 04 Jun 2026 06:34:51 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:eed3:d0ae:8f44:9e49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d6c65sm71326935e9.12.2026.06.04.06.34.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:34:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/5] fetch2: Convert parts of unpack() to use parameter lists
Date: Thu,  4 Jun 2026 14:34:45 +0100
Message-ID: <20260604133446.2528212-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604133446.2528212-1-richard.purdie@linuxfoundation.org>
References: <20260604133446.2528212-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 13:34:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19608

The unpack function makes heavy use of shell pipelines but start the
conversion to avoid shell=True where possible.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 845dd3baab1..58359896602 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1558,7 +1558,10 @@ class FetchMethod(object):
             unpackdir = rootdir
 
         def _run(cmd):
-            ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=unpackdir, env=env)
+            if isinstance(cmd, str):
+                ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=unpackdir, env=env)
+            else:
+                ret = subprocess.call(cmd, preexec_fn=subprocess_setup, cwd=unpackdir, env=env)
             if ret != 0:
                 raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), urldata.url)
 
@@ -1570,36 +1573,36 @@ class FetchMethod(object):
         cmd = None
 
         if unpack:
-            tar_cmd = 'tar --extract --no-same-owner'
+            tar_cmd = ['tar', '--extract', '--no-same-owner']
             if 'striplevel' in urldata.parm:
                 striplevel = urldata.parm['striplevel']
                 if not striplevel.isdigit():
                     raise UnpackError("Invalid striplevel parameter: %s" % striplevel, urldata.url)
-                tar_cmd += ' --strip-components=%s' % striplevel
+                tar_cmd.append('--strip-components=%s' % striplevel)
             if file.endswith('.tar'):
-                cmd = '%s -f %s' % (tar_cmd, file)
+                cmd = tar_cmd + ['-f', file]
             elif file.endswith('.tgz') or file.endswith('.tar.gz') or file.endswith('.tar.Z'):
-                cmd = '%s -z -f %s' % (tar_cmd, file)
+                cmd = tar_cmd + ['-z', '-f', file]
             elif file.endswith('.tbz') or file.endswith('.tbz2') or file.endswith('.tar.bz2'):
-                cmd = 'bzip2 -dc %s | %s -f -' % (file, tar_cmd)
+                cmd = 'bzip2 -dc %s | %s -f -' % (file, shlex.join(tar_cmd))
             elif file.endswith('.gz') or file.endswith('.Z') or file.endswith('.z'):
                 cmd = 'gzip -dc %s > %s' % (file, efile)
             elif file.endswith('.bz2'):
                 cmd = 'bzip2 -dc %s > %s' % (file, efile)
             elif file.endswith('.txz') or file.endswith('.tar.xz'):
-                cmd = 'xz -dc %s | %s -f -' % (file, tar_cmd)
+                cmd = 'xz -dc %s | %s -f -' % (file, shlex.join(tar_cmd))
             elif file.endswith('.xz'):
                 cmd = 'xz -dc %s > %s' % (file, efile)
             elif file.endswith('.tar.lz'):
-                cmd = 'lzip -dc %s | %s -f -' % (file, tar_cmd)
+                cmd = 'lzip -dc %s | %s -f -' % (file, shlex.join(tar_cmd))
             elif file.endswith('.lz'):
                 cmd = 'lzip -dc %s > %s' % (file, efile)
             elif file.endswith('.tar.7z'):
-                cmd = '7z x -so %s | %s -f -' % (file, tar_cmd)
+                cmd = '7z x -so %s | %s -f -' % (file, shlex.join(tar_cmd))
             elif file.endswith('.7z'):
                 cmd = '7za x -y %s 1>/dev/null' % file
             elif file.endswith('.tzst') or file.endswith('.tar.zst'):
-                cmd = 'zstd --decompress --stdout %s | %s -f -' % (file, tar_cmd)
+                cmd = 'zstd --decompress --stdout %s | %s -f -' % (file, shlex.join(tar_cmd))
             elif file.endswith('.zst'):
                 cmd = 'zstd --decompress --stdout %s > %s' % (file, efile)
             elif file.endswith('.zip') or file.endswith('.jar'):
@@ -1608,10 +1611,10 @@ class FetchMethod(object):
                 except ValueError as exc:
                     bb.fatal("Invalid value for 'dos' parameter for %s: %s" %
                              (file, urldata.parm.get('dos')))
-                cmd = 'unzip -q -o'
+                cmd = ['unzip', '-q', '-o']
                 if dos:
-                    cmd = '%s -a' % cmd
-                cmd = "%s '%s'" % (cmd, file)
+                    cmd.append('-a')
+                cmd.append(file)
             elif file.endswith('.rpm') or file.endswith('.srpm'):
                 if 'extract' in urldata.parm:
                     unpack_file = urldata.parm.get('extract')
@@ -1634,8 +1637,12 @@ class FetchMethod(object):
                         raise UnpackError("Unable to unpack deb/ipk package - does not contain supported data.tar* file", urldata.url)
                 else:
                     raise UnpackError("Unable to unpack deb/ipk package - could not list contents", urldata.url)
-                quoted_datafile = shlex.quote(datafile)
-                cmd = 'ar x %s %s && %s -p -f %s && rm %s' % (shlex.quote(file), quoted_datafile, tar_cmd, quoted_datafile, quoted_datafile)
+                bb.note("Unpacking %s to %s/" % (file, unpackdir))
+                urldata.unpack_tracer.unpack("archive-extract", unpackdir)
+                _run(['ar', 'x', file, datafile])
+                _run(tar_cmd + ['-p' ,'-f', datafile])
+                os.remove(os.path.join(unpackdir, datafile))
+                return
 
         if not unpack or not cmd:
             urldata.unpack_tracer.unpack("file-copy", unpackdir)
@@ -1652,7 +1659,7 @@ class FetchMethod(object):
                     if urlpath.find("/") != -1:
                         destdir = urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
-                cmd = 'cp --force --preserve=timestamps --no-dereference --recursive -H "%s" "%s"' % (file, destdir)
+                cmd = ['cp', '--force', '--preserve=timestamps', '--no-dereference', '--recursive', '-H', file, destdir]
         else:
             urldata.unpack_tracer.unpack("archive-extract", unpackdir)
 


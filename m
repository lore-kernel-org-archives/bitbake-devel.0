Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CD6CD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 13:21:49 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20125.1780492905890463625
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Jun 2026 06:21:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aZJdonlC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49068493267so75774025e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 06:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780492904; x=1781097704; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfE7/TElbXR1ZuprQkaJMOSBiQHOiX+8qx0lRf7fJQM=;
        b=aZJdonlCxY89MhASnRzJ7WvFgc31F04uTShcQC3C2pg0mnuUQcBJ9a1VSqE6Rj5EiN
         hhWPxcwRybF4SX4YfkKMg6drseIcef7pDHiLScb/ikYn5Ecs/mgxc2DzU8Ur7jWFQhAd
         sY+SGP8xM0RZrk1lOQszUOxP9LDOwuM5E9Zkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780492904; x=1781097704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfE7/TElbXR1ZuprQkaJMOSBiQHOiX+8qx0lRf7fJQM=;
        b=k7onuTKFAJTX8vLTN3OH8SEMf7XZD9pqPdhmbmj5fHuUGaKUCr7C9h/s9McEA1rGVQ
         sg6FuAtavxGraw6W4H04dax7UqjRaM4tlo1dNV1MgC6esMZ+4QUK3jQZuccW4Z2Ew2Yc
         uBhvBHv7gKEgB3gJoZBUiYgAw+5nJ9auqUNeiqbSsa9eF9QTtV+V0gT9W7apHyCq5v5L
         1qfwBJLr0m5VVgXpjdKlw1wsvU3YCJ1jXbxmD6WWILLnEUhixfmC+gzCVgRgYkpeoflq
         0ghxIIo0JfR0WqEwJ9NImHgxRw4r/2qlszzlfGEIysWlLA/V0t2CiAN5TfCwnl+cCg6Z
         lwoQ==
X-Gm-Message-State: AOJu0YwmYdhYq5Cvn5Y4+ooMFl/dFnSj7t6tVfJtwZRJkzfq3T2SxF/X
	zKCn+g3iySsMPQHXVWAUbTd4sCT2rp4fJrEjUeMQggOykHTd199Dgx52fV7z4bcvU/4TxpOrJhb
	IPjO8
X-Gm-Gg: Acq92OFA0nRtApIr87ORNqlla69SoJB4E6UbZq3ILWH1hZJ8atOy8+9cVqrQj1qBGXq
	tLmZJA1wbt7KFT0quU2dsvSIhARnFM3za0yqjK9kPVKP9EF6aeMHDo9S+Ty+r//UMutVmpaQuCz
	22OX2R9R9fqMBfBKPjxY/Ea89w/dEBUrLYyg50sB/t973NKiWT+6ZGIaRt4JVr452fhVZYe71V7
	IF6Lq6jMBQCV3y6X45cQRSmoLSWtP0wXlbK321nPmbfiKE6cPusxy7K/3n4ln4PZhINYyqvObRd
	7V/CB8WvmM4f0eYvufgsItwlNyDq0nmyGNChhvSFlq2kudTBYkvPLI0jOY/aU4rOHHvZPq7uVT3
	C1yLGuTd8ZF+MkkjnOSIrPE5/Wwr4WvMg/QdX+F2s1hUtktJwkIla6BYC4eN8uvacBgDOxHwlCp
	i5XiV3N/hL+B0maOu6VKtO4CqT8Tp62Iu/o1v5ylOoFeYHSlKtHcSypO60MmuICA==
X-Received: by 2002:a05:600c:35ce:b0:490:b9c3:6c49 with SMTP id 5b1f17b1804b1-490b9c36d9dmr41054635e9.29.1780492903921;
        Wed, 03 Jun 2026 06:21:43 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:202c:df88:9261:8b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7d6b990sm26761725e9.2.2026.06.03.06.21.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:21:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Convert parts of unpack() to use parameter lists
Date: Wed,  3 Jun 2026 14:21:42 +0100
Message-ID: <20260603132142.1076020-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Jun 2026 13:21:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19603

The unpack function makes heavy use of shell pipelines but start the
conversion to avoid shell=True where possible.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 82 ++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 36 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 93d8b1820d8..191049f2127 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1539,6 +1539,32 @@ class FetchMethod(object):
             bb.fatal("Invalid value for 'unpack' parameter for %s: %s" %
                      (file, urldata.parm.get('unpack')))
 
+        env = os.environ.copy()
+        path = data.getVar('PATH')
+        if path:
+            env['PATH'] = path
+
+        # If 'subdir' param exists, create a dir and use it as destination for unpack cmd
+        if 'subdir' in urldata.parm:
+            subdir = urldata.parm.get('subdir')
+            if os.path.isabs(subdir):
+                if not os.path.realpath(subdir).startswith(os.path.realpath(rootdir)):
+                    raise UnpackError("subdir argument isn't a subdirectory of unpack root %s" % rootdir, urldata.url)
+                unpackdir = subdir
+            else:
+                unpackdir = os.path.join(rootdir, subdir)
+            bb.utils.mkdirhier(unpackdir)
+        else:
+            unpackdir = rootdir
+
+        def _run(cmd):
+            if isinstance(cmd, str):
+                ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=unpackdir, env=env)
+            else:
+                ret = subprocess.call(cmd, preexec_fn=subprocess_setup, cwd=unpackdir, env=env)
+            if ret != 0:
+                raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), urldata.url)
+
         base, ext = os.path.splitext(file)
         if ext in ['.gz', '.bz2', '.Z', '.xz', '.lz', '.zst']:
             efile = os.path.join(rootdir, os.path.basename(base))
@@ -1547,36 +1573,36 @@ class FetchMethod(object):
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
@@ -1585,10 +1611,10 @@ class FetchMethod(object):
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
@@ -1598,7 +1624,7 @@ class FetchMethod(object):
                 else:
                     cmd = 'rpm2cpio.sh %s | cpio --no-absolute-filenames -id' % (file)
             elif file.endswith('.deb') or file.endswith('.ipk'):
-                output = subprocess.check_output(['ar', '-t', file], preexec_fn=subprocess_setup)
+                output = subprocess.check_output(['ar', '-t', file], preexec_fn=subprocess_setup, env=env)
                 datafile = None
                 valid_datafiles = ('data.tar', 'data.tar.gz', 'data.tar.xz',
                                    'data.tar.zst', 'data.tar.bz2', 'data.tar.lzma')
@@ -1611,21 +1637,11 @@ class FetchMethod(object):
                         raise UnpackError("Unable to unpack deb/ipk package - does not contain supported data.tar* file", urldata.url)
                 else:
                     raise UnpackError("Unable to unpack deb/ipk package - could not list contents", urldata.url)
-                quoted_datafile = shlex.quote(datafile)
-                cmd = 'ar x %s %s && %s -p -f %s && rm %s' % (shlex.quote(file), quoted_datafile, tar_cmd, quoted_datafile, quoted_datafile)
-
-        # If 'subdir' param exists, create a dir and use it as destination for unpack cmd
-        if 'subdir' in urldata.parm:
-            subdir = urldata.parm.get('subdir')
-            if os.path.isabs(subdir):
-                if not os.path.realpath(subdir).startswith(os.path.realpath(rootdir)):
-                    raise UnpackError("subdir argument isn't a subdirectory of unpack root %s" % rootdir, urldata.url)
-                unpackdir = subdir
-            else:
-                unpackdir = os.path.join(rootdir, subdir)
-            bb.utils.mkdirhier(unpackdir)
-        else:
-            unpackdir = rootdir
+                bb.note("Unpacking %s to %s/" % (file, unpackdir))
+                _run(['ar', 'x', file, datafile])
+                _run(tar_cmd + ['-p' ,'-f', datafile])
+                os.remove(os.path.join(unpackdir, datafile))
+                return
 
         if not unpack or not cmd:
             urldata.unpack_tracer.unpack("file-copy", unpackdir)
@@ -1642,21 +1658,15 @@ class FetchMethod(object):
                     if urlpath.find("/") != -1:
                         destdir = urlpath.rsplit("/", 1)[0] + '/'
                         bb.utils.mkdirhier("%s/%s" % (unpackdir, destdir))
-                cmd = 'cp --force --preserve=timestamps --no-dereference --recursive -H "%s" "%s"' % (file, destdir)
+                cmd = ['cp', '--force', '--preserve=timestamps', '--no-dereference', '--recursive', '-H', file, destdir]
         else:
             urldata.unpack_tracer.unpack("archive-extract", unpackdir)
 
         if not cmd:
             return
 
-        path = data.getVar('PATH')
-        if path:
-            cmd = "PATH=\"%s\" %s" % (path, cmd)
         bb.note("Unpacking %s to %s/" % (file, unpackdir))
-        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True, cwd=unpackdir)
-
-        if ret != 0:
-            raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), urldata.url)
+        _run(cmd)
 
         if iterate is True:
             iterate_urldata = urldata


Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684D3C433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 15:11:13 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.46271.1636384271831145667
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 07:11:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XIoiOv20;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id b12so27471201wrh.4
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 07:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeVEreaWgyK/RXRjI+q93H7BVnXJqFoc2jhb/sX4140=;
        b=XIoiOv20VoY6S6BW1hF9oRGWRVmW0+jpZC22KsYtnqCxZn7S4WYesCjHAeJuGHy+QQ
         kquwWbPlDJ9SwYzXoJV7mKy5vdq4mdCKQ/iiUdE99O48VH+QhlitzdthHAMxSjn7LonD
         UNJy0zRlFKZQ3xEG29elXwX90InLBax4XzEO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeVEreaWgyK/RXRjI+q93H7BVnXJqFoc2jhb/sX4140=;
        b=zHLSRVoiDMwkNlC6MKMn7p/EXv7laafbwR8m4eNDRVIvKn8tUYv+cRLMYkEKv3XsEk
         Ptn5TUMvmHzaL3aKklx/kmkeQiMv36hGEp5Y/d27oIqXUT9POPtWIVYDCiLhFF2iAIfL
         YYYCkq+zUqOuoDZ0WFW62Bn6iUIX1+7y8l/QZcBIqvOkHab/uzgl2sS9cDAHODrGQ3TT
         ccTpGEmd+Meg6hhlLh5wQfZc3E6IgXOUsw8Ada3zXa8ArVnwrFlIJjNH4KYXvvaDTe/Y
         IrFzLbtb72jC/y3oT7SyUA8d/ZZLGKygFc/im+IXC6iz6tCW9KChoQcejSRfwk8+Zxb/
         bc9A==
X-Gm-Message-State: AOAM533QVk4ABKRetFpTNWiCkau4G2xV735VFXKfL8o4FAPqiWzwiqbm
	2Exzi615uk/eGHrWWYKKE8RaS4XE6QNyqA==
X-Google-Smtp-Source: 
 ABdhPJyfXc223x6/MQ9lrGXtRgRJ/BUVHv6yOtq7Olg+Q5AQh7xCXh4tf8343cLb5CjRH7DACi5GFg==
X-Received: by 2002:a05:6000:1862:: with SMTP id
 d2mr481686wri.203.1636384269923;
        Mon, 08 Nov 2021 07:11:09 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:5c39:dba0:779a:3673])
        by smtp.gmail.com with ESMTPSA id
 21sm15858766wmj.18.2021.11.08.07.11.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:11:09 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] fetch2/checksum/siggen: Fix taskhashes not tracking file
 directories
Date: Mon,  8 Nov 2021 15:11:08 +0000
Message-Id: <20211108151108.3733447-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 15:11:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12944

Currently if you have something like:

SRC_URI = "file://foobar;subdir=${S}"

and a file like:

foobar/1/somefile

and then move it to:

foobar/2/somefile

the task checksums don't reflect/notice this. The file-checksum fields
encode two pieces of data, the file path and whether or not the file
exists. Changing the code which uses these fields is problematic.

We can however add a "/./" path element which means "include the bit
after the marker in the checksum" which the path walking code can use
to mark which bits of the path are visible to the fetcher.

I'm not convinced this is great design but it does appear to work.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/checksum.py | 12 +++++++++++-
 lib/bb/siggen.py   | 11 ++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 1d50a26426..fb8a77f6ab 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -50,6 +50,7 @@ class FileChecksumCache(MultiProcessCache):
         MultiProcessCache.__init__(self)
 
     def get_checksum(self, f):
+        f = os.path.normpath(f)
         entry = self.cachedata[0].get(f)
         cmtime = self.mtime_cache.cached_mtime(f)
         if entry:
@@ -84,15 +85,24 @@ class FileChecksumCache(MultiProcessCache):
                 return None
             return checksum
 
+        #
+        # Changing the format of file-checksums is problematic as both OE and Bitbake have
+        # knowledge of them. We need to encode a new piece of data, the portion of the path
+        # we care about from a checksum perspective. This means that files that change subdirectory
+        # are tracked by the task hashes. To do this, we do something horrible and put a "/./" into
+        # the path. The filesystem handles it but it gives us a marker to know which subsection
+        # of the path to cache.
+        #
         def checksum_dir(pth):
             # Handle directories recursively
             if pth == "/":
                 bb.fatal("Refusing to checksum /")
+            pth = pth.rstrip("/")
             dirchecksums = []
             for root, dirs, files in os.walk(pth, topdown=True):
                 [dirs.remove(d) for d in list(dirs) if d in localdirsexclude]
                 for name in files:
-                    fullpth = os.path.join(root, name)
+                    fullpth = os.path.join(root, name).replace(pth, os.path.join(pth, "."))
                     checksum = checksum_file(fullpth)
                     if checksum:
                         dirchecksums.append((fullpth, checksum))
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 578ba5d661..44965c8cca 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -328,6 +328,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         for (f, cs) in self.file_checksum_values[tid]:
             if cs:
+                if "/./" in f:
+                    data = data + "./" + f.split("/./")[1]
                 data = data + cs
 
         if tid in self.taints:
@@ -385,7 +387,12 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         if runtime and tid in self.taskhash:
             data['runtaskdeps'] = self.runtaskdeps[tid]
-            data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[tid]]
+            data['file_checksum_values'] = []
+            for f,cs in self.file_checksum_values[tid]:
+                if "/./" in f:
+                    data['file_checksum_values'].append(("./" + f.split("/./")[1], cs))
+                else:
+                    data['file_checksum_values'].append((os.path.basename(f), cs))
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:
                 data['runtaskhashes'][dep] = self.get_unihash(dep)
@@ -1028,6 +1035,8 @@ def calc_taskhash(sigdata):
 
     for c in sigdata['file_checksum_values']:
         if c[1]:
+            if "./" in c[0]:
+                data = data + c[0]
             data = data + c[1]
 
     if 'taint' in sigdata:
-- 
2.32.0



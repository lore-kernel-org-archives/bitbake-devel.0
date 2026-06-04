Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD72CD6E6B
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 13:34:53 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11718.1780580090182078860
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2026 06:34:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gUOOk3iQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b64c8311so8895335e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780580088; x=1781184888; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S07ch3KPnW04Kay19fV7xvy5hpDM0bdmgUfvzsp87R8=;
        b=gUOOk3iQfayzALrs73/DqMRFggpee7KZ+uE503oHb76kDTzd7epMccbPBSKeYxttrs
         DzA2fLQxwfUNmVchQLt0cvyRWdAWpoZKuuzs1v/gORmrW4FAkKPbJlkEgzIYsUF7xhAb
         WCdagCtWH4qZJIc8pXXcBT8tq0MnOLAmtnSDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780580088; x=1781184888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S07ch3KPnW04Kay19fV7xvy5hpDM0bdmgUfvzsp87R8=;
        b=XQQt4BUTvAscbqMBikFPt3yPfTUX2CzR5ufjbN1dAFn3DANW0pQU3IwQAIzdUacflQ
         jpvwySIpF+FIrc8eRce3W/eRx1o7bhcuscaOpmYcLQMsobe0EF80eazXvjo2CqICqok3
         VTCPd57pfW62GInxhx6w2vN9mwvM/Ce8r9IQZdVY/td1W4WxFI1adH3cDQulCtanuuy9
         O1zHDpsuTk2tYIHyb1pg+J0KHGNQkscfz/ykTtP2clNAym8OhsTOVhhDr7mU91e9Evlk
         CYqvms/RcW7MnseuQNOrUE/0fXa6UcMxEfZts04kBHoA8pHtJvEiGKurgVMGgYupQzrE
         pi/Q==
X-Gm-Message-State: AOJu0YyP6iJg79D+jtLopwbL1/6UnUzstHc7JJdyik3co+4ojCgC5jj1
	Vx8rtQaNuUx4OYsD8xtMKp1JdHfbpbWZt4pSrl/W1oE0NuO2GgFF2jiRlTiArsM/IstPy8hokjd
	jsZAs
X-Gm-Gg: Acq92OF+RVwfPJIArfMrMGyZRCARUqcZ+qRnxrRQSi1lZDAAIuklGkOqsaolCf+L/PO
	RdPYIvfrzqp/BMFIuN+C2sWVR/NnIgiBl4aIqHxffhCMQp8yEdpqOC4jFEsa1oZd/6MyTjYObmu
	TYl3eJIyFXtYMZExnvFwtsaXG4REhnqgespXML8triK2l0FzDJgwlnUQm5S8IYKLcKUv9/FYQ68
	erQ+gj4wvG8UCiiDnJ74sIKmr91OZjYf8n4N2d+tqzZYy5Sw6T9U/XCgdf+TJxNVgMwQrkhEQd3
	dxSyeAzd/ynqIvDgO7pelw1Aoi95LWmQXRGmQ8xoMcnxl5Z/QPVp+iXIhrgQJbCs7EvAxwyCyRU
	HWeP87UeW2namxrsOAHsMGy0MI2ua/fZ9Z/LyF7GREajypqXNCU8PyL4v+vtqlTRPEpxeQifvtr
	y6yPl6nZkXcyyZW9xEbzqCWwUbduLEZlowSOSjmx14GjLMEyZBSgp1tJcXeZFiHeA=
X-Received: by 2002:a05:600c:c490:b0:490:b0df:9eac with SMTP id 5b1f17b1804b1-490b5e94d73mr135690665e9.3.1780580088237;
        Thu, 04 Jun 2026 06:34:48 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:eed3:d0ae:8f44:9e49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d6c65sm71326935e9.12.2026.06.04.06.34.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:34:47 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/5] fetch2: Reorder unpack code to facilitate changes
Date: Thu,  4 Jun 2026 14:34:42 +0100
Message-ID: <20260604133446.2528212-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 13:34:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19605

In order to refactor the function, we need path and unpackdir to be set
earlier in the function. This change just moves code to earlier in the
function.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 93d8b1820d8..d94f54d1bc5 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1539,6 +1539,21 @@ class FetchMethod(object):
             bb.fatal("Invalid value for 'unpack' parameter for %s: %s" %
                      (file, urldata.parm.get('unpack')))
 
+        path = data.getVar('PATH')
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
         base, ext = os.path.splitext(file)
         if ext in ['.gz', '.bz2', '.Z', '.xz', '.lz', '.zst']:
             efile = os.path.join(rootdir, os.path.basename(base))
@@ -1614,19 +1629,6 @@ class FetchMethod(object):
                 quoted_datafile = shlex.quote(datafile)
                 cmd = 'ar x %s %s && %s -p -f %s && rm %s' % (shlex.quote(file), quoted_datafile, tar_cmd, quoted_datafile, quoted_datafile)
 
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
-
         if not unpack or not cmd:
             urldata.unpack_tracer.unpack("file-copy", unpackdir)
             # If file == dest, then avoid any copies, as we already put the file into dest!
@@ -1649,7 +1651,6 @@ class FetchMethod(object):
         if not cmd:
             return
 
-        path = data.getVar('PATH')
         if path:
             cmd = "PATH=\"%s\" %s" % (path, cmd)
         bb.note("Unpacking %s to %s/" % (file, unpackdir))


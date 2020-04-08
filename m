Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.1514.1586387993286919677
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Apr 2020 16:19:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A2BEchls;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id f13so2932644wrm.13
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Apr 2020 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HVaP9V8gwHxx1OVyyv+vsWO3ZJxeCH53umdHJjXCNIo=;
        b=A2BEchlsBNOcGgQv91rmqRJpFoHCD2H1Q2reaOgkOs3vV1Snztys/L4b4toHtyCzO5
         nJM+2OSlbLUT67uUsQb1xSmPzABkQ3j5/ajEsEbsBinsM2biNtaAEEdwnf+HKk5jItWX
         APO7CQ4xynfNeQDkVVcMb3AsuQGj34M23Ei4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVaP9V8gwHxx1OVyyv+vsWO3ZJxeCH53umdHJjXCNIo=;
        b=nITCL2rppfwq71IE4bj3JxQ6AT6i/osymHzXfxAQcJk2xWWQGyLw/EWEiBjLJQry4+
         1efNtrK+nIX4yfa0wamhDpZb4UI8giI6todNhzhR6TAWzhs2eVxqH6dNWU8jFX/aXZpZ
         WlPAVO6lbTVEqjrX1cmQTpTb+mgvLrZX2NwdLaWqNMW0Z/48JmdL5dUdTZuMQGoAVugt
         vJEywiTiWbqRRKR2K1G9+6/4Ebi2MNMnNkrb5b+B28f7yqSWsWmcRZM0tUjgZOmMsYbw
         7JbEqniZEo7aHio9yEFPNt4ZKcb7pcyKKWR9J2t+t/wgu3D1I+OcboS1a4l+YbQgHw0w
         LyeQ==
X-Gm-Message-State: AGi0PuayhzbPYO64b9VwJ45dblbIeWma0DxspdKwNtRWx4LhqNZkZ5tW
	Zz3iQCpk3GPE/3+g3m9e0TccWdBr0AQ=
X-Google-Smtp-Source: APiQypIrirEvCtIQJPmx223ohw6Q8rvHorzzITdrSSHMvK48KkOFMlvmlBrv/rfmYiee2HeuCNs89Q==
X-Received: by 2002:adf:fad0:: with SMTP id a16mr711333wrs.149.1586387991550;
        Wed, 08 Apr 2020 16:19:51 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id z16sm3904895wrl.0.2020.04.08.16.19.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 16:19:51 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cache: Fix performance problem with large numbers of source files
Date: Thu,  9 Apr 2020 00:19:49 +0100
Message-Id: <20200408231949.393761-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408231949.393761-1-richard.purdie@linuxfoundation.org>
References: <20200408231949.393761-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some companies are using large numbers of patch files in SRC_URI.
Rightly or wrongly that exposes a performance problem where the code
does not handle the large string manipulations in a way which works
efficienty in python.

This is a modified version of a patch from z00539568
<zhangyifan46@huawei.com153340508@qq.com which addresses the performance
problem. I modified it to use a more advanced regex, retain the "*" check
and cache the regex.

[YOCTO #13824]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index a5aaf3b999..d1be83617b 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -21,6 +21,7 @@ import logging
 import pickle
 from collections import defaultdict
 import bb.utils
+import re
 
 logger = logging.getLogger("BitBake.Cache")
 
@@ -369,6 +370,7 @@ class Cache(NoCache):
         self.data_fn = None
         self.cacheclean = True
         self.data_hash = data_hash
+        self.filelist_regex = re.compile(r'(?:(?<=:True)|(?<=:False))\s+')
 
         if self.cachedir in [None, '']:
             self.has_cache = False
@@ -607,20 +609,12 @@ class Cache(NoCache):
         if hasattr(info_array[0], 'file_checksums'):
             for _, fl in info_array[0].file_checksums.items():
                 fl = fl.strip()
-                while fl:
-                    # A .split() would be simpler but means spaces or colons in filenames would break
-                    a = fl.find(":True")
-                    b = fl.find(":False")
-                    if ((a < 0) and b) or ((b > 0) and (b < a)):
-                        f = fl[:b+6]
-                        fl = fl[b+7:]
-                    elif ((b < 0) and a) or ((a > 0) and (a < b)):
-                        f = fl[:a+5]
-                        fl = fl[a+6:]
-                    else:
-                        break
-                    fl = fl.strip()
-                    if "*" in f:
+                if not fl:
+                    continue
+                # Have to be careful about spaces and colons in filenames
+                flist = self.filelist_regex.split(fl)
+                for f in flist:
+                    if not f or "*" in f:
                         continue
                     f, exist = f.split(":")
                     if (exist == "True" and not os.path.exists(f)) or (exist == "False" and os.path.exists(f)):
-- 
2.25.1


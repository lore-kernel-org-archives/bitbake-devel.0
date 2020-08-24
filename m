Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web11.197888.1598284128948358779
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 08:48:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=pkE6gATv;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id 92so1057742qtb.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phW9Hr7QyEHR9An/b8NDgr/ogmcIV3Ixp6dbIPb4GDg=;
        b=pkE6gATvixEfSQAN/XuIIKZM97YpNaMJcxb/h6+V8lBXlj20Nm7bHjNPiGe5cFfwTm
         2bn2YRPLUrPM4fl7aTL6ajJe00UwIjMoHlEt3wmWdkAMKJQaYbcxLrhcm95hiMVXx2tS
         yyj45QPoa76wMq3/CfiHX/rlPmwGGZVngYlIH6a10y2HgA+69vBDTpU9zH1eRRtqMsNZ
         5CxS70b6tNj+lcTDUnuN0q7HadffSDdykic43DPRtWdPoB3q3OF2TG2juOSxEFPCgM3N
         HLQR1TKw4hMTBZCc16XQtmduzBRuEFV1oZhUx2dHZn6j/nejjuwQwJgK2zW3bk67SSZI
         nq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phW9Hr7QyEHR9An/b8NDgr/ogmcIV3Ixp6dbIPb4GDg=;
        b=Bfb8zxUOactm90i27/Ow7UDTzHeOX4skeI0qUVaUDxfZ38KPWi0X/RLqSjPPsmvx2h
         9R2bUPTFlIWmdq4keR8FnTRuPkb06CAxvVWefJFbv9N8EMMgZIPYbjDjl8j/K2fZJHBU
         gLaI+wpBkUxxpmzlyAMn4BPX2fNLa/TsX7dSQ3K9g9t3FsXFN2G37Yt/xmpaJ/eoUFFy
         zXaR0ZBmN8qXFarIm+PtxfOx8JabqVqyIekAWdWBSgL3o6Jw832XEy3g/AkGb0UXhkKi
         5f4ONStcOS1otb9/dNs1+7bQ7DB0Bg5qgaFwyhO5fA3QQiHIInhqkVRxwmnsAM7tUR5W
         HONQ==
X-Gm-Message-State: AOAM532sRlckoL5f59Jg00JUaD9CsIsXsrm77UVQxb8l9S+M3wmcUm3R
	uvSwEI/9Daiwx6ZKdr3UnPrYPmXrYzK1WQ==
X-Google-Smtp-Source: ABdhPJzKd8HsAGzy3lhfYNoE39iq+zlbsiVx+1ucpm10Ssr8Mla0zDVlHi/+3CTIlc4WtBpeImUBpg==
X-Received: by 2002:ac8:2962:: with SMTP id z31mr5213636qtz.88.1598284127936;
        Mon, 24 Aug 2020 08:48:47 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id x13sm11116119qts.23.2020.08.24.08.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:48:47 -0700 (PDT)
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org,
	Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
	=?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Subject: [PATCH 2/2] bitbake: siggen: clean_basepath: improve perfo and readability
Date: Mon, 24 Aug 2020 11:48:36 -0400
Message-Id: <20200824154836.23600-2-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824154836.23600-1-jeff.dagenais@gmail.com>
References: <376560ff987c4585f7f21c2cae4c8f50451ad743.camel@linuxfoundation.org>
 <20200824154836.23600-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This change improves performance by reducing runtime about 33% for typical
inputs. (using test_clean_basepath_performance)

It is also easier to read, and slightly more resilient to future changes since it doesn't
mention 'virtual' anymore.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Co-Developed-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
Sigend-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
---
 lib/bb/siggen.py | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index ad49d1e2..1456324a 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -746,16 +746,26 @@ def list_inline_diff(oldlist, newlist, colors=None):
             ret.append(item)
     return '[%s]' % (', '.join(ret))
 
-def clean_basepath(a):
-    mc = None
-    if a.startswith("mc:"):
-        _, mc, a = a.split(":", 2)
-    b = a.rsplit("/", 2)[1] + '/' + a.rsplit("/", 2)[2]
-    if a.startswith("virtual:"):
-        b = b + ":" + a.rsplit(":", 2)[0]
-    if mc:
-        b = b + ":mc:" + mc
-    return b
+def clean_basepath(basepath):
+    basepath, dir, recipe_task = basepath.rsplit("/", 2)
+    cleaned = dir + '/' + recipe_task
+
+    if basepath[0] == '/':
+        return cleaned
+
+    if basepath.startswith("mc:"):
+        mc, mc_name, basepath = basepath.split(":", 2)
+        mc_suffix = ':mc:' + mc_name
+    else:
+        mc_suffix = ''
+
+    # mc stuff now removed from basepath. Whatever was next, if present will be the first
+    # suffix. ':/', recipe path start, marks the end of this. Something like
+    # 'virtual:a[:b[:c]]:/path...' (b and c being optional)
+    if basepath[0] != '/':
+        cleaned += ':' + basepath.split(':/', 1)[0]
+
+    return cleaned + mc_suffix
 
 def clean_basepaths(a):
     b = {}
-- 
2.28.0


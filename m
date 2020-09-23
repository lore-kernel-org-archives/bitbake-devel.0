Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web12.14164.1600868804020762066
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2020 06:46:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=NsxSp/U9;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: jeff.dagenais@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id 16so22821226qkf.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2020 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9X6gipvf2rIx0GOdw+0XgFxQePZVnZ7O6nvM+0OFIuY=;
        b=NsxSp/U9iqQkbj6AV2U2Jli/Ny0qq+zzSWdpZilBGNbCbBcnQC9gdQyixaiffA4NkA
         aNRoPWdyicqBEDB0J50l7a1uS6G86m+MeQ7Lbn9hnkYDBKNsKtcC7kO4d3+L5UJW4PxA
         iL0bff2HCzrjU2bfVBP/h65+kkqyE9hVm6qkKq7Ni2skOTc/vGem9oQd1bMLXBw1Vtim
         lDrBJBw9ypRAV1Y7QKJTrfXdtPsIQJyW7OjJcUhTZqRhmKUA33gsVXil51rcS/oa0cPt
         YAocpgBaA2w3C/Z8CS7WeU2dirGWcuOZbFzmI0l6JEumqGkYfQwM/Ikv+4BEKjACNmw/
         wzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9X6gipvf2rIx0GOdw+0XgFxQePZVnZ7O6nvM+0OFIuY=;
        b=el2dDCsJLygac7TTcYasTRkAcnlEYjt76AY2ZRTRY5i70+lMtUL3N4Lquqes9QMguW
         UnhTezVu7rLnxltUz3dgc8x6qtKFrT1rnLEvC3bzwFydYkYsk6bVcvcu2Ik2zEoRwGxh
         n16Qw7zdMFlSlDrYVegNKHXQx9e4OAsXUE37+g/LLQ1FXDtoL1BnbJX3nO00EtJPOV8r
         YA9/Mdx3pE6OXvLEgHuXs/oa0QrdsbcEJ0xiRBquE9jsFLlMgO1gWzRG+/hLpnH4mrzX
         aXDdgnm+MpcEJMlFyVIKd5WY11ztlLlLHvX8/XatQGPQ0ZsuORVOCY3d5vuumxj6tlro
         0V+Q==
X-Gm-Message-State: AOAM530mzJRs7VmZ9sosGFDpW9GzjnZ/YiWXSDdUq8tY5z6WR5jhPtI+
	jbdY8IqQGPxM9r8ICso4snMTeF5t/pDglA==
X-Google-Smtp-Source: ABdhPJypdgjbh30zKiO+dfChNL5oBXaWUnGGTzU4YEV+wEZif2A1jowFofB1MIiq6vB9oG4LXTkniQ==
X-Received: by 2002:a05:620a:15ac:: with SMTP id f12mr8222172qkk.19.1600868802622;
        Wed, 23 Sep 2020 06:46:42 -0700 (PDT)
Return-Path: <jeff.dagenais@gmail.com>
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id z7sm4948885qtc.10.2020.09.23.06.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 06:46:41 -0700 (PDT)
From: "Jean-Francois Dagenais" <jeff.dagenais@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org,
	Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
	=?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Subject: [PATCH 2/2] bitbake: siggen: clean_basepath: improve perfo and readability
Date: Wed, 23 Sep 2020 09:44:06 -0400
Message-Id: <20200923134406.19362-2-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923134406.19362-1-jeff.dagenais@gmail.com>
References: <376560ff987c4585f7f21c2cae4c8f50451ad743.camel@linuxfoundation.org>
 <20200923134406.19362-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This change improves performance by reducing runtime about 33% for typical
inputs. (using test_clean_basepath_performance)

It is also easier to read, and slightly more resilient to future changes since it doesn't
mention 'virtual' anymore.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Co-Developed-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
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


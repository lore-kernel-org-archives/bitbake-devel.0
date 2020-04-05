Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web11.17651.1586095348504999677
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Apr 2020 07:02:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YyoND5sJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id p10so14197540wrt.6
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Apr 2020 07:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rfkDAOY4v8jFOTlIYlo97UsEUizMvS7gat+Mb6YhStA=;
        b=YyoND5sJHgumbrNBdhoc1jr+88wvK7QOmB2eCjx1Z6Mw2vSNfZKpCCsqw9gxLb0C3I
         blHetjLRxtKkYOTdDVxzUeVSsXF/J56R+u2/lOv1OK3keNasexGnDCGdQIizDgIrecTl
         M+V0pVu36gmzzBlZ2phXu03jZfFVZDV2+trng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rfkDAOY4v8jFOTlIYlo97UsEUizMvS7gat+Mb6YhStA=;
        b=WAQ98E+oioe9K+19SWY2Mb+gX1ycBcNZpFi2D0aQQ5p+1Dr5kxjUNSY30wwHjbOBPU
         ev5e0yUIlO8ODRG23x2/1TvXvQA0L659pzuzfqjs2AM4dwCjj5l0arbPq91bYEkxalqg
         8DSx+C+aPzZD6U0SAWbMbzVh9jVGTcW0KuleLGDIkOnXvJwxK+ErUg3s1yDpTJ4J/5NA
         6WhdCnXIjTZu1e/gEhgkfGupuFKtTozmz185Z5W327Qt5KWBXUZ97ruMybXWcWSdlSBN
         He7yNPXQzsLlbOBpciGlKJT31+sUyt19xNyh+yNCyNOysy9H1EePbVXiOJ5cm2+vLHJD
         7YdQ==
X-Gm-Message-State: AGi0PubkBFROJ0ve0/uxtS+NlzuxNITvbwfyZ4KEpH4Z3yI7MbwEyCd0
	630BpEND8TqQyFTEXkvP/38vMTtrWQo=
X-Google-Smtp-Source: APiQypLZNARVU9u9/CgTF0GGVks71xzlamfhu+sdgWDFxzH38vHZiBZTEouDCovgpE8b0rQW7BHPVA==
X-Received: by 2002:adf:9168:: with SMTP id j95mr18288954wrj.145.1586095346789;
        Sun, 05 Apr 2020 07:02:26 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id 9sm19662178wmm.6.2020.04.05.07.02.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 07:02:26 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tinfoil: Add back ability to parse on top of a datastore
Date: Sun,  5 Apr 2020 15:02:25 +0100
Message-Id: <20200405140225.235686-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option was removed recently as we didn't realise the layerindex
relies upon it. Add back the API which it turns out can be supported
as long as we assume the datastore passed in is a remote datastore
which it usually would be unless created locally.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 3 +--
 lib/bb/tinfoil.py | 7 +++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 2879950933..6abf38668b 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -499,8 +499,7 @@ class CommandsSync:
         appends = params[1]
         appendlist = params[2]
         if len(params) > 3:
-            config_data_dict = params[3]
-            config_data = command.remotedatastores.receive_datastore(config_data_dict)
+            config_data = command.remotedatastores[params[3]]
         else:
             config_data = None
 
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 1164ee6014..7d53608b21 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -617,7 +617,7 @@ class Tinfoil:
         fn = self.get_recipe_file(pn)
         return self.parse_recipe_file(fn)
 
-    def parse_recipe_file(self, fn, appends=True, appendlist=None):
+    def parse_recipe_file(self, fn, appends=True, appendlist=None, config_data=None):
         """
         Parse the specified recipe file (with or without bbappends)
         and return a datastore object representing the environment
@@ -635,7 +635,10 @@ class Tinfoil:
         try:
             if appends and appendlist == []:
                 appends = False
-            dscon = self.run_command('parseRecipeFile', fn, appends, appendlist)
+            if config_data:
+                 dscon = self.run_command('parseRecipeFile', fn, appends, appendlist, config_data.dsindex)
+            else:
+                dscon = self.run_command('parseRecipeFile', fn, appends, appendlist)
             if dscon:
                 return self._reconvert_type(dscon, 'DataStoreConnectionHandle')
             else:
-- 
2.25.1


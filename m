Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C286C433F5
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 16:39:55 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.153.1648658394673164921
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Mar 2022 09:39:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=W0HMbKye;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f174.google.com with SMTP id p17so20929538plo.9
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Mar 2022 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NOG5VUjgbBEU/P9kFDLaVWN0rKBZ0l2OkUqfofK2Fy8=;
        b=W0HMbKyeT3KA+wNphEvFRla+KIRBmwNskzuVzA8bV9/1DqPKcZTu26Xtq829Fw8eVQ
         hdNOiALC44Ix0vWs6zcRDAeIaBEKNastLmBWLeCqIqE1LkY7yI3IcOaKYnIWa2MwO+7w
         uoiA3NNW7nmKmv8RAbgvIgxkXJnhwnYFBVrm6A4NVRxs0NMw3q66YgKcmmOR9s/qhB3y
         tLsMKldZz1dLxq+jThJ7NCLNmlXvB1/WSpNI3yMGhTdreKdg1T1e2iT95JUX6iEul6Tb
         MOtphPwZINQdPNsRYa997isNCRul4kBgIScVkcp3qUX5zU5AzEUGY5/YamaMwEbYPLzl
         nOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOG5VUjgbBEU/P9kFDLaVWN0rKBZ0l2OkUqfofK2Fy8=;
        b=5anX6JivykKMoYFfkZvK3eds2BUizEsvv1nTJ9oQUzwfvPaTjo9NDpOLlLEitCmXyO
         nkEDJCO2X/mW4YTbF3dzXB4PKiqlkNE4WtM5sBt4J/f1dyi44KX0OiAQHomrAkBfahjX
         VacS/EMSvlOmbR7+qdYPk1pyLFznzVZnB2l0zfvcJEumD/w3k09wk1FjPJHVCemW6KNn
         Jf2zGzgNGrlIfOZ4F9pnCDJZ9KdJBiHx7ICkQZGAxd8whK7sLiP/vL2WYmdnasL7s/Sv
         xi1/Q39v2x3EiNlPQelguwjDN4Xa3ZLL5pF9XFtUxtC2mRDBWsAJkQ+vhWJfVgmqmSya
         2OUA==
X-Gm-Message-State: AOAM530RKmViPxRosnfLNP77+tgQVn95W0BzbdkwW9bBaJJYN5627BBb
	CH2tujk7JLS3MlhX33FxkV8GhyS6xB/5bvCfm1Q=
X-Google-Smtp-Source: 
 ABdhPJy3dgx9eZei2sQdIXge9QubbrT9Zo7fiBG7Mk11quSxxj+U5ANkxz4G1gf0v7UgbyQQla4l9w==
X-Received: by 2002:a17:90a:3e4e:b0:1c6:586a:4d6a with SMTP id
 t14-20020a17090a3e4e00b001c6586a4d6amr407263pjm.214.1648658393774;
        Wed, 30 Mar 2022 09:39:53 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 a16-20020a17090a6d9000b001c9c3e2a177sm6815030pjk.27.2022.03.30.09.39.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:39:53 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/1] fetch2: add check for empty
 SRC_URI hash string
Date: Wed, 30 Mar 2022 06:39:38 -1000
Message-Id: 
 <2cfc128b583a6e7f44f095fff0cd1e4e937f3790.1648658231.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648658231.git.steve@sakoman.com>
References: <cover.1648658231.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Mar 2022 16:39:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13552

From: Scott Weaver <weaverjs@gmail.com>

No error was being reported when the hash string was set to empty.
For example: SRC_URI[md5sum] = ""

On a related note (not a bug):
Because whitespace in the string will result in a checksum mismatch, the error
message was updated to make it a little clearer why the error was thrown.
For example: SRC_URI[md5sum] = " " or
SRC_URI[md5sum] = " 209f8326f5137d8817a6276d9577a2f1"

Now creates a message like this:
File: '/home/scott/yocto-cache/downloads/rsync-3.2.3.tar.gz' has md5
checksum '209f8326f5137d8817a6276d9577a2f1' when ' 209f8326f5137d8817a6276d9577a2f1' was expected

[YOCTO #14232]

Signed-off-by: Scott Weaver <weaverjs@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a13510d0028e234ea2f4744b0d0c38558395c70f)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index dc99914c..3e6555bd 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -562,6 +562,9 @@ def verify_checksum(ud, d, precomputed={}):
 
         checksum_expected = getattr(ud, "%s_expected" % checksum_id)
 
+        if checksum_expected == '':
+            checksum_expected = None
+
         return {
             "id": checksum_id,
             "name": checksum_name,
@@ -612,7 +615,7 @@ def verify_checksum(ud, d, precomputed={}):
 
     for ci in checksum_infos:
         if ci["expected"] and ci["expected"] != ci["data"]:
-            messages.append("File: '%s' has %s checksum %s when %s was " \
+            messages.append("File: '%s' has %s checksum '%s' when '%s' was " \
                             "expected" % (ud.localpath, ci["id"], ci["data"], ci["expected"]))
             bad_checksum = ci["data"]
 
-- 
2.25.1



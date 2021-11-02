Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF06EC433F5
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 14:57:47 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web12.931.1635865066936626156
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=J8Yu7GqL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 133so6652309wme.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KeQ6eYOte877s0N9AGolz2QrllC7D0TGblYihB2gcUc=;
        b=J8Yu7GqLk5J7QbeopfMSGUm0GukZ5uwetGsur/UcVmYdA0ImQV6+ZGLlH0YmwFLsf7
         ZiVrFlGLIUCLewlP4dfxVTbavMmN6aWNANZnrUlHMRk/34apURGGJxIYBgWCl87gl+ZX
         Ktm1ZDVn3F5WbvEW4iPs89lW4B3RXxfrg4igI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KeQ6eYOte877s0N9AGolz2QrllC7D0TGblYihB2gcUc=;
        b=D6+XXm+xkULhOkZGDPB6rh8gx6y62tny0m+jnFycLXHlHnYQIvoiAkqhChkUzS5UC8
         crUCMp2p7GSkrPWLV4E5r33yYc0vgxpxKfjh+xq/wfl8HQSS1DCHKzbpv2iRlYE0rsKb
         Y/U7RvtnrLtr1+Q0nBhrQ7t3bg6SxVTczqNHYsqVihkPOEFzqn5yIgO7beVlWu0Zs3Di
         9Oc1D+tK5YdpTkQuHjUGJXNLd+O4l2uO/YMX/u/FqbtY4mX/AFaW2LXAELvIcqfwPntm
         TEkRSF86+lER2OpLthRLUa3G0X01uQHlEo9glouGIlDzCYYI2zN76YxFuGopNGTubLG3
         5RAg==
X-Gm-Message-State: AOAM5304V76GJxeGgcXi1+/dRCiS/bXQcs25nv/jNbDwDvpKJpt7JkXU
	TB1PseB51vwp/slpGUEDNFWGDR+MVtsgIg==
X-Google-Smtp-Source: 
 ABdhPJz6xJJKKhbOmDZZXpBOQ9NwxECQntKpa2KXSO2DulgL/HdrkZP24BWhrT8C2+nWUL9Tr6rF4Q==
X-Received: by 2002:a05:600c:354b:: with SMTP id
 i11mr5709643wmq.61.1635865065225;
        Tue, 02 Nov 2021 07:57:45 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:e05:60cd:475e:19f5])
        by smtp.gmail.com with ESMTPSA id
 q26sm14916634wrc.39.2021.11.02.07.57.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:57:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/5] fetch: Handle mirror user/password replacements correctly
Date: Tue,  2 Nov 2021 14:57:41 +0000
Message-Id: <20211102145742.3550251-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211102145742.3550251-1-richard.purdie@linuxfoundation.org>
References: <20211102145742.3550251-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 14:57:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12866

Username or password replacements in URIs were being appended rather than
replaced in mirror url remapping. Fix this and add a test case.

[YOCTO #13823]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 4 ++++
 lib/bb/tests/fetch.py     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 43b312ce7e..6a38cb0955 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -430,6 +430,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
     uri_replace_decoded = list(decodeurl(uri_replace))
     logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
     result_decoded = ['', '', '', '', '', {}]
+    # 0 - type, 1 - host, 2 - path, 3 - user,  4- pswd, 5 - params
     for loc, i in enumerate(uri_find_decoded):
         result_decoded[loc] = uri_decoded[loc]
         regexp = i
@@ -449,6 +450,9 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                 for l in replacements:
                     uri_replace_decoded[loc][k] = uri_replace_decoded[loc][k].replace(l, replacements[l])
                 result_decoded[loc][k] = uri_replace_decoded[loc][k]
+        elif (loc == 3 or loc == 4) and uri_replace_decoded[loc]:
+            # User/password in the replacement is just a straight replacement
+            result_decoded[loc] = uri_replace_decoded[loc]
         elif (re.match(regexp, uri_decoded[loc])):
             if not uri_replace_decoded[loc]:
                 result_decoded[loc] = ""
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 29a952f286..918fec9134 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -431,6 +431,10 @@ class MirrorUriTest(FetcherTest):
         ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake;branch=master", "git://git.openembedded.org/bitbake;protocol=http")
             : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
 
+        ("git://user1@someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake;branch=master", "git://user2@git.openembedded.org/bitbake;protocol=http")
+            : "git://user2@git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
+
+
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"
         #("file://sstate-xyz.tgz", "file://.*/.*", "file:///somewhere/1234/sstate-cache") : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
-- 
2.32.0



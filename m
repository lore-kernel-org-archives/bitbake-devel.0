Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web09.8928.1632493358680989164
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Sep 2021 07:22:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=jOt8AEtW;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.176, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f176.google.com with SMTP id w19so8982520pfn.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Sep 2021 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RDOGqxa3K8XEbLnR3QmBKTWuvbnFuCvjzblVMYeyBp8=;
        b=jOt8AEtW193yfb1eXrM4aBItqmxk6HHb4/dM7065XKzTPZ+J5ekK6x6RlP5eP2qnZW
         HhphaZeQLuwxr+xYP3hDAWglUuThD0K58tSUnbA7vzao4KT8eAZKbHyKIhAsWu7JMGA/
         /1wJSQZlr2iQoHmWwtCKItooKq//fMmtjQmLX6mAzrGBSIuXiFavt/zUZRmmrnaY3ELM
         qUeD0p43zaL9PZLxR5gMl6lQHC+rpmEJscgiO9sS0pAukcK8W5yGyYbLIKnD2xHs8EOF
         gHhWyaJR0z3GJmWZTziqY/IlvcvlRaW1Ug4drmgfFHP/zvWhjCLJEOnm3JUSQw9xP7Xr
         twZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDOGqxa3K8XEbLnR3QmBKTWuvbnFuCvjzblVMYeyBp8=;
        b=7HhFgEY3hiWVb5rQZoN0/RBKYrbwQDN0sdZETcC+s3UuPREQBQLhTbGT78K4FBphm2
         l9Ol3OMDFXmj9M0i1Sb/VXWOzdBE3WO80234OP06dCRdVfQwXcJKutIJ3azMyCKRQ5Aj
         IXemm91pDU+7IlrDUvsIkUlENw++h13PRhtbPn4sVxTJd2zCTg1Xg9n2mPS8vhJ4SNLG
         2hJ8XqpsG8bF4CARbm3VB8DVEnwhVM3BzI9F7dNH+YEY4F8/LZCQWuy9U4PKSquXpml3
         G9Uvnxx4vMnJ0VftwhjNvGBCuSKDlsM4+tHebfZ03y7BEkpynl/+ypBCRW+o00vwAF83
         v34Q==
X-Gm-Message-State: AOAM530swhi0rqkuF/gY/Ui3bWuYRZl8l0FCFXFt6sKsurNeLTiy8YU9
	BOU4pV0OLNusHJN09roMZIgBTQOSID/X5cOUNbM=
X-Google-Smtp-Source: ABdhPJx/daiPw3T/w5OFncUb5m0GAzUonBTGAHEwg1MiJM1qyW80H88cU/jFqZfoiQdNL1XAZOF8/A==
X-Received: by 2002:a05:6a00:1586:b0:447:b30c:4a65 with SMTP id u6-20020a056a00158600b00447b30c4a65mr9975593pfk.0.1632493357744;
        Fri, 24 Sep 2021 07:22:37 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id j20sm9907347pgb.2.2021.09.24.07.22.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 07:22:37 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 11/14] cookerdata: Improve missing core layer error message
Date: Fri, 24 Sep 2021 04:21:04 -1000
Message-Id: <45e397e9b5cc290345402ab26aa1ab7625d7bb09.1632493110.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1632493110.git.steve@sakoman.com>
References: <cover.1632493110.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the core layer is missing from bblayers.conf, the message the user sees is
hard to understand. Improve it.

[YOCTO #14340]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 5815a7258ebb8a989e0c6f5798853559d9413f02)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/cookerdata.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 472423fd..44af7b2a 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -399,6 +399,8 @@ class CookerDataBuilder(object):
                 if c in collections_tmp:
                     bb.fatal("Found duplicated BBFILE_COLLECTIONS '%s', check bblayers.conf or layer.conf to fix it." % c)
                 compat = set((data.getVar("LAYERSERIES_COMPAT_%s" % c) or "").split())
+                if compat and not layerseries:
+                    bb.fatal("No core layer found to work with layer '%s'. Missing entry in bblayers.conf?" % c)
                 if compat and not (compat & layerseries):
                     bb.fatal("Layer %s is not compatible with the core layer which only supports these series: %s (layer is compatible with %s)"
                               % (c, " ".join(layerseries), " ".join(compat)))
-- 
2.25.1


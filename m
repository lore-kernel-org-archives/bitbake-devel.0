Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web08.579.1611601796397911203
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jan 2021 11:09:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=pqcz564m;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id g15so211812pjd.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 25 Jan 2021 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yPR1K5vULoNL1xXci31nb8rA30SN6OVbc2rsDZ49Pxo=;
        b=pqcz564mqwctJq67BiS/XMsKAJDvMSvj5rNpDCBR1uPb02EbzMPJImHKEFg7SLWx/3
         oA0vV0NtyGNFS7YDBl1Q7S4+FQ/TIXruGqOCAfXnV/n6AVCsl2bHFsoSLFX7A2in5VUf
         qorthScqZyilRNunhInLeumeD3mg0FGkp/hVFifV7FvZ50L5RIsDxbyo4iMH5p93u1C6
         X1T3Www58ImRqlvxw9Abyv4g2yPJWPf2mbI4R3RDEcqH+TECIm0wwSIiew29MezylRE5
         UeDvsc9YqAEr0Is3lBCtU6pYPbapgpjHHKxJUNSWqKCn+6Q8XxxbbObJx90f/rLluqKK
         4mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPR1K5vULoNL1xXci31nb8rA30SN6OVbc2rsDZ49Pxo=;
        b=rgAx59rIkc5HcDKrnJzfXBLPqK7Xhzg/LWgxYwFsqC/nG/sDnhPNiRVbYJaIRBAXGd
         /RbhR0h5AwoTquUDDCleK3XjuZV7sa0YFN+e3u5pth6pvA0sFJ/kbSEXcfhn1T17HSOn
         C8z7a/wQgutsh3uW8dMMVkYrTTLFG58Y6ON4rkmMlcezH1QRLgPOaoGS7Qq2Crzgvagb
         nts9LA2aEKeFSEt3l45EQJgPMcTueu/JIaFy6WyaL8vZSn4GOMjUdXsMeGJmQZhYuB/z
         3x3Ob8PhBm8LlkNJvxDOR/sJQkjlEfhMel1uYmlYR3C82Z4svhTWWD4uNHb5pROpwx2j
         vlBw==
X-Gm-Message-State: AOAM533U/Th69P7dDzi8hRKQld1K1/eK4RFAFAAzaVN86xVsEzgVNFPL
	lHkTyplIq+rKoJzADAuEvVR8yDoeuJBq9Amv+2E=
X-Google-Smtp-Source: ABdhPJxi4ka1Hj3F9rgTfcTZSZ3jhX2t8sZ9uBxnkgomNl0D5+/tv/OiiecJ2EegOBwA4m9obEoikA==
X-Received: by 2002:a17:90a:f98c:: with SMTP id cq12mr1652869pjb.191.1611601795395;
        Mon, 25 Jan 2021 11:09:55 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id e123sm16614637pfe.78.2021.01.25.11.09.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:09:54 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH] data_smart: Ensure hash reflects vardepvalue flags correctly
Date: Mon, 25 Jan 2021 09:09:38 -1000
Message-Id: <39a42e340f74099211dc0870482c40ad3f47b899.1611601598.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611601598.git.steve@sakoman.com>
References: <cover.1611601598.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The get_hash() function is used to decide if the base configuration has changed
and hence whether a reparse is required. The vardepvalue flag's value was not
expanded but it is often used in contexts like:

METADATA_REVISION = "${@base_detect_revision(d)}"
METADATA_REVISION[vardepvalue] = "${METADATA_REVISION}"

which in it's unexpanded form means reparsing doesn't happen when it should
as the data appears unchanged. Update get_hash to expand the values of
vardepvalue so reparsing works as expected. This avoids basehash mismatch
errors such as the one recently caused by using METADATA_REVISION in poky.conf's
DISTRO_VERSION variable. The issue there could be exposed by a recipe using
DISTRO_VERSION with the sequence:

bitbake os-release
<change the revision of the metadata with a dummy commit>
bitbake os-release -C install

which was caused because METADATA_REVISION changed but the metadata didn't reparse.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 26ccf1575aef2d6e2d7717d3bd10b1ed0d5a777d)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7f1b6dcb..1d8774ee 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -1005,7 +1005,7 @@ class DataSmart(MutableMapping):
             else:
                 data.update({key:value})
 
-            varflags = d.getVarFlags(key, internalflags = True)
+            varflags = d.getVarFlags(key, internalflags = True, expand=["vardepvalue"])
             if not varflags:
                 continue
             for f in varflags:
-- 
2.25.1


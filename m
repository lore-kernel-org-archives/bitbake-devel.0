Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web12.9331.1632047552475247828
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 19 Sep 2021 03:32:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JxMXX+42;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id x6so23198474wrv.13
        for <bitbake-devel@lists.openembedded.org>; Sun, 19 Sep 2021 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q/WFajcomWJyx/MFzwhFvn29eL6uutzM+Lyq51xdhoQ=;
        b=JxMXX+42LZ/DgUWk96UdpVDMsJPvLnDhCpxar0JSnIjNQxFzlu7nhrst+ExioAv3/G
         WL5vwX3k/doJaa8SEuSyc7U//HIBohKec9QQbqCHv5RzXdsHwu5Udg7v7A4oafVRtXQB
         PeYReK406+aBW+ugMHsob3tUZ4u8xYXjE7mzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/WFajcomWJyx/MFzwhFvn29eL6uutzM+Lyq51xdhoQ=;
        b=Pa/Edm5z6A6iL63kNMUaEV+G/SUuM1ZWlWdhr5w/FJOeW1a3qb3hrNlhw34bEKSums
         2vPi8ssGkQobnEcdUjZVn+nyytrPAtWK9wF0APridtObcaXr7RHvY17R2fI7RHPxRogt
         PN6g+s9ji8jN/Sc4jJbIyr/fm3suXARFCuCUSids5hC6hM61IYFVA+KAiqqTiqhMGjq8
         n99D2cP6+78s37etc+Cdi3d+CI3PaE+sEvYJC9p6tuH6LOw6RzoShOAVl4GsuCuSiNMv
         1hPtNezb4AFygbHqO3Ti3zrU1T6k2UUCnsv37LgvhCCEg0UreTkOJhqqbQJPZHk0mmz5
         Xoeg==
X-Gm-Message-State: AOAM5306rzR/8r4ENR42dDw2T4241ZwC/0AKi67LVo9cN9/p0JCYDFGq
	mj4LL8A6cjt9O2MvXHN0qNq5q6VVegXUYSo/
X-Google-Smtp-Source: ABdhPJw8UBJ72tt6q+EFej7vQOCOIXwsCe46+CplMWD6z6xkFRKPanIHXr0RxjoBZewaaNOCd/kMIg==
X-Received: by 2002:a05:6000:c3:: with SMTP id q3mr22201465wrx.361.1632047550783;
        Sun, 19 Sep 2021 03:32:30 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:f583:326e:a3bb:7da1])
        by smtp.gmail.com with ESMTPSA id r5sm12017758wrm.79.2021.09.19.03.32.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 03:32:30 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] tests/fetch2: Fix quoting warning
Date: Sun, 19 Sep 2021 11:32:28 +0100
Message-Id: <20210919103228.1541093-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210919103228.1541093-1-richard.purdie@linuxfoundation.org>
References: <20210919103228.1541093-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix:

lib/bb/tests/fetch.py:1288: DeprecationWarning: invalid escape sequence

for several lines of the fetch tests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 242be36891..c637a29632 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1265,13 +1265,13 @@ class FetchLatestVersionTest(FetcherTest):
             : "20120614",
         # packages with a valid UPSTREAM_CHECK_GITTAGREGEX
                 # mirror of git://anongit.freedesktop.org/xorg/driver/xf86-video-omap since network issues interfered with testing
-        ("xf86-video-omap", "git://git.yoctoproject.org/bbfetchtests-xf86-video-omap", "ae0394e687f1a77e966cf72f895da91840dffb8f", "(?P<pver>(\d+\.(\d\.?)*))")
+        ("xf86-video-omap", "git://git.yoctoproject.org/bbfetchtests-xf86-video-omap", "ae0394e687f1a77e966cf72f895da91840dffb8f", r"(?P<pver>(\d+\.(\d\.?)*))")
             : "0.4.3",
-        ("build-appliance-image", "git://git.yoctoproject.org/poky", "b37dd451a52622d5b570183a81583cc34c2ff555", "(?P<pver>(([0-9][\.|_]?)+[0-9]))")
+        ("build-appliance-image", "git://git.yoctoproject.org/poky", "b37dd451a52622d5b570183a81583cc34c2ff555", r"(?P<pver>(([0-9][\.|_]?)+[0-9]))")
             : "11.0.0",
-        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot", "cd437ecbd8986c894442f8fce1e0061e20f04dee", "chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
+        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot", "cd437ecbd8986c894442f8fce1e0061e20f04dee", r"chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
             : "1.3.59",
-        ("remake", "git://github.com/rocky/remake.git", "f05508e521987c8494c92d9c2871aec46307d51d", "(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
+        ("remake", "git://github.com/rocky/remake.git", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
             : "3.82+dbg0.9",
     }
 
@@ -1311,11 +1311,11 @@ class FetchLatestVersionTest(FetcherTest):
         #
         # http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2
         # https://github.com/apple/cups/releases
-        ("cups", "/software/1.7.2/cups-1.7.2-source.tar.bz2", "/apple/cups/releases", "(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
+        ("cups", "/software/1.7.2/cups-1.7.2-source.tar.bz2", "/apple/cups/releases", r"(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
             : "2.0.0",
         # http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz
         # http://ftp.debian.org/debian/pool/main/d/db5.3/
-        ("db", "/berkeley-db/db-5.3.21.tar.gz", "/debian/pool/main/d/db5.3/", "(?P<name>db5\.3_)(?P<pver>\d+(\.\d+)+).+\.orig\.tar\.xz")
+        ("db", "/berkeley-db/db-5.3.21.tar.gz", "/debian/pool/main/d/db5.3/", r"(?P<name>db5\.3_)(?P<pver>\d+(\.\d+)+).+\.orig\.tar\.xz")
             : "5.3.10",
     }
 
-- 
2.32.0


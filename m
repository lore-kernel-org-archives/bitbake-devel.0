Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D007DC433FE
	for <webhook@archiver.kernel.org>; Tue,  7 Dec 2021 12:41:47 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web08.66402.1638880906062232810
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Dec 2021 04:41:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=RiWV1tO7;
 spf=pass (domain: gmail.com, ip: 209.85.221.41,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id a9so29135493wrr.8
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Dec 2021 04:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xxcg3aWoo3tF3XVG/HIxkR0luOARuf7gLLld801GHok=;
        b=RiWV1tO7Kr6fLaNu6cp2+mLQmjQK5976cxyHdrIa6hXQ/pBM2p+o8ROmszm1y9B7ar
         ffCR3KBy8YC+2IzOyc886AYNUQX6kdEkopxt3Kg5TRZ0Fm9OFRkoY6otfrwJzGJ4drCy
         t1aICFtySqw4jrRk9YnwUJmA4qR0BjJISda0161VHohsu0eX6CFWuTvztlUF4RpSJ4Sn
         ZpFxLgAaF05qvvVzyKWCQVIxH/xEPBwpVsykRCjG1iqpMh3/kAOEdjilF6o9oEsOBqhe
         I7q8UCwKVuLoPGuds36XhpgPUSmnnBzsFIEDuK9XTt6BdFhC8tWbM3Jx4xIW0zjwLj06
         NzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xxcg3aWoo3tF3XVG/HIxkR0luOARuf7gLLld801GHok=;
        b=oph8emOZa0ELuw0jp6FDhemqwqf6CVcYRcL3PADNXOb5UAcZbzrUDZ8OTYnBi6cC1R
         ZUTVy61PohzlsRT5fqBc5CY1cUvwMBIRAXbECaUaieRmTW2On12B0Gzbr34NqGfvSZUS
         WBoHtxAkWhTxbMv7b06ltyTF8KghSY8XAmduYu+oT3kterOJQPPW3KbiMj9DTP0aVqUW
         2q+u/JvsccOfhjfEZv8RluBje726wY3KSZSG6WcX1NdEMIKL5/JD4GeoamjVZLvuj0V2
         K7GAvISgPLBOGTLHstJ8N7nTZ5zogJN3nsxmvAmooa+2Ux/KtF7tXWWmY0KPCL4WRPKp
         jhTQ==
X-Gm-Message-State: AOAM531VYK3gEllJ3ZeGSbHxeBmsEqH0/hKcjl+YIMB+8r69bb64qN/q
	mnuyc5wzEqyrgnDCbbSnqiYvvOMbt5ZQ1g==
X-Google-Smtp-Source: 
 ABdhPJzB/I8uGGVRKDkgDWXZd8FH9j+jFM/KrgIH/WASeEvz3U/FixzYUtiiOgtTMrVVPeMtjwUuWQ==
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr51102741wrd.10.1638880904473;
        Tue, 07 Dec 2021 04:41:44 -0800 (PST)
Received: from nereus.lab.linutronix.de. (b2b-109-90-143-203.unitymedia.biz.
 [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id
 n4sm16508320wri.41.2021.12.07.04.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 04:41:44 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] fetch: add a test for version check where compression changes
Date: Tue,  7 Dec 2021 13:41:41 +0100
Message-Id: <20211207124141.3193820-1-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Dec 2021 12:41:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13142

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../debian/pool/main/m/minicom/index.html     | 59 +++++++++++++++++++
 bitbake/lib/bb/tests/fetch.py                 |  6 ++
 2 files changed, 65 insertions(+)
 create mode 100644 bitbake/lib/bb/tests/fetch-testdata/debian/pool/main/m/minicom/index.html

diff --git a/bitbake/lib/bb/tests/fetch-testdata/debian/pool/main/m/minicom/index.html b/bitbake/lib/bb/tests/fetch-testdata/debian/pool/main/m/minicom/index.html
new file mode 100644
index 0000000000..4a1eb4de13
--- /dev/null
+++ b/bitbake/lib/bb/tests/fetch-testdata/debian/pool/main/m/minicom/index.html
@@ -0,0 +1,59 @@
+<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
+<html>
+ <head>
+  <title>Index of /debian/pool/main/m/minicom</title>
+ </head>
+ <body>
+<h1>Index of /debian/pool/main/m/minicom</h1>
+  <table>
+   <tr><th valign="top"><img src="/icons/blank.gif" alt="[ICO]"></th><th><a href="?C=N;O=D">Name</a></th><th><a href="?C=M;O=A">Last modified</a></th><th><a href="?C=S;O=A">Size</a></th></tr>
+   <tr><th colspan="4"><hr></th></tr>
+<tr><td valign="top"><img src="/icons/back.gif" alt="[PARENTDIR]"></td><td><a href="/debian/pool/main/m/">Parent Directory</a></td><td>&nbsp;</td><td align="right">  - </td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1+deb8u1.debian.tar.xz">minicom_2.7-1+deb8u1.debian.tar.xz</a></td><td align="right">2017-04-24 08:22  </td><td align="right"> 14K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1+deb8u1.dsc">minicom_2.7-1+deb8u1.dsc</a></td><td align="right">2017-04-24 08:22  </td><td align="right">1.9K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1+deb8u1_amd64.deb">minicom_2.7-1+deb8u1_amd64.deb</a></td><td align="right">2017-04-25 21:10  </td><td align="right">257K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1+deb8u1_armel.deb">minicom_2.7-1+deb8u1_armel.deb</a></td><td align="right">2017-04-26 00:58  </td><td align="right">246K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1+deb8u1_armhf.deb">minicom_2.7-1+deb8u1_armhf.deb</a></td><td align="right">2017-04-26 00:58  </td><td align="right">245K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1+deb8u1_i386.deb">minicom_2.7-1+deb8u1_i386.deb</a></td><td align="right">2017-04-25 21:41  </td><td align="right">258K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1.debian.tar.xz">minicom_2.7-1.1.debian.tar.xz</a></td><td align="right">2017-04-22 09:34  </td><td align="right"> 14K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1.dsc">minicom_2.7-1.1.dsc</a></td><td align="right">2017-04-22 09:34  </td><td align="right">1.9K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1_amd64.deb">minicom_2.7-1.1_amd64.deb</a></td><td align="right">2017-04-22 15:29  </td><td align="right">261K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1_arm64.deb">minicom_2.7-1.1_arm64.deb</a></td><td align="right">2017-04-22 15:29  </td><td align="right">250K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1_armel.deb">minicom_2.7-1.1_armel.deb</a></td><td align="right">2017-04-22 15:29  </td><td align="right">255K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1_armhf.deb">minicom_2.7-1.1_armhf.deb</a></td><td align="right">2017-04-22 15:29  </td><td align="right">254K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1_i386.deb">minicom_2.7-1.1_i386.deb</a></td><td align="right">2017-04-22 15:29  </td><td align="right">266K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1_mips.deb">minicom_2.7-1.1_mips.deb</a></td><td align="right">2017-04-22 15:29  </td><td align="right">258K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1_mips64el.deb">minicom_2.7-1.1_mips64el.deb</a></td><td align="right">2017-04-22 15:29  </td><td align="right">259K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1_mipsel.deb">minicom_2.7-1.1_mipsel.deb</a></td><td align="right">2017-04-22 15:29  </td><td align="right">259K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1_ppc64el.deb">minicom_2.7-1.1_ppc64el.deb</a></td><td align="right">2017-04-22 15:29  </td><td align="right">253K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7-1.1_s390x.deb">minicom_2.7-1.1_s390x.deb</a></td><td align="right">2017-04-22 15:29  </td><td align="right">261K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1+b1_amd64.deb">minicom_2.7.1-1+b1_amd64.deb</a></td><td align="right">2018-05-06 08:14  </td><td align="right">262K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1+b1_arm64.deb">minicom_2.7.1-1+b1_arm64.deb</a></td><td align="right">2018-05-06 07:58  </td><td align="right">250K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1+b1_armel.deb">minicom_2.7.1-1+b1_armel.deb</a></td><td align="right">2018-05-06 08:45  </td><td align="right">253K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1+b1_armhf.deb">minicom_2.7.1-1+b1_armhf.deb</a></td><td align="right">2018-05-06 10:42  </td><td align="right">253K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1+b1_i386.deb">minicom_2.7.1-1+b1_i386.deb</a></td><td align="right">2018-05-06 08:55  </td><td align="right">266K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1+b1_mips.deb">minicom_2.7.1-1+b1_mips.deb</a></td><td align="right">2018-05-06 08:14  </td><td align="right">258K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1+b1_mipsel.deb">minicom_2.7.1-1+b1_mipsel.deb</a></td><td align="right">2018-05-06 12:13  </td><td align="right">259K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1+b1_ppc64el.deb">minicom_2.7.1-1+b1_ppc64el.deb</a></td><td align="right">2018-05-06 09:10  </td><td align="right">260K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1+b1_s390x.deb">minicom_2.7.1-1+b1_s390x.deb</a></td><td align="right">2018-05-06 08:14  </td><td align="right">257K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1+b2_mips64el.deb">minicom_2.7.1-1+b2_mips64el.deb</a></td><td align="right">2018-05-06 09:41  </td><td align="right">260K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1.debian.tar.xz">minicom_2.7.1-1.debian.tar.xz</a></td><td align="right">2017-08-13 15:40  </td><td align="right"> 14K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.7.1-1.dsc">minicom_2.7.1-1.dsc</a></td><td align="right">2017-08-13 15:40  </td><td align="right">1.8K</td></tr>
+<tr><td valign="top"><img src="/icons/compressed.gif" alt="[   ]"></td><td><a href="minicom_2.7.1.orig.tar.gz">minicom_2.7.1.orig.tar.gz</a></td><td align="right">2017-08-13 15:40  </td><td align="right">855K</td></tr>
+<tr><td valign="top"><img src="/icons/compressed.gif" alt="[   ]"></td><td><a href="minicom_2.7.orig.tar.gz">minicom_2.7.orig.tar.gz</a></td><td align="right">2014-01-01 09:36  </td><td align="right">843K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2.debian.tar.xz">minicom_2.8-2.debian.tar.xz</a></td><td align="right">2021-06-15 03:47  </td><td align="right"> 14K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2.dsc">minicom_2.8-2.dsc</a></td><td align="right">2021-06-15 03:47  </td><td align="right">1.8K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2_amd64.deb">minicom_2.8-2_amd64.deb</a></td><td align="right">2021-06-15 03:58  </td><td align="right">280K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2_arm64.deb">minicom_2.8-2_arm64.deb</a></td><td align="right">2021-06-15 04:13  </td><td align="right">275K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2_armel.deb">minicom_2.8-2_armel.deb</a></td><td align="right">2021-06-15 04:13  </td><td align="right">271K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2_armhf.deb">minicom_2.8-2_armhf.deb</a></td><td align="right">2021-06-15 04:13  </td><td align="right">272K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2_i386.deb">minicom_2.8-2_i386.deb</a></td><td align="right">2021-06-15 04:13  </td><td align="right">285K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2_mips64el.deb">minicom_2.8-2_mips64el.deb</a></td><td align="right">2021-06-15 04:13  </td><td align="right">277K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2_mipsel.deb">minicom_2.8-2_mipsel.deb</a></td><td align="right">2021-06-15 04:13  </td><td align="right">278K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2_ppc64el.deb">minicom_2.8-2_ppc64el.deb</a></td><td align="right">2021-06-15 04:13  </td><td align="right">286K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8-2_s390x.deb">minicom_2.8-2_s390x.deb</a></td><td align="right">2021-06-15 03:58  </td><td align="right">275K</td></tr>
+<tr><td valign="top"><img src="/icons/unknown.gif" alt="[   ]"></td><td><a href="minicom_2.8.orig.tar.bz2">minicom_2.8.orig.tar.bz2</a></td><td align="right">2021-01-03 12:44  </td><td align="right">598K</td></tr>
+   <tr><th colspan="4"><hr></th></tr>
+</table>
+<address>Apache Server at ftp.debian.org Port 80</address>
+</body></html>
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index dc45eb2e13..6b77afe5f1 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1346,6 +1346,12 @@ class FetchLatestVersionTest(FetcherTest):
         # http://ftp.debian.org/debian/pool/main/d/db5.3/
         ("db", "/berkeley-db/db-5.3.21.tar.gz", "/debian/pool/main/d/db5.3/", r"(?P<name>db5\.3_)(?P<pver>\d+(\.\d+)+).+\.orig\.tar\.xz")
             : "5.3.10",
+        #
+        # packages where the tarball compression changed in the new version
+        #
+        # http://ftp.debian.org/debian/pool/main/m/minicom/minicom_2.7.1.orig.tar.gz
+        ("minicom", "/debian/pool/main/m/minicom/minicom_2.7.1.orig.tar.gz", "", "")
+            : "2.8",
     }
 
     @skipIfNoNetwork()
-- 
2.20.1



Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A182C4167B
	for <webhook@archiver.kernel.org>; Fri,  9 Dec 2022 08:58:48 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.8843.1670576326049650113
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Dec 2022 00:58:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=daj3zFwt;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id o5so4526791wrm.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 00:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAurBWsNYHUiDRIfZ6C3ncqydGSa+pcSK8qSMj+wcXQ=;
        b=daj3zFwtrJ5IjRxDHMEj9xhr2F8ZAm3NB53EZkMdi/wN8b+xTAe1W3mFP9842h+X4D
         fVDvFiiyeK38dFOMfQu8F5ZDHN/61KRye79h40T9NrM3GopQaEtYRHzCeT/An1hL46Ut
         OFsZFR7T+XbWQRFiAPHS1iwmtNU0uiZ1lCQ0JfGX0fJItvzO7qiNq1kpntyWgZUtszVo
         sRTryD/pFdY08NnpQaGW/6zxpmEv3wmZot1A3itUPChiRUlSodXTXqmhhJhOOqzWG4Ae
         iyQNrc+5a65qc6bZL0T10b99lzbMQQG0mdX2pGIHWn9HqVdJhper1j78KOnVGTUy4CtI
         y6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAurBWsNYHUiDRIfZ6C3ncqydGSa+pcSK8qSMj+wcXQ=;
        b=jRiJpZeiXVOUXmKeY9TZWiGXyjFdDgkbbbcA4iOThaAnbIahmoy8Pfo3WZqSk6xDuG
         wDP5QK8ye0H//fejBmBRn06PgxQFoREaB9cCh5HcSK1Wwn4cBOKOMZc/J8r+rIRH6yoV
         LZcn6NCG2HvwuKrD/nqnh2SjQzcYJWLRLh6b7V6bOK/5urJeOSxuQTCaceMNVs/DlvBC
         4YecUP3QwqXe7xXK9ZmVLUrQL6HTFpQ+zQYZlj6Bbjy7hHnhjSrPEEm+eT9rSHsiQbJK
         rH2Ordqsf5ZH6xF150NeQCESm7xxgnBArMK1GGkvNv7xvfLisO08tlcwz3ZaAAv7Mn4k
         0iIg==
X-Gm-Message-State: ANoB5pnwiNqXzR07bwrCjh3ooDfA4mFQYxX81f/6gye/mUOtx1lU831h
	Fk6UCtPrky0+2ibXPttku06AHEoPJL0=
X-Google-Smtp-Source: AA0mqf7m+QRQgbVFHQgSu7o2PJfSV862epHlcHjJFK4moRiUtaJ6lElFDpoL1/PSzgrNRR/MrKcUmQ==
X-Received: by 2002:a05:6000:1c1d:b0:236:8cca:d3c9 with SMTP id ba29-20020a0560001c1d00b002368ccad3c9mr3640138wrb.53.1670576324226;
        Fri, 09 Dec 2022 00:58:44 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d4006000000b0022cc0a2cbecsm835991wrp.15.2022.12.09.00.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 00:58:43 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v3] fetch2/wget.py: correctly match versioned directories
Date: Fri,  9 Dec 2022 09:58:40 +0100
Message-Id: <20221209085840.3733809-1-alex@linutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 08:58:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14158

When obtaining latest upstream versions, the code needs
to check if the existing tarball is in a versioned directory
(e.g. component-name/x.y/component-name-x.y.z.tar.gz) and
if it is, it needs to first obtain the list of all
such versioned directories and then check all of them by going
one step up in the directory hierarchy.

Existing code was returning a correct match when the component
name did not have numbers, e.g. a check on 'source/epiphany/43/'
would return 43, but was stopping too soon when the component
name itself had numbers ('source/libxml2/2.10/' would return libxml2).

This change ensures the last match is taken instead of the first.

Also, adjust the fetcher tests to check that versioned directories
are correctly traversed in this case (e.g. the step to go one level
up is taken and a new tarball is discovered in a different versioned
directory).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/wget.py                 |  4 +-
 .../software/libxml2/2.10/index.html          | 20 ++++++++++
 .../software/libxml2/2.9/index.html           | 40 +++++++++++++++++++
 .../software/libxml2/index.html               | 19 +++++++++
 bitbake/lib/bb/tests/fetch.py                 |  3 ++
 5 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.10/index.html
 create mode 100644 bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.9/index.html
 create mode 100644 bitbake/lib/bb/tests/fetch-testdata/software/libxml2/index.html

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 821afa5b58..7ccea3ad89 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -644,10 +644,10 @@ class Wget(FetchMethod):
             # search for version matches on folders inside the path, like:
             # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
             dirver_regex = re.compile(r"(?P<dirver>[^/]*(\d+\.)*\d+([-_]r\d+)*)/")
-            m = dirver_regex.search(path)
+            m = dirver_regex.findall(path)
             if m:
                 pn = d.getVar('PN')
-                dirver = m.group('dirver')
+                dirver = m[-1][0]
 
                 dirver_pn_regex = re.compile(r"%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
diff --git a/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.10/index.html b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.10/index.html
new file mode 100644
index 0000000000..4e41af6d6a
--- /dev/null
+++ b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.10/index.html
@@ -0,0 +1,20 @@
+<!DOCTYPE html><html><head><meta http-equiv="content-type" content="text/html; charset=utf-8"><meta name="viewport" content="width=device-width"><style type="text/css">body,html {background:#fff;font-family:"Bitstream Vera Sans","Lucida Grande","Lucida Sans Unicode",Lucidux,Verdana,Lucida,sans-serif;}tr:nth-child(even) {background:#f4f4f4;}th,td {padding:0.1em 0.5em;}th {text-align:left;font-weight:bold;background:#eee;border-bottom:1px solid #aaa;}#list {border:1px solid #aaa;width:100%;}a {color:#a33;}a:hover {color:#e33;}</style>
+
+<title>Index of /sources/libxml2/2.10/</title>
+</head><body><h1>Index of /sources/libxml2/2.10/</h1>
+<table id="list"><thead><tr><th style="width:55%"><a href="?C=N&amp;O=A">File Name</a>&nbsp;<a href="?C=N&amp;O=D">&nbsp;&darr;&nbsp;</a></th><th style="width:20%"><a href="?C=S&amp;O=A">File Size</a>&nbsp;<a href="?C=S&amp;O=D">&nbsp;&darr;&nbsp;</a></th><th style="width:25%"><a href="?C=M&amp;O=A">Date</a>&nbsp;<a href="?C=M&amp;O=D">&nbsp;&darr;&nbsp;</a></th></tr></thead>
+<tbody><tr><td class="link"><a href="../">Parent directory/</a></td><td class="size">-</td><td class="date">-</td></tr>
+<tr><td class="link"><a href="LATEST-IS-2.10.3" title="LATEST-IS-2.10.3">LATEST-IS-2.10.3</a></td><td class="size">2.5 MiB</td><td class="date">2022-Oct-14 12:55</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.0.news" title="libxml2-2.10.0.news">libxml2-2.10.0.news</a></td><td class="size">7.1 KiB</td><td class="date">2022-Aug-17 11:55</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.0.sha256sum" title="libxml2-2.10.0.sha256sum">libxml2-2.10.0.sha256sum</a></td><td class="size">174 B</td><td class="date">2022-Aug-17 11:55</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.0.tar.xz" title="libxml2-2.10.0.tar.xz">libxml2-2.10.0.tar.xz</a></td><td class="size">2.6 MiB</td><td class="date">2022-Aug-17 11:55</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.1.news" title="libxml2-2.10.1.news">libxml2-2.10.1.news</a></td><td class="size">455 B</td><td class="date">2022-Aug-25 11:33</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.1.sha256sum" title="libxml2-2.10.1.sha256sum">libxml2-2.10.1.sha256sum</a></td><td class="size">174 B</td><td class="date">2022-Aug-25 11:33</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.1.tar.xz" title="libxml2-2.10.1.tar.xz">libxml2-2.10.1.tar.xz</a></td><td class="size">2.6 MiB</td><td class="date">2022-Aug-25 11:33</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.2.news" title="libxml2-2.10.2.news">libxml2-2.10.2.news</a></td><td class="size">309 B</td><td class="date">2022-Aug-29 14:56</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.2.sha256sum" title="libxml2-2.10.2.sha256sum">libxml2-2.10.2.sha256sum</a></td><td class="size">174 B</td><td class="date">2022-Aug-29 14:56</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.2.tar.xz" title="libxml2-2.10.2.tar.xz">libxml2-2.10.2.tar.xz</a></td><td class="size">2.5 MiB</td><td class="date">2022-Aug-29 14:56</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.3.news" title="libxml2-2.10.3.news">libxml2-2.10.3.news</a></td><td class="size">294 B</td><td class="date">2022-Oct-14 12:55</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.3.sha256sum" title="libxml2-2.10.3.sha256sum">libxml2-2.10.3.sha256sum</a></td><td class="size">174 B</td><td class="date">2022-Oct-14 12:55</td></tr>
+<tr><td class="link"><a href="libxml2-2.10.3.tar.xz" title="libxml2-2.10.3.tar.xz">libxml2-2.10.3.tar.xz</a></td><td class="size">2.5 MiB</td><td class="date">2022-Oct-14 12:55</td></tr>
+</tbody></table></body></html>
diff --git a/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.9/index.html b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.9/index.html
new file mode 100644
index 0000000000..abdfdd0fa2
--- /dev/null
+++ b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.9/index.html
@@ -0,0 +1,40 @@
+<!DOCTYPE html><html><head><meta http-equiv="content-type" content="text/html; charset=utf-8"><meta name="viewport" content="width=device-width"><style type="text/css">body,html {background:#fff;font-family:"Bitstream Vera Sans","Lucida Grande","Lucida Sans Unicode",Lucidux,Verdana,Lucida,sans-serif;}tr:nth-child(even) {background:#f4f4f4;}th,td {padding:0.1em 0.5em;}th {text-align:left;font-weight:bold;background:#eee;border-bottom:1px solid #aaa;}#list {border:1px solid #aaa;width:100%;}a {color:#a33;}a:hover {color:#e33;}</style>
+
+<title>Index of /sources/libxml2/2.9/</title>
+</head><body><h1>Index of /sources/libxml2/2.9/</h1>
+<table id="list"><thead><tr><th style="width:55%"><a href="?C=N&amp;O=A">File Name</a>&nbsp;<a href="?C=N&amp;O=D">&nbsp;&darr;&nbsp;</a></th><th style="width:20%"><a href="?C=S&amp;O=A">File Size</a>&nbsp;<a href="?C=S&amp;O=D">&nbsp;&darr;&nbsp;</a></th><th style="width:25%"><a href="?C=M&amp;O=A">Date</a>&nbsp;<a href="?C=M&amp;O=D">&nbsp;&darr;&nbsp;</a></th></tr></thead>
+<tbody><tr><td class="link"><a href="../">Parent directory/</a></td><td class="size">-</td><td class="date">-</td></tr>
+<tr><td class="link"><a href="LATEST-IS-2.9.14" title="LATEST-IS-2.9.14">LATEST-IS-2.9.14</a></td><td class="size">3.0 MiB</td><td class="date">2022-May-02 12:03</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.0.sha256sum" title="libxml2-2.9.0.sha256sum">libxml2-2.9.0.sha256sum</a></td><td class="size">87 B</td><td class="date">2022-Feb-14 18:27</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.0.tar.xz" title="libxml2-2.9.0.tar.xz">libxml2-2.9.0.tar.xz</a></td><td class="size">3.0 MiB</td><td class="date">2022-Feb-14 18:27</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.1.sha256sum" title="libxml2-2.9.1.sha256sum">libxml2-2.9.1.sha256sum</a></td><td class="size">87 B</td><td class="date">2022-Feb-14 18:28</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.1.tar.xz" title="libxml2-2.9.1.tar.xz">libxml2-2.9.1.tar.xz</a></td><td class="size">3.0 MiB</td><td class="date">2022-Feb-14 18:28</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.10.sha256sum" title="libxml2-2.9.10.sha256sum">libxml2-2.9.10.sha256sum</a></td><td class="size">88 B</td><td class="date">2022-Feb-14 18:42</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.10.tar.xz" title="libxml2-2.9.10.tar.xz">libxml2-2.9.10.tar.xz</a></td><td class="size">3.2 MiB</td><td class="date">2022-Feb-14 18:42</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.11.sha256sum" title="libxml2-2.9.11.sha256sum">libxml2-2.9.11.sha256sum</a></td><td class="size">88 B</td><td class="date">2022-Feb-14 18:43</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.11.tar.xz" title="libxml2-2.9.11.tar.xz">libxml2-2.9.11.tar.xz</a></td><td class="size">3.2 MiB</td><td class="date">2022-Feb-14 18:43</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.12.sha256sum" title="libxml2-2.9.12.sha256sum">libxml2-2.9.12.sha256sum</a></td><td class="size">88 B</td><td class="date">2022-Feb-14 18:45</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.12.tar.xz" title="libxml2-2.9.12.tar.xz">libxml2-2.9.12.tar.xz</a></td><td class="size">3.2 MiB</td><td class="date">2022-Feb-14 18:45</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.13.news" title="libxml2-2.9.13.news">libxml2-2.9.13.news</a></td><td class="size">26.6 KiB</td><td class="date">2022-Feb-20 12:42</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.13.sha256sum" title="libxml2-2.9.13.sha256sum">libxml2-2.9.13.sha256sum</a></td><td class="size">174 B</td><td class="date">2022-Feb-20 12:42</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.13.tar.xz" title="libxml2-2.9.13.tar.xz">libxml2-2.9.13.tar.xz</a></td><td class="size">3.1 MiB</td><td class="date">2022-Feb-20 12:42</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.14.news" title="libxml2-2.9.14.news">libxml2-2.9.14.news</a></td><td class="size">1.0 KiB</td><td class="date">2022-May-02 12:03</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.14.sha256sum" title="libxml2-2.9.14.sha256sum">libxml2-2.9.14.sha256sum</a></td><td class="size">174 B</td><td class="date">2022-May-02 12:03</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.14.tar.xz" title="libxml2-2.9.14.tar.xz">libxml2-2.9.14.tar.xz</a></td><td class="size">3.0 MiB</td><td class="date">2022-May-02 12:03</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.2.sha256sum" title="libxml2-2.9.2.sha256sum">libxml2-2.9.2.sha256sum</a></td><td class="size">87 B</td><td class="date">2022-Feb-14 18:30</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.2.tar.xz" title="libxml2-2.9.2.tar.xz">libxml2-2.9.2.tar.xz</a></td><td class="size">3.2 MiB</td><td class="date">2022-Feb-14 18:30</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.3.sha256sum" title="libxml2-2.9.3.sha256sum">libxml2-2.9.3.sha256sum</a></td><td class="size">87 B</td><td class="date">2022-Feb-14 18:31</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.3.tar.xz" title="libxml2-2.9.3.tar.xz">libxml2-2.9.3.tar.xz</a></td><td class="size">3.2 MiB</td><td class="date">2022-Feb-14 18:31</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.4.sha256sum" title="libxml2-2.9.4.sha256sum">libxml2-2.9.4.sha256sum</a></td><td class="size">87 B</td><td class="date">2022-Feb-14 18:33</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.4.tar.xz" title="libxml2-2.9.4.tar.xz">libxml2-2.9.4.tar.xz</a></td><td class="size">2.9 MiB</td><td class="date">2022-Feb-14 18:33</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.5.sha256sum" title="libxml2-2.9.5.sha256sum">libxml2-2.9.5.sha256sum</a></td><td class="size">87 B</td><td class="date">2022-Feb-14 18:35</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.5.tar.xz" title="libxml2-2.9.5.tar.xz">libxml2-2.9.5.tar.xz</a></td><td class="size">3.0 MiB</td><td class="date">2022-Feb-14 18:35</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.6.sha256sum" title="libxml2-2.9.6.sha256sum">libxml2-2.9.6.sha256sum</a></td><td class="size">87 B</td><td class="date">2022-Feb-14 18:36</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.6.tar.xz" title="libxml2-2.9.6.tar.xz">libxml2-2.9.6.tar.xz</a></td><td class="size">3.0 MiB</td><td class="date">2022-Feb-14 18:36</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.7.sha256sum" title="libxml2-2.9.7.sha256sum">libxml2-2.9.7.sha256sum</a></td><td class="size">87 B</td><td class="date">2022-Feb-14 18:37</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.7.tar.xz" title="libxml2-2.9.7.tar.xz">libxml2-2.9.7.tar.xz</a></td><td class="size">3.0 MiB</td><td class="date">2022-Feb-14 18:37</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.8.sha256sum" title="libxml2-2.9.8.sha256sum">libxml2-2.9.8.sha256sum</a></td><td class="size">87 B</td><td class="date">2022-Feb-14 18:39</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.8.tar.xz" title="libxml2-2.9.8.tar.xz">libxml2-2.9.8.tar.xz</a></td><td class="size">3.0 MiB</td><td class="date">2022-Feb-14 18:39</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.9.sha256sum" title="libxml2-2.9.9.sha256sum">libxml2-2.9.9.sha256sum</a></td><td class="size">87 B</td><td class="date">2022-Feb-14 18:40</td></tr>
+<tr><td class="link"><a href="libxml2-2.9.9.tar.xz" title="libxml2-2.9.9.tar.xz">libxml2-2.9.9.tar.xz</a></td><td class="size">3.0 MiB</td><td class="date">2022-Feb-14 18:40</td></tr>
+</tbody></table></body></html>
diff --git a/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/index.html b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/index.html
new file mode 100644
index 0000000000..c183e06a55
--- /dev/null
+++ b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/index.html
@@ -0,0 +1,19 @@
+<!DOCTYPE html><html><head><meta http-equiv="content-type" content="text/html; charset=utf-8"><meta name="viewport" content="width=device-width"><style type="text/css">body,html {background:#fff;font-family:"Bitstream Vera Sans","Lucida Grande","Lucida Sans Unicode",Lucidux,Verdana,Lucida,sans-serif;}tr:nth-child(even) {background:#f4f4f4;}th,td {padding:0.1em 0.5em;}th {text-align:left;font-weight:bold;background:#eee;border-bottom:1px solid #aaa;}#list {border:1px solid #aaa;width:100%;}a {color:#a33;}a:hover {color:#e33;}</style>
+
+<title>Index of /sources/libxml2/</title>
+</head><body><h1>Index of /sources/libxml2/</h1>
+<table id="list"><thead><tr><th style="width:55%"><a href="?C=N&amp;O=A">File Name</a>&nbsp;<a href="?C=N&amp;O=D">&nbsp;&darr;&nbsp;</a></th><th style="width:20%"><a href="?C=S&amp;O=A">File Size</a>&nbsp;<a href="?C=S&amp;O=D">&nbsp;&darr;&nbsp;</a></th><th style="width:25%"><a href="?C=M&amp;O=A">Date</a>&nbsp;<a href="?C=M&amp;O=D">&nbsp;&darr;&nbsp;</a></th></tr></thead>
+<tbody><tr><td class="link"><a href="../">Parent directory/</a></td><td class="size">-</td><td class="date">-</td></tr>
+<tr><td class="link"><a href="2.0/" title="2.0">2.0/</a></td><td class="size">-</td><td class="date">2009-Jul-14 13:04</td></tr>
+<tr><td class="link"><a href="2.1/" title="2.1">2.1/</a></td><td class="size">-</td><td class="date">2009-Jul-14 13:04</td></tr>
+<tr><td class="link"><a href="2.10/" title="2.10">2.10/</a></td><td class="size">-</td><td class="date">2022-Oct-14 12:55</td></tr>
+<tr><td class="link"><a href="2.2/" title="2.2">2.2/</a></td><td class="size">-</td><td class="date">2009-Jul-14 13:04</td></tr>
+<tr><td class="link"><a href="2.3/" title="2.3">2.3/</a></td><td class="size">-</td><td class="date">2009-Jul-14 13:05</td></tr>
+<tr><td class="link"><a href="2.4/" title="2.4">2.4/</a></td><td class="size">-</td><td class="date">2009-Jul-14 13:05</td></tr>
+<tr><td class="link"><a href="2.5/" title="2.5">2.5/</a></td><td class="size">-</td><td class="date">2009-Jul-14 13:05</td></tr>
+<tr><td class="link"><a href="2.6/" title="2.6">2.6/</a></td><td class="size">-</td><td class="date">2009-Jul-14 13:05</td></tr>
+<tr><td class="link"><a href="2.7/" title="2.7">2.7/</a></td><td class="size">-</td><td class="date">2022-Feb-14 18:24</td></tr>
+<tr><td class="link"><a href="2.8/" title="2.8">2.8/</a></td><td class="size">-</td><td class="date">2022-Feb-14 18:26</td></tr>
+<tr><td class="link"><a href="2.9/" title="2.9">2.9/</a></td><td class="size">-</td><td class="date">2022-May-02 12:04</td></tr>
+<tr><td class="link"><a href="cache.json" title="cache.json">cache.json</a></td><td class="size">22.8 KiB</td><td class="date">2022-Oct-14 12:55</td></tr>
+</tbody></table></body></html>
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 0af06e46e5..ad3d4dea7d 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1401,6 +1401,9 @@ class FetchLatestVersionTest(FetcherTest):
         # http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz
         ("cmake", "/files/v2.8/cmake-2.8.12.1.tar.gz", "", "")
             : "2.8.12.1",
+        # https://download.gnome.org/sources/libxml2/2.9/libxml2-2.9.14.tar.xz
+        ("libxml2", "/software/libxml2/2.9/libxml2-2.9.14.tar.xz", "", "")
+            : "2.10.3",
         #
         # packages with versions only in current directory
         #
-- 
2.30.2



Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67B7C3A5A7
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 16:03:27 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.18113.1670515405882507772
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Dec 2022 08:03:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=MctWeEqh;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id w15so2136239wrl.9
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BLYxuU2JveJh+Ois2xgeuDtCWxYTV0JJkWjFoEd2T7U=;
        b=MctWeEqhKPE0ZVLN/iLWFzOvzpEcfNiowoKN5naIrXpQP+cGf5s1yWU7G0QtKP80L/
         O+W/T2CuLz6YMO//xo6cDIilIyGmsEm1skvYRDqHhwcznwDqVYpcT0zvGiUCffHQomks
         yav7YKX+Pm3xYA43wJSzrBgq2UM6GGP+6hVdkFm3jjPJiJpr7wM4ejFqqCTGSC4nxFcM
         LEBWDqdDgaOzDFE33g2vvV5yaz65mthf3aYeKniTgGMRzFc9Ig7/NN7ro8NTB7Mju4Cr
         s4ZrOBAsGF/zSUasJlVOaG2CDkeTlXztOQ1Emq5jlfKayO3lZIlwRr5tefo0wVb0M/EF
         NCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLYxuU2JveJh+Ois2xgeuDtCWxYTV0JJkWjFoEd2T7U=;
        b=HjwpJCtLNXRRHluM9gZNhBraz2jEqb8JihXVMhYV7Txq3mrQNd60GArNjmvRTlR98e
         +IFmlmtEJhLdi9alcOhsbayobeX91nOxJj3CYebO57TDnoGotKbk+e1jL8oclVB4Akwk
         j50QD8kYiSrWBFhYGpOypTVLHLRy/s309hXePtTivEdmdoXrPiZ2m0+hwI/AwBcrF4Ih
         GWGZTVA/1wl3ykp6J39r9gkCVT0Ol0eGP3zu0JoLA+Om5twPhMs9F+zhKqKaqnEpVePw
         /0wtFxxqn0Ho2YkX8VD6A3yXJXh2JAvLPVlpbhSoH/OQYXzF2/gqH26nQnFjkleftPH/
         cV+w==
X-Gm-Message-State: ANoB5pllZyi81+u6DZT7L9jJU/ghgmaOPoqLqjFji2CQC/s7/nUaqvbQ
	rzNEUiL+swPBmiXDUMhBw1wWrVVaDuQ=
X-Google-Smtp-Source: AA0mqf6t1JzigPfDLkyggvaHvtT+vK7EtDIq+Jusp45tQKmP8jIhlncSsCI3oinCJP8HbBtOLqizzw==
X-Received: by 2002:adf:f5c3:0:b0:242:3427:bb51 with SMTP id k3-20020adff5c3000000b002423427bb51mr18951550wrp.635.1670515404021;
        Thu, 08 Dec 2022 08:03:24 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002365730eae8sm22634034wrx.55.2022.12.08.08.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:03:23 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2] fetch2/wget.py: correctly match versioned directories
Date: Thu,  8 Dec 2022 17:03:20 +0100
Message-Id: <20221208160320.3306734-1-alex@linutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 16:03:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14152

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
 create mode 100644 bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.=
10/index.html
 create mode 100644 bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.=
9/index.html
 create mode 100644 bitbake/lib/bb/tests/fetch-testdata/software/libxml2/in=
dex.html

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 821afa5b58..7ccea3ad89 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -644,10 +644,10 @@ class Wget(FetchMethod):
             # search for version matches on folders inside the path, like:
             # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-$=
{PV}.tar.gz
             dirver_regex =3D re.compile(r"(?P<dirver>[^/]*(\d+\.)*\d+([-_]=
r\d+)*)/")
-            m =3D dirver_regex.search(path)
+            m =3D dirver_regex.findall(path)
             if m:
                 pn =3D d.getVar('PN')
-                dirver =3D m.group('dirver')
+                dirver =3D m[-1][0]
=20
                 dirver_pn_regex =3D re.compile(r"%s\d?" % (re.escape(pn)))
                 if not dirver_pn_regex.search(dirver):
diff --git a/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.10/inde=
x.html b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.10/index.ht=
ml
new file mode 100644
index 0000000000..b1d12f6707
--- /dev/null
+++ b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.10/index.html
@@ -0,0 +1,20 @@
+<!DOCTYPE html><html><head><meta http-equiv=3D"content-type" content=3D"te=
xt/html; charset=3Dutf-8"><meta name=3D"viewport" content=3D"width=3Ddevice=
-width"><style type=3D"text/css">body,html {background:#fff;font-family:"Bi=
tstream Vera Sans","Lucida Grande","Lucida Sans Unicode",Lucidux,Verdana,Lu=
cida,sans-serif;}tr:nth-child(even) {background:#f4f4f4;}th,td {padding:0.1=
em 0.5em;}th {text-align:left;font-weight:bold;background:#eee;border-botto=
m:1px solid #aaa;}#list {border:1px solid #aaa;width:100%;}a {color:#a33;}a=
:hover {color:#e33;}</style>
+
+<title>Index of /sources/libxml2/2.10/</title>
+</head><body><h1>Index of /sources/libxml2/2.10/</h1>
+<table id=3D"list"><thead><tr><th style=3D"width:55%"><a href=3D"?C=3DN&am=
p;O=3DA">File Name</a>&nbsp;<a href=3D"?C=3DN&amp;O=3DD">&nbsp;&darr;&nbsp;=
</a></th><th style=3D"width:20%"><a href=3D"?C=3DS&amp;O=3DA">File Size</a>=
&nbsp;<a href=3D"?C=3DS&amp;O=3DD">&nbsp;&darr;&nbsp;</a></th><th style=3D"=
width:25%"><a href=3D"?C=3DM&amp;O=3DA">Date</a>&nbsp;<a href=3D"?C=3DM&amp=
;O=3DD">&nbsp;&darr;&nbsp;</a></th></tr></thead>
+<tbody><tr><td class=3D"link"><a href=3D"../">Parent directory/</a></td><t=
d class=3D"size">-</td><td class=3D"date">-</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"LATEST-IS-2.10.3" title=3D"LATEST-IS-2.1=
0.3">LATEST-IS-2.10.3</a></td><td class=3D"size">2.5 MiB</td><td class=3D"d=
ate">2022-Oct-14 12:55</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.0.news" title=3D"libxml2-2.=
10.0.news">libxml2-2.10.0.news</a></td><td class=3D"size">7.1 KiB</td><td c=
lass=3D"date">2022-Aug-17 11:55</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.0.sha256sum" title=3D"libxm=
l2-2.10.0.sha256sum">libxml2-2.10.0.sha256sum</a></td><td class=3D"size">17=
4 B</td><td class=3D"date">2022-Aug-17 11:55</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.0.tar.xz" title=3D"libxml2-=
2.10.0.tar.xz">libxml2-2.10.0.tar.xz</a></td><td class=3D"size">2.6 MiB</td=
><td class=3D"date">2022-Aug-17 11:55</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.1.news" title=3D"libxml2-2.=
10.1.news">libxml2-2.10.1.news</a></td><td class=3D"size">455 B</td><td cla=
ss=3D"date">2022-Aug-25 11:33</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.1.sha256sum" title=3D"libxm=
l2-2.10.1.sha256sum">libxml2-2.10.1.sha256sum</a></td><td class=3D"size">17=
4 B</td><td class=3D"date">2022-Aug-25 11:33</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.1.tar.xz" title=3D"libxml2-=
2.10.1.tar.xz">libxml2-2.10.1.tar.xz</a></td><td class=3D"size">2.6 MiB</td=
><td class=3D"date">2022-Aug-25 11:33</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.2.news" title=3D"libxml2-2.=
10.2.news">libxml2-2.10.2.news</a></td><td class=3D"size">309 B</td><td cla=
ss=3D"date">2022-Aug-29 14:56</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.2.sha256sum" title=3D"libxm=
l2-2.10.2.sha256sum">libxml2-2.10.2.sha256sum</a></td><td class=3D"size">17=
4 B</td><td class=3D"date">2022-Aug-29 14:56</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.2.tar.xz" title=3D"libxml2-=
2.10.2.tar.xz">libxml2-2.10.2.tar.xz</a></td><td class=3D"size">2.5 MiB</td=
><td class=3D"date">2022-Aug-29 14:56</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.3.news" title=3D"libxml2-2.=
10.3.news">libxml2-2.10.3.news</a></td><td class=3D"size">294 B</td><td cla=
ss=3D"date">2022-Oct-14 12:55</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.3.sha256sum" title=3D"libxm=
l2-2.10.3.sha256sum">libxml2-2.10.3.sha256sum</a></td><td class=3D"size">17=
4 B</td><td class=3D"date">2022-Oct-14 12:55</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.10.3.tar.xz" title=3D"libxml2-=
2.10.3.tar.xz">libxml2-2.10.3.tar.xz</a></td><td class=3D"size">2.5 MiB</td=
><td class=3D"date">2022-Oct-14 12:55</td></tr>=0D
+</tbody></table></body></html>
\ No newline at end of file
diff --git a/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.9/index=
.html b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.9/index.html
new file mode 100644
index 0000000000..d02dbbff67
--- /dev/null
+++ b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/2.9/index.html
@@ -0,0 +1,40 @@
+<!DOCTYPE html><html><head><meta http-equiv=3D"content-type" content=3D"te=
xt/html; charset=3Dutf-8"><meta name=3D"viewport" content=3D"width=3Ddevice=
-width"><style type=3D"text/css">body,html {background:#fff;font-family:"Bi=
tstream Vera Sans","Lucida Grande","Lucida Sans Unicode",Lucidux,Verdana,Lu=
cida,sans-serif;}tr:nth-child(even) {background:#f4f4f4;}th,td {padding:0.1=
em 0.5em;}th {text-align:left;font-weight:bold;background:#eee;border-botto=
m:1px solid #aaa;}#list {border:1px solid #aaa;width:100%;}a {color:#a33;}a=
:hover {color:#e33;}</style>
+
+<title>Index of /sources/libxml2/2.9/</title>
+</head><body><h1>Index of /sources/libxml2/2.9/</h1>
+<table id=3D"list"><thead><tr><th style=3D"width:55%"><a href=3D"?C=3DN&am=
p;O=3DA">File Name</a>&nbsp;<a href=3D"?C=3DN&amp;O=3DD">&nbsp;&darr;&nbsp;=
</a></th><th style=3D"width:20%"><a href=3D"?C=3DS&amp;O=3DA">File Size</a>=
&nbsp;<a href=3D"?C=3DS&amp;O=3DD">&nbsp;&darr;&nbsp;</a></th><th style=3D"=
width:25%"><a href=3D"?C=3DM&amp;O=3DA">Date</a>&nbsp;<a href=3D"?C=3DM&amp=
;O=3DD">&nbsp;&darr;&nbsp;</a></th></tr></thead>
+<tbody><tr><td class=3D"link"><a href=3D"../">Parent directory/</a></td><t=
d class=3D"size">-</td><td class=3D"date">-</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"LATEST-IS-2.9.14" title=3D"LATEST-IS-2.9=
.14">LATEST-IS-2.9.14</a></td><td class=3D"size">3.0 MiB</td><td class=3D"d=
ate">2022-May-02 12:03</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.0.sha256sum" title=3D"libxml=
2-2.9.0.sha256sum">libxml2-2.9.0.sha256sum</a></td><td class=3D"size">87 B<=
/td><td class=3D"date">2022-Feb-14 18:27</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.0.tar.xz" title=3D"libxml2-2=
.9.0.tar.xz">libxml2-2.9.0.tar.xz</a></td><td class=3D"size">3.0 MiB</td><t=
d class=3D"date">2022-Feb-14 18:27</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.1.sha256sum" title=3D"libxml=
2-2.9.1.sha256sum">libxml2-2.9.1.sha256sum</a></td><td class=3D"size">87 B<=
/td><td class=3D"date">2022-Feb-14 18:28</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.1.tar.xz" title=3D"libxml2-2=
.9.1.tar.xz">libxml2-2.9.1.tar.xz</a></td><td class=3D"size">3.0 MiB</td><t=
d class=3D"date">2022-Feb-14 18:28</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.10.sha256sum" title=3D"libxm=
l2-2.9.10.sha256sum">libxml2-2.9.10.sha256sum</a></td><td class=3D"size">88=
 B</td><td class=3D"date">2022-Feb-14 18:42</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.10.tar.xz" title=3D"libxml2-=
2.9.10.tar.xz">libxml2-2.9.10.tar.xz</a></td><td class=3D"size">3.2 MiB</td=
><td class=3D"date">2022-Feb-14 18:42</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.11.sha256sum" title=3D"libxm=
l2-2.9.11.sha256sum">libxml2-2.9.11.sha256sum</a></td><td class=3D"size">88=
 B</td><td class=3D"date">2022-Feb-14 18:43</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.11.tar.xz" title=3D"libxml2-=
2.9.11.tar.xz">libxml2-2.9.11.tar.xz</a></td><td class=3D"size">3.2 MiB</td=
><td class=3D"date">2022-Feb-14 18:43</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.12.sha256sum" title=3D"libxm=
l2-2.9.12.sha256sum">libxml2-2.9.12.sha256sum</a></td><td class=3D"size">88=
 B</td><td class=3D"date">2022-Feb-14 18:45</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.12.tar.xz" title=3D"libxml2-=
2.9.12.tar.xz">libxml2-2.9.12.tar.xz</a></td><td class=3D"size">3.2 MiB</td=
><td class=3D"date">2022-Feb-14 18:45</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.13.news" title=3D"libxml2-2.=
9.13.news">libxml2-2.9.13.news</a></td><td class=3D"size">26.6 KiB</td><td =
class=3D"date">2022-Feb-20 12:42</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.13.sha256sum" title=3D"libxm=
l2-2.9.13.sha256sum">libxml2-2.9.13.sha256sum</a></td><td class=3D"size">17=
4 B</td><td class=3D"date">2022-Feb-20 12:42</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.13.tar.xz" title=3D"libxml2-=
2.9.13.tar.xz">libxml2-2.9.13.tar.xz</a></td><td class=3D"size">3.1 MiB</td=
><td class=3D"date">2022-Feb-20 12:42</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.14.news" title=3D"libxml2-2.=
9.14.news">libxml2-2.9.14.news</a></td><td class=3D"size">1.0 KiB</td><td c=
lass=3D"date">2022-May-02 12:03</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.14.sha256sum" title=3D"libxm=
l2-2.9.14.sha256sum">libxml2-2.9.14.sha256sum</a></td><td class=3D"size">17=
4 B</td><td class=3D"date">2022-May-02 12:03</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.14.tar.xz" title=3D"libxml2-=
2.9.14.tar.xz">libxml2-2.9.14.tar.xz</a></td><td class=3D"size">3.0 MiB</td=
><td class=3D"date">2022-May-02 12:03</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.2.sha256sum" title=3D"libxml=
2-2.9.2.sha256sum">libxml2-2.9.2.sha256sum</a></td><td class=3D"size">87 B<=
/td><td class=3D"date">2022-Feb-14 18:30</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.2.tar.xz" title=3D"libxml2-2=
.9.2.tar.xz">libxml2-2.9.2.tar.xz</a></td><td class=3D"size">3.2 MiB</td><t=
d class=3D"date">2022-Feb-14 18:30</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.3.sha256sum" title=3D"libxml=
2-2.9.3.sha256sum">libxml2-2.9.3.sha256sum</a></td><td class=3D"size">87 B<=
/td><td class=3D"date">2022-Feb-14 18:31</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.3.tar.xz" title=3D"libxml2-2=
.9.3.tar.xz">libxml2-2.9.3.tar.xz</a></td><td class=3D"size">3.2 MiB</td><t=
d class=3D"date">2022-Feb-14 18:31</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.4.sha256sum" title=3D"libxml=
2-2.9.4.sha256sum">libxml2-2.9.4.sha256sum</a></td><td class=3D"size">87 B<=
/td><td class=3D"date">2022-Feb-14 18:33</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.4.tar.xz" title=3D"libxml2-2=
.9.4.tar.xz">libxml2-2.9.4.tar.xz</a></td><td class=3D"size">2.9 MiB</td><t=
d class=3D"date">2022-Feb-14 18:33</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.5.sha256sum" title=3D"libxml=
2-2.9.5.sha256sum">libxml2-2.9.5.sha256sum</a></td><td class=3D"size">87 B<=
/td><td class=3D"date">2022-Feb-14 18:35</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.5.tar.xz" title=3D"libxml2-2=
.9.5.tar.xz">libxml2-2.9.5.tar.xz</a></td><td class=3D"size">3.0 MiB</td><t=
d class=3D"date">2022-Feb-14 18:35</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.6.sha256sum" title=3D"libxml=
2-2.9.6.sha256sum">libxml2-2.9.6.sha256sum</a></td><td class=3D"size">87 B<=
/td><td class=3D"date">2022-Feb-14 18:36</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.6.tar.xz" title=3D"libxml2-2=
.9.6.tar.xz">libxml2-2.9.6.tar.xz</a></td><td class=3D"size">3.0 MiB</td><t=
d class=3D"date">2022-Feb-14 18:36</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.7.sha256sum" title=3D"libxml=
2-2.9.7.sha256sum">libxml2-2.9.7.sha256sum</a></td><td class=3D"size">87 B<=
/td><td class=3D"date">2022-Feb-14 18:37</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.7.tar.xz" title=3D"libxml2-2=
.9.7.tar.xz">libxml2-2.9.7.tar.xz</a></td><td class=3D"size">3.0 MiB</td><t=
d class=3D"date">2022-Feb-14 18:37</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.8.sha256sum" title=3D"libxml=
2-2.9.8.sha256sum">libxml2-2.9.8.sha256sum</a></td><td class=3D"size">87 B<=
/td><td class=3D"date">2022-Feb-14 18:39</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.8.tar.xz" title=3D"libxml2-2=
.9.8.tar.xz">libxml2-2.9.8.tar.xz</a></td><td class=3D"size">3.0 MiB</td><t=
d class=3D"date">2022-Feb-14 18:39</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.9.sha256sum" title=3D"libxml=
2-2.9.9.sha256sum">libxml2-2.9.9.sha256sum</a></td><td class=3D"size">87 B<=
/td><td class=3D"date">2022-Feb-14 18:40</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"libxml2-2.9.9.tar.xz" title=3D"libxml2-2=
.9.9.tar.xz">libxml2-2.9.9.tar.xz</a></td><td class=3D"size">3.0 MiB</td><t=
d class=3D"date">2022-Feb-14 18:40</td></tr>=0D
+</tbody></table></body></html>
\ No newline at end of file
diff --git a/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/index.htm=
l b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/index.html
new file mode 100644
index 0000000000..b09341efa8
--- /dev/null
+++ b/bitbake/lib/bb/tests/fetch-testdata/software/libxml2/index.html
@@ -0,0 +1,19 @@
+<!DOCTYPE html><html><head><meta http-equiv=3D"content-type" content=3D"te=
xt/html; charset=3Dutf-8"><meta name=3D"viewport" content=3D"width=3Ddevice=
-width"><style type=3D"text/css">body,html {background:#fff;font-family:"Bi=
tstream Vera Sans","Lucida Grande","Lucida Sans Unicode",Lucidux,Verdana,Lu=
cida,sans-serif;}tr:nth-child(even) {background:#f4f4f4;}th,td {padding:0.1=
em 0.5em;}th {text-align:left;font-weight:bold;background:#eee;border-botto=
m:1px solid #aaa;}#list {border:1px solid #aaa;width:100%;}a {color:#a33;}a=
:hover {color:#e33;}</style>
+
+<title>Index of /sources/libxml2/</title>
+</head><body><h1>Index of /sources/libxml2/</h1>
+<table id=3D"list"><thead><tr><th style=3D"width:55%"><a href=3D"?C=3DN&am=
p;O=3DA">File Name</a>&nbsp;<a href=3D"?C=3DN&amp;O=3DD">&nbsp;&darr;&nbsp;=
</a></th><th style=3D"width:20%"><a href=3D"?C=3DS&amp;O=3DA">File Size</a>=
&nbsp;<a href=3D"?C=3DS&amp;O=3DD">&nbsp;&darr;&nbsp;</a></th><th style=3D"=
width:25%"><a href=3D"?C=3DM&amp;O=3DA">Date</a>&nbsp;<a href=3D"?C=3DM&amp=
;O=3DD">&nbsp;&darr;&nbsp;</a></th></tr></thead>
+<tbody><tr><td class=3D"link"><a href=3D"../">Parent directory/</a></td><t=
d class=3D"size">-</td><td class=3D"date">-</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.0/" title=3D"2.0">2.0/</a></td><td cla=
ss=3D"size">-</td><td class=3D"date">2009-Jul-14 13:04</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.1/" title=3D"2.1">2.1/</a></td><td cla=
ss=3D"size">-</td><td class=3D"date">2009-Jul-14 13:04</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.10/" title=3D"2.10">2.10/</a></td><td =
class=3D"size">-</td><td class=3D"date">2022-Oct-14 12:55</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.2/" title=3D"2.2">2.2/</a></td><td cla=
ss=3D"size">-</td><td class=3D"date">2009-Jul-14 13:04</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.3/" title=3D"2.3">2.3/</a></td><td cla=
ss=3D"size">-</td><td class=3D"date">2009-Jul-14 13:05</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.4/" title=3D"2.4">2.4/</a></td><td cla=
ss=3D"size">-</td><td class=3D"date">2009-Jul-14 13:05</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.5/" title=3D"2.5">2.5/</a></td><td cla=
ss=3D"size">-</td><td class=3D"date">2009-Jul-14 13:05</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.6/" title=3D"2.6">2.6/</a></td><td cla=
ss=3D"size">-</td><td class=3D"date">2009-Jul-14 13:05</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.7/" title=3D"2.7">2.7/</a></td><td cla=
ss=3D"size">-</td><td class=3D"date">2022-Feb-14 18:24</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.8/" title=3D"2.8">2.8/</a></td><td cla=
ss=3D"size">-</td><td class=3D"date">2022-Feb-14 18:26</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"2.9/" title=3D"2.9">2.9/</a></td><td cla=
ss=3D"size">-</td><td class=3D"date">2022-May-02 12:04</td></tr>=0D
+<tr><td class=3D"link"><a href=3D"cache.json" title=3D"cache.json">cache.j=
son</a></td><td class=3D"size">22.8 KiB</td><td class=3D"date">2022-Oct-14 =
12:55</td></tr>=0D
+</tbody></table></body></html>
\ No newline at end of file
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 0af06e46e5..ad3d4dea7d 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1401,6 +1401,9 @@ class FetchLatestVersionTest(FetcherTest):
         # http://www.cmake.org/files/v2.8/cmake-2.8.12.1.tar.gz
         ("cmake", "/files/v2.8/cmake-2.8.12.1.tar.gz", "", "")
             : "2.8.12.1",
+        # https://download.gnome.org/sources/libxml2/2.9/libxml2-2.9.14.ta=
r.xz
+        ("libxml2", "/software/libxml2/2.9/libxml2-2.9.14.tar.xz", "", "")
+            : "2.10.3",
         #
         # packages with versions only in current directory
         #
--=20
2.30.2



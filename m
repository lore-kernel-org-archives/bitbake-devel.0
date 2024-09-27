Return-Path: <brennan.coslett@bluerivertech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88459CDD1CE
	for <webhook@archiver.kernel.org>; Fri, 27 Sep 2024 16:10:25 +0000 (UTC)
Received: from mx0a-000e4101.pphosted.com (mx0a-000e4101.pphosted.com [67.231.152.47])
 by mx.groups.io with SMTP id smtpd.web11.73140.1727453417439977269
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Sep 2024 09:10:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bluerivertech.com header.s=google header.b=ipsSmk8i;
 spf=pass (domain: bluerivertech.com, ip: 67.231.152.47, mailfrom: prvs=1000d3c49b=brennan.coslett@bluerivertech.com)
Received: from pps.filterd (m0202935.ppops.net [127.0.0.1])
	by mx0a-000e4101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RG34Jg022810
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 Sep 2024 11:10:16 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-000e4101.pphosted.com (PPS) with ESMTPS id 41wv6hsq1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 Sep 2024 11:10:16 -0500 (CDT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7d4dee4dfdcso2210105a12.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Sep 2024 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluerivertech.com; s=google; t=1727453402; x=1728058202; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KI8ehIxtrgjb2a8RMJHoXjEFLD4HSf2BhzyR7ZCyG0w=;
        b=ipsSmk8i+csxGVY1Qoc8dLY3q7F4YfE1XAabix3C4RcXjHuREeT6aakZjWlbEkRASS
         NLc09eC7a+7tPzgHeUzRn9LC/XbUXFUMeA3DzUaNPEwlLuREcEccpkSRVGNcKeouxUB+
         IRyDfuysj+DhAnZbPhxEU1+qygoT6O2FBigb8SmUB1crKacfT+ioJKAXUBfNMnVZFvzX
         DOsCJcGjL72uT3faeBjqkdP2BEBpUum9O0bvOPh/Flv/Zft+S0Dy+VlXf5ZJdLuNTgMr
         nPNZS2oGnOJ/eaKl3UgyURyBs4ie8XXDdFTO2DAkKOlsms6K4sJ4ueANq8TtFkzZSihO
         4NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727453402; x=1728058202;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KI8ehIxtrgjb2a8RMJHoXjEFLD4HSf2BhzyR7ZCyG0w=;
        b=RhHvqwQTPJAWgvYyB8ZvPA9paTcob4SkRFlvmjnV0QSdX7UDDdwBZ0Y0rTOTpOTsn4
         z6olPX5UYdvL6Mgma3noNrnMfTBM2SPvG698Ryy7ej5vA5ocmfjBUak11yhdrMY7phKl
         TCwK7rWY603MWoC14GZaiFjD5J0bCxAMiv5TvqNzj3lexIZ4BG2izc+qrSx8h0aUAKCN
         eK5J2IoX55i/9U4MXcMPEhU0TzlIRZUQLVhVWnqT9TbG+cYW1x6Ovc3e/OVeIJ1N5/4l
         cdczhtpUPKve1mfdktBSR7u5YVkZcRoCWaCFcYXrWkE6u3IYUh1nMzvCxNMfIWz/j4jN
         /f+Q==
X-Gm-Message-State: AOJu0YxkTiK7/++vwRCWp7WuqbN3N7t1p7ey5seXGKD8ckWof6yHYumZ
	4F5xcOCajx85vHgGh42t9VZFbN2sBoIlLI1PoqDlAls0jMQBgxGAK3AezfKA/uREnuBqs4GC44G
	ADob/OUTLUBvAkGS9L96HWQ/jsJS/2iRrWWC8GozPGiJ7hij5FYOC6SiIhQCFC4PIw006Ec/TeK
	S5Rb5WaF9GMaRPZsSJKSjb6nZG/QaHMfRSvgtNjONzoRuVLHo2II5uyck=
X-Received: by 2002:a17:903:32c7:b0:207:20b0:1380 with SMTP id d9443c01a7336-20b37b7c440mr52957515ad.44.1727453402393;
        Fri, 27 Sep 2024 09:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA/AKjlkYob0nw2bzWTmn2dpu8+gczXsB16uOBMHb0oXK8gfmksOEo+5I1sK9Hxm9yMUADFuAHDlEwl8Rw9kk=
X-Received: by 2002:a17:903:32c7:b0:207:20b0:1380 with SMTP id
 d9443c01a7336-20b37b7c440mr52957045ad.44.1727453401942; Fri, 27 Sep 2024
 09:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240927152225.2516136-1-brennan.coslett@bluerivertech.com>
In-Reply-To: <20240927152225.2516136-1-brennan.coslett@bluerivertech.com>
From: Brennan Coslett <brennan.coslett@bluerivertech.com>
Date: Fri, 27 Sep 2024 11:09:51 -0500
Message-ID: <CAAc_J+_bjkedrH1kj2+qHi=OiEnC9TPxCqpZAVSLiqBs7Xsp6g@mail.gmail.com>
Subject: [RFC PATCH] bitbake: fetch2: Fix systemd template file parsing
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000063bbd006231c163c"
X-Proofpoint-ORIG-GUID: CKfNbc9ljXHob2uO1q7EoOMY7oK2aUvk
X-Proofpoint-GUID: CKfNbc9ljXHob2uO1q7EoOMY7oK2aUvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 phishscore=0 clxscore=1011 spamscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270117
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Sep 2024 16:10:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16610

--00000000000063bbd006231c163c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Brennan Coslett <brennan.coslett@bluerivertech.com>
Date: Fri, Sep 27, 2024 at 10:22=E2=80=AFAM
Subject: [RFC PATCH] bitbake: fetch2: Fix systemd template file parsing
To: <bitbake-devel@lists.openembedded.org>
Cc: Brennan Coslett <brennan.coslett@bluerivertech.com>


I noticed that the archiver was failing to collect any source from
the systemd-serialgetty package which has a very simple SRC_URI:

   SRC_URI =3D "file://serial-getty@.service"

The regex used by fetch2.decodeurl() was treating the unit name as
a user and then returning back a file path of ".service" which the
archiver then failed to find, this adds additional logic to
reassembly the full file name for file type urls. It also adds a test
to bb.tests.fetch for these types of files which only passes with this
change, I had to add additional logic to encodeurl keep the tests happy
as well.

Signed-off-by: Brennan Coslett <brennan.coslett@bluerivertech.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 16 +++++++++++++++-
 bitbake/lib/bb/tests/fetch.py     |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py
b/bitbake/lib/bb/fetch2/__init__.py
index ddee4400bb..3d6973a6e5 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -369,6 +369,13 @@ def decodeurl(url):
         path =3D location[locidx:]
     elif type.lower() =3D=3D 'file':
         host =3D ""
+        # The regex we use above fails on file:// urls for systemd
+        # template files which generally follow the format of
+        # "<unit name>@.service" and split out the unit name
+        # into the user group, so manually put it back
+        if user:
+            location =3D "%s@%s" % (user, location)
+            user =3D None
         path =3D location
     else:
         host =3D location
@@ -414,7 +421,14 @@ def encodeurl(decoded):
         # Standardise path to ensure comparisons work
         while '//' in path:
             path =3D path.replace("//", "/")
-        url.append("%s" % urllib.parse.quote(path))
+        urllib_parsed =3D urllib.parse.urlparse(path).path
+        if type =3D=3D "file":
+            # urllib.parse.urlparse automatically converts "@" to "%40"
+            # which then fails the bitbake self-tests (the rest of the
+            # stack was able to handle this fine) so convert it back
+            # after the fact.
+            urllib_parsed =3D urllib_parsed.replace('%40', '@')
+        url.append(urllib_parsed)
     if p:
         for parm in p:
             url.append(";%s=3D%s" % (parm, p[parm]))
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 4e26e38811..dff7780e33 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -1390,6 +1390,7 @@ class URLHandle(unittest.TestCase):
        "file://somelocation;someparam=3D1": ('file', '', 'somelocation', '=
',
'', {'someparam': '1'}),
        "https://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D1234" :
('https', 'somesite.com', '/somerepo.git', '', '', {'user':
'anyUser:idtoken=3D1234'}),
        r'git://s.o-me_ONE:!#$%^&*()-_=3D{}[]\|:?,.<>~`@
git.openembedded.org/bitbake;branch=3Dmain;protocol=3Dhttps': ('git', '
git.openembedded.org', '/bitbake', 's.o-me_ONE',
r'!#$%^&*()-_=3D{}[]\|:?,.<>~`', {'branch': 'main', 'protocol' : 'https'}),
+       "file://serialgetty@.service" : ('file', '', 'serialgetty@.service'=
,
'', '', {}),
     }
     # we require a pathname to encodeurl but users can still pass such
urls to
     # decodeurl and we need to handle them
--=20
2.46.1

--00000000000063bbd006231c163c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">From: <strong class=3D"gmail_sendername" dir=3D"auto">Brennan Coslet=
t</strong> <span dir=3D"auto">&lt;<a href=3D"mailto:brennan.coslett@blueriv=
ertech.com">brennan.coslett@bluerivertech.com</a>&gt;</span><br>Date: Fri, =
Sep 27, 2024 at 10:22=E2=80=AFAM<br>Subject: [RFC PATCH] bitbake: fetch2: F=
ix systemd template file parsing<br>To:  &lt;<a href=3D"mailto:bitbake-deve=
l@lists.openembedded.org">bitbake-devel@lists.openembedded.org</a>&gt;<br>C=
c: Brennan Coslett &lt;<a href=3D"mailto:brennan.coslett@bluerivertech.com"=
>brennan.coslett@bluerivertech.com</a>&gt;<br></div><br><br>I noticed that =
the archiver was failing to collect any source from<br>
the systemd-serialgetty package which has a very simple SRC_URI:<br>
<br>
=C2=A0 =C2=A0SRC_URI =3D &quot;file://serial-getty@.service&quot;<br>
<br>
The regex used by fetch2.decodeurl() was treating the unit name as<br>
a user and then returning back a file path of &quot;.service&quot; which th=
e<br>
archiver then failed to find, this adds additional logic to<br>
reassembly the full file name for file type urls. It also adds a test<br>
to bb.tests.fetch for these types of files which only passes with this<br>
change, I had to add additional logic to encodeurl keep the tests happy<br>
as well.<br>
<br>
Signed-off-by: Brennan Coslett &lt;<a href=3D"mailto:brennan.coslett@blueri=
vertech.com" target=3D"_blank">brennan.coslett@bluerivertech.com</a>&gt;<br=
>
---<br>
=C2=A0bitbake/lib/bb/fetch2/__init__.py | 16 +++++++++++++++-<br>
=C2=A0bitbake/lib/bb/tests/fetch.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A02 files changed, 16 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__in=
it__.py<br>
index ddee4400bb..3d6973a6e5 100644<br>
--- a/bitbake/lib/bb/fetch2/__init__.py<br>
+++ b/bitbake/lib/bb/fetch2/__init__.py<br>
@@ -369,6 +369,13 @@ def decodeurl(url):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D location[locidx:]<br>
=C2=A0 =C2=A0 =C2=A0elif type.lower() =3D=3D &#39;file&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # The regex we use above fails on file:// urls=
 for systemd<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # template files which generally follow the fo=
rmat of<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # &quot;&lt;unit name&gt;@.service&quot; and s=
plit out the unit name<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # into the user group, so manually put it back=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if user:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 location =3D &quot;%s@%s&quot; %=
 (user, location)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D location<br>
=C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D location<br>
@@ -414,7 +421,14 @@ def encodeurl(decoded):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Standardise path to ensure comparisons =
work<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while &#39;//&#39; in path:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path =3D path.replace(&quot=
;//&quot;, &quot;/&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 url.append(&quot;%s&quot; % urllib.parse.quote=
(path))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 urllib_parsed =3D urllib.parse.urlparse(path).=
path<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if type =3D=3D &quot;file&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # urllib.parse.urlparse automati=
cally converts &quot;@&quot; to &quot;%40&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # which then fails the bitbake s=
elf-tests (the rest of the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # stack was able to handle this =
fine) so convert it back<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # after the fact.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 urllib_parsed =3D urllib_parsed.=
replace(&#39;%40&#39;, &#39;@&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 url.append(urllib_parsed)<br>
=C2=A0 =C2=A0 =C2=A0if p:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for parm in p:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url.append(&quot;;%s=3D%s&q=
uot; % (parm, p[parm]))<br>
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py<=
br>
index 4e26e38811..dff7780e33 100644<br>
--- a/bitbake/lib/bb/tests/fetch.py<br>
+++ b/bitbake/lib/bb/tests/fetch.py<br>
@@ -1390,6 +1390,7 @@ class URLHandle(unittest.TestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;file://somelocation;someparam=3D1&quot;: =
(&#39;file&#39;, &#39;&#39;, &#39;somelocation&#39;, &#39;&#39;, &#39;&#39;=
, {&#39;someparam&#39;: &#39;1&#39;}),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<a href=3D"https://somesite.com/somerepo.=
git;user=3DanyUser:idtoken=3D1234" rel=3D"noreferrer" target=3D"_blank">htt=
ps://somesite.com/somerepo.git;user=3DanyUser:idtoken=3D1234</a>&quot; : (&=
#39;https&#39;, &#39;<a href=3D"http://somesite.com" rel=3D"noreferrer" tar=
get=3D"_blank">somesite.com</a>&#39;, &#39;/somerepo.git&#39;, &#39;&#39;, =
&#39;&#39;, {&#39;user&#39;: &#39;anyUser:idtoken=3D1234&#39;}),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r&#39;git://s.o-me_ONE:!#$%^&amp;*()-_=3D{}[]\|=
:?,.&lt;&gt;~`@<a href=3D"http://git.openembedded.org/bitbake;branch=3Dmain=
;protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blank">git.openembedded.or=
g/bitbake;branch=3Dmain;protocol=3Dhttps</a>&#39;: (&#39;git&#39;, &#39;<a =
href=3D"http://git.openembedded.org" rel=3D"noreferrer" target=3D"_blank">g=
it.openembedded.org</a>&#39;, &#39;/bitbake&#39;, &#39;s.o-me_ONE&#39;, r&#=
39;!#$%^&amp;*()-_=3D{}[]\|:?,.&lt;&gt;~`&#39;, {&#39;branch&#39;: &#39;mai=
n&#39;, &#39;protocol&#39; : &#39;https&#39;}),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;file://serialgetty@.service&quot; : (&#39=
;file&#39;, &#39;&#39;, &#39;serialgetty@.service&#39;, &#39;&#39;, &#39;&#=
39;, {}),<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0# we require a pathname to encodeurl but users can stil=
l pass such urls to <br>
=C2=A0 =C2=A0 =C2=A0# decodeurl and we need to handle them<br>
-- <br>
2.46.1<br>
<br>
</div></div>

--00000000000063bbd006231c163c--


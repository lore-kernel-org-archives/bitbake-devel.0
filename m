Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
 by mx.groups.io with SMTP id smtpd.web10.26326.1611141193233444808
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Jan 2021 03:13:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@st.com header.s=stmicroelectronics header.b=FT/7Fn9M;
 spf=pass (domain: st.com, ip: 185.132.182.106, mailfrom: christophe.priouzeau@st.com)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10KBCaaA012769;
	Wed, 20 Jan 2021 12:13:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=ryU66iGQUGPrBh3kBUf87Na8HyaKLSBr/XmG+AC3MOI=;
 b=FT/7Fn9MlrhWJwVy5Ciff2hTAubffJM3B+9XQlzpyCxTWZWmf3HGn+iNVXJKE01cC7xZ
 2Ap+Hr1Zh8hTtvuIKUC0bW1Up2X1Xn8afc+qptk+DV0MAkpz3TiKSedqKYEgqL3w+9yL
 jPu+HT7caBff5VLmwAnJpoWBij996oOMIpLliTtg2JdCxSF0UhYYYwXh+25/EWeAdjDl
 MjSCp2BU0u4Ftu6GEKLRZEw3REOvd5+9p8wLLYWq7eoFg451FB68+7BFg8GeYyKpWtCP
 lgxUN9XvB88XM7/S+jcCJJOfEM8cUtDsQGHWarM5yZUgtnlwblBE5paAOFEjm/Zqgafq aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com with ESMTP id 3668p4ux81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Jan 2021 12:13:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F32EE10002A;
	Wed, 20 Jan 2021 12:13:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E965A232737;
	Wed, 20 Jan 2021 12:13:06 +0100 (CET)
Received: from SFHDAG2NODE2.st.com (10.75.127.5) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 12:13:06 +0100
Received: from SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b]) by
 SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b%20]) with mapi id
 15.00.1473.003; Wed, 20 Jan 2021 12:13:06 +0100
From: "cpriouzeau" <christophe.priouzeau@st.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Christophe PRIOUZEAU <christophe.priouzeau@st.com>,
        Ross Burton
	<ross.burton@arm.com>
Subject: [PATCH] WGET: update user-agent
Thread-Topic: [PATCH] WGET: update user-agent
Thread-Index: AQHW7x06PowD+XKEXUeBHVe3cFjOKQ==
Date: Wed, 20 Jan 2021 11:13:06 +0000
Message-ID: <20210120111304.3689-1-christophe.priouzeau@st.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_02:2021-01-18,2021-01-20 signatures=0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

With the usage of enterprise proxy, the user-agent defined are
too old and refused by proxy configuration.

Signed-off-by: Christophe Priouzeau <christophe.priouzeau@st.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
---
V2:
 - update of Two User-agent (integration of comment of Ross Burton
 - Test passed under STMicroelectronics enterprise proxy

 lib/bb/fetch2/wget.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index e6d9f528..e952f411 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -52,6 +52,12 @@ class WgetProgressHandler(bb.progress.LineFilterProgress=
Handler):
=20
=20
 class Wget(FetchMethod):
+
+    # CDNs like CloudFlare may do a 'browser integrity test' which can fai=
l
+    # with the standard wget/urllib User-Agent, so pretend to be a modern
+    # browser.
+    user_agent =3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gecko=
/20100101 Firefox/84.0"
+
     """Class to fetch urls via 'wget'"""
     def supports(self, ud, d):
         """
@@ -297,7 +303,7 @@ class Wget(FetchMethod):
             # Some servers (FusionForge, as used on Alioth) require that t=
he
             # optional Accept header is set.
             r.add_header("Accept", "*/*")
-            r.add_header("User-Agent", "Mozilla/5.0 (X11; U; Linux i686; e=
n-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12")
+            r.add_header("User-Agent", self.user_agent)
             def add_basic_auth(login_str, request):
                 '''Adds Basic auth to http request, pass in login:password=
 as string'''
                 import base64
@@ -401,9 +407,8 @@ class Wget(FetchMethod):
         """
         f =3D tempfile.NamedTemporaryFile()
         with tempfile.TemporaryDirectory(prefix=3D"wget-index-") as workdi=
r, tempfile.NamedTemporaryFile(dir=3Dworkdir, prefix=3D"wget-listing-") as =
f:
-            agent =3D "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.12=
) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12"
             fetchcmd =3D self.basecmd
-            fetchcmd +=3D " -O " + f.name + " --user-agent=3D'" + agent + =
"' '" + uri + "'"
+            fetchcmd +=3D " -O " + f.name + " --user-agent=3D'" + self.use=
r_agent + "' '" + uri + "'"
             try:
                 self._runwget(ud, d, fetchcmd, True, workdir=3Dworkdir)
                 fetchresult =3D f.read()
--=20
2.17.1

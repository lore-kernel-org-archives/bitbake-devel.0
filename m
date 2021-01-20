Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
 by mx.groups.io with SMTP id smtpd.web11.25660.1611136251907015518
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Jan 2021 01:50:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@st.com header.s=stmicroelectronics header.b=z11vZC5J;
 spf=pass (domain: st.com, ip: 185.132.182.106, mailfrom: christophe.priouzeau@st.com)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10K9kmih009569
	for <bitbake-devel@lists.openembedded.org>; Wed, 20 Jan 2021 10:50:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=R8bsS2scCeiIdhD6yc5XC2XNbqbaUXBgz6aJSYQDItU=;
 b=z11vZC5JyZvmzqsLD9W0gy6ilt8dfjlrtqyUQ6f5pCyGmrEFQwTUrw6+QELvIg9HYQa4
 kAQ7NpovRWAKMxAFExRWJi9lmoMVQEkArzCJFMDT/v+7SEXVTVoOy8SId1+12mlnjDCd
 UhsXFcFkss7czO93vRqSjKZbg+aG/KptNnvrMhrvitA5L81+py64uPiz7JHwjiP5/rnG
 2C1Mei70CjbhwyrdwA7fpsJiY2NcuEZTO2msA2PFGB/rZk1zcXz2CF4cEhWyjYnEhIcL
 mUJb7ojFvNiyYWbzuO1k5pyb1uPql2L4HTtkONG8DmUQkYwDw+B9BTdmXrVXTs8kSbq7 ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com with ESMTP id 3668p4ucu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 20 Jan 2021 10:50:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 99948100034
	for <bitbake-devel@lists.openembedded.org>; Wed, 20 Jan 2021 10:50:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 378362296EA
	for <bitbake-devel@lists.openembedded.org>; Wed, 20 Jan 2021 10:50:49 +0100 (CET)
Received: from SFHDAG2NODE2.st.com (10.75.127.5) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 10:50:48 +0100
Received: from SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b]) by
 SFHDAG2NODE2.st.com ([fe80::14c2:73ff:db87:a27b%20]) with mapi id
 15.00.1473.003; Wed, 20 Jan 2021 10:50:48 +0100
From: "cpriouzeau" <christophe.priouzeau@st.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Christophe PRIOUZEAU <christophe.priouzeau@st.com>
Subject: [MASTER][1.46][PATCH] WGET: update user-agent
Thread-Topic: [MASTER][1.46][PATCH] WGET: update user-agent
Thread-Index: AQHW7xG6ny7DrdfnskifpLbv4E+4nA==
Date: Wed, 20 Jan 2021 09:50:48 +0000
Message-ID: <20210120095046.31357-1-christophe.priouzeau@st.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_02:2021-01-18,2021-01-20 signatures=0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

With the usage of enterprise proxy, the user-agent defined are
too old and refused by proxy configuration.

Signed-off-by: Christophe Priouzeau <christophe.priouzeau@st.com>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index e6d9f528..98c6635d 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -297,7 +297,7 @@ class Wget(FetchMethod):
             # Some servers (FusionForge, as used on Alioth) require that t=
he
             # optional Accept header is set.
             r.add_header("Accept", "*/*")
-            r.add_header("User-Agent", "Mozilla/5.0 (X11; U; Linux i686; e=
n-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/9.10 (karmic) Firefox/3.6.12")
+            r.add_header("User-Agent", "Mozilla/5.0 (X11; Ubuntu; Linux x8=
6_64; rv:84.0) Gecko/20100101 Firefox/84.0")
             def add_basic_auth(login_str, request):
                 '''Adds Basic auth to http request, pass in login:password=
 as string'''
                 import base64
--=20
2.17.1

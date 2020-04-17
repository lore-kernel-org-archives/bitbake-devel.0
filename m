Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [91.207.212.93])
 by mx.groups.io with SMTP id smtpd.web10.6746.1587117253217496413
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Apr 2020 02:54:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@st.com header.s=stmicroelectronics header.b=Etr/JUHw;
 spf=pass (domain: st.com, ip: 91.207.212.93, mailfrom: christophe.priouzeau@st.com)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03H9lbBs007227
	for <bitbake-devel@lists.openembedded.org>; Fri, 17 Apr 2020 11:54:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=STMicroelectronics;
 bh=k4LVuAkN7U5HzKmxUL0kQ3Ep9TeCxFM7krhxBqjeauM=;
 b=Etr/JUHwSnqrithhRZX2EmEwi4rSgH7Q8utlro2PdyNBTXC+IbaMCfpV1FWIWkz3ygeH
 mWEf88k5KFKqMGPUBaSTZI3k4p6GT4+MOs+PXMoH9RMHA15+EgMU6NM7owvuA1SGDQah
 QiBiAzE4Jg/0ZO9pyK760cfHYWxQRTT46511SrvYmnnl2SiVIM9Q21jUqMR9PzuJ8xrl
 YMqIT7Vn1dBL+WmYiSpuK3PikyYnBq3e+J/fEXCgKRxOHsOpj11XOQahFfd33L1Uqg9X
 /K623ikwYXGre8P0U3U41GQMwe4DDnm2w+9DANqbjRSsBkz+ne368ZkMKbYdmR0Allav Dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com with ESMTP id 30dn8s8ku1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 17 Apr 2020 11:54:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 15C52100034
	for <bitbake-devel@lists.openembedded.org>; Fri, 17 Apr 2020 11:54:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1316B2AF585
	for <bitbake-devel@lists.openembedded.org>; Fri, 17 Apr 2020 11:54:10 +0200 (CEST)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 11:54:09 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Fri, 17 Apr 2020 11:54:09 +0200
From: "cpriouzeau" <christophe.priouzeau@st.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Christophe PRIOUZEAU <christophe.priouzeau@st.com>,
        Christophe GUILLON
	<christophe.guillon@st.com>
Subject: [PATCH] Fix infinite loop while trying to lock file on name too long error
Thread-Topic: [PATCH] Fix infinite loop while trying to lock file on name too
 long error
Thread-Index: AQHWFJ4k6DGrhjE59ESWvqK/ItitXg==
Date: Fri, 17 Apr 2020 09:54:09 +0000
Message-ID: <20200417095407.8505-1-christophe.priouzeau@st.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_03:2020-04-17,2020-04-17 signatures=0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

During a call of lockfile the open go on error and generate an infinite
 loop of bitbake.

open("...._deploy_source_date_epoch.tgz.siginfo.lock", O_RDWR|O_CREAT|O_APP=
END|O_CLOEXEC, 0666) =3D -1 ENAMETOOLONG (File name too long)

Signed-off-by: Christophe Priouzeau <christophe.priouzeau@st.com>
Signed-off-by: Christophe Guillon <christophe.guillon@st.com>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 5f5767c1d..f48a30dea 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -494,7 +494,7 @@ def lockfile(name, shared=3DFalse, retry=3DTrue, block=
=3DFalse):
                     return lf
             lf.close()
         except OSError as e:
-            if e.errno =3D=3D errno.EACCES:
+            if e.errno =3D=3D errno.EACCES or e.errno =3D=3D errno.ENAMETO=
OLONG:
                 logger.error("Unable to acquire lock '%s', %s",
                              e.strerror, name)
                 sys.exit(1)
--=20
2.17.1

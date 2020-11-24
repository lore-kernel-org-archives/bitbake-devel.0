Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
 by mx.groups.io with SMTP id smtpd.web08.2830.1606250189228237125
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Nov 2020 12:36:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@hpe.com header.s=pps0720 header.b=cyh9dOh7;
 spf=pass (domain: hpe.com, ip: 148.163.143.35, mailfrom: prvs=05974f0549=javier.tia@hpe.com)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AOKXaun029259
	for <bitbake-devel@lists.openembedded.org>; Tue, 24 Nov 2020 20:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pps0720;
 bh=a11IoIZyb8KEjFi/pZg5bW3BDYetUYOQUs2bcIi8ywQ=;
 b=cyh9dOh7nYoN/bSULxAXGUR1gWjDYd4eik6tRo0ToY7YVNSFDFj1eVTK1VhNT7Rka+f1
 wA6+TfhZQFoZj98gpHhYFvg4D8ZXM2+FoEyLciuXUSsbYOAwsyaDyEApOY7QTTXyt7iD
 eEHW3VoApLAERXBrA12QHSLThgNobq2tmXfgx7b3QY0JgrGiiX2JszahQQmF30PE105U
 HAuKYW/eZr4sZ89MpEdciHfaJ9dPqKM/qM4/PJ7YKci614sS9lzV2JN+5vAAdcC1lQ9w
 LYM4WGCdWtEl5M4/p/gWGN3PpTvmA5xF5ja8nmEFCFk1Hyydkrae55dCcMdmhoilFiPW gg== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
	by mx0b-002e3701.pphosted.com with ESMTP id 3517pqgskd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 24 Nov 2020 20:36:28 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
	by g4t3427.houston.hpe.com (Postfix) with ESMTP id F0E0857
	for <bitbake-devel@lists.openembedded.org>; Tue, 24 Nov 2020 20:36:27 +0000 (UTC)
Received: from hpnsw4260.rose.rdlabs.hpecorp.net (hpnsw4260.rose.rdlabs.hpecorp.net [15.116.49.55])
	by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id A58C646;
	Tue, 24 Nov 2020 20:36:27 +0000 (UTC)
From: "Javier Tia" <javier.tia@hpe.com>
To: bitbake-devel@lists.openembedded.org
Cc: =?utf-8?q?Javier=20Ti=C3=A1?= <javier.tia@hpe.com>
Subject: [PATCH] Add variable-key quality checker
Date: Tue, 24 Nov 2020 12:36:17 -0800
Message-Id: <20201124203617.35637-1-javier.tia@hpe.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_07:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=403
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240121
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0b-002e3701.pphosted.com id 0AOKXaun029259
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Allow to select between a warning or error message when variable key
replace the original key.

Signed-off-by: Javier Ti=C3=A1 <javier.tia@hpe.com>
---
 lib/bb/data.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 0d75d0c1..ca14d64a 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -100,7 +100,16 @@ def expandKeys(alterdata, readdata =3D None):
         if newval is not None:
             val =3D alterdata.getVar(key, False)
             if val is not None:
-                bb.warn("Variable key %s (%s) replaces original key %s (=
%s)." % (key, val, ekey, newval))
+                msg =3D "Variable key %s (%s) replaces original key %s (=
%s)." % (key, val, ekey, newval)
+                error_qa =3D alterdata.getVar('ERROR_QA', False)
+                warn_qa =3D alterdata.getVar('WARN_QA', False)
+                if error_qa and 'variable-key' in error_qa:
+                    bb.error(msg)
+                elif warn_qa and 'variable-key' in warn_qa:
+                    bb.warn(msg)
+                else:
+                    bb.warn(msg)
+
         alterdata.renameVar(key, ekey)
=20
 def inheritFromOS(d, savedenv, permitted):
--=20
2.29.2


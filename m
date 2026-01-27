Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A262D2FEFA
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 21:53:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1237.1769550804354595901
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 13:53:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@foundries.io header.s=google header.b=gdWuqrAo;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.168.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RKRlSC4002321
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:24 GMT
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by4dyr68m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:23 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-124a95d580cso1306785c88.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769550803; x=1770155603; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhBeqlh+7XFSVtKGkqCNSyVPQct07oOIo+OIdBvLxjs=;
        b=gdWuqrAoo8hZKKXUxnE1ZTemNPQTIBqFAlyxq2WmuyHD8hsjqfItf8ryM10PDQeXsV
         fsV1OI18vJXT+O7PXgwBcSMBJXZqGcDGTLidl0HNDoBulEEE5+7UxZ1kWj4vog0i6YG7
         2JmUcirqvh1k/iwMPcLbxuTwWsoPXyrDch+HqXtl2ER7Qh9rep5Qwz++woSIEfoC+tH/
         HuUPM98tAGoSaYNTKdfaCq1zZv65RV8JDUtv80tpYBMaRdiAU6k2d7TwHd4ucjxXcb5n
         9bySpUtxzqHGj91NnKMCKBCYJ4YmWhjnc7DirvaTzyAlDwMl0wTTNbLcQ3/6xNagMzO9
         F05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769550803; x=1770155603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JhBeqlh+7XFSVtKGkqCNSyVPQct07oOIo+OIdBvLxjs=;
        b=LofGtB/XmqiU++qLThZVhaJ36ZR3Rt6PBfGOljXC8P6w5xIPyeNzrDBpUPiA2ICg8x
         YquNNFJoUQ8hmOzIDPWyIShpeWJr3K8MPoSdNcZL+IlAbgfI6IRuZDGfd9OQ7Ae5ts8k
         fdi+oX32gvONoagodmbNtcnqTyTHfg78ggrGDp6BPdic5+EFphxnDPbm9zGRJkvNBvdH
         lIFd1FY8bmF3DTaX/nLIazfWR7ek4IUkwfaS8t8TXO3wVQVQ6cEIqv+Tr0m/018fb9xE
         EivVXUy3Gv9Wz14VEaBvt0OKjzixfFtFdPilcz0k6pV/lHz3Yn9E5++L7dAUVHC6R2Jx
         86rQ==
X-Gm-Message-State: AOJu0Yy7EUQ+zJQN4MpAMtvJ4DZyRCU3yEXegRCuMrrHuIhRDxqjvYmp
	IonarwVqYa19LPuSIYLr4cJkurO1gUuvec6MdiW8U+y2C6NefjPYl+vqQWHlMpTyKhZooZC1yEb
	YwC5UOgBABq5OmpFkF85khslU1fyuYbug1BdbSs/gskOMZYii7vGaeso4Ux8e8PJxa6i4ynIYME
	SUTn+8eQ2N
X-Gm-Gg: AZuq6aJqYOwgnOEb23/quGM1UUl170FXkXfsDlMhl4ojlLPv+5i8M3sZOccY1KMuWDH
	Ubq8ZFv893lb3qKTFpHIC9nwoji4uJnA/TMP2TGWLsSCAcHk88c25m2yplYSaxCoYwBacE5fZdC
	zOTWKr8vApB/oD+2QMrJSkUNFdWgJv/Qkl/SKg7l890ieHcKv/pnFJbKGA/+DfY86dlHby1RvSo
	RRncwl2bQoAnjID08L7RchbcSybbI9XAF5+1p/INY0RpmwX+MF1CH3lSwKspP4s+FQW5ueOeEET
	cetiMCnQuuh0Wqk3AocMXB5TU3g/INmXO1g4LUoBPzecaOsV1PODnWmmM0H+e2ygZYI652gnqhD
	wBAtFo4cpLHlbVCjMW8vxBQRAtY3kPI4sbh4mIgKPUGhkAc+BdAKL1n6/jiJBVMcKRmwFhn0eVZ
	eTQg==
X-Received: by 2002:a05:7022:488:b0:123:2d38:929a with SMTP id a92af1059eb24-124a00cf0b9mr2095069c88.38.1769550803050;
        Tue, 27 Jan 2026 13:53:23 -0800 (PST)
X-Received: by 2002:a05:7022:488:b0:123:2d38:929a with SMTP id a92af1059eb24-124a00cf0b9mr2095051c88.38.1769550802549;
        Tue, 27 Jan 2026 13:53:22 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9cdcbcfsm31627c88.0.2026.01.27.13.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 13:53:22 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
        Daiane Angolini <daiane.angolini@foundries.io>
Subject: [docs][PATCH v2 3/4] docs: Fix leading text for bitbake-setup init
Date: Tue, 27 Jan 2026 18:53:02 -0300
Message-Id: <20260127215303.512936-4-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127215303.512936-1-daiane.angolini@foundries.io>
References: <20260127215303.512936-1-daiane.angolini@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Authority-Analysis: v=2.4 cv=XqT3+FF9 c=1 sm=1 tr=0 ts=697933d3 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EGU_KJDdnLjsBuGhkGQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: qeae4aXbBnbL0h5yvrlLNsu_mwS7c_CL
X-Proofpoint-ORIG-GUID: qeae4aXbBnbL0h5yvrlLNsu_mwS7c_CL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE3OCBTYWx0ZWRfX66KUuU2QWYLv
 +/OH8vAafs3kc6aOlSPf6t+OV2VSJ2cfzO7Co96pXNTPMtS7b2PrxPNhZmp/NnIQDS2fNESgw1f
 5+kdmsgozKsSQ8uJxm33u9dBq1enrb4OvE66Y+JrOXYJ5t3XomBBkMVT6urcXnlFEHKYdX3gDOv
 W3LMSaGbjkEzF0t7SkLpE3JmWJOY+xMorm8gYq/TZa1o6OeOu5qmi7qvIZvPdgpW6bxGnZNYOIQ
 3SMzwN10oAy6O2O090TgqE/FL7VutTaspVgkQNUc/MER0eHh0Jvit9xAyGNxLxe3WCEC0dBFe6/
 LELxdCdi9Eh/mBkZYucjdIPefCPeRB7FshETGrS/nFYZ49sW08fW35rM308Ks7TD8fTO7yMuIYd
 P/YNnL2GK13xx2cqceeTQAlxFYd0M6dmXPRlBd0ri0T6YyuQrnfB+UejKjCUcZaYnNiHoX9Z+vX
 biZVNos8AHLtQdogBgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270178
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0031df01.pphosted.com id 60RKRlSC4002321
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18908

If we use the default of bitbake-setut init we may not create anything
(as the first default for an empty directory is N).

If user does not chose a number, the script asks again for a number.

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 .../bitbake-user-manual-environment-setup.rst                  | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 6d76e3db4..8d86659bf 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -50,8 +50,7 @@ Quick Start
       See the :ref:`ref-bbsetup-section-config-reference` section to lea=
rn more
       about ``bitbake-setup`` input configuration files.
=20
-#. With the default choices, the ``bitbake-setup init`` command creates =
the
-   following files and directories::
+#. Here is an example of files and directories structure created by ``bi=
tbake-setup init``::
=20
       ./bitbake-builds/
       =E2=94=9C=E2=94=80=E2=94=80 site.conf
--=20
2.34.1



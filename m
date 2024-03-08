Return-Path: <quic_vkraleti@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62529C5475B
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 13:33:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web10.21886.1709904836186462900
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Mar 2024 05:33:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=ftAuvPPt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: quicinc.com, ip: 205.220.168.131, mailfrom: quic_vkraleti@quicinc.com)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428CDsw3005016
	for <bitbake-devel@lists.openembedded.org>; Fri, 8 Mar 2024 13:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=ajddfR9cWCwwuBgQnDntFpSzWjzEk3u6Xcq3eDLMvj0=; b=ft
	AuvPPtsnnzGB5C0rl51vimSukrtL5KuiR2Ypx36FyfRRF6DNZLYoaPvkvMfogIBK
	stl2WnJ1qgNU6X25mDWaSNr49gye8QVvrG63sKvfNHK3XnoshipnzpiImeCGpZS1
	U76vvOJwUI8slj3HR/iGuTJFZObcpmhrZ+GTDB/lpj/3fgBMa/Y+I+tGgl4E38vG
	QGJd91564O4tnwVN4c1xnmfd65sftcsPyJ3sq5USUT8qzmzVBL8/OqlnLIwbZqSL
	ewssgpu/QdQ4xl+prYD1YDJdYpLWxpQTDCqkS+XFHys0YKJUElCIwo6ZVme9SaHS
	pvNwYTxLeq5S6O6jM6HA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8r9urh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 08 Mar 2024 13:33:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428DXt4l031425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 8 Mar 2024 13:33:55 GMT
Received: from hu-vkraleti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Mar 2024 05:33:53 -0800
From: Viswanath Kraleti <quic_vkraleti@quicinc.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/2] fetch2: Fix misleading "no output" msg
Date: Fri, 8 Mar 2024 19:03:32 +0530
Message-ID: <20240308133332.2213250-2-quic_vkraleti@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240308133332.2213250-1-quic_vkraleti@quicinc.com>
References: <20240308133332.2213250-1-quic_vkraleti@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FwVOT5fDB-xeip5-nqgiWJ4ci1axi0I1
X-Proofpoint-GUID: FwVOT5fDB-xeip5-nqgiWJ4ci1axi0I1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 mlxlogscore=808 lowpriorityscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403080108
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Mar 2024 13:33:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15993

When a command is run with a non-null log, errors are only output to the
log and are not returned in the exception. In that case direct users to
that logfile instead of telling the command had no output.

Signed-off-by: Viswanath Kraleti <quic_vkraleti@quicinc.com>
---
 lib/bb/fetch2/__init__.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3529531c..fed36a32 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -943,7 +943,10 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
         elif e.stderr:
             output = "output:\n%s" % e.stderr
         else:
-            output = "no output"
+            if log:
+                output = "see logfile for output"
+            else:
+                output = "no output"
         error_message = "Fetch command %s failed with exit code %s, %s" % (e.command, e.exitcode, output)
     except bb.process.CmdError as e:
         error_message = "Fetch command %s could not be run:\n%s" % (e.command, e.msg)
-- 
2.25.1



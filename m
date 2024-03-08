Return-Path: <quic_vkraleti@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615D2C54E4A
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 13:33:57 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web11.21894.1709904835046648523
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Mar 2024 05:33:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=gsrZPovh;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: quicinc.com, ip: 205.220.168.131, mailfrom: quic_vkraleti@quicinc.com)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428CtIr5015363
	for <bitbake-devel@lists.openembedded.org>; Fri, 8 Mar 2024 13:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=/+2f+/A
	+sTn+Nwps+TgLpamKaJkqNU+SOznQdD3yCag=; b=gsrZPovh0psHYZ8MBXEnAcJ
	cC8KAe4fXAprVwkwAWQnu7CDgic6sjYWXg1wqVL9xaPRnLU8hB+/nHQe7NKh2t7e
	MuTpfPlAh0eBwPlURalN4vA1NnueeJUa+UTfgVOaeIgo9RDd1NSi8IvIvcIonLnl
	tKKC7xJoaalv9UFiIrVtjbjrOxVrt7Gd//rB51MqsW0zR/JkcJq+7oWCVCdepAmt
	5SCJh5pZAdI7JyT4ZTG7i63GCT/O5xKq/Mu71rkuBTX80ExicxXgj+0EXxww0GCy
	N7mRFlTGV7jJDdxrMAjOwSthL0b5tQcxlDFK15rzDRIaOBvyTlOmFcUxVyEZc5w=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqyu60hae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 08 Mar 2024 13:33:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428DXrFj006275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 8 Mar 2024 13:33:53 GMT
Received: from hu-vkraleti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Mar 2024 05:33:52 -0800
From: Viswanath Kraleti <quic_vkraleti@quicinc.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/2] fetch2/git: Add verbose logging support
Date: Fri, 8 Mar 2024 19:03:31 +0530
Message-ID: <20240308133332.2213250-1-quic_vkraleti@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KGTTPBMSqbNGHg8KRmq_x1jkwstRiWrL
X-Proofpoint-ORIG-GUID: KGTTPBMSqbNGHg8KRmq_x1jkwstRiWrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403080108
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Mar 2024 13:33:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15992

Currently when git fetches fail, hardly any log is generated that
figures out what went wrong. To ease debugging introduced a flag,
BB_GIT_VERBOSE_FETCH, when enabled git fetch happens with verbose
logging support, thus user can share required logs at one shot.

Signed-off-by: Viswanath Kraleti <quic_vkraleti@quicinc.com>
---
 lib/bb/fetch2/git.py | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b9dc576d..8193ce0c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -201,11 +201,15 @@ class Git(FetchMethod):
 
         ud.noshared = d.getVar("BB_GIT_NOSHARED") == "1"
 
+        verbose = d.getVar("BB_GIT_VERBOSE_FETCH") == "1"
+
         ud.cloneflags = "-n"
         if not ud.noshared:
             ud.cloneflags += " -s"
         if ud.bareclone:
             ud.cloneflags += " --mirror"
+        if verbose:
+            ud.cloneflags += " --verbose"
 
         ud.shallow = d.getVar("BB_GIT_SHALLOW") == "1"
         ud.shallow_extra_refs = (d.getVar("BB_GIT_SHALLOW_EXTRA_REFS") or "").split()
@@ -433,6 +437,7 @@ class Git(FetchMethod):
         else:
             needs_clone = True
 
+        verbose = d.getVar("BB_GIT_VERBOSE_FETCH") == "1"
         # If the repo still doesn't exist, fallback to cloning it
         if needs_clone:
             # We do this since git will use a "-l" option automatically for local urls where possible,
@@ -443,6 +448,8 @@ class Git(FetchMethod):
                 if os.path.isdir(objects) and not os.path.islink(objects):
                     repourl = repourl_path
             clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
+            if verbose:
+                clone_cmd = "GIT_TRACE_PACKET=1 GIT_TRACE=2 GIT_CURL_VERBOSE=1 " + clone_cmd + " --verbose"
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
@@ -460,6 +467,8 @@ class Git(FetchMethod):
                 fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
             else:
                 fetch_cmd = "LANG=C %s fetch -f --progress %s refs/heads/*:refs/heads/* refs/tags/*:refs/tags/*" % (ud.basecmd, shlex.quote(repourl))
+            if verbose:
+                fetch_cmd = "GIT_TRACE_PACKET=1 GIT_TRACE=2 GIT_CURL_VERBOSE=1 " + fetch_cmd + " --verbose"
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
@@ -555,7 +564,11 @@ class Git(FetchMethod):
 
         The upstream url of the new clone isn't set at this time, as it'll be
         set correctly when unpacked."""
-        runfetchcmd("%s clone %s %s %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, dest), d)
+        verbose = d.getVar("BB_GIT_VERBOSE_FETCH") == "1"
+        verbose_env_vars = ""
+        if verbose:
+            verbose_env_vars = " GIT_TRACE_PACKET=1 GIT_TRACE=2 GIT_CURL_VERBOSE=1"
+        runfetchcmd("%s%s clone %s %s %s" % (verbose_env_vars, ud.basecmd, ud.cloneflags, ud.clonedir, dest), d)
 
         to_parse, shallow_branches = [], []
         for name in ud.names:
@@ -645,7 +658,11 @@ class Git(FetchMethod):
 
         clonedir_is_up_to_date = not self.clonedir_need_update(ud, d)
         if clonedir_is_up_to_date:
-            runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
+            verbose_env_vars = ""
+            verbose = d.getVar("BB_GIT_VERBOSE_FETCH") == "1"
+            if verbose:
+                verbose_env_vars = " GIT_TRACE_PACKET=1 GIT_TRACE=2 GIT_CURL_VERBOSE=1"
+            runfetchcmd("%s%s clone %s %s/ %s" % (verbose_env_vars, ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
             source_found = True
         else:
             source_error.append("clone directory not available or not up to date: " + ud.clonedir)
-- 
2.25.1



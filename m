Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE3C10AB806
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:47 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55626.1774551466637518229
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=T8WSbge1;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcJ3113430;
	Thu, 26 Mar 2026 18:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=bOLMXbc8hguZiZ1S3HP5FY/P6157GT/CdCEFKcGi0jg=; b=
	T8WSbge1iIMyqxS1df2uqbU5v52mYWcGCFyxsdKRygfQzFzW3pkje/OlaVcWSeWy
	JDejNlbU9xGyq4e6pNVm6Mbj6gIXFyV/dc1w0Op3nJJWULWvma1eNL23Fr/llyzh
	IUOBLugkqRdnAkm+swJxZy9hGzObbqTIDHOgzUWGehcfmZ+ewb4lLWi1NJgt2VAh
	zokAQ1xnCH/RTo/rQmqohtKSighvkTjG3fitcgI4qoJKPfeIWprFpKMvw+YUow7b
	qH//c/ztgXwF6QEfXyplWQpwrq9iVjtAw6JtEB5U/ZZvhVMgd9ivdO0WYeg5hYfw
	DbdFh9bh3LuKLo+6nf+CSQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 18:57:45 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 11:57:43 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 11:57:43 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 02/11] bitbake-setup: Resolve unused loop control variables
Date: Thu, 26 Mar 2026 11:57:33 -0700
Message-ID: <20260326185742.542268-3-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VMoXELU8EUhvwFdCxlxrFnzsZTTMXdG8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfX3Yo0JK7NrC6u
 mmfozN93b5qXCoZ9CcTq7rPFxX1ugmDGdOjae09l2zS4J0dBvAzd3bCnQOTqYWOgwNKP/xiC+Od
 lREDUUV/CRQJ6+khcviK0fyZQfyCEwBxN7USwLjbeY5E69t9WG7exBkIETIBoccHimSiAepzDX4
 nU9zD3XmQSadwk90ugaUv3RymEymhQSnJQNhFsOsrlulqu/Ppz8GsFzysmflFmU+cBV2rbz2ZPM
 5XoIEwlgu58SdAoA87lXOW/6Du/EiOimIydPpb0t1YsyIdxhX19e8yzuIJNQe7qjn0jzkhpdMBi
 7OdZMfskKE4ctvb+/vImcTHG3VYmDB5BRcu7KDw/dlJf9uoEdkhIaGiwExoKaSB/BUjzal985ci
 UMzxRkiq565oK70/1OXgYk+tS5y11LEUZZmGityHX6Pos1F1/e0UTN1o3RXdzs1StfKphO+hLEo
 MLe9Ms2g3mt5bukhHNw==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581a9 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=IJQjoT7YMls2vlgdCqcA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: VMoXELU8EUhvwFdCxlxrFnzsZTTMXdG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260136
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 18:57:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19246

The ruff lint tool reported loop control variables that were
not being used:
    B007 Loop control variable `dirs` not used within loop body

Adding underscore as a prefix helps indicate that it is not
being used inside the loop.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 212da4f88..60d324b39 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -133,7 +133,7 @@ def commit_config(config_dir):
 def _write_layer_list(dest, repodirs):
     layers = []
     for r in repodirs:
-        for root, dirs, files in os.walk(os.path.join(dest,r)):
+        for root, _dirs, files in os.walk(os.path.join(dest,r)):
             if os.path.basename(root) == 'conf' and 'layer.conf' in files:
                 layers.append(os.path.relpath(os.path.dirname(root), dest))
     layers_f = os.path.join(dest, ".oe-layers.json")
@@ -414,7 +414,7 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
     logger.plain("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
 
 def get_registry_config(registry_path, id):
-    for root, dirs, files in os.walk(registry_path):
+    for root, _dirs, files in os.walk(registry_path):
         for f in files:
             if f.endswith('.conf.json') and id == get_config_name(f):
                 return os.path.join(root, f)
@@ -818,7 +818,7 @@ def has_expired(expiry_date):
 def list_registry(registry_path, with_expired):
     json_data = {}
 
-    for root, dirs, files in os.walk(registry_path):
+    for root, _dirs, files in os.walk(registry_path):
         for f in files:
             if f.endswith('.conf.json'):
                 config_name = get_config_name(f)
-- 
2.39.5



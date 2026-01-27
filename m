Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468B3D340A5
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14888.1769529916485594113
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=dZLuEe99;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZC880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=dYnHEIL01zf43US/m5Ynn28q9dBjsHpUUoHr3TWpUk8=; b=dZLuEe99r63u
	afIDUXwKKzQYa9C0r15+OVgwkAGWx4hxFA6NHZUiqfWep01tPju312PxSlZr1P9N
	4n/PaJZDnI79ivas0hj6PJCsNeFnKX9YFeyIlGVJ7D5NWCswcrAIxN+gJ2TxboBX
	UPf0GXS4Oaf/AGujj8eO3q80pbPlukwzA6UXAYEpAP8PF0sqIxSnAT9eA9DicZl0
	nih6HyvS72W2m1fSghLgnr30Tidg9fJ4vkFdQKmziNWRkkLYLySHy1utEOOg6Cnj
	Uj3V6lnQgfpB067QxtIVR4S77uP+d7dEmBToIwCifvvNOvRZ+3ECWJ3/Fe+UILrt
	hk3PRLjQ9A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:16 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 27 Jan 2026 08:05:14 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 27 Jan 2026 08:05:14 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 05/10] bitbake-setup: Resolve unused loop control variables
Date: Tue, 27 Jan 2026 08:05:02 -0800
Message-ID: <20260127160508.3392732-6-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: m17v5-rM3qFuGVOg9VIyFC6tWGM5mcY9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfX9Deebjs6Kz5g
 ZX3SqOWsWltIpNqh4pzR3Ovpmjv3Yvp1+LoXKk2LggrOB1snI/JN5TOFheZfmXJpF0X93VOyNW3
 Tl9G/TGQazEXB+dSAtsq/xN2r13oCfEnwT6SAmjgvp6aKxl3zC7xbsabdxMzOKVqVLIxRR5QTFU
 Fo7MpYzMJobVo4dgh09EcdaB2v1NRHX/5WftMBHJ/Z4cgFACsMt2siBppFOY886cf5nDK8JF5AW
 EXwT65v2k7G+VpWVegoQGvhoIfnkl7zGNX3xQIdBHvO1RdSe5ikUMcMtkpM35fqesCs0aWaprfF
 hGtbJIH7EjfHPBBpB8YQTzZqFqmQq8HYFVzjXY3SJj/gikmHbPsPZGMQBUewDkkfTL5dAECyF32
 rcUV/YdyAElbf5JnBvSIinlIBUK2bnQkMQsVKuO1PFEZVsj8E8jZpeb5hMQV7paehOW4y8pLFNR
 A1gsJMq/UV9P1ZrzHPQ==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23c cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=IJQjoT7YMls2vlgdCqcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: m17v5-rM3qFuGVOg9VIyFC6tWGM5mcY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270131
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 16:05:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18894

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
index 2b611864..bfd04771 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -94,7 +94,7 @@ def commit_config(config_dir):
 def _write_layer_list(dest, repodirs):
     layers = []
     for r in repodirs:
-        for root, dirs, files in os.walk(os.path.join(dest,r)):
+        for root, _dirs, files in os.walk(os.path.join(dest,r)):
             if os.path.basename(root) == 'conf' and 'layer.conf' in files:
                 layers.append(os.path.relpath(os.path.dirname(root), dest))
     layers_f = os.path.join(dest, ".oe-layers.json")
@@ -388,7 +388,7 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
     logger.plain("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
 
 def get_registry_config(registry_path, id):
-    for root, dirs, files in os.walk(registry_path):
+    for root, _dirs, files in os.walk(registry_path):
         for f in files:
             if f.endswith('.conf.json') and id == get_config_name(f):
                 return os.path.join(root, f)
@@ -766,7 +766,7 @@ def has_expired(expiry_date):
 def list_registry(registry_path, with_expired):
     json_data = {}
 
-    for root, dirs, files in os.walk(registry_path):
+    for root, _dirs, files in os.walk(registry_path):
         for f in files:
             if f.endswith('.conf.json'):
                 config_name = get_config_name(f)
-- 
2.49.0



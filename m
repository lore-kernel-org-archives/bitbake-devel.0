Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37E5CD98F5
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 21:31:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1849.1781645505827108296
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 14:31:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=g353fVqC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=062707f644=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLVjSr290773
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=HEge4qrUzNScL/ouTtbg/1ISDrfsIW7VBV5kPsT6xwY=; b=
	g353fVqCdg06n0/xBusMTkDHD6DdWYcJYSvTtx6mFnwwWbwcFg5w4d6QU4grl3xx
	f2+vLs0/qUNO/KiAHL6nMenmd49tpCYF7JTT96SC42w0nAvrt5/tI4O67Pc/uRxS
	qUyJw5po2kkxqFck5fg/VQuCzTNmCrs10FEQQhrREV17tmjN99icphduXZ4t5nEN
	rOCJDDmhSZuYdn3MT0BuIm7iMwwWh8PTNvnxTFklE41+HNTTZLMTDMpXs+6P19Eh
	NoyRmy7DdzfOK3Z/CP1UGLhup9CVpXks+qZ1a2fZ8l1iJAArsCxLWzAJwtyFCThF
	s8rWccuCUUn3rgxN2SR83g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbr03v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:45 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 16 Jun 2026 14:31:44 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 16 Jun 2026 14:31:44 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Tue, 16 Jun 2026 14:31:21 -0700
Subject: [PATCH v3 01/10] bitbake-setup: Resolve unused loop control
 variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-add-pypi-v7-v3-1-fe224e3ba878@windriver.com>
References: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
In-Reply-To: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: L67LyQosCydTx6z_lpiLer7CM6rFKJat
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX9tc50Gs7JeHk
 lwKswl4y1H1h/ctOksxEbOn2lK6J24nFpurxlXa4ON7zho62ziWzPdNVBelXXZ3F8vjYlWD+HGK
 U503EsjUPo5M/fTXg6n0si4NSAxnjj8m3hdm5Y1E5DLgtYKKDdIfwDdxibqTGiP4Ra+GkcFELio
 A7T0BEzz8EIldPBDm78c/iVFsS6epI/Fn+i5Fgsm41P0i9dzLGIEE5CLVQ6X6ZfszSfVPF4PFxK
 s+1GjrZ5wram+uZ7tjHN/Ou2Yv5mw6uk2Uei17CWyRn1YMOSHIPmUkRC9q4u05QvDCIcAYUJKDH
 +WQK1ed81pL/ZiJyOZmcOAzBT1W6Vnr0CjpX6I35QelQCDZ8rot3NtWfae7QcS1O3bTo/Q2H1wv
 yEozgy265QUyB2kv9NFBZWc8MI1nFg==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a31c0c1 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=sUOjBdtlMpAVF4UGVlkA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: L67LyQosCydTx6z_lpiLer7CM6rFKJat
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX6Y9LuprxMgjU
 Qs8lmjgHAbRAzGWoeAXwya4BwI6zzoADjvLeMXtJz+wznf/dw6fA2930NPNM2PXISquj7nSJGLw
 NkCpSP8m7Dlw4o2QKwrpIriJofLyhBkTDI0phGXgMwJRf7GBKvUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606160218
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 21:31:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19717

The ruff lint tool reported loop control variables that were
not being used:
    B007 Loop control variable `dirs` not used within loop body

Replace dirs with an underscore to indicate that the value
is being discarded.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 2829e753..508d141f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -134,7 +134,7 @@ def commit_config(config_dir):
 def _write_layer_list(dest, repodirs):
     layers = []
     for r in repodirs:
-        for root, dirs, files in os.walk(os.path.join(dest,r)):
+        for root, _, files in os.walk(os.path.join(dest,r)):
             if os.path.basename(root) == 'conf' and 'layer.conf' in files:
                 layers.append(os.path.relpath(os.path.dirname(root), dest))
     layers_f = os.path.join(dest, ".oe-layers.json")
@@ -449,7 +449,7 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
         configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
 
 def get_registry_config(registry_path, id):
-    for root, dirs, files in os.walk(registry_path):
+    for root, _, files in os.walk(registry_path):
         for f in files:
             if f.endswith('.conf.json') and id == get_config_name(f):
                 return os.path.join(root, f)
@@ -1000,7 +1000,7 @@ def has_expired(expiry_date):
 def list_registry(registry_path, with_expired):
     json_data = {}
 
-    for root, dirs, files in os.walk(registry_path):
+    for root, _, files in os.walk(registry_path):
         for f in files:
             if f.endswith('.conf.json'):
                 config_name = get_config_name(f)

-- 
2.49.0



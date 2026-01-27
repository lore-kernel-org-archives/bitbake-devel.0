Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B2D340AB
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15118.1769529916894885606
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=rqbUsMd6;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZD880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=mpp1Ab61qQydCDxKK/MSSVX6l5kCWDKJSIzlK7WiaVY=; b=rqbUsMd6XtSq
	NUEJ0+6UikUOgwnh/1F7g2CD79d5GaUo8UKxHnEjcUFVfiAaJcVfxlMTTOPlf3wq
	RAWkpaZPWBQerFdg4PV3NFXcfw3ptN2zl8hzUhAwZOVynVnwgGRsVmMC16SLI3IB
	wHquFwJCvN+vQoSvjMAu1sw09X4XgGRX6OchHGEVyDkzeAnNjhvxEu2V6MhjOSXY
	wGpaRXFWNHcUy6dMlGloxARVhc4hDk2fPplW4fJRDRRHDyiRSOUT7oHZdDL2cjXF
	y7I6VklagvQoy/80wx4QO8Gc/26oheedg8WUK2G9t5aXuBp6hagFByTD+P3rN6yh
	P6v1UVYxnQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-7
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
Subject: [PATCH v2 06/10] bitbake-setup: Fix ambiguous variable names
Date: Tue, 27 Jan 2026 08:05:03 -0800
Message-ID: <20260127160508.3392732-7-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bQ24iOK98B-KiGfCNWx4oB2GhwLRteRz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfX28WzUKAqZAOs
 C2eQZSWoL9RafrHIduLq/ImEXMeXJ9G4ep9KHbd5A3PT/O6Uol/cty6EvPUMjr/ym3RFvgxwsAj
 HZvC/UmJyRyS6D34LlzYTU76o+Hk0BLt2SPpvyCcW8NsKb16NmQ8AzQBKbA0B6lTxUBRX40nhEd
 7zvf21X+wR62cnQB1E94do0hj+2fTGvq31pgsZljPd/ZIA1AxYNUJYANcxBb1SwI/ABHvi1WbYA
 R7f6DfW5eAA6V9Ous7DUOOXd9AS0/T9GW/VCLb2ydQ5Ux7nUFvSxDOcQkeWUodWnQV5sMn1VdSr
 KF2rpletIbSQX/JvbB5YSQu0LcHvbfK6UhErbzO83TT+7sQ07e/Y1h3PEvHPwrrHahA9ENoi1u2
 rHBYaEq2c5hxfJVIbyvVKiUaI+hydEkdbaujhOPMBwRpr89RbF+teaV1DjPnYqrJtykUTOuhouE
 AkzApuWgh6JMd3IT0sw==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23c cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=Aatwvv_jfEF2aNKkGsIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: bQ24iOK98B-KiGfCNWx4oB2GhwLRteRz
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18895

The ruff lint tool detected use of ambiguous variables that
were named with a single letter:

    E741 Ambiguous variable name: `l`
    E741 Ambiguous variable name: `f`

This replaces the variables with a descriptive variable to add
clarity.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index bfd04771..59412588 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -204,11 +204,11 @@ bitbake-setup init -L {} /path/to/repo/checkout""".format(
 
     if oesetupbuild:
         links = {'setup-build': oesetupbuild, 'oe-scripts': os.path.dirname(oesetupbuild), 'oe-init-build-env-dir': oeinitbuildenvdir}
-        for l,t in links.items():
-            symlink = os.path.join(layerdir, l)
+        for link,item in links.items():
+            symlink = os.path.join(layerdir, link)
             if os.path.lexists(symlink):
                 os.remove(symlink)
-            os.symlink(os.path.relpath(t,layerdir),symlink)
+            os.symlink(os.path.relpath(item,layerdir),symlink)
 
     return layers_fixed_revisions
 
@@ -217,19 +217,19 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
         os.makedirs(build_conf_dir)
         layers_s = []
 
-        for l in layers:
-            l = os.path.join(layerdir, l)
-            layers_s.append("  {} \\".format(l))
+        for layer in layers:
+            layer = os.path.join(layerdir, layer)
+            layers_s.append("  {} \\".format(layer))
 
-        for l in filerelative_layers:
+        for layer in filerelative_layers:
             if thisdir:
-                l = os.path.join(thisdir, l)
+                layer = os.path.join(thisdir, layer)
             else:
                 raise Exception("Configuration is using bb-layers-file-relative to specify " \
                 "a layer path relative to itself. This can be done only " \
                 "when the configuration is specified by its path on local " \
                 "disk, not when it's in a registry or is fetched over http.")
-            layers_s.append("  {} \\".format(l))
+            layers_s.append("  {} \\".format(layer))
 
         layers_s = "\n".join(layers_s)
         bblayers_conf = """BBLAYERS ?= " \\
@@ -389,9 +389,9 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
 
 def get_registry_config(registry_path, id):
     for root, _dirs, files in os.walk(registry_path):
-        for f in files:
-            if f.endswith('.conf.json') and id == get_config_name(f):
-                return os.path.join(root, f)
+        for file in files:
+            if file.endswith('.conf.json') and id == get_config_name(file):
+                return os.path.join(root, file)
     raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
 
 def merge_overrides_into_sources(sources, overrides):
@@ -767,10 +767,10 @@ def list_registry(registry_path, with_expired):
     json_data = {}
 
     for root, _dirs, files in os.walk(registry_path):
-        for f in files:
-            if f.endswith('.conf.json'):
-                config_name = get_config_name(f)
-                config_data = json.load(open(os.path.join(root, f)))
+        for file in files:
+            if file.endswith('.conf.json'):
+                config_name = get_config_name(file)
+                config_data = json.load(open(os.path.join(root, file)))
                 config_desc = config_data["description"]
                 expiry_date = config_data.get("expires", None)
                 if expiry_date:
-- 
2.49.0



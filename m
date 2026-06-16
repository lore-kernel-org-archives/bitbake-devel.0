Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC2CD98F0
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 21:31:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1851.1781645506349787486
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 14:31:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=UJ0mh8d3;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=062707f644=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLVM0b495812
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=EZOpwPLCPjCphqfLDR/hN1GnkBpuifbGBuiJFz4lKEk=; b=
	UJ0mh8d3cv4QajoFmk/p+wCrgT2lDDDxSGqv97pkynQkz+yQseZJRTLmv3v/RMQl
	9acuxB8KX+XVt2Th8tbQn198x2L3oQX23HdWaYNlAB4XDC54TAKKsPkJU46PAnUX
	idz+dL3yzlalrdKgJrgcDqwYal37IynyVhg0H6uxaA28Pr8mkgE53+xLLhH19jFv
	fTRCTsQi2q/tKiU1YG+cTLX0wT13HNEdh0jZ9p+eN2jWq7nmdPvAjmK/m9WUxrw5
	mDrzD7xIUA9lFy0IfKZ8Cf/dQa72UUVHwxQNCINefdCQ1aKtUYYefsfjbL15CE74
	CkTba8m/D8jIMYqshe263A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eueft0012-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:45 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 16 Jun 2026 14:31:45 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 16 Jun 2026 14:31:45 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Tue, 16 Jun 2026 14:31:22 -0700
Subject: [PATCH v3 02/10] bitbake-setup: Fix ambiguous variable names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-add-pypi-v7-v3-2-fe224e3ba878@windriver.com>
References: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
In-Reply-To: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: VvuqkzOGTwwmAKBjWm04RdO03uCb5tt6
X-Authority-Analysis: v=2.4 cv=B+2JFutM c=1 sm=1 tr=0 ts=6a31c0c1 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=Aatwvv_jfEF2aNKkGsIA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: VvuqkzOGTwwmAKBjWm04RdO03uCb5tt6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX5fl5pIooR02v
 DwpRVXPI+qI+RmAI8sUdLHqSZ980mOC/igDF7ZzRAklXtvtxtTzE07nBVMUXIDnbrLcu4TM3rOI
 SmjSuxr4bdLHVFbZszERDMyFLGviGfDc1rLNvdKFJ/TYdQAFCXP4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX4JdXIOmVICMp
 6oglZO830ylNr4+jJmKqxSxEwnUxyGZ2eLYi2hqdLKS5+MGOIYK0RSpPiXUsf/+DNjcw51v8INp
 Cjo0/ZzZ6pwZawhKG8nP3o73P9R3s8zXqDOIg74jPi5Hl4OzVeu3S072EolMreUh6ue20qlUYIv
 rP+1BRqzBDW83h4pZsjkW81bWlMIwMbPPcwtDMXGzBed3alsoW8sYcoIyu0FsEFJ/UDtWRXPxBg
 jE+Gbuk7RW5XhgkAwBKmTkwg/f4NmVj03jiXDCYLOp+mLN+3x+QnD1iza5NjuNdwUltLyd3dfeS
 6uu4EpOSUJDPtXiP0W8cvKdiT+DV7n4W6YNJmYHc0MLC4YVX1R8DIdl9ncN8iw9zWJI8vCP/yao
 DyaLKUQMfkRqT4Ol/VGSTlY4sHVrQu5MVDF82hIS4hU/fNv2MC6gt4vKlJ2pXCjPDjLmMpGjDvV
 jrQrLor2Go5n9HsBUgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606160218
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 21:31:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19715

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
index 508d141f..664bffee 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -248,11 +248,11 @@ bitbake-setup init -L {} /path/to/repo/checkout""".format(
 
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
 
@@ -261,19 +261,19 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
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
@@ -450,9 +450,9 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
 
 def get_registry_config(registry_path, id):
     for root, _, files in os.walk(registry_path):
-        for f in files:
-            if f.endswith('.conf.json') and id == get_config_name(f):
-                return os.path.join(root, f)
+        for file in files:
+            if file.endswith('.conf.json') and id == get_config_name(file):
+                return os.path.join(root, file)
     raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
 
 def merge_overrides_into_sources(sources, overrides):
@@ -1001,10 +1001,10 @@ def list_registry(registry_path, with_expired):
     json_data = {}
 
     for root, _, files in os.walk(registry_path):
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



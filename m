Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BB510AB810
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55628.1774551467067369589
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=LHma1iTX;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcK3113430;
	Thu, 26 Mar 2026 18:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=7+ErdocRkrHOIpKWr3dg2oKiLu0Gvgg3QYi5aKFtPKo=; b=
	LHma1iTX02vrUPzkpWvujDuZhes1lPdwyUgvfBZ4zMU8Y5TiHBnaId3nFBinsxDe
	/OZ7T90Lmk4kIYPLsgS+iszN7qkV522mOGN0CNiC4Ca3HV42MKvj4scUAYgltBZU
	sDqQ2q0bDWyGzM9PX5EKBEom7OCU2fewa+Lo4rlTomF1fSUHfTVW9LJDegcnz6B4
	jUCpfCBQp1U7QafuQdTUwh4ckVmbX69PrJo8dcLAuybOXJ1DRe+ft6GV/56Lf6lk
	vlyY/NmbItfPwebwMD6vzRuO7o5ld9nt3b++0dkwdMHC6i2jM3VFNr2RXANWYVuP
	5ELJhxRW6UiJwqUs225GdA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-4
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
Subject: [PATCH 03/11] bitbake-setup: Fix ambiguous variable names
Date: Thu, 26 Mar 2026 11:57:34 -0700
Message-ID: <20260326185742.542268-4-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tg9cKQXp5Y3mL9iQQ09tOVuUUhEE4dXg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfX58ME+RwmRtBi
 kMEVv9Z6LYgN2zaCJqCwvo42YhQoRyO/6uBNTj8WBp1HrY6RbJ+74OGtNoALYVibn8iPfPaTso9
 6Sc2dUDBj1H7CziCKUhGMd4aisfegu5sPQjjwVCgZjLU5rEvfYzTjm/ZYbawl1mabPSnBYmHgRr
 1etUiFrQcTW2YDs2ccI36qSDI2DTBi5ZkpIlDDC+TJanHKSuQgqEySE39ASlQete+YXMICc7z1B
 7rowNToL0JMhOBNv8hyTIbUqW66xTTAxYSC4i08ij6NsgiN1TyiRCAcfcd5KMWui31OwY+9sP+6
 ILMXWTUTRjKsqbeqYUZeE1XW5vuf20rLnLWZthugVE8WcvrHYZueRj1KnHRbm/Sev8iqbaTpIsg
 l7fQk1yRKOC7J6D3dYtQ9nTcl0wWI+Vyw5Gu1luFFCuNNRwwQ8zJI7djrqJiT5rEiBJ+jfTbeeh
 uF+pHTsO2C7JR7JnIhg==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581a9 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=Aatwvv_jfEF2aNKkGsIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: tg9cKQXp5Y3mL9iQQ09tOVuUUhEE4dXg
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
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 18:57:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19248

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
index 60d324b39..828459a00 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -231,11 +231,11 @@ bitbake-setup init -L {} /path/to/repo/checkout""".format(
 
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
 
@@ -244,19 +244,19 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
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
@@ -415,9 +415,9 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
 
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
@@ -819,10 +819,10 @@ def list_registry(registry_path, with_expired):
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
2.39.5



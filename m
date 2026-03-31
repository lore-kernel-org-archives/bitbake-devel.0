Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C0610F92EB
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 16:07:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24320.1774973227456063417
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 09:07:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=o4A2rFJU;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V5i48B352519;
	Tue, 31 Mar 2026 16:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=pihGZTyErDUygIr5ObsmyDqUX2L3FCPTPNR22JFtJNM=; b=
	o4A2rFJUeE7MEepmTQTSPJUwglQU1yGeJ5NGu9dhYv2lW1arPK9hI7bqrbpEF3r8
	IVUMfU6ygdHejYgT0sGNnan8daO/UqkyxDxBgG3h8LsM9temqTa8iniUWj6l0suL
	CNKibbM5dvIVsVyX0Xo8l/xus9e1xpdPumA1oYXRXviKGt+VaWQ5xqnMFVCcB/EJ
	sajXmCAlMPqfQZ2j3E3973gfsoDwuRlMhbrQY3zZOg0nDZyhHsKOZwcydTUCuU+l
	bFdufE9dBauDG2mSJNBQLNTPHk9NqW09YJzAhf1X0W2w3KSxDaZAfYeERI21xUqm
	OaAyXOCuRH0/kmQG+nVrMw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4bxjb-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 16:07:05 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 09:07:04 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 09:07:04 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH v2 02/13] bitbake-setup: Fix ambiguous variable names
Date: Tue, 31 Mar 2026 09:06:52 -0700
Message-ID: <20260331160703.3137930-3-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331160703.3137930-1-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cbf129 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=Aatwvv_jfEF2aNKkGsIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfXywTlukZSEBMp
 7y2qWiC9ghFe37TCkFj1x5d7aeRc/INprLDS751Sy3VnTwxT84VxBKZq20g0D/iC3SW5n5BrOnw
 42QNL4p/tQr9j16ldiQbh+Z11MSg0gRB/tIwRIyx0s7Ecxe8xfQU/yScurUym2iefGAcqtZAAdb
 c9rkj7Ejp2CaLDJOUsSiGzgPn5N4LVW7e2xpunQCTWD4zls+rdT4UQU/1EoMVEpDOd7vHFp2hMx
 mZOrxOWc5KinR5TUu1ItUh+Tr8xqN51EHHHAzayfpDmhaQzxF6oVZ3P4G+2id4PlhRxnmIx2DMf
 zpxoBX8j4xXkpeXgyjQ1NnAdl6fXpAoywtJpEBQ77e69wJDyBtywc4QTi6Jud5ciP4vDtTULo3F
 MYMi3C6pzqEBMIQ60stm08izuwGqjZQjh36MAbHhKUQeygCcr29AWiGuvlEEvgF/o+5nODvdx0Q
 V+L7JixL6EUPaWrIZzw==
X-Proofpoint-GUID: 1BbjK0aTXImmxJsxjtk7hO2tnPzShx0a
X-Proofpoint-ORIG-GUID: 1BbjK0aTXImmxJsxjtk7hO2tnPzShx0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310154
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 16:07:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19302

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
index 304fbe6cc..313962cd4 100755
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
@@ -446,9 +446,9 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
 
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
@@ -997,10 +997,10 @@ def list_registry(registry_path, with_expired):
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



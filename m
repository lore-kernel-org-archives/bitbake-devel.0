Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A50D2FEF4
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 21:53:30 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1281.1769550802247873229
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 13:53:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=QCVfuu65;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.168.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RHDtib1980950
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:22 GMT
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by1jx0utq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b75222e9easo17418592eec.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769550801; x=1770155601; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA9D+gOmvMUJO3RRBaFRFNuQ47rZu/dEOy44dlbTsM4=;
        b=QCVfuu65u4BdrbLIQXqR/imM4fBLKcElgr3Cx9u/opq4GoPB8929kNV95UCuGQm23H
         +6LZnd3B1bdjLb8bAeP5xGOuOriJVP4rAgMIBaA8t0P8xwSlSYOx/+9KCz45TeVv4OeK
         MFa8x8RRPHIhryaqT5BqZEtZobw1HVSEqaZoRwdNT2bcRGXU1FaMfpVOqWfEO0Ixr+Km
         indla7JZN5+OT5tOr5rPl9NfFhGRAfBpytteeczYs5q3fRkW4V1SKgTrShbFRjK0AjaK
         q5kbBi1WefmrhdUbKUfJFhqm5cPQysYe5SCsnaGyKCC3OGW+Q/nTvIvAm2xFxGGd/bSV
         3bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769550801; x=1770155601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IA9D+gOmvMUJO3RRBaFRFNuQ47rZu/dEOy44dlbTsM4=;
        b=boH1riK/JGOAl83HHZAlXF+K9w+IbSlJjG/A+AWCHx3K9I2E5cIKLf94mvS6KWM8x6
         WDijFy+5VVrraviP5zhY1ZFEWkuOI+kc8Q6pBuZLdz5PcqS0+AcpFIhifK8/mf4Vf0ph
         PhtqZEXWpdKi2TtVa9XxbCfRVZOJltN1Tva0LDF/eGTE1zigHj5XWVLxXp/E3vMXz18d
         rfm99droPpOTQl6ejxqQJlOZxj8YkkWW/pf9l39kuG8UwdAc8KvE26C9/eh/12C5nl85
         6U2XZhXSuNzHcIntaMn5dfkM3H5KbCnlACDjL+MzPPBcRD6nmrR92KSh+GmmY44nJHwf
         YWUg==
X-Gm-Message-State: AOJu0YwKTaoLg3cRdyCrs/+5Q+U7YWvbGzVzxsFtjgWvxC/fyKQ4aUKl
	SuQeuxIXm0ENXZ3qB9NagDFCnXnEmEspA3BkauFZm1ekYJzilawNrmf1+G5aychwW216suPAYzT
	C9rsE9ZBGTFjK1fxGT6fhoU31e9Jofj1HbpGUNd2O2rdxxJNUFcmOwMBHrJQb2FwsISqrGuBDsu
	mJZPZAR41S
X-Gm-Gg: AZuq6aLLqSEinOzgEB1DdFIjoUaCJuxfgo0esIh8VHToJ72bb94Q6Q9ovk2MfXUG3Mp
	zZISaPfmLD4qagVboUdPC5YOoZeIHDIfzsFiaYEVgb/Ld2QPVgQ9U3VR3TDUIUXgWFhwvEEPpYE
	bOzf7VwkdYteYvfG3bJjZAPPg1b2cyRSsiHfimmiI5SyZsOL61sethp1Z0j1YKpCrDoksBLur1e
	lA+gtt3ksB73hGNWn33zu1KoS2k8ooTz4c8nzbjSroW/Xkk5Gnow2GU4mQ5EpnYALxBYuKE6hfo
	s7aKfB6ytS5J6e7zcGfASVmMxh3otVpgs4GwKR7LSo1wlVuzUZVPQ5K7/gyZYHCDSoK+mV8FGxM
	N/vDhgkJKmw609MNo9DknM43gdN0NUE/YFOrbFR6DqOvuU1LRiyxIXgBa0+/KKF9q/Zsm7RT3hZ
	s1iw==
X-Received: by 2002:a05:7022:fa2:b0:11f:2c69:32 with SMTP id a92af1059eb24-124a005baa1mr1750931c88.7.1769550800704;
        Tue, 27 Jan 2026 13:53:20 -0800 (PST)
X-Received: by 2002:a05:7022:fa2:b0:11f:2c69:32 with SMTP id a92af1059eb24-124a005baa1mr1750916c88.7.1769550800209;
        Tue, 27 Jan 2026 13:53:20 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9cdcbcfsm31627c88.0.2026.01.27.13.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 13:53:19 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
        Daiane Angolini <daiane.angolini@foundries.io>
Subject: [docs][PATCH v2 2/4] bitbake-setup: Change the output to match the terminology in the docs
Date: Tue, 27 Jan 2026 18:53:01 -0300
Message-Id: <20260127215303.512936-3-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127215303.512936-1-daiane.angolini@foundries.io>
References: <20260127215303.512936-1-daiane.angolini@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jb877NcA1lCBvJk8P847xQ_EFzodFrGw
X-Authority-Analysis: v=2.4 cv=duPWylg4 c=1 sm=1 tr=0 ts=697933d1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=LVY25okwlNza5Yhv:21 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1WldhAeflNbf4ZlfaWQA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE3OCBTYWx0ZWRfXwuBQWgpk8WTx
 yIBOka5De1M+qoSf8uwBiKMGKE7/D1hDaDu6l5Zfs+NN0p6sE7GqaXUzPRrBE3NC2odz85c9FF9
 QvkAh+bQKWRj3W7z7Yx+bXw4gwVWnqeR0z7F7rskOShP3c6HwjD0xmLVl2CdEfjIFXRSMH72+6o
 h0qOqyHTBAa/DTAckQf4/F0jGiwQB3TNged5uMcjUMLHouPyXtzNH4WaWYSBkZ0wF7EyPmPoyzl
 RGveu0h4a8rO5Jtli5D9Q+UzaxHE7cBKDSZiadpvck2TiJwj04fg8+vATmZQ95o1/oBMCPhjlxD
 kQy2MKUyWYgdj2qnc9CSIiLiCYldDjcOONXHB2gkEYqELrkUHU+rRz8zIUUZJbZ2Xta8sQpDdio
 iJtg3o8hhR4JHLwTjeJ0h84JvfG17A0Jp7T5YsiNWJANK4ilDyXg5sxloDlF8INlE6gVoiDBGyf
 ENRfZA5hZAGjKrVC2Wg==
X-Proofpoint-GUID: jb877NcA1lCBvJk8P847xQ_EFzodFrGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18907

Make the output to match the terminology used in the documentation for
some terms.

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 bin/bitbake-setup                                             | 4 ++--
 default-registry/configurations/poky-master.conf.json         | 2 +-
 default-registry/configurations/poky-whinlatter.conf.json     | 2 +-
 .../bitbake-user-manual-environment-setup.rst                 | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c8..d3654cac8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -475,7 +475,7 @@ def choose_config(configs, non_interactive):
     if non_interactive:
         raise Exception("Unable to choose from configurations in non-interactive mode: {}".format(not_expired_configs))
 
-    logger.plain("\nAvailable configurations:")
+    logger.plain("\nAvailable Configuration Templates:")
     for n, config_name in config_list:
         config_data = configs[config_name]
         expiry_date = config_data.get("expires", None)
@@ -485,7 +485,7 @@ def choose_config(configs, non_interactive):
         else:
            logger.plain("{}. {}\t{}".format(n, config_name, config_desc))
     config_n = int_input([i[0] for i in config_list],
-                         "\nPlease select one of the above configurations by its number: ") - 1
+                         "\nPlease select one of the above Configuration Templates by its number: ") - 1
     return config_list[config_n][1]
 
 def choose_fragments(possibilities, parameters, non_interactive, skip_selection):
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 1de038bab..f248a4811 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -57,7 +57,7 @@
                     "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
                 },
                 "distro": {
-                    "description": "Distribution configuration variants",
+                    "description": "Target Distributions",
                     "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
                 }
             },
diff --git a/default-registry/configurations/poky-whinlatter.conf.json b/default-registry/configurations/poky-whinlatter.conf.json
index bfa67426d..4827ebe11 100644
--- a/default-registry/configurations/poky-whinlatter.conf.json
+++ b/default-registry/configurations/poky-whinlatter.conf.json
@@ -58,7 +58,7 @@
                     "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
                 },
                 "distro": {
-                    "description": "Distribution configuration variants",
+                    "description": "Target Distributions",
                     "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
                 }
             },
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 76f5c41e3..6d76e3db4 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -762,7 +762,7 @@ They contain the following sections:
                         "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
                     },
                     "distro": {
-                        "description": "Distribution configuration variants",
+                        "description": "Target Distributions",
                         "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
                     }
                 },
-- 
2.34.1



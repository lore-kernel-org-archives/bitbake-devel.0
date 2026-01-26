Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580E9D19530
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 22:28:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33757.1769466490661063631
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jan 2026 14:28:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=VmgA9d1U;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.168.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKgGSN3384245
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:10 GMT
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a09xe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b738854780so5352185eec.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 14:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769466489; x=1770071289; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLG6bnyR0Y+dX0CTeYrYDhKqgTpqVghHhOp9tnjx2lY=;
        b=VmgA9d1UD8oGIQoxxj66utxB8Vu00pmNJbjbvjI7pi8XK8ph1OlMfF5FACAtX9bwBC
         oEn731F9SHGdFHZigAO6sHWeV4SLEtbfEIC6kYIxx75MKLQKIo1kZ+rUng+/WGXkOMvK
         3tUdOQQO8ZmGoQG1idiVZk3Ycvo4QKWyKKGKNYVHNZJK4aOz3fI5qRha1FO3tnWKhggK
         aORt2Li7nyKCvPiZMdO9FCzS8wcifkP1+mQoPr9JsjhRUL+4M4CUUGa8VshlqnuM7vI4
         7MFfl6s+YVsxD8ES0Kh5MFuvVU7g5NjICJaCIwH21ekIYJrAFEvE8+//kfMd3hf1OSlH
         7cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769466489; x=1770071289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLG6bnyR0Y+dX0CTeYrYDhKqgTpqVghHhOp9tnjx2lY=;
        b=f5MNpy+ZQolBtaxAAy2hX5vfKsAQaOTXDr41YvpiUzTlPODj4c+2WIz4HRuefpVkTj
         g8dL98c0we6jH9B925tVFVJ1azdpWArc+MshKH9dZu/f2dWujGq8bCvf8LUKzHkCosq3
         LFh4sIgqkDmTLAAXVci+acPax9v6eTtqrlgAFUvfiuwKIy0LVGw6O/xFwl31PMgkPi7/
         VCAcIkGXDmeiwsC1PfYOaaOU2nEVtx8SIFf/CZJ2VdqRPIc1Yuyb5It/t7steKJ8t1Sj
         f4dkRr6rRqNex99J5J/FgAgUDE1YuLZAC4wi7vxanWPUq9XgYBQEypW0b/XwUS3bpOWG
         qscg==
X-Gm-Message-State: AOJu0YxcAdwmNbukMjEi5EAysdIXaJL4ZTUqEbU7FU8fSfs9HflZmCX/
	nGrikN53v5fLwpxDQ8pLga4XbPy6FPe9H51fSCpk+LvZiaoW2Lzz2EsHAgcRgc/4zrIzVcxcH12
	NFP9Pfdn4U/+JXpdyUDB37xlBEAbDDdJOkka60uMB2ziAtY/pIffvqd/Qt7xz3AdWULlLpjMwyo
	pniZvWo+Jh
X-Gm-Gg: AZuq6aLrMLtFoI7fdohXD5sAYVYyH6GXWwczHDWZen839hvE3OuUR4rtc/26S30wsVU
	uvKtf7bsJDFWyTG77FftoKD3gqA25S4lZtngJa8ySrcC3HO/YGKM4DCMfAjJd7iy9+lsohS/fjT
	h+q27SBrGXrjAQ4bN/xWtU845dbGR5iJgrd2ee23KMTQALWGD1w0gZRoUX792Zp+rWdaQXk5G/z
	GAO+HzucT+BVfhDpN82nFVTqlSj0uMX8ngGyUYA+GcxzJCY/tzUg5AbBOTVxW5c/TXO1hlAPD++
	FceqXeA3cgLJuIDNGbl+nm+LWiFGLfg7xJ6QG+jjNuiVbbfkOmhRpaQbHRmjmLmh15rthXMlOY3
	bjjIhPvnDXAtf2u0hEGqA6lN4LnvnmcLm63QqQO1RMzVdqW4mGuUMQWjLgZpq91kqQCY3/KvxeS
	P2Rw==
X-Received: by 2002:a05:7300:2211:b0:2ae:51fa:b7ec with SMTP id 5a478bee46e88-2b764508d53mr3559103eec.25.1769466488887;
        Mon, 26 Jan 2026 14:28:08 -0800 (PST)
X-Received: by 2002:a05:7300:2211:b0:2ae:51fa:b7ec with SMTP id 5a478bee46e88-2b764508d53mr3559090eec.25.1769466488381;
        Mon, 26 Jan 2026 14:28:08 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6b6227sm15057543eec.8.2026.01.26.14.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 14:28:07 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
        Daiane Angolini <daiane.angolini@foundries.io>
Subject: [docs][PATCH 2/5] bitbake-setup: Change the output to match the terminology in the docs
Date: Mon, 26 Jan 2026 19:27:40 -0300
Message-Id: <20260126222743.411405-2-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126222743.411405-1-daiane.angolini@foundries.io>
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5MiBTYWx0ZWRfX3XCWPPkD/W8e
 osMZpJqoEStpPiKN0TNw0h2Qx+P565ZvjoKAU2xftMrPPJco1pNweq7oF7GcbSQ7Df2T1qwtyks
 TqpSNJE1DKXagZvZvIzZHIsa9tWG4eq1zvgA0vj1yXHmbH05QCC9j9k+kiiXZvEApz+MzkYEq8o
 Q8XRP3t6OuG+QMh0+21SZIjpx415AHhp/1yBDlD2WBvday98mpiM/L4vlEc00UcWKE5V4miWvAk
 9X6OI7KZX1B815juI6oUNmvne4Owck6BkuqwMiDVrGJwSiHzmTZBMpG7E1uvwkXcI8Wthgn5k68
 ZPtr4m9rw6lviEnzmFysb1gh7HS43PUKD6OfqFAQVs/atkuBPtcRkbTCN+ND/rKmXwK60XeKRy+
 I0RlNUBfRKZfl/uBKb/WXNgfV6B/2kCzuTU2z2g/F6X1lxcEfERdDELbepqp5Lr7+GAgLs7l0yv
 TWzOyXE8A6ROKUdUlqw==
X-Proofpoint-ORIG-GUID: FoTecDFOEsVwAoQpfKql8koj0-hm6Ujv
X-Proofpoint-GUID: FoTecDFOEsVwAoQpfKql8koj0-hm6Ujv
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=6977ea7a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=LVY25okwlNza5Yhv:21 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Q4-j1AaZAAAA:8 a=dmwNTU5nqUlyjdgfk1sA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260192
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18872

The original output in the script does not use the original terminology
from the document. This patch changes the script output to match the
terminoly, this way user can search the documentation for help.

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 bin/bitbake-setup                                         | 8 ++++----
 default-registry/configurations/poky-master.conf.json     | 2 +-
 default-registry/configurations/poky-whinlatter.conf.json | 2 +-
 .../bitbake-user-manual-environment-setup.rst             | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c8..65f0c5eb3 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -457,11 +457,11 @@ def choose_bitbake_config(configs, parameters, non_interactive):
     if non_interactive:
         raise Exception("Unable to choose from bitbake configurations in non-interactive mode: {}".format(configs_dict))
 
-    logger.plain("\nAvailable bitbake configurations:")
+    logger.plain("\nAvailable Variants:")
     for n, config_data in enumerated_configs:
         logger.plain("{}. {}\t{}".format(n, config_data["name"], config_data["description"]))
     config_n = int_input([i[0] for i in enumerated_configs],
-                         "\nPlease select one of the above bitbake configurations by its number: ") - 1
+                         "\nPlease select one of the above Variants by its number: ") - 1
     return flattened_configs[config_n]
 
 def choose_config(configs, non_interactive):
@@ -475,7 +475,7 @@ def choose_config(configs, non_interactive):
     if non_interactive:
         raise Exception("Unable to choose from configurations in non-interactive mode: {}".format(not_expired_configs))
 
-    logger.plain("\nAvailable configurations:")
+    logger.plain("\nAvailable BitBake Setup Template:")
     for n, config_name in config_list:
         config_data = configs[config_name]
         expiry_date = config_data.get("expires", None)
@@ -485,7 +485,7 @@ def choose_config(configs, non_interactive):
         else:
            logger.plain("{}. {}\t{}".format(n, config_name, config_desc))
     config_n = int_input([i[0] for i in config_list],
-                         "\nPlease select one of the above configurations by its number: ") - 1
+                         "\nPlease select one of the above BitBake Setup Templates by its number: ") - 1
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
index 824b01ffb..7bbe7cc75 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -347,7 +347,7 @@ In addition, the command can take the following arguments:
 
       $ ./bitbake/bin/bitbake-setup init https://git.openembedded.org/bitbake/plain/default-registry/configurations/oe-nodistro-master.conf.json
 
--  This example initializes a :term:`Setup` with: 
+-  This example initializes a :term:`Setup` with:
 
    -  A custom :ref:`ref-bbsetup-setting-top-dir-prefix` and :ref:`ref-bbsetup-setting-top-dir-name`
    -  A :term:`source override`, and additionally overriding openembedded-core with a locally managed directory.
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



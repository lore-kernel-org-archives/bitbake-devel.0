Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2955D44C48
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 13:22:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35504.1768483353677306771
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 05:22:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=k4C7lO2Z;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.168.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FAU3mp2564331
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 13:22:33 GMT
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bpxhs8cv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 13:22:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1d26abbd8so29795071cf.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 05:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1768483352; x=1769088152; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Si490lgkZcR3a60THtaAcOrHpHaTnjD+EyLsG2fQ6Ak=;
        b=k4C7lO2Z2qXvfMGMGcjPOSV2Gg7w40EinGIc3nnbVt03B0wTpKZbcvi5LHk24QTzvW
         uZ7Hp2i64ZJYR2AqsnD4UwX1jsbQaCk8qNREUiqLMbRZzhISNJSGuHtRCGEiY8aHtyZY
         WGOPMBmLQ0ABiSa3E/70R2Q6h9KJ5vDMdPi5Sdka+knc082UYRUASag14pemcmfo45ub
         Xnf1krEDz78RLlUxS5ZewujDD9LMz+L/f71NR5ipO58nCcUmoGy8YE/5X+zTo2k4EQpN
         mZkXSUF/DGjZSUH4rvVXkKPJd0sugTa4pdPZNOF5hIXqMqaZDQBWr2HBARa2sCrNmMjy
         mf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768483352; x=1769088152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si490lgkZcR3a60THtaAcOrHpHaTnjD+EyLsG2fQ6Ak=;
        b=aoeB4vd+x2pCOjkMwFzfwt4mX3FrfxZEBQVZu1akjeWqWK5LWuo1uTsGJb5zzI/AtY
         AakTdCg6oEuFQOU74ZzXund4xE2OQJ/N1cf3YuCFO7FJc6FweNGaXGhuVSHHSya4BZQO
         iWU75jmwlCiCs6pJIsY+WB5AyXtM5IrZtATKBNR1/UoikY68Kim2vtSn12SUyDZy5pdJ
         iTb3acnUwdIwho+WbSorSnuYk74qYJZLyKmNViCjHuk7B04odHIwuUpXwO7WUzbX8nAn
         pvCHx//6wKwseaMsS81I7MRNpdXXNGo2SdJhT+KmgVIXHC6+hfKrH0eeKa0K073TMEdq
         /N4A==
X-Gm-Message-State: AOJu0Yz5yMvJXx699mNoJToY+v5ZZB9XXNtMAeIiWTc/j+8lS5p8KfLv
	gs4pQ18dwhIvXmcQMPsbfxkAYTPNfr7s9gv5HL32XcAnsHt8pFIXuz/BKV9M0tvCkTPi5D6GTSs
	2Cr7Agw5K38eK7EUp+LFODKiJRRxgDoRoVBOEJ6epDJIg7V3X5C3r8N4jb0ryzn+R42pI8gGd39
	7ShbZnoCJ8
X-Gm-Gg: AY/fxX4Hw/MpRTRemqRi1cbwGmWBlepU2Tb146+qf6xiMdXhdJJHZNiNAMVZ7wW+/ap
	LWZIWFv6lhKo/PDooshXqLG3e8TMbesCVNAf2ReiqpvqI+7GZGHAGIvVcoBTidCs/9nbil/A4sm
	oEXlkHK2zWc3bhxWatmSJ4Go2N9XF5V4VUJ269YjDIMeCU9Q8Z0a8XsJ1+MIkBu0yx2zn+02CpD
	h7QQeX5AcT1u1uO4IRA7L3zFN62vx+D6BUrRsJBrtypYYxT5ICaL6pwlrCcYY+MebRgf/RG1D34
	UG5y1J9wwVhGp6UbXPq/e/crsCfEV08u+wx0HsZeGC2a86kkibux9NTBaI8JE6U0tQvzJzHyEf0
	Av+M3kaLv4dQsttsJulGcwXk9yviLhEx2ky9YNlu6txi8BF97GdA+tNz2kcIuYobTIHkmUuX7ea
	i+2Q==
X-Received: by 2002:ac8:53c3:0:b0:501:50cd:cd3f with SMTP id d75a77b69052e-50150cdcfe0mr43745351cf.49.1768483351927;
        Thu, 15 Jan 2026 05:22:31 -0800 (PST)
X-Received: by 2002:ac8:53c3:0:b0:501:50cd:cd3f with SMTP id d75a77b69052e-50150cdcfe0mr43745151cf.49.1768483351549;
        Thu, 15 Jan 2026 05:22:31 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148ecc817sm32979721cf.26.2026.01.15.05.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 05:22:31 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Daiane Angolini <daiane.angolini@foundries.io>
Subject: [PATCH] bitbake-setup: verify if a configuration file is html
Date: Thu, 15 Jan 2026 10:22:23 -0300
Message-Id: <20260115132223.2034792-1-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FI4WBuos c=1 sm=1 tr=0 ts=6968ea19 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2V6DY6BgAAAA:8 a=445lGB1KyGxMULKEttgA:9 a=a_PwQJl-kcHnX1M80qC6:22
 a=ldqKKs2zR4t-S6fqr-1n:22
X-Proofpoint-GUID: 71mw4tHu7e5Je9pqM3hwEQgmJ7LWZj5p
X-Proofpoint-ORIG-GUID: 71mw4tHu7e5Je9pqM3hwEQgmJ7LWZj5p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDEwMCBTYWx0ZWRfX3R/jTNQCG1ft
 PGK2wT/sC2oDeCVOY+OMcy5NrM2DbL8PY+7dH6g+BpnXeg4wbc+jick8fbsmJUfiUEhFgosc51O
 DaJtKpri0gWi2t/Itc1FtPrLnfuxqTHkJeDpxJ36d8q2cypPDEzwlCJlo1OkU9qtX81q4ksrJL9
 k8xtUGlF4kajhDR1yftZ6nGRb6uofgvRsV6A/IBdGz4JfgVZFD/9nAwnQGfPjBHoHD5h/l2nl0z
 z87WBZ02Ag2irYDhmLfgm/R4bE+Y0+QI0+buLrngzZven8B2BzKu8thhCoXsZFWUoTyFR81rg3R
 oN7vLzOKaPfR2OUggZd0iTLYq0VyVxg838MoB23z+xHmOJ4cf5BJR6+eJ6meW71fZi9TSFDXyf6
 HMeR+jNWTDruDpbL4WVzx59soAgP0K1gu67Niiv4yqAjb0vraHF5IFKt/dZOW5dxdTfgj6fU7Rq
 9WZjouaVM+DR04PqpHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_04,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601150100
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 13:22:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18778

If the file is a html and not a json, lets notify the user.

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 bin/bitbake-setup | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c8..1a1f0cdd4 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -528,7 +528,10 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
             logger.info("Reading configuration from network URI\n    {}".format(config_id))
             import urllib.request
             with urllib.request.urlopen(config_id) as f:
-              upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f)}
+                content = f.read().decode('utf-8')
+                if content.lstrip().startswith('<!') or content.lstrip().lower().startswith('<html'):
+                    raise Exception("Invalid configuration file: received HTML instead of JSON from {}".format(config_id))
+                upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.loads(f)}
         else:
             logger.info("Looking up config {} in configuration registry".format(config_id))
             registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
-- 
2.34.1



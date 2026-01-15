Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF0D4660B
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 18:27:47 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1623.1768501663245052388
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 10:27:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=ajaF5sug;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FFYIH13113515
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 18:27:42 GMT
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq2pm0kqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 18:27:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ffb4222a4eso31162811cf.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 10:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1768501661; x=1769106461; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBEMhCzgKQfdRA5n+LT1zv4eCiJNoG39dkmReYMDS7s=;
        b=ajaF5sugenkv2LPUfvYKE6kWC45AsFhVEbF1TkhjsRR7gY5VVaqzD4bVc/cnV7BAcD
         h7ECQUVpk4d8+UlZZRFvnFr3ojGlXptgOPuBctVf+JVsqi0WvctwSl2cdJR45EmbVCqx
         ozw/4pC4RQuz/kT99Fbj98deFhEIuhrSjTkuyaxkz69QU/LVX13iiGLOfI8fvippHzXb
         U+x1AbkJ/0OO8LwTs+RTz7wEQfRH4ucfd9i0XW1gmJHsBrwyKd9zxSxn8ZrlcM7YgciN
         eyRCtwNo04aNRABlItsIgGysnu3nEXyJMpH/pET6zk8UD0yuPPWB+c3tOBV6EC1xDAQZ
         VYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501661; x=1769106461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBEMhCzgKQfdRA5n+LT1zv4eCiJNoG39dkmReYMDS7s=;
        b=OcD4JWqU3wvMRiUWgSoUCFzVtLYf6PKEdzuY4gzGBhdWdP4sJyuu1FBhueeBzKPjnY
         VcLPeDmPV2gY7+GX9rG+o0p+VcLQDzlyVjxbpMEIczRAm0ZREh2fTiz/dkCWmBio4fSb
         qUzeI4el4xsJqVuSOrkJjaVycJmIApaePqJIqNiIDZjip13SMoP3GeSnDR8pLHqxqGB3
         oyJyeYEkfIYhkDLLLydEQ8PYHlQIMa5offZdMKpMP0+s/uwo3/Ws1Nrbcw4WwsJbylKy
         4Dy3XAKWvUCff4aZFiGrvwSR4uSh2bmugEW/eLWt0wjbpnXea2FT+Sq3JnefMASaDSX0
         dQzw==
X-Gm-Message-State: AOJu0YwvdeMTWkFrd2d8RrkHPB/vnqvf4GM+iSvGt6YzmLRE8D+l5wzw
	6U2HaU/Rcf1YTK9kW50DCC1xxs76Md+8pwKBf0k6JkAW6YwkKrmPvYKVewRunFVkqk4aJ8ihZ7Q
	tlRKMbAwrGYx59BswZGWD1IY6ZPBXR/Sid+V8gWJfFaXZ5xy97ge4FF2w7fJuF75mDxiVV+rO4t
	tXsRCrYD8U
X-Gm-Gg: AY/fxX6kOXmG6wO4E/z6J19Mp7u4TW31NtSwHUYyJdxthYW510GEtTGkxoeDs6lu5Cg
	+/qcboF+FETJf/jX4ECllqpkSeVYN6C8bfNERbLvfcBqsBWrtW22L263Vqs6dI4yIkHdewXX/Ce
	XmMgn0UIu0z6c1VgoXUEZ3SKPRzRwOj489ZhwVIHsrAvyuUXFEbjHt+p9Q5ZqEufeIMc6fKve2K
	VYhFks9La1FMQOgHCZzmT4WTzeCnQwgb3HKv1ANlU03K6fyZRRvpnzw5P8TZBvCU5wmAX0nNEhb
	17IL1avFbW9rngCdXVxYvSIQVCpQ3NIEOwDK/acYQffleAl+28hW0ezZwa5SWAtP8ZS/dOLT+YM
	yIsWT7VKojb0AvV7UTnU2KsU9zizsznwbh9MPK/GdWr8U3DZr1P78rfAovRa8k08wnKyz8/CiOo
	bYCw==
X-Received: by 2002:a05:622a:1453:b0:4ff:b273:808e with SMTP id d75a77b69052e-502a15ebc25mr5746551cf.17.1768501660879;
        Thu, 15 Jan 2026 10:27:40 -0800 (PST)
X-Received: by 2002:a05:622a:1453:b0:4ff:b273:808e with SMTP id d75a77b69052e-502a15ebc25mr5746291cf.17.1768501660483;
        Thu, 15 Jan 2026 10:27:40 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9f480sm1599111cf.13.2026.01.15.10.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:27:39 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: Daiane Angolini <daiane.angolini@foundries.io>
Subject: [bitbake-devel][PATCH v2] bitbake-setup: fail if the url is not a json
Date: Thu, 15 Jan 2026 15:27:19 -0300
Message-Id: <20260115182719.2066962-1-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TVKkKUpyUVR2XaHQWcUEA1TXtqtn2Li8
X-Authority-Analysis: v=2.4 cv=TNlIilla c=1 sm=1 tr=0 ts=6969319e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2V6DY6BgAAAA:8 a=BkmZvL9K1pEJHHFBmHAA:9 a=lqcHg5cX4UMA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=ldqKKs2zR4t-S6fqr-1n:22
X-Proofpoint-ORIG-GUID: TVKkKUpyUVR2XaHQWcUEA1TXtqtn2Li8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE0MiBTYWx0ZWRfX1zMb3XIL3MzD
 05OPNicLP8KMQXRpQDzBRXAeLuXmnNHEzLnW/KM2XwKEj/u8D3TIJSSz+U7O13cvwhHOVm26JT8
 tP9h9QbmJIS6UeX5dNZy8GixGCKC2drB1PCkTpqG1xpKTyNhDPZGjxt+nYyWfR2hosrhnkkVvUT
 j8vF7f791aodprw7I9Gw6zEZ+tD8SVfv0uba8WCukGgN2O37h3FU//QunPJOYMmeYR9vCw/tQod
 se1WcEBlzwmsAsN3/LPE7jlemEs46CEF6MT6Wg8hu4ymE6vTzrsm0XA5+Zby11irZE3G5DNCVe6
 x+wcyq0dE/sb6XzhdLDlqOB8cvGppnUKeL+mrk2balni2sLcdqw4ZJV+q0qCctNT/L3eQBMvZrZ
 VVMPUz/e1G5hdL8+JGbcUCxRBdefSrO7Ui4qmUdDYjo2vdjILgidKLCVYXV3Dd3KGcZORPERa1w
 ezwmrWcrwSBlbBz8NIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601150142
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 18:27:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18789

In those cases when the user enters a URL that points to the html
representation of a json file, and not the actual json file, we can
at least let them know that the URL point to a file which is not a json.

It will help when a user copy and paste a URL from a browser and the
tool cannot parse it as json.

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 bin/bitbake-setup | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c8..f9880feb1 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -527,8 +527,12 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
         elif config_id.startswith("http://") or config_id.startswith("https://"):
             logger.info("Reading configuration from network URI\n    {}".format(config_id))
             import urllib.request
-            with urllib.request.urlopen(config_id) as f:
-              upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f)}
+            try:
+                with urllib.request.urlopen(config_id) as f:
+                    json_data = json.load(f)
+                upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json_data}
+            except json.JSONDecodeError as e:
+                raise Exception ("Invalid JSON from {}. Are you pointing to an HTML page? {}".format(config_id, e))
         else:
             logger.info("Looking up config {} in configuration registry".format(config_id))
             registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
-- 
2.34.1



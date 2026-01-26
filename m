Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B238D19532
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 22:28:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34329.1769466492498698895
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jan 2026 14:28:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=R0yuGdDE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.168.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKgJ3V3707346
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:12 GMT
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3bg9y5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b7155ca88cso4558966eec.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 14:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769466491; x=1770071291; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fT7lu0B0msCLuinqYTxbPwSZ9ApOFX0xq48z7TGck0=;
        b=R0yuGdDEE0rjCAXtpDwR88b+YzaLFMks8tHKsgiXjKYRN7xaTFm2aXH+koBnefSwui
         FFG2tiwBJxqFTiYkk9PDTokw22ZRtLCXKEZ0oErK5n4R4X0zatnyCsXphIbVXCD1hUn8
         6nxs2USsH72os+8uKMVoPqqPmIwbJs4OPX+cve2G2lbC9xBKfAKCVKfwOZNL5pFkWStR
         b+hEEOS+QItCZ47+s2n9Ij+Tq0tz/EQi0LRXSEJjRCXXwaAZED5cKz21Z39LwljODudZ
         Ups2v/kdOM+vcDgt69kEFcKk+MqFJaQ4UfGHEZhbk8Jyr5tQdNlTMDa2qkP2flnMK85K
         A2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769466491; x=1770071291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5fT7lu0B0msCLuinqYTxbPwSZ9ApOFX0xq48z7TGck0=;
        b=CMR9vOypgTDSm6kBpoAKv2yK2oKzh6Z79sg6yN7WsWwipD/pZF6nOUJkTajMFDIOBI
         u7dz556iCvIS8qEV/6X3D79IYFWJth/1eKEDSBNjKvKsflAKivlggNiOn9TTOsEjcmOZ
         aWONKe52qfSn9B+ATWo+NX6mlE5VXOwFMEqNEtCVntUTlgS0gXBNaWqVfwdDipngh3/X
         +JiDbl4laBFicuNer6VvZgGsIV+xadIcn7K5rCqnON50tpMUD5rw3Hslyo3yspHfA5sG
         1AcCWfXJ+okF+ixzvl53EBmQ71OD+RPwjghWWF/AaVD9DycRavDVdGZ0MirIu67FSPF3
         m0HQ==
X-Gm-Message-State: AOJu0YzwIp3FCZQpKe5KAB0JTXrHvWaP19c+j54PDSQXlPki1appjGAX
	ahSbDJ+Hagug6W9p4cjwrVzCgPLaVSq/V5bxt8buA++qXPWqk5Htfy1oZxYlH8YFTeTWxoOZCuA
	fmFvvul8HKsocpeYnZpY0a50gBVdsRtgDSEye8RuetVxjTylEXTtKEs5XZgpYkZuEd2APHTaisN
	/9Aj+MgtkZ
X-Gm-Gg: AZuq6aI2uF6aSadIRaHZitaYAAKYXwUs8nDsVMdmahznMIWZdlXdpf3OmWbpqRPwPLG
	f/m0KUWwt4/DHMbbEXAmeK+AuiUeHOSujnTCdsibWEUliN7G6p3E+6Uv3YdlMMib6pp+KS3hk9N
	LuLYleaAYi6Af/w6yeiix/ueGj5eBgD6DOY1B8yhKIK+MDiQhVryZd7I/Yyld4o/Bf9Ed+aoZRE
	bONpUYfKTR98lMGq95gW7Rl3L1IZrgBH6IFNHMPWjMnyeClykDtlSjsy34lrGjO+db9ZqnuV1nM
	DkVrSgJ2ePyayqs4dEqSfIg2NjtPujyAg2Wi1AQC0dWxsReL7FlNNBxA9akhHu2xz91KDXzoBag
	pfQAhx8wsNR12Hsrtdzs4ENCd7qt1SG1DkFV7KbsIaJUg9SWN6SkrpAnzT8RB0xw/ilrskpQb2c
	cdUQ==
X-Received: by 2002:a05:7300:1483:b0:2b7:1e86:35ee with SMTP id 5a478bee46e88-2b7644f24d7mr2750578eec.28.1769466490928;
        Mon, 26 Jan 2026 14:28:10 -0800 (PST)
X-Received: by 2002:a05:7300:1483:b0:2b7:1e86:35ee with SMTP id 5a478bee46e88-2b7644f24d7mr2750570eec.28.1769466490525;
        Mon, 26 Jan 2026 14:28:10 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6b6227sm15057543eec.8.2026.01.26.14.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 14:28:10 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
        Daiane Angolini <daiane.angolini@foundries.io>
Subject: [docs][PATCH 3/5] docs: Fix leading text for bitbake-setup init
Date: Mon, 26 Jan 2026 19:27:41 -0300
Message-Id: <20260126222743.411405-3-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126222743.411405-1-daiane.angolini@foundries.io>
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nrAkPZcjNFhYdnOyhkMhCwLG6wmGH3Ku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5MiBTYWx0ZWRfX5gJlKwdjl6ds
 954F7+utJkGKs+J4gNIw0znE6MS7737kKnYKLmanjn8YM+5GAiSPJIxCGOMmXpOgQmuf6lvYFKT
 XFhG2+gvBEDeyi304lTnlSMYKmeGfOAcSeYvwyvvsH3swxD8x6DL9PeM1dTzuMicWGLUW8VnKn1
 SGw16VGIM1U6LVL8H6XV4lmiFkJ8TGdOd3Kt5HbjK7lh+0XE8ABt2V5b/WcIC+gFW/KZtyxYKYz
 DKZdxFotjnH3IDcT6CckJhuzmTR9wr2vtaWkM9EOETMLrv4kxULToKs7ttfiOaJRY+l+HJKjtXV
 5JxpcUkZKv4W+brGwFd8Aq0IbmyYsgcxrDdgcsF8QDnVfdWNxromr9axB0eX75fDnXzgbAIm6R2
 19+HKq3mbWwT5wwiOVcTJ2yA5XBnXbMofYLmTK6kr9Sv05pgw/ehTDIpcKWVg1icNo01HLkl9+O
 xWfu0vJNG5q1kq47FIg==
X-Proofpoint-GUID: nrAkPZcjNFhYdnOyhkMhCwLG6wmGH3Ku
X-Authority-Analysis: v=2.4 cv=AOFXvqQI c=1 sm=1 tr=0 ts=6977ea7c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=5bBFTqW_sXXhRPb7D7UA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260192
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18873

If we use the default of bitbake-setut init we may not create anything
(as the first default for an empty directory is N).

If user does not chose a number, the script asks again for a number.

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 .../bitbake-user-manual-environment-setup.rst                   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 7bbe7cc75..e316ead56 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -50,7 +50,7 @@ Quick Start
       See the :ref:`ref-bbsetup-section-config-reference` section to learn more
       about ``bitbake-setup`` input configuration files.
 
-#. With the default choices, the ``bitbake-setup init`` command creates the
+#. One example of ``bitbake-setup init`` possible command creates the
    following files and directories::
 
       ./bitbake-builds/
-- 
2.34.1



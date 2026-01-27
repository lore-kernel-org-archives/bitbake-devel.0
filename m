Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33A8D2FEF8
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 21:53:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1240.1769550807783916639
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 13:53:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=mP+6REVT;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RH80Wu1268770
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:26 GMT
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyauf6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:26 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-124a710003fso106901c88.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 13:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769550805; x=1770155605; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz0uqWgQ1hdqBdE8i4ul6Oa/CAVX7Z5/wVEh6XPOWlc=;
        b=mP+6REVThmv72VEP8WQksISFKajg3LnKbj/oWJYqt0DO/xXbkum4RSz5EFLX+dh0lH
         ub6EzjSvGXuVPvWi9m+TrvYKn29wXZaG87pmq/dr4470A0O5LuMVPkfkVeuBXRFOOiQy
         OFdrSDfsZB4wVwlcTr+rMyNvqeYHiRw9cNic2HGONWdlaiKLECCKnB02XRSk2Up+dk/m
         xkeb4DbFO8/d+TRmUSaj6PopeN5ZTGG/rL2gANYB6ULVv3fNp32JUTkZd4117g2YFnLj
         GG/scLQYPsfvhtge7jPlcIByG+StAYiho9Idb8r+ZIP5ynapLk1c35hmBX+7KYRwXYKj
         TIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769550805; x=1770155605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wz0uqWgQ1hdqBdE8i4ul6Oa/CAVX7Z5/wVEh6XPOWlc=;
        b=CIZ+/CAVClxgCQb0q8LGmRWsMoQaqnqtbv18+d4C+RNXPvBPqg4vBU5UesKsot0wYP
         MrWTqvK8uwlEtqOP5ykCW6iO9zLE7y6DjBOtyTUbip6OLdeDTfbxPe/IctTQZTqOOuQF
         3lGJMi8AQb1Nb7kXoVMLlJK5ay0TV5vzbRjK2rQpXd4kDdrkQKY+saLA05jjlIoh1SvA
         M4Sb9sjgjpT0QyOmhOpgmoDF/esaIjpELOABrTdYaHmEuIj+XKOIBTd8PifyZU6j05hO
         GhjPYbcIpNKdlSxNc6GIp/z8rbuLocLdfJh865X19EdGs8mf1O2Yad3q8ypexv/I4Y7D
         l5TQ==
X-Gm-Message-State: AOJu0Yy+qKTL+c8TM++ClpxGkLpqkTNy0KKkuLfvQXhviyM5mAEhi7Ui
	51TfSH9uA2FvxzjTSODqJApMczSBBy5I0qU2TSB5oMnBgxpltFHH6oK8/oCHTTcHx+xCo9qXzan
	q5Zh8Z0EF47WPELQX6fZCLP/yej88FxJbuFZ7DM6WnKkxn4J+aOR4xdgA6sS/iFhMRt4OU/Q/fp
	GG8f0Hgvg7
X-Gm-Gg: AZuq6aKOHJgI7br8S9waaxbJZplb0BMnau213Uf9A2dSeyFGqNdoijt77X8wvYYwMcf
	cSFeeydnXF4lSpkbKPfoq+DaMGFWaMLN3XkdeTMVmPJaZrof9onXEYENFwnPwRCRlQ00zvtdfMn
	7KV8uANYPB63nJzGipWfwvvt/Xd7JhwLGO/HVuFDbHqUWubvFBRr5Dug7JtJYvfylatAhdJU2bQ
	IUZNup73WzDscs/UpVv5DzrSneSCLZx2HkvwpoOlZu0Nz2k9CpA0jEkJY5bQmUMt2FnsK+6WXQj
	QJdLU6pQsj0a6f8EbSk9SnHRelT39hema2dejh8BbEhE+mN7ITOYKULVQneVQzzJuppo+PoELWs
	l1NsG2b/noG7Peg2CuVFsRXXlYHefyZ+fM55p/5o8XFg50gerAnZC4mvt+2NGyMcdlQbw46LlHu
	+OgA==
X-Received: by 2002:a05:7022:90e:b0:11b:f271:835a with SMTP id a92af1059eb24-124a05796c7mr1775789c88.3.1769550805247;
        Tue, 27 Jan 2026 13:53:25 -0800 (PST)
X-Received: by 2002:a05:7022:90e:b0:11b:f271:835a with SMTP id a92af1059eb24-124a05796c7mr1775771c88.3.1769550804792;
        Tue, 27 Jan 2026 13:53:24 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9cdcbcfsm31627c88.0.2026.01.27.13.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 13:53:24 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
        Daiane Angolini <daiane.angolini@foundries.io>
Subject: [docs][PATCH v2 4/4] docs: Fix sources as required
Date: Tue, 27 Jan 2026 18:53:03 -0300
Message-Id: <20260127215303.512936-5-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127215303.512936-1-daiane.angolini@foundries.io>
References: <20260127215303.512936-1-daiane.angolini@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fMK7K_CBwb01ktmr7GGyAlHDCEczd464
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=697933d6 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1OdKnqY07euSGrlipCwA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: fMK7K_CBwb01ktmr7GGyAlHDCEczd464
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE3OCBTYWx0ZWRfX8IT4kJba7KWc
 zOcfOeVyKpN1alxqk29LJDjZ81GFOmtSiAzRslBPQXPuD9hm4j+YkTpAkGQAlp3U+5tGUy2Bu47
 5G/acVsXlYQOf3xPcUf8ZKs1ysZvAYn1IFfTqpZHt6XWIwfkPwmNf5hASVUR91uc6Z99OZqyuCY
 ZxCyT7umlLJr5VJw6XDCC1I+EwwOgniqFO5LbHCugqaYtaVFUBWrMCZCTBznJu7Bd2BVzEvEyLp
 h63bJL3QSP5doMZdvW3lzxXkCxhNTW2eCLN0TVhhcg2s4Jcb5WrNJw2Ll71e+QWBwewwR1QZdkj
 0pucYROHKEZFrUJaMtQ12Fpwc9WsaHkoEhMqcC4lGbNBD1oywlXbcL3Vn7iRpaud5Keq3SoFFE6
 slI4QczwhI1mmTy5JLlRee8fNfy7qY8ow6tQ7fZhDwAnzRQE+GdrMMbgJAjtIxklP7PlS64eagX
 mpEGHF/h+vHI9/ZSowA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 21:53:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18909

If sources is empty, nothing happens. So let's just not say it's
optional, and let's say the minimum is bitbake source code.

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 .../bitbake-user-manual-environment-setup.rst               | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 8d86659bf..fdfefac0e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -660,8 +660,10 @@ They contain the following sections:
           "description": "OpenEmbedded - 'nodistro' basic configuration"
       }
 
--  ``sources`` (*optional*): sources, such as git repositories that should be provided
-   under ``layers/`` directory of a :term:`Setup`.
+-  ``sources`` (**required**): sources, such as git repositories that should
+   be provided under ``layers/`` directory of a :term:`Setup`. Although the
+   list of sources can be very flexible, at least BitBake should be cloned
+   to generate a :term:`Setup`.
 
    Example:
 
-- 
2.34.1



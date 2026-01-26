Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA82D19528
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 22:28:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33761.1769466496228357229
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jan 2026 14:28:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=CXqUlcJp;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.180.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKgPfK3399324
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:15 GMT
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxdv9gjt5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b6f0b345e3so23873945eec.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 14:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769466493; x=1770071293; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFCEUUgWDqmsNldatAZmr/rljlDaOIPSpMPKTpXcvJA=;
        b=CXqUlcJp/dDQpwfNfYRCXRvAhK/8wZHK2a1tP8tuAilZ+E966F+6zv/IecBBK7gIPp
         kUlyGG2AjZ5DG+LO+fSo8gkRapqh+sun4owTxR92C977OLQsZjKs+PJinrXagAcfwt3q
         go+rSVxCGwtSHfhD1uZTCF9chca07vOkiVuhAfC3JhybQp6AKiQpNUV2ZNz3TqcwbK2w
         wLaH9vjN9H/5YVsamffRC/MAd40NSZAPNFoo9bTo4OOiXjSmVv6fWKH2EKkLcjjgyuba
         4TVD29umUcQSbT3akeo6fYB/Hocj4CpfeESnbXEY7lb/ksdKG3qqyMhrJ+2M6nATRXIh
         vr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769466493; x=1770071293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yFCEUUgWDqmsNldatAZmr/rljlDaOIPSpMPKTpXcvJA=;
        b=gdNB8u92HkuNo4GJy39DHlM7wAZs9OnUF4F4/9QlX/sxKUezg1LmI/0//DRwUlRI7U
         HWxnDr8gzXJyIeFke5GsmE/VdroHH/Munt1k2X0Q0uQYWnKNnpFIXcO3/kybkDrygKMB
         Id8x26RGvyLliTaRLXJYVymKgwxerkDlcnaHR5m3AF5RKNcNSdyun8yBJaoxiFqH2VbP
         jYkMKGZLHoWTsNTOUN6yXBYCgVhYQW1YKO3Plp613sgQMAuUoLge8zd8qqsKNgMV29yz
         bVIlsfHtADFAMqS91vcmZhRkQXAizH8vcjFUZs4griJCZBbwLL3TvXrAgFsvT8p9RyQz
         uiVA==
X-Gm-Message-State: AOJu0Ywll84ZRooOz8Bu9yWA7pwckfErPzj2R+2Ar8z8/AC8w9D7n0Hr
	0NS/zob8CHgTly2s8rCYSX65pchk1zVQsKnfJGreC2zICVSey+wz2N+G3Fmbt93sRq9yBsJhAJn
	Pgo+J6uurWgwEAdZDyKmp+CS4Djdh4vQl37IZbIFLFR6u9LwGy5LYP3uFW9UY8+4PCjB3x6plgx
	64mxssUSlH
X-Gm-Gg: AZuq6aK1IBi0U0r9kLKeG+/6rZNtHCGopTqp9XevBG06w+51I0Zamccb7kw3ld/BQHG
	jAerZwIVdTBS4vmbPU5atRUXAJ/eH0oSwKR+MvcCf78sxYhcPKMLXpdC1kGiDtOaIeThOx5hY+h
	L43eJXJjk1skV2fvKIIJ1qQ1KE6lYeJvMjfz2pbzWX5nf2VIAzzfdRQBMSD/f0blxGAYUuZetOa
	0UetT99RAVOpQt8hMr+AKe67TbzGMImmVwOtG46jgMtz9B1t7bN+cEMEJaqeOXSUXzt9rdmlmhw
	xcop+4IeGLYKpODzGyu/zgbvBaHr8KP/1oTINrvY5R+X+WGGUGbq3oJDldOGrqFK2RCPZjmGkDU
	JXiWW4hWtI1X2R/HKlpm5rEZcEUG1jEBu4ElWFzADTXXf/qe63929Vf4Qs4GslYrj7zNO4uPzv5
	btwg==
X-Received: by 2002:a05:7300:cd9a:b0:2ae:5ab4:e932 with SMTP id 5a478bee46e88-2b764628d6bmr3226025eec.43.1769466493498;
        Mon, 26 Jan 2026 14:28:13 -0800 (PST)
X-Received: by 2002:a05:7300:cd9a:b0:2ae:5ab4:e932 with SMTP id 5a478bee46e88-2b764628d6bmr3226012eec.43.1769466493101;
        Mon, 26 Jan 2026 14:28:13 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6b6227sm15057543eec.8.2026.01.26.14.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 14:28:12 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
        Daiane Angolini <daiane.angolini@foundries.io>
Subject: [docs][PATCH 4/5] doc: Add the term Variant
Date: Mon, 26 Jan 2026 19:27:42 -0300
Message-Id: <20260126222743.411405-4-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126222743.411405-1-daiane.angolini@foundries.io>
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OYOVzxTY c=1 sm=1 tr=0 ts=6977ea7e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KQc11KMpeXEtGPe8wygA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: 03vyedUXCqK2ydIAHVdD5QQSxAxYbtqA
X-Proofpoint-ORIG-GUID: 03vyedUXCqK2ydIAHVdD5QQSxAxYbtqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5MiBTYWx0ZWRfX1/CuerplZRWo
 ObYEAOmO1FE+G6WEutsBklh/PIgniTAgS8MpTigFCqpLjmUJw0eeh0ZMWIw9LB19YneYP4aebS9
 Sr5WBUdCnBeRvTJYNxf6fM4twj50kKOZKoqiYcRODcGWtn92jB9p7iSgBUjYVR6kLOsjjfXuWrm
 VDmgIxbfOWq0qfwv+Y8XC6AOAmvftB773TPRDSbdc21CeTQKQsxIwq66nRuRqEd9HSpkIUaLe5u
 Nq1IZQbdgkYXSGYKD5IyCdkM1hOTwDcMB571Bja5+gGBWWhnnvtrKBRzuN6b6wVaDDNTZbaV9o9
 rZANVPu5/Pb26Rgpd+DGWi02PN2C08oDmV/cgpZnkVOHyx6OKuOJ3UpRmGLLAtTUDNXFgSNXCwf
 PvELpAgQv3Hh+qaeTwERnAtdEVujnL6Hybl7KPovRYuAQ15qASgUYj1Qed7re2wUJ3Ecs4B9xRS
 QfXUR+ejLNQ7i023zww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260192
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18874

It also add a description for the term based on the concept that a
variant is a fragment or a set of fragments.

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 .../bitbake-user-manual-environment-setup.rst          | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index e316ead56..700e02216 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -212,6 +212,16 @@ The following components are involved to create the content of these directories
       It is also a Git repository, that contains a history of the setup instance
       and updates made to it via :ref:`ref-bbsetup-command-update`.
 
+   :term:`Variant`
+      A Variant is a fragment or a set of fragments grouped under a name that
+      makes sense for a project. It is a nested configuration within a
+      :term:`BitBake Setup Template`.
+
+      A :term:`BitBake Setup Template` can contain multiple variants. Users
+      select among them during the :ref:`ref-bbsetup-command-init` command to
+      customize the :term:`Setup`. Variants enable scaling configurations by
+      sharing common parameters in a parent while differing in specific settings.
+
    :term:`Registry`
       A configuration registry is a place where one or more :term:`BitBake
       Setup Templates <BitBake Setup Template>` are stored.
-- 
2.34.1



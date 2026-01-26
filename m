Return-Path: <daiane.angolini@foundries.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C64BD19526
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 22:28:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33762.1769466497019039431
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jan 2026 14:28:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@foundries.io header.s=google header.b=I78DkQ9c;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: foundries.io, ip: 205.220.168.131, mailfrom: daiane.angolini@foundries.io)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKgsMP3481823
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:16 GMT
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bx0v32tdg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b715b26fc3so6717275eec.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 14:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1769466496; x=1770071296; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY2krERVNMW1rY9Sl0iRg3yaPXKyr9CUfjCuYN8uong=;
        b=I78DkQ9cwhKg9oWaAhm+/wWA280T+IdWbuOXD7gQte47kC0ZV4j6rApdtk5W7NNlra
         nuD62C7Am4T6a71Mzmy99dMf+qPx/H5KrVLCbLDieezgbh76eilkl8heJ912fnymzSTZ
         v2a4qOG/XhIBpWj5pz8Q/OtgPrzsLRSTg7qok/dDHQHh25mkcgXdZ9X3jZy966/fVCrl
         wjX84jAOy3vSqBFdyQA/r30Dga3Xr1wRjahhtHPW5Zf+1R0J4zSgIiLYG/igI5eD8Sj8
         XVj4C5bJ2g3tgqy9I/rj4JhRMl4vgbRIUH7cEwbsZf6rXrr7ISTPq6fLyBABDZNH3ghq
         tBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769466496; x=1770071296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dY2krERVNMW1rY9Sl0iRg3yaPXKyr9CUfjCuYN8uong=;
        b=DTqMGxXn2GWIpnU1HoLw/AYP2gdtZRo+x6zozsYcjnaFDjpw7a+pJyfipwzXdb32oX
         l14Ac98MBn0m/5aMxvyZPyhaKCSfDE8wk+4e/EpfG+7ZzRFQ6nGDZQ07MRha2YCNM8Wi
         oMt8Ug2gc773DLu2tNqSKcpk7yaYlSR9FrLma8sRnK82omcLk8NJFkRq5jRp6csWyEKX
         S/fDLLfOHtjnFKlZXtYR8tJ1LkBxApE7QKUC0gRW6oq0zPnV0IXpxWvxjABKL0mlxuDQ
         sf4H+HCAaAavdrB7YwE1yNOEgIoxyif6/SxUTYlE/CIujuxkTtUzrMfnChhYTJL67lti
         PWVQ==
X-Gm-Message-State: AOJu0Yx+O7+PMnXncDosKEgwwOHJJfbWW0xgCUO/CsgtnYIFG8gtSSq1
	fLKfArWsgFGw/d1TH3wj7iNVDdBfp7kvzTYjKuUfXp+Z1eNzpNwg0w2a6Drx8aZISCwhavs0g4s
	DL82H7ACL9LPeiMCH3yZ/647yLsplwE3AfISXa7esJdek+1G4fsb3tKO+chh1bpnKcdCdep9siF
	TYP4Ol3rdZ
X-Gm-Gg: AZuq6aJ1flWnavaBK6yEw/bfFYR1Tw4DgSD8Q1OqsC/PnTSzEjfOxepfH/e/3dl8oLQ
	D8rQElHuVSOClP9tP/resTnDMoEfKDrlpvE+3zy1vs0IWGV0t5V3hUFVEK1oOJFictIkx/l7s/f
	h+CMZg5oXw4ZHrVdEipTLX2Sv9r7TPokkUcX65IlSHwn09GyCMEu21R2iUAvDmhTXy2keetpERE
	3aL/dQ5bIsPLB+KNwDuEeKyrC+nv6/HQ/DfV2ntcSwU/0GSgf2OfTwklw7FrKKnxyx7NhWPktn3
	gd1PW3yTdBVWf/5cJ9JnSBHZcJ/PXBRLhIdwJakh6pngnCN5ZjMx1XQ5qVy7z6P+s4yXIpXiEoQ
	4f02QN3DXXK5U3swGbAkvWVqYQBB4JcNe0jwXDiJpX/uZykc3Gk1KvGq2rcYBWlq8ZR2df7dsSH
	meDA==
X-Received: by 2002:a05:7300:7fa7:b0:2ae:5f28:eafc with SMTP id 5a478bee46e88-2b76451ac6bmr3218202eec.27.1769466495750;
        Mon, 26 Jan 2026 14:28:15 -0800 (PST)
X-Received: by 2002:a05:7300:7fa7:b0:2ae:5f28:eafc with SMTP id 5a478bee46e88-2b76451ac6bmr3218186eec.27.1769466495337;
        Mon, 26 Jan 2026 14:28:15 -0800 (PST)
Received: from lola.lan ([187.183.40.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6b6227sm15057543eec.8.2026.01.26.14.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 14:28:14 -0800 (PST)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
        Daiane Angolini <daiane.angolini@foundries.io>
Subject: [docs][PATCH 5/5] docs: Fix sources as required
Date: Mon, 26 Jan 2026 19:27:43 -0300
Message-Id: <20260126222743.411405-5-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260126222743.411405-1-daiane.angolini@foundries.io>
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5MiBTYWx0ZWRfX8faIjLgsBJMS
 2n3QFSoHiHUvyxfV4gbJgwGNIUu99+aSxNPu/iDnY2Tcc2cAMIfVS7c2YJxrpfzrO6bVVCZCcdd
 ftmPwlTlo9NHAdpcqHMgmqiHIztDyjKGTcdYmWA3SP09+5S31ZOUWJEfU7xCTYz+cuy5UIDrZb8
 I6ed919/7q5rXJK8v7PJpiTDo7GiQlI9WtL2wZYxhsXDBZiB9aKfwgVQK5s9Ckqhlnxqjw/oe9U
 dcWyvps7JrfrSC+EJ0xR2O23R7/DwV9s9b0+yMrACkbzXuLu1J/Gy0XmXeLtQEJDKMhuYT96aC5
 WzLw09iKZvY3+fkooshBg+JZpVAUTjEVUC8DSrW8iY3jck38p8lABvBxMlI5iN/JuY8+tn9WKNs
 s2Qr0Ia6t0H3VhtpXljLR7FqhKyoX4HWcUBxYnqodj/7cGfZTHPLqfKgflD+dM2FSYpC0HwByzJ
 qxMlgrV8bLBA8fQkO0A==
X-Proofpoint-GUID: uyvD8f7h7N_rjKQPOgMiJ39ONV8S3jqa
X-Proofpoint-ORIG-GUID: uyvD8f7h7N_rjKQPOgMiJ39ONV8S3jqa
X-Authority-Analysis: v=2.4 cv=JYyxbEKV c=1 sm=1 tr=0 ts=6977ea80 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=PIITv4rVe324bgT4salBLw==:17
 a=vUbySO9Y5rIA:10 a=9UA2AVYIz8kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CihtY_vhn8dth2W4YvEA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260192
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 22:28:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18875

If sources is empty, nothing happens. So let's just not say it's
optional, and let's say the minimum is bitbake source code.

Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
---
 .../bitbake-user-manual-environment-setup.rst               | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 700e02216..5d6bcbea1 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -671,8 +671,10 @@ They contain the following sections:
           "description": "OpenEmbedded - 'nodistro' basic configuration"
       }
 
--  ``sources`` (*optional*): sources, such as git repositories that should be provided
-   under ``layers/`` directory of a :term:`Setup`.
+-  ``sources``: sources, such as git repositories that should be provided
+   under ``layers/`` directory of a :term:`Setup`. Although the list of sources
+   can be very flexible, at least BitBake should be cloned to generate a
+   :term:`Setup`.
 
    Example:
 
-- 
2.34.1



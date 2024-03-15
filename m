Return-Path: <derek.erdmann@sonos.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D47C54E58
	for <webhook@archiver.kernel.org>; Fri, 15 Mar 2024 18:56:08 +0000 (UTC)
Received: from mx0b-0003c201.pphosted.com (mx0b-0003c201.pphosted.com [205.220.183.22])
 by mx.groups.io with SMTP id smtpd.web10.1426.1710528967094520957
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Mar 2024 11:56:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sonos.com header.s=pps1 header.b=Wyj4njQB;
 dkim=pass header.i=@sonos.com header.s=google header.b=dF7MzEF2;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: sonos.com, ip: 205.220.183.22, mailfrom: prvs=9804e3a9a8=derek.erdmann@sonos.com)
Received: from pps.filterd (m0299973.ppops.net [127.0.0.1])
	by mx0b-0003c201.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42FEWlkm029548
	for <bitbake-devel@lists.openembedded.org>; Fri, 15 Mar 2024 18:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonos.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pps1; bh=kYkys4agYmg2ozasfchFIihMv
	gQbNzcHEzzNffNnP3k=; b=Wyj4njQBXJY1ktZmSP+bRGex4Z0TM7Q5pWqScjoTE
	eWtozYM581ydk4NOUUzI4qwzC66Iyp+nvKGmGjfIJS0thNs0Gb+EAQ8mULf16EGF
	XFPU0/bIuDURNCQn8sXAF1DrmbZudDZiCcHD+hmN7z2SzN8QGJDPaZEql/cEqFc9
	Ch6F7luqbMp+OX6fGlIOvlUI/utmwWh2W5p9VG9+aTAhuR9pHaepeOotzwRubwOJ
	NlmCUbi0kUzuVcksHIlNJgxX+MzFEejKP1LHJ8um0HtCkJEllmZ7kMxxnR6LoihB
	qZ2FHlXum157Rdapr1BNOIdmxGcEa0RiNeiU58xLEjdVw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0b-0003c201.pphosted.com (PPS) with ESMTPS id 3wva09992r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 15 Mar 2024 18:56:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dd85211e0eso24345765ad.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Mar 2024 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sonos.com; s=google; t=1710528965; x=1711133765; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYkys4agYmg2ozasfchFIihMvgQbNzcHEzzNffNnP3k=;
        b=dF7MzEF22Ga9MKLEn4B4JYQj0YeaaPo8OOQ4SSktVa2I8Cd/4EHxIbk0uFj5m/o1hv
         FuWGJK12EKhZQ03CPXElhiewSPAXtoDyxEMY2lwrsLFfT4ejFyQxe3EToHR5PySZTdwE
         wY3vPpb1YylJmddQU0dF1LnPlycPDL01Ot7K8bnxSP1xXymhbcCVnxt9AFy9Dw8cbJof
         yrfwVoTSxy6ZUlMwmyjUFM1i+qdVa2VqrITDgxIuybDVnNR/MJ6PviPCfZjNZWNqQIrE
         Mrk34X4/HwOC9Ayt6Okh2uw4s9FvdMZ7E6cF7+bHfdzywY0F3njj8goRIbnh2iF+565P
         JqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528965; x=1711133765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYkys4agYmg2ozasfchFIihMvgQbNzcHEzzNffNnP3k=;
        b=hAqJl1at7o8hvNLFNlv2GgAEMngsypmyLN/GLnSV/Uyz8CTwrGVuUcUOcSIXvbCcB9
         bojtyvUr9kqyJSb1ygu05o8UcHQAjQByGXX9qmazWNB6V08SQjiYID6UpLTX7aHnC73f
         xgQlZery6iK3hsRMcLu837PxUp1R+TIadgGGGtmM9jVfWDVCvp0Xtfbw5R0fy6f/venJ
         14XuQH17JudqoKkG09MNg2t5L6sBlBcBTyK7dFapWPTEH1BmANPotahDC9NwP16Er/0G
         ANYcLiht/y/kQ85dYAbArOaB2+YgmwtCl8YlZTKG2C1U/MtNblY9M/dp190MWbIfcQRz
         Yzlg==
X-Gm-Message-State: AOJu0YxGpSXAzAHYs2ZxuFId4F5YHl5VRqvqZoRaXnfznWBh4LXrYCYc
	klWvtDAh+GcmFR/jFC4ITXFVyUtzB02YUVGpj8kR972qEK1uoVItphmyGMKduNiIMFxQ0TUdko+
	ugvqARHEXvA7yCuy9kU+IR+QwV0eIiajYbiKH6ZwSrzaU5Dh300rZ98ZihqrKOiah1PfkuHZXaP
	8qB8yo
X-Received: by 2002:a17:902:ed0b:b0:1de:e5aa:5ce with SMTP id b11-20020a170902ed0b00b001dee5aa05cemr4097865pld.41.1710528964582;
        Fri, 15 Mar 2024 11:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIQo99xRuax72Fc91QqUWAImnO9g12wQOhF/FMafZaWVs+aqOLD2yioy4ZPCAMrFrQOYR2Hg==
X-Received: by 2002:a17:902:ed0b:b0:1de:e5aa:5ce with SMTP id b11-20020a170902ed0b00b001dee5aa05cemr4097819pld.41.1710528964109;
        Fri, 15 Mar 2024 11:56:04 -0700 (PDT)
Received: from devastator.sonos.com ([50.34.161.149])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d974ffa1fcsm4212490plh.173.2024.03.15.11.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:56:03 -0700 (PDT)
From: Derek Erdmann <derek.erdmann@sonos.com>
To: bitbake-devel@lists.openembedded.org
Cc: Derek Erdmann <derek.erdmann@sonos.com>
Subject: [PATCH] fetch2/git: Install Git LFS in local repository config
Date: Fri, 15 Mar 2024 11:55:33 -0700
Message-ID: <20240315185533.71921-1-derek.erdmann@sonos.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b4_EFU8oh9GX_QfiAHkRtyipsIPtYvoi
X-Proofpoint-ORIG-GUID: b4_EFU8oh9GX_QfiAHkRtyipsIPtYvoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_05,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403150153
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Mar 2024 18:56:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15999

Git uses a lock file to prevent concurrent modifications to the global
config, so if unpack tasks for different recipes try to run "git lfs
install" simultaneously the operation can fail:

    error: could not lock config file /home/build/.gitconfig: File exists exit status 255
    Run `git lfs install --force` to reset Git configuration.

Adding "--local" sets the smudge and clean filters in the local
repository's config instead of modifying the user's global config.

Signed-off-by: Derek Erdmann <derek.erdmann@sonos.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index b9dc576d..ba1556e7 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -673,7 +673,7 @@ class Git(FetchMethod):
             elif not need_lfs:
                 bb.note("Repository %s has LFS content but it is not being fetched" % (repourl))
             else:
-                runfetchcmd("%s lfs install" % ud.basecmd, d, workdir=destdir)
+                runfetchcmd("%s lfs install --local" % ud.basecmd, d, workdir=destdir)
 
         if not ud.nocheckout:
             if subpath:
-- 
2.43.2



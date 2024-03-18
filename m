Return-Path: <david.zuhn@sonos.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FCFC54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 18:50:16 +0000 (UTC)
Received: from mx0a-0003c201.pphosted.com (mx0a-0003c201.pphosted.com [205.220.171.22])
 by mx.groups.io with SMTP id smtpd.web11.53438.1710787815939072070
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Mar 2024 11:50:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sonos.com header.s=pps1 header.b=om7csgRG;
 dkim=pass header.i=@sonos.com header.s=google header.b=e/4TH9AM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: sonos.com, ip: 205.220.171.22, mailfrom: prvs=98076466c0=david.zuhn@sonos.com)
Received: from pps.filterd (m0299971.ppops.net [127.0.0.1])
	by mx0a-0003c201.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IG2OIX008951
	for <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 11:50:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonos.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pps1; bh=DGfkdHfND9DkSFXmIwKsh0xVB
	wOVKevmCPF0i0vPO74=; b=om7csgRGmokRoCvYNXpxrEiIYeGHBcupbjSnGqMzo
	xQ9W6HwdvDT6QvTOxsTrEI0olCcHUhbVlsMwNxY9F887NFw+SVfiimx4MPfvJhAS
	MtTk+ofJ1vQ2CjqA0Ec+iHrReVxzyglxtuTPutBynV9fHKIYkfVI0plTxsbjKhEw
	dP3u6RGucyooVOu7UPbfc+7b0Pw7PqQiiQJe0wLSR7hRPVZv0yC2XYTbqIl3ZS8u
	fX+14/HnCLnkwhcU8xJk4m8BfTO6BQDrGKR0ik6D9ewyNeSXhCkVquXxE0XOx6X3
	HCAwKU0LF51vsU7NPAJjpTYL5nYWvviuxYiAOfhYEGbMw==
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	by mx0a-0003c201.pphosted.com (PPS) with ESMTPS id 3ww8x7jj5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 11:50:15 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbdcfcd458so374389539f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sonos.com; s=google; t=1710787813; x=1711392613; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DGfkdHfND9DkSFXmIwKsh0xVBwOVKevmCPF0i0vPO74=;
        b=e/4TH9AM2S1kPUk8Yo5qN3UcOsWta9UMY8w5LX472iRgsuXZGSWoKRZhHt3Kt/nDtm
         ZtYRl4H7B3AxDjBBoyP7jybqBQWmlbg34kH3obwM8ylKFaue4HX1frkomd1j0Z7bcb34
         Nx8M1TFodFXKBd8vX7D9HDVL4RFg9Ih3i2uuVJMtXVcYA9QNrp4qQLkkxUAWul5lj4aS
         FekN3rLGTDGvQF7hZDe2BhWCrOiKB4YgflufMZdaQaGayyXHCGAiW6y11vxBNca7E82L
         s/YnJsnGoyoWgxcoAWOWDT7ehY69s6Vdrmz4kPBH/8HgJ/toSCbY4aqMcI5XdtD47xOS
         xw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710787813; x=1711392613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGfkdHfND9DkSFXmIwKsh0xVBwOVKevmCPF0i0vPO74=;
        b=OhMgttlzT0des7sg2CI5oZIKTsgOKfHGZvNbraFea2yL7sbhFYcMxaY+R/lg9LmzNO
         dnJX25FrwtCUICg1LPkFEHFHbDNlRYAVTHAaUrMKORROpiSZfDsbYt7PDhE8pc1hkY2U
         T57pMNe80qVp/Ix+HOdYnNW5qIZlQZ3aWepYqXAXTJya2RCH2LxsmhhVbrjI23XBSZKw
         U/oybjK3QzkVHNSu1p5Hdzh2glG4b4DVNPyP2TfRMcyIuRzcbBRm3trkPr+KLwtcbIiq
         bEtTxYbAGuZNoghCxUbYB2zuwMkPXuXomdJ7cr2smo7FRitM4dM6oNsRP492LSaPvuJ2
         a9FQ==
X-Gm-Message-State: AOJu0YxyNKJEFWLpOhVEZvK2UHjYZUeWS+wdqYBXPJA+7zrPmYGLiFTv
	NHYBAm6fwgmW4Z240u0ahAyXNwL0HJPDcOdsqfjquxH0uA5ll59Mlfc9LN6fMAGUEU0AAkvMETa
	FeAwyYqy8E8VaJhMPn0OPgWu44AHQ1WlT4S/5on4NrwFZ4YdCx7ohMKzcL06FuvxJ6+mRujgCSp
	wLh1Jn
X-Received: by 2002:a92:c944:0:b0:366:a7e1:7677 with SMTP id i4-20020a92c944000000b00366a7e17677mr318132ilq.3.1710787813458;
        Mon, 18 Mar 2024 11:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzZSp019w5MeJv3fFamgYJfTv4d+ym0h+bKPuQODaO80712wJC1FfzQApb0aHJiV4tRa4BzA==
X-Received: by 2002:a92:c944:0:b0:366:a7e1:7677 with SMTP id i4-20020a92c944000000b00366a7e17677mr318120ilq.3.1710787813194;
        Mon, 18 Mar 2024 11:50:13 -0700 (PDT)
Received: from roebling.sonos.com (63-231-140-193.mpls.qwest.net. [63.231.140.193])
        by smtp.gmail.com with ESMTPSA id j4-20020a056e02014400b00366b66af14asm1299123ilr.17.2024.03.18.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:50:12 -0700 (PDT)
From: david d zuhn <david.zuhn@sonos.com>
To: bitbake-devel@lists.openembedded.org
Cc: david d zuhn <david.zuhn@sonos.com>
Subject: [PATCH] bitbake-worker: allow '=' in environment variable values
Date: Mon, 18 Mar 2024 13:50:05 -0500
Message-Id: <20240318185005.2487115-1-david.zuhn@sonos.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1mEDUFF2dr8hVoUh8vmyplTHOQLu9KVo
X-Proofpoint-GUID: 1mEDUFF2dr8hVoUh8vmyplTHOQLu9KVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=959 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403180143
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 18:50:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16008

Limit the split to key & value (2 items) instead of the n items one
can get if there are '=' characters in the value.

Fixes [YOCTO #15447]

Signed-off-by: david d zuhn <david.zuhn@sonos.com>
---
 bin/bitbake-worker | 4 ++--
 lib/bb/runqueue.py | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index eba9c562..891d4796 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -183,7 +183,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
     if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not dry_run:
         fakeroot = True
         envvars = (runtask['fakerootenv'] or "").split()
-        for key, value in (var.split('=') for var in envvars):
+        for key, value in (var.split('=',1) for var in envvars):
             envbackup[key] = os.environ.get(key)
             os.environ[key] = value
             fakeenv[key] = value
@@ -195,7 +195,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                         (fn, taskname, ', '.join(fakedirs)))
     else:
         envvars = (runtask['fakerootnoenv'] or "").split()
-        for key, value in (var.split('=') for var in envvars):
+        for key, value in (var.split('=',1) for var in envvars):
             envbackup[key] = os.environ.get(key)
             os.environ[key] = value
             fakeenv[key] = value
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6987de3e..bc7e1817 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1359,7 +1359,7 @@ class RunQueue:
             fakerootcmd = shlex.split(mcdata.getVar("FAKEROOTCMD"))
             fakerootenv = (mcdata.getVar("FAKEROOTBASEENV") or "").split()
             env = os.environ.copy()
-            for key, value in (var.split('=') for var in fakerootenv):
+            for key, value in (var.split('=',1) for var in fakerootenv):
                 env[key] = value
             worker = subprocess.Popen(fakerootcmd + [sys.executable, workerscript, magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
             fakerootlogs = self.rqdata.dataCaches[mc].fakerootlogs
-- 
2.26.2



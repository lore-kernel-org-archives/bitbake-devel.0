Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24673.1793841930028785734
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Nov 2026 17:25:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@lab126.com header.s=amazoncorp2 header.b=OAkmuc+g;
 spf=pass (domain: lab126.com, ip: 35.155.198.111, mailfrom: prvs=762179350=kpoduval@lab126.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=lab126.com; i=@lab126.com; q=dns/txt; s=amazoncorp2;
  t=1793841930; x=1825377930;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gGWdb3kPNC9aodlUL0C3gHsUp3b/sEDLTUHA1OFrxd0=;
  b=OAkmuc+gYZD8JBP/ABnZ5nzTavu1ddk6usZDXeVzg7lvK8hsMSQquTdT
   zM7vV0uTgQDon5NzrkKUE4y/IOy0sCadbg0XvICZzAYgtLkwv1JbQT4Dd
   Tx9EfBrciK2Sx7MqxX55cjOzVZIe4dP6001Jnd+sVmbP+ju/YsLdWkEuR
   +4wRs7Mm0TCHNPZ8b/3/dgOgoparUkjxrM18im3WwxAj9nRyF22nTYgWh
   C9TFuTDOXbbkFeq7Kv70tMSVu6aD4i9yLTOilJemO24xIJLu6MZcexFOg
   1yPgBneUJZASvdv0Hyys2bOBFvRoib0heZCn1WdBmeRJlNTqG/OPAoh7t
   Q==;
X-CSE-ConnectionGUID: uYi7sY2wTHygwiNTAByn9Q==
X-CSE-MsgGUID: nzrj7rGGTWedkwzFs/tjLg==
X-IronPort-AV: E=Sophos;i="6.27,196,1787011200"; 
   d="scan'208";a="33044525"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:25:29 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:20737]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.208:2525] with esmtp (Farcaster)
 id bb384db0-68ec-4e44-8de5-1f0f4ad5387f; Thu, 5 Nov 2026 01:25:28 +0000 (UTC)
X-Farcaster-Flow-ID: bb384db0-68ec-4e44-8de5-1f0f4ad5387f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 01:25:28 +0000
Received: from u1cb251c9c70150.ant.amazon.com (10.68.99.17) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 01:25:28 +0000
From: <kpoduval@lab126.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Karthik Poduval <kpoduval@lab126.com>, <armccurdy@gmail.com>,
	<richard.purdie@linuxfoundation.org>,
	<stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 0/1] fetch/s3: use boto3 natively for S3 fetches
Date: Wed, 4 Nov 2026 17:25:21 -0800
Message-ID: <20261105012522.878275-1-kpoduval@lab126.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: kpoduval@lab126.com
X-Originating-IP: [10.68.99.17]
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2026 01:25:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20393
Content-Type: text/plain; charset="utf-8"

From: Karthik Poduval <kpoduval@lab126.com>

Hi,

This reworks the S3 fetcher (lib/bb/fetch/s3.py) to fetch objects in-process
with the boto3 SDK instead of shelling out to the "aws" CLI once per object,
with an automatic fallback to the CLI when boto3 is not importable.

Disclosure (per the project's AI-assisted contribution policy): this change
was developed with AI assistance. The commit carries an "AI-Generated: Kiro,
Claude Opus 4.8" tag. I have reviewed, built and tested the change and take
responsibility for it.

The motivation is sstate mirrors hosted on S3. The current fetcher runs
"aws s3 ls" / "aws s3 cp" as a subprocess for every object; each call pays the
Python interpreter + botocore import startup, re-resolves credentials and
configuration, and opens a fresh TLS connection. For a mirror of many small
objects (thousands of setscene HEAD+GET lookups) that per-object startup cost
dominates the build wall time rather than the transfer itself.

Fetching with boto3 in-process and caching one warm S3 client per worker
process removes that overhead. In my testing an "aws s3 ls" costing ~0.9s per
object dropped to ~0.08s warm (~11x), and a core-image-minimal build backed by
an S3 sstate mirror went from ~20 minutes to ~9 minutes with full sstate reuse
and no fetch errors.

The series also fixes a real bug that the SDK path exposes: bitbake's mirror
rewriting percent-encodes ':' in sstate object names as %3A. The aws CLI
tolerated this, but boto3 re-encodes the key at signing time, so without
unquoting the key first S3 returns 400 Bad Request on every lookup.

Points I would appreciate maintainer guidance on:

- boto3 is imported lazily and only used if importable; otherwise the existing
  aws-CLI path runs unchanged, so this adds no new hard dependency. I am happy
  to change how the optional dependency is gated if you prefer.
- Region/profile are resolved from the datastore and then the standard AWS
  environment variables, with ~/.aws/config honoured by boto3. There is a
  small credential-retrieval backoff for transient credential_process rate
  limits; I can drop or simplify that if it is considered out of scope for
  bitbake.

Tested on bitbake master (parent 741285343): the offline fetcher selftests
(bb.tests.fetch, 218 tests) pass, and the boto3 download/head_object,
key-decoding (%3A), 404 handling and CLI-fallback paths were exercised
directly. The fetcher was also exercised end-to-end against a real S3 sstate
mirror, restoring ~1400 sstate objects with no fetch errors during a full
core-image-minimal build.

Thanks,
Karthik

Karthik Poduval (1):
  fetch/s3: fetch via boto3 by default, falling back to the AWS CLI

 lib/bb/fetch/s3.py | 233 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 206 insertions(+), 27 deletions(-)

-- 
2.43.0


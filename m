Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
	[209.85.223.174])
	by mail.openembedded.org (Postfix) with ESMTP id 5A5A36093B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jul 2018 15:42:04 +0000 (UTC)
Received: by mail-io0-f174.google.com with SMTP id l14-v6so1281786iob.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Jul 2018 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=VMPML02ZwN1rdatu6FLUF95Dsbujume3ZvrHBE8PlEI=;
	b=fogILA5rvDRVErva+j6MW4Cl/obr/YaAJvoH6souegw0dPpyNmhOV9+R8rAOVpbbND
	C5c+Ng3oKpHQ7qC71v7EdRDP4X8D+AC1Oywq9Csu3+yYMwSb0xc4XZj4Ftw2NHuudgA4
	W1BliHzxA2q2pDbAh1fhbCV4bQCde5ktq0JswPVJD2W/x4RZneZGKBeXcEsKYch1oK/I
	gBpqaocGJzYeGlnOJ1fVch9iogMATRz//RnX2fbDErUTBeCBFw3cqaOQXBPQSfU+AC8s
	pjwxQHzV7L+2AZ0MN89OIr1GBdBOz+XUyw+knP2FzlsZ/B6tqBaM7uCeJVHGRZaErBjx
	7rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=VMPML02ZwN1rdatu6FLUF95Dsbujume3ZvrHBE8PlEI=;
	b=rJiF1wFlPSphhyAGWm8ViGGz69tRAPEMqs+rhfygih6WQswlVBDafXGsHWrMuCBVAs
	qBqFH9ZiR+Tvk2HqzMOR+GbQw4Xt9dzafkVCF6wFbMFHfCHkSS1B7esi0ND7keOQxwau
	Mpbz1gZCCBd4+jQk9wg8VfmfXEP82mIG4SYqrXi+QaStuWESOid4syO/PZ7A2l8Z+t5D
	oW69qeH+48PxSQkJCm2mGrgvGz6U8EZlN3Z+8tm5sGzvEIuX5/KAN7w1MYPAvG+7mjd0
	4W7eoBsxR6iKymjXx26FRzcvu32Z60xR4WXzptPEA7PEzI5zyHRJaBmUE42jl7D7vWwC
	LSrg==
X-Gm-Message-State: APt69E2hip2AB5CtPb4Fk9JGXo9sUO1BAJjVgMD8Ju8DPtcH+E2qiwdS
	hymiwrUIypqLKZ1Xs8Z+2vctq77Q
X-Google-Smtp-Source: AAOMgpesUj6I0xeCU171CO4qdj7qMrFfw5xye3g7Koiqz98nh0oyq59+Ejt3PPKfbaJEkHpcWcDu1Q==
X-Received: by 2002:a5e:d713:: with SMTP id
	v19-v6mr8717096iom.75.1530891725018; 
	Fri, 06 Jul 2018 08:42:05 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r80-v6sm1734053ita.20.2018.07.06.08.42.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 06 Jul 2018 08:42:04 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jul 2018 10:41:57 -0500
Message-Id: <20180706154200.28769-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 1/4] runqueue: Remove trailing whitespace
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 06 Jul 2018 15:42:04 -0000

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 0a4d1554663..792b91a11c1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1061,7 +1061,7 @@ class RunQueueData:
 
         # Create a whitelist usable by the stamp checks
         self.stampfnwhitelist = {}
-        for mc in self.taskData: 
+        for mc in self.taskData:
             self.stampfnwhitelist[mc] = []
             for entry in self.stampwhitelist.split():
                 if entry not in self.taskData[mc].build_targets:
-- 
2.17.1



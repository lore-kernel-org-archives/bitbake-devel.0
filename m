Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
	[209.85.221.45])
	by mail.openembedded.org (Postfix) with ESMTP id 722036C102
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jan 2020 11:03:08 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id b6so36864607wrq.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 Jan 2020 03:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=w+N09YtZsTzOa0K8ZCk897zFR7qWzEalq/m0x1hjLVI=;
	b=UtakXbv67W03qJ7zt8C+e85jpj0QoM3b3K8PjtcT+QqsNgR0FtMJXnLH4ozgkPKpvZ
	f3rEdt/KcnalOFlR5QYCncZUyVX58RHuGan/D2aNtoAeCmKcZzaTQjJM3xBbnjxRW967
	Irjjnpa+4DO4eYBEn1HNU/yLzSFth+Jxy4M9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=w+N09YtZsTzOa0K8ZCk897zFR7qWzEalq/m0x1hjLVI=;
	b=HbCtB4qXKkHdCur+9a49CsEd2xow3usZ0AGsSdycdnG9cqUGMVsml3Cb5buPddV11J
	hcr8TWBQpzainz69dAYfD7k+1gYMzIX+ND68Vt1R3I6n8F83EAC9n5Jhwb9VNO6Osejk
	GggzJWSxdZqi6mPZM4MJbyXOX5TsdmRhPom/7JPdjj2WHn1RPHlusVIu9DmDuSqU6YHO
	Xs4sSC84npdwTBj2vaTPaEeFx5ES7LMstYdXtR5KJzSfLqQGvS0o2Uvw7YS/HIOoXdgA
	shkvS+AsFq1cHpLLzqdO2HVHwo+1VXyyFWHpi/J+Vf1Z6Y5JtCoRQYbdLHJHFRVJrsFT
	dXnA==
X-Gm-Message-State: APjAAAWNfcF0eLgkvys5jXtyVi01Q+PUNWjtLpqXGd3j6uMiKe/igQln
	X9w/fZxj2c6hQdfPcacnopzxFIk3HbA=
X-Google-Smtp-Source: APXvYqxMe+uMnwkOKtIEBdwSZ+GZ/u7mgjZwAHi0Lxy9SN+XVkSPSl3i1kpTxtihXjG3QNcZzanrtQ==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr74140889wrn.283.1577876588500; 
	Wed, 01 Jan 2020 03:03:08 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a1sm5250672wmj.40.2020.01.01.03.03.06
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 01 Jan 2020 03:03:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jan 2020 11:03:01 +0000
Message-Id: <20200101110305.12317-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/5] runqueue: Fix equiv hash handling build failures
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
X-List-Received-Date: Wed, 01 Jan 2020 11:03:09 -0000
Content-Transfer-Encoding: 8bit

Regardless of whether we remapped the hash on the server or not, we need
to have bitbake work as if we did as we need to match how the stamp files
look.

This change resolves build failures where tasks were rerunning when they
shouldn't.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 729439ef31..f82799800b 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2302,8 +2302,9 @@ class RunQueueExecute:
                     remapped = True
                 elif tid in self.scenequeue_covered or tid in self.sq_live:
                     # Already ran this setscene task or it running. Report the new taskhash
-                    remapped = bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
+                    bb.parse.siggen.report_unihash_equiv(tid, newhash, origuni, newuni, self.rqdata.dataCaches)
                     logger.info("Already covered setscene for %s so ignoring rehash (remap)" % (tid))
+                    remapped = True
 
                 if not remapped:
                     #logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
-- 
2.20.1



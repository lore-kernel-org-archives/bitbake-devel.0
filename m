Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 8A9BC7BDD3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2018 18:15:30 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id r24so16809897wmh.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2018 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=N7S8AtkyaNU070xIcS0/zbRoLJoD6Vvyv0c3PcQOGwI=;
	b=HVyjahxoYo9sXdcQCm3Bi3hDguR94D7Fb2YUb9X7+N6NdmSG71k5R68gD98Ns3SlLW
	z17lBqMmvZYW7KABzPkm2MGQYxgxjGSmkVqr5J0te9AaLEJdaqL6PdlMqWL8HPBM4WXq
	maKUHgXRVafPsjSNCdXhgi4zhgj8Ug9NfI1FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=N7S8AtkyaNU070xIcS0/zbRoLJoD6Vvyv0c3PcQOGwI=;
	b=IU2SoU6sFvLtX/j9IKqihQh8ST0pS9Ax91QyQqmPeAoeNndDBHF9BWM2d11QOy1VF3
	QamVFY+FGAP7ezKktAcaiv5kWxiuV64BMrNK11k+aZyGI6RSnZ6fzgS/6ik8TACuNyIa
	6gRYLdCrAiWe00e+iV9LAKUSbVccCc5W3NxvxSR+KZWeuPefOb0QbmftFItpFTPG2ihc
	lmWqhF7tAR8YuxQPjeg3GbTGC14sML9Gypij5rYcKxtOFqRXwRiLKlaIrAVc6W47noTt
	Yv8uPYV5vkpRcjYfg4arh2NDZlg5C56y3JuOSUPBOHJqo9TeVp51qEMMhbizBlE4SZay
	ls3w==
X-Gm-Message-State: AA+aEWbdk60Rswm+AhefISZ238ADKXdtDZXc59k2Rb1fLr4OU7izerKa
	0fulegb1LuU3VAMIA0F4+IIpaJqN5vSnYA==
X-Google-Smtp-Source: AFSGD/VNvRck1JeNbgT6lXMBPWcEj0TM/U73tOXvKAGjoW8dh7fllL3KXpPMMqPPCSxqJwyr5do/eg==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr4263622wmb.40.1544811330784; 
	Fri, 14 Dec 2018 10:15:30 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	199sm6410959wmh.21.2018.12.14.10.15.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 14 Dec 2018 10:15:30 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Dec 2018 18:15:29 +0000
Message-Id: <20181214181529.9139-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH] server/process: Ensure socket has a timeout set
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
X-List-Received-Date: Fri, 14 Dec 2018 18:15:30 -0000
Content-Transfer-Encoding: 8bit

We're seeing hangs in oe-selftest where server startup and shutdown are
racing. The assumption was a connect would timeout however no timeout is
set which can leave processes hanging. Set a short timeout for
the connection to avoid this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 1a6a826746..f7d07266cf 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -474,6 +474,8 @@ def connectProcessServer(sockname, featureset):
     readfd = writefd = readfd1 = writefd1 = readfd2 = writefd2 = None
     eq = command_chan_recv = command_chan = None
 
+    sock.settimeout(2)
+
     try:
         try:
             os.chdir(os.path.dirname(sockname))
-- 
2.19.1



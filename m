Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f196.google.com (mail-it1-f196.google.com
	[209.85.166.196])
	by mail.openembedded.org (Postfix) with ESMTP id 9958D7C44B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Feb 2019 16:56:32 +0000 (UTC)
Received: by mail-it1-f196.google.com with SMTP id m62so1356435ith.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Feb 2019 08:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=TYyr5xTSW9tKk4MJ5CrmJrJJGS6JwD68porvloGNZmM=;
	b=c0WXwirKJ+55swby40c6ux1JbOXuTmVHFvjXaFK4eK/WR8ar4uuh1kLSrlJGDKePck
	zvlwIGRP06r0WvLjgJy/VYch6Ny7EVa88nyJDCvxhbNhHCmhdqb2pLwTXKHZSjIBd2eq
	aFWk+YpWDYm5I7dSlr0YUQmyQ02clrIVR64FLLP6LPWFSi52uRxoqJUP7/VomZyaNV3P
	X2q5PVZLrHmLXWOVIrona5mubdPhj21OqlbHKxEv9BtWEA7LAZv15Dz/uYVNMPdQN7IH
	1RsPdXX1f4+aKkaCH86ASgmSjTEmuJAh9wHSec1EzRb1+VDl5scOzPoHsdewNusvBNcU
	j2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=TYyr5xTSW9tKk4MJ5CrmJrJJGS6JwD68porvloGNZmM=;
	b=ACzExi243wiw5+r2X5/+kXiV5nI04lX4pNZAJHLyE2X7mb6DDofIXe1bzZ69e/q1JC
	EX9OO38mK7MHmX+S8GPfwSXYsKf6vOog5ZZS8bdjW7rnC5CIPAJNFirbpPDnwh0u/fbr
	uzk9eThuYEC2EErlYILqWt7AcoJURgnBCUC27t5QWaCUTa9znMGH85GP+AIu6Do6Ovuo
	ckeMFPfRgwBfN3Zd7c0hoy6uZ2qj7DGS1srVYa6tBVWVTkjC1HPsa8bw81e/DQbxWqHB
	0x3bhr/bij0yxbKMnPKwPu6eW63O42G3aYjwYRX1ItxvfD37D9kBrcikUHzFJezuzZsw
	Y79Q==
X-Gm-Message-State: AHQUAuawvnCQ3hfxE1zXtn4flCdKHCuwOwj7CDC8uu63Thw63pKaz6GL
	HNWvkLHv4BN2ltu6b3ss3KyReR6W5Jc=
X-Google-Smtp-Source: AHgI3IbaPTQ2oQkNGNPBkij49zVg2aGQbUU3Bx9/Da8dzVx8QRJRMhlMzWLaamu6kvdCsB9Y43KiXw==
X-Received: by 2002:a24:3c3:: with SMTP id e186mr5010417ite.155.1549558593195; 
	Thu, 07 Feb 2019 08:56:33 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	s26sm5251943ioe.86.2019.02.07.08.56.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 07 Feb 2019 08:56:32 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Feb 2019 10:56:03 -0600
Message-Id: <20190207165603.20306-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] bitbake: Allow arguments in FAKEROOTCMD
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
X-List-Received-Date: Thu, 07 Feb 2019 16:56:32 -0000
Content-Transfer-Encoding: 8bit

Changes FAKEROOTCMD so that it can accept additional arguments to pass
to the fakeroot implementation instead of being treated as a simple
command

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 6002ccf06a8..56b8319528c 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1221,12 +1221,12 @@ class RunQueue:
         if fakeroot:
             magic = magic + "beef"
             mcdata = self.cooker.databuilder.mcdata[mc]
-            fakerootcmd = mcdata.getVar("FAKEROOTCMD")
+            fakerootcmd = mcdata.getVar("FAKEROOTCMD").split()
             fakerootenv = (mcdata.getVar("FAKEROOTBASEENV") or "").split()
             env = os.environ.copy()
             for key, value in (var.split('=') for var in fakerootenv):
                 env[key] = value
-            worker = subprocess.Popen([fakerootcmd, "bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
+            worker = subprocess.Popen(fakerootcmd + ["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
         else:
             worker = subprocess.Popen(["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
         bb.utils.nonblockingfd(worker.stdout)
-- 
2.20.1



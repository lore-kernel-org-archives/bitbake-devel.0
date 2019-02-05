Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id F34E16D545
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Feb 2019 21:40:33 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id z15so3313447wrn.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 05 Feb 2019 13:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KVe1KeIJ2OHbU+PUJHJfOysposEvRpNe7kxHcdWtWJY=;
	b=Tiol2PwFfa8Diq5EbFLn3q1+McK/2E2K+KQ6K92xFJrIISXrete02oau1iweik+CRo
	+Z/x8Mb4npDRrn5+kPZZDqFY/wVE4zKKbSpK5GkaBKij4Ur9gNaN+i9PL3yHx4n9IETQ
	v1sUwTrdZ+/o+gYX3XA/CeKCitWYMmvXoz0Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KVe1KeIJ2OHbU+PUJHJfOysposEvRpNe7kxHcdWtWJY=;
	b=bGU9kueJFyjW558UkYIqQePpt8BJ5wZ9gYoBZZg2Bm6z2RxHA3RADvL5ALfVIELpqu
	fTMSh/cdKTJ9iFtACahTQFR41EnZliWYV8CPcPHHyVV7WAeAk0CvajjaXRtZqcV2+AAw
	jbr5VP2vIK59P2X5vlANCWW2en8/mOC59ugnef6A9QZjt7MJaOb0VZrTYF1PVyJ3rY5I
	9GR6QLryPy2tmu9QHdx16GMDz97aunuih+w9pm8irmiy0v5x03U+Umo31c7JazYoSYX2
	65HQhWdLO7gejmiP3rvtb/wDA2ss08ImGUUQgg8r/BR/j3X6CgXCfCV3+vVcrsS0KVN2
	kC2g==
X-Gm-Message-State: AHQUAuZFUVdDFQ6nZwN5+rONEkg9xlAAInpIpRrtfCU6qOU4YmhDfXyn
	l9Us9ufqBJ4Sa6jhp2ac/e7bkw5U50c=
X-Google-Smtp-Source: AHgI3IZjlm/iTQsZXzk2FGG0F3ZXzn2FZXa2V02TMzG4+6I9UUN5Bww1UlIjZ7DNnu0M/jR3Hfvuvg==
X-Received: by 2002:adf:a28d:: with SMTP id s13mr5568995wra.100.1549402833906; 
	Tue, 05 Feb 2019 13:40:33 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	126sm12658732wmd.1.2019.02.05.13.40.33
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 13:40:33 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Feb 2019 21:40:32 +0000
Message-Id: <20190205214032.13125-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] server/process: Add missing exception raise
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
X-List-Received-Date: Tue, 05 Feb 2019 21:40:34 -0000
Content-Transfer-Encoding: 8bit

The intent of the code was to catch one kind of error, it was actually swallowing
all exceptions and looping indefinitely. Fix it to work as intended.

This explains some mystery hangs we've been seeing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 28b8eb9b86..80a7875ad9 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -499,6 +499,7 @@ def connectProcessServer(sockname, featureset):
                 except IOError as e:
                     if e.errno == errno.EWOULDBLOCK:
                         pass
+                    raise
         finally:
             os.chdir(cwd)
 
-- 
2.20.1



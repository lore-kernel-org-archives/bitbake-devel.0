Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 587A8606D0
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Sep 2019 07:49:58 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id s18so16346992wrn.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Sep 2019 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=mBqATp4qo5E6ckWQviovwh8VdrTWFltUrB8j9W0GEJc=;
	b=BREGZqU6BfCoWJPqNsOdJFnmqNY0PsHBnxjz/bOtLGSGiWCu0mUqErb4UOOxndoIg6
	MV/YGgReQtIdlC0YrLpshdARc6VE2pgothSjN7cWhKCr4N2HyUA038bjtFRD1Nrc4zdO
	T65RzMcwepIEN4OcalmccagYy717eSjt3bIeGhk4ukd9LTf5FgTdlbCriVcpvCFtzmBd
	XK1WWNY7NTs6luVxsg2JY8wG4cEshdjlKf+YjUfn6Pk8b8Y8BDaRenV992BpgRuNEDIv
	RIp+QPDGSRwQy0mwl0bhCAf+3Fre0YvWLtgzLbX3Ru+TsF0c6TpqjX91shxVqtQWvsv4
	As6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=mBqATp4qo5E6ckWQviovwh8VdrTWFltUrB8j9W0GEJc=;
	b=BEKxZ8s8AcoxnAvrNRFpAakcKSe8n+EeMyvSLLMkNmEUn/Ae+nwJy6igpN85mNccJ7
	SjEVpb/I7po1oh6HEKE3gGnXS1VobON85IcqfTCyTOedCpf7vBad/9H3AABkEc37OT2Z
	yekoYC21tYYDK/Y6o1OVCZmGU5gW64lC4jlrztW9hZC5L5OcPVkpztZofCJmCWsDN+vU
	YeNoy2p4t13j4iBW5uFxdEQ5R7FEjJFyx6E3Pi10pNX/eh+Nx4YmzUBW7QEc+i2OmLby
	tkrLX0W0AUf04tK3Y6QvzWC/XLyFE8q35/An90RGGO4nXmVQkMyQYXmtHV3ppOhzZ9Aa
	D42w==
X-Gm-Message-State: APjAAAU0duNBHpNtdD/hyCMp8X7eaZPWdl+y/Wt0k2Q7PnCci7Dejftw
	riq/SUSji37H//asiJdJIpW37h0ay0w=
X-Google-Smtp-Source: APXvYqwF9kug4/AmajTZsW+YUgeAwo3deg8/2Q9ok5mjGA562AktRiOMIWHaWUsQvFBPDoODhHM6ow==
X-Received: by 2002:a5d:6602:: with SMTP id n2mr11264141wru.317.1567496998614; 
	Tue, 03 Sep 2019 00:49:58 -0700 (PDT)
Received: from localhost (ip-217-030-068-212.aim-net.cz. [217.30.68.212])
	by smtp.gmail.com with ESMTPSA id
	z21sm5778984wmf.30.2019.09.03.00.49.57
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 03 Sep 2019 00:49:57 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Sep 2019 07:49:56 +0000
Message-Id: <20190903074957.1679-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 1/2] movefile: fix exception handling with python3
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
X-List-Received-Date: Tue, 03 Sep 2019 07:49:58 -0000

* with python3 this fails with:
  File: 'bitbake/lib/bb/utils.py', lineno: 799, function: movefile
       0795:        try:
       0796:            os.rename(src, destpath)
       0797:            renamefailed = 0
       0798:        except Exception as e:
   *** 0799:            if e[0] != errno.EXDEV:
       0800:                # Some random error.
       0801:                print("movefile: Failed to move", src, "to", dest, e)
       0802:                return None
       0803:            # Invalid cross-device-link 'bind' mounted or actually Cross-Device
  Exception: TypeError: 'OSError' object is not subscriptable

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 0618e46f..3e90b6a3 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -780,7 +780,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
             os.rename(src, destpath)
             renamefailed = 0
         except Exception as e:
-            if e[0] != errno.EXDEV:
+            if e.errno != errno.EXDEV:
                 # Some random error.
                 print("movefile: Failed to move", src, "to", dest, e)
                 return None
-- 
2.17.1



Return-Path: <martin.jansa@gmail.com>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 416056C13D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Sep 2019 07:37:01 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id j16so20059655wrr.8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Sep 2019 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=FPmu9B620/NgJdZLlWY+F+RGuOXT2HZ+ditwKvbGNbU=;
	b=fUV4hUwJkzQc2mihRSiTpaT7LawrNq+IhLcGIe1gqyFYfwsMYm0oI811jVqoyHkeoN
	LRO9XhJABGPf9ymPUE2GAknqsvxRoXxleObKOCAXQdGBsPqGsNOOXsECM2tDywespEQQ
	/KaQ2b8UQpv0recYGkrPTKgZur8BfZsX4mXpkcHsHPAA7o19WiWdU0/SQiMhJQBDkInb
	nBF5rLLUbE2Kwu9CpTljmcYL2UKDLOVZxmaoFcCqcf30aydLf3aD7ZE5gSUKq6UM5+Gf
	UO4u65u+8lmj4fIKS+xOZ48k3BoybqzUcbrYOLJ8sqxmPVW3LO+SRjRlZmEPQBPk37+2
	i5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=FPmu9B620/NgJdZLlWY+F+RGuOXT2HZ+ditwKvbGNbU=;
	b=roxAbEGLxanlRp+FdpApAj2Lai4RGJU4i+d7B8DqJX9L7cSX53g0d+wmvHOGS+TrBY
	iLEra1rBasB/4ozUxUov9yLbpaYeBT1KUR1XIJAErXJYBkiBBhhTHoR1E4pbc6WRMO+p
	VpzElPxYUzA+qVbQIDp4qm1Y5a5uVJjtgciTIx7E1pjI4iU1k0m2bBsF8SHPYwkIpDTN
	lqcdJhjD2h5lcuYRxAIsoFHfiMbOQvGhzdAyMeMJykFJ6h0R7NDA2umnaM7oAEdIGI3f
	qOJRIcqSnt+tyZP/kbkYldfJuVmHjxsmvKawtku9WFlW5R8fbuzDTuIi/EuZs4eS4Iu3
	8F3w==
X-Gm-Message-State: APjAAAXYh3oizgQAs4u9EzoLt2i9xfcP4RZPi/OFDTuMiq0yFk6Buz/R
	mAwXtInSJtUM1uKbdtJb6JEH3pjWCNU=
X-Google-Smtp-Source: APXvYqw5QWQeg+oTcfUkDkQbnYbnelGS4Ht5BVnd8F3Q0tczUUykC/tSfBE/bOBd067ohmsD+p2GQQ==
X-Received: by 2002:adf:e607:: with SMTP id p7mr24967002wrm.230.1567582621693; 
	Wed, 04 Sep 2019 00:37:01 -0700 (PDT)
Received: from localhost (ip-217-030-068-212.aim-net.cz. [217.30.68.212])
	by smtp.gmail.com with ESMTPSA id w9sm6468815wra.15.2019.09.04.00.37.00
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 04 Sep 2019 00:37:00 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Sep 2019 07:36:59 +0000
Message-Id: <20190904073700.2566796-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [1.40][PATCH 1/2] utils: Fix movefile() exception handling with python3
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
X-List-Received-Date: Wed, 04 Sep 2019 07:37:01 -0000

From: Martin Jansa <martin.jansa@gmail.com>

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 215c18cf..f5bd816c 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -796,7 +796,7 @@ def movefile(src, dest, newmtime = None, sstat = None):
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



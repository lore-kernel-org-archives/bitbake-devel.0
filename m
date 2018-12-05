Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id A022B6D6F6
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Dec 2018 13:07:04 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id q18so19598605wrx.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Dec 2018 05:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=lMmEaxxp83XI2wXwu8Baw3HlPblJB/hbvHON7rQB9tc=;
	b=Ggb8xMOqghoXj/wiphP+0w7DxpIjyxPwr8zP9tkNcdpPpE5CQjY9KZkRrhx8m2bkbV
	4f1njwVEEmyvLABzEPUz3Bjq2jqWkxtlTIM78gmXGLsfyey4+Qtr4yDPf9TV7QFFeOTq
	oFQReU+SrMfI2rINVVKSLAFb9vndNEqaFrvqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=lMmEaxxp83XI2wXwu8Baw3HlPblJB/hbvHON7rQB9tc=;
	b=KnCK879i0hmrpV7kXCXj0G4DOO1ptZz+qWnjN+FyMtV6oHVPjzxxlYskUQczui29gW
	P6kRDiBfcKqj76yQJAd92WCZzlfBAB7f/fZdb33o/ZH2hI0Q/e3q9WP+A4KSAvG/jv6m
	D3TLVXFTQm+2cxMfDafck0dMWgK7mR8i5ZkpmXibKYo2CwPrptvBC6fAfDtFTI4nKUyR
	bQT6RWo9w7cP+0v6W18BPQ0jbeY7SdaBK6Y2YlYY1vk7IePXQXDBkL+LXUIlr8pUsa+X
	SY/YMjIpmygsiJD/lmUAg0NRng32hZlkJJkH8i4AletIvJ3RLDbdhYbIkFC75Ssetivf
	gArg==
X-Gm-Message-State: AA+aEWb3Pxk1aC6gjZqZpI/C7ibuZENCytceFICNkoBhmR10kfuV6uqe
	uAxybe3X7PKGpMKEleQKXgssW+aFvM8=
X-Google-Smtp-Source: AFSGD/X2YSoc1zOXMgISxc30W00kiftMGRiDZI91vww+bmP0KaLYLaistiOHnYPTwXEP8uVJWYh8Lw==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr21258936wrr.329.1544015225112;
	Wed, 05 Dec 2018 05:07:05 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l197sm11825711wma.44.2018.12.05.05.07.04
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Dec 2018 05:07:04 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Dec 2018 13:07:00 +0000
Message-Id: <20181205130703.13546-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Subject: [PATCH 1/4] server/process: Make lockfile handling clearer
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
X-List-Received-Date: Wed, 05 Dec 2018 13:07:06 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 81617acd96..d56681c5a9 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -239,6 +239,12 @@ class ProcessServer(multiprocessing.Process):
         while not lock:
             with bb.utils.timeout(3):
                 lock = bb.utils.lockfile(lockfile, shared=False, retry=False, block=True)
+                if lock:
+                    # We hold the lock so we can remove the file (hide stale pid data)
+                    bb.utils.remove(lockfile)
+                    bb.utils.unlockfile(lock)
+                    return
+
                 if not lock:
                     # Some systems may not have lsof available
                     procs = None
@@ -259,10 +265,6 @@ class ProcessServer(multiprocessing.Process):
                     if procs:
                         msg += ":\n%s" % str(procs)
                     print(msg)
-                    return
-        # We hold the lock so we can remove the file (hide stale pid data)
-        bb.utils.remove(lockfile)
-        bb.utils.unlockfile(lock)
 
     def idle_commands(self, delay, fds=None):
         nextsleep = delay
-- 
2.19.1



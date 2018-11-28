Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
	[209.85.128.42])
	by mail.openembedded.org (Postfix) with ESMTP id 539D66C566
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Nov 2018 16:31:54 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id y185so4380770wmd.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Nov 2018 08:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=Rd5A517I3hBNIkOwbdp7Yu02n61PNe/PorRSpTlaaGI=;
	b=LDwUZIK50+MA2huUbkUrJnMnaU21riXGE833YgKfl/Jz6UsM6f6YtyJ9PJvt6aQ+qH
	jCzy9ondhE/jimQYlaHy0Cxs6/QdmssBNfa7ZQkiW4YYnyFqmqnqk90ZcSoHtVNwBCNU
	96OhWu2HkykKNXsTXwI+GAaHM2ElvBaoKmoeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=Rd5A517I3hBNIkOwbdp7Yu02n61PNe/PorRSpTlaaGI=;
	b=k68ikiBW8cUAmccPe+IBXE+IGJyKbrVaUtrmu1pMiTK+F7j2+yV/FQjDlSM1ljfS6z
	ZDc2AoafA+z54F8N5LRZpIB2NOC54n+S+sBZeYYfKPCxgz7HtJeP6OwhGXtRZ7LD8RxG
	BvvK92S30ffaoKZH73LPOhdkAWuX+aseN6DTPIPGmmEEpCvK8yvfDeed/nYA0HMDUCSf
	wLcOq8qCdFPtbUKP6ke95BE4GbYZ+aeJ8Hv3mEr0Usaj/ei6VUB9XYhV7Kw+jXkm8NyJ
	gJno7D9teSNXfSPzykg6wjTTEh9oXMUX91txzmGwx6GKyLAY+4JFPgwJIhLwKZkCQRfb
	RIJQ==
X-Gm-Message-State: AA+aEWainYfzzBJz41G977b9JNsyNSc8OOlhNydCOE2Cnt5/QHIU7oIF
	zH3VqJ6Zjff1+AYHrTDQay0IPQYtBKc=
X-Google-Smtp-Source: AFSGD/V2Xsddzip33c5T0SsVeaXMYfAm8rzaxvKmUBqC2mECou6mzodMWXmVjgx2otPcHfrjHuXGtA==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr3156609wme.57.1543422714711; 
	Wed, 28 Nov 2018 08:31:54 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	z12sm7714456wrh.35.2018.11.28.08.31.53
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 28 Nov 2018 08:31:53 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Nov 2018 16:31:52 +0000
Message-Id: <20181128163152.16770-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] server/process: Fix ConnectionRefusedError tracebacks
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
X-List-Received-Date: Wed, 28 Nov 2018 16:31:54 -0000

Improve connetion refused error handling:

NOTE: Retrying server connection...
NOTE: Reconnecting to bitbake server...
NOTE: Retrying server connection... (Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-opensuse/build/bitbake/lib/bb/server/process.py", line 471, in connectProcessServer
    sock.connect(os.path.basename(sockname))
ConnectionRefusedError: [Errno 111] Connection refused

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-opensuse/build/bitbake/lib/bb/main.py", line 464, in setup_bitbake
    server_connection = bb.server.process.connectProcessServer(sockname, featureset)
  File "/home/pokybuild/yocto-worker/oe-selftest-opensuse/build/bitbake/lib/bb/server/process.py", line 502, in connectProcessServer
    os.close(i)
TypeError: an integer is required (got type NoneType)
)
WARNING: /home/pokybuild/yocto-worker/oe-selftest-opensuse/build/bitbake/lib/bb/main.py:481: ResourceWarning: unclosed <socket.socket fd=14, family=AddressFamily.AF_UNIX, type=SocketKind.SOCK_STREAM, proto=0>
  logger.info("Retrying server connection... (%s)" % traceback.format_exc())

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index efb4332394..81617acd96 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -499,7 +499,8 @@ def connectProcessServer(sockname, featureset):
             command_chan.close()
         for i in [writefd, readfd1, writefd2]:
             try:
-                os.close(i)
+                if i:
+                    os.close(i)
             except OSError:
                 pass
         sock.close()
-- 
2.17.1



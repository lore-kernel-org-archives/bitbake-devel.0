Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 5C0DD797CC
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Sep 2018 13:13:40 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id y2-v6so14714320wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Sep 2018 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=+F1CAzMfTnYPt1sH3zFjyd4VFAgTgZhkFa1ELys3vTs=;
	b=HI3bxf+yCVsn+lBdglOCqRk+ys0HcNxl3iCPwisSvkbGfjWXsgjuK1X94H5JRos/LW
	xjk+LWvevkSTCScS5YpnSAUVSoa7kzOIaNzXuJSCRij8AT4TxiyxNpIM/HxV7YSANstd
	9u0NaFOA3aBiJiejufQ1yDFl4Xhg1QWM0jb30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=+F1CAzMfTnYPt1sH3zFjyd4VFAgTgZhkFa1ELys3vTs=;
	b=gZUZ/M985hRi6g7wuBHs6vTeSDAoYFP6av/2KiH8Wotkp9g8GOeXbS9RzflT7qU+7P
	5pGbXKJJlUrkvqF0tLf7AuT6r5DV1GBh7jrjcNouQaE3khqMQeR0GXRueJpOYpyBWDvJ
	1TTnes5v1PGqbXjmedUgAj9aSo137le6bZimr4aSxWbdPjBcEgd2zWvgHpTrVIs5Ap2V
	9lr8wcuNJ52iPg1f3ZjeviyHvU8w9mjC4xqTVcKOK78VQvk3uQymqH39YlCsEBSL9ZTO
	bTOJ3RO5sG0HTp1pTFZf1QGDGXxKhIzSGEsyukqbcreXUf5Up2w3DAwCR24vaC7zJon4
	VILw==
X-Gm-Message-State: APzg51CWHc2Tp8iARt76yJxnPpyfc971X5DFt11n8ShXZ25sza79rafk
	So+Km4KZXiJiI96syOTi2+tbTNt+6eY=
X-Google-Smtp-Source: ANB0Vdb0kXNKB8UTMWzz65se8wWHVioI0DXBGy9vnw5Dc419JXq5bqzR/GujaTUIQmWER4JD/CWIRw==
X-Received: by 2002:a1c:adca:: with SMTP id
	w193-v6mr4771377wme.147.1536326020703; 
	Fri, 07 Sep 2018 06:13:40 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	n15-v6sm4793813wrm.27.2018.09.07.06.13.39
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Sep 2018 06:13:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Sep 2018 14:13:37 +0100
Message-Id: <20180907131337.19487-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180907131337.19487-1-richard.purdie@linuxfoundation.org>
References: <20180907131337.19487-1-richard.purdie@linuxfoundation.org>
Subject: [PATCH 2/2] cooker/runqueue: Turn universe warnings into verbnotes
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
X-List-Received-Date: Fri, 07 Sep 2018 13:13:40 -0000

If the user puts universe on the commandline, they don't really want warnings
so use the new verbnote level instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py   | 2 +-
 lib/bb/runqueue.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d7e90f25d2..71a0eba8e4 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1594,7 +1594,7 @@ class BBCooker:
                     pkgs_to_build.append(t)
 
         if 'universe' in pkgs_to_build:
-            parselog.warning("The \"universe\" target is only intended for testing and may produce errors.")
+            parselog.verbnote("The \"universe\" target is only intended for testing and may produce errors.")
             parselog.debug(1, "collating packages for \"universe\"")
             pkgs_to_build.remove('universe')
             for mc in self.multiconfigs:
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7095ea5abc..91911aff89 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1070,7 +1070,7 @@ class RunQueueData:
                     msg += "\n%s has unique rprovides:\n  %s" % (provfn, "\n  ".join(rprovide_results[provfn] - commonrprovs))
 
                 if self.warn_multi_bb:
-                    logger.warning(msg)
+                    logger.verbnote(msg)
                 else:
                     logger.error(msg)
 
-- 
2.17.1



Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
	[209.85.221.52])
	by mail.openembedded.org (Postfix) with ESMTP id EFD917F120
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 13:13:57 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id j8so5856514wrj.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=0F/doQg1l9cIS976WAJjX6X/dKuSBqnIK8RwW2SmJaE=;
	b=OQUcNrb23PH/NcQOe9ynrNriI/7bF05fVdrh/u9g5MbpYSFiVDbcl0Sg+gQ/BkqLB8
	hogcE327Qr9Zb2/nShwYdxFYShlQym9bNlJqJkdVqUsN0MG47/u/WcPOmjuD7K5lgj9m
	lVajbdjk9FW3JyopKwUSibLnNOHLD8PkAbNZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=0F/doQg1l9cIS976WAJjX6X/dKuSBqnIK8RwW2SmJaE=;
	b=kaSZsnVwb7jIe229MJCVFh/XuQHDNrPMiXzs4yd9PlxJ85CVh/dNb2iymtcG05FZ8t
	52bmdFQaqbGLLeLZEzUsymaPdDlcFMjD8yNpGlT9u54YNTUPaK4CffVouHpdJHBkbKy0
	qzKmm3DnkqvPHB6rlZc4p9pMSzBTulrmIdVEZhB1psrjR9cIzTGG0DaPBqbuU2GDKANE
	s4OpidQHISJH1lzYxcDkgaoy2yzdodo5Tzw9rlJpN3vSFJBwbw3dUzV2sXc00lgbuqA1
	HKFR7BK3RtfeI1lclB+H1xoNNeD+EVM+r+e9Lp6yc5h8zR7Vhb92I+95bflqCTEoJ7Xc
	q+tA==
X-Gm-Message-State: APjAAAUxEEA1XDLYUM4F2Aie9Ug6xay5AGci0++aKhABzKubKqUra58D
	So6yxaZoLMwT1IYa1kfEskgT+bgIhvg=
X-Google-Smtp-Source: APXvYqzB1ICqUCWb2xWcpLSCiypbe+OP2ccYScV/9B7Yg1O7OB95GaYSf/SGFQniheYooB4Y8zWN2A==
X-Received: by 2002:a05:6000:11c6:: with SMTP id
	i6mr6695797wrx.193.1562937238455; 
	Fri, 12 Jul 2019 06:13:58 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	k9sm6015169wmi.33.2019.07.12.06.13.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 12 Jul 2019 06:13:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Jul 2019 14:13:49 +0100
Message-Id: <20190712131349.29918-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
References: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 7/7] tests/runqueue: Allow common sstate tasks to become valid
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
X-List-Received-Date: Fri, 12 Jul 2019 13:13:58 -0000
Content-Transfer-Encoding: 8bit

As the logic in bitbake improves, the logic in the tests needs to as well.

Afer we built a task for the first time, allow its setscene hash verification
status to change, mirroring what would happen in a multiconfig build.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/runqueue-tests/classes/base.bbclass | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/tests/runqueue-tests/classes/base.bbclass b/lib/bb/tests/runqueue-tests/classes/base.bbclass
index b966568dc7..07685744da 100644
--- a/lib/bb/tests/runqueue-tests/classes/base.bbclass
+++ b/lib/bb/tests/runqueue-tests/classes/base.bbclass
@@ -5,6 +5,9 @@ def stamptask(d):
     import time
 
     thistask = d.expand("${PN}:${BB_CURRENTTASK}")
+    with open(d.expand("${TOPDIR}/%s.run") % thistask, "a+") as f:
+        f.write("\n")
+
     if d.getVar("BB_CURRENT_MC") != "default":
         thistask = d.expand("${BB_CURRENT_MC}:${PN}:${BB_CURRENTTASK}")
     if thistask in d.getVar("SLOWTASKS").split():
@@ -225,6 +228,9 @@ def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *,
         if n in valid:
             bb.note("SState: Found valid sstate for %s" % n)
             ret.append(task)
+        elif os.path.exists(d.expand("${TOPDIR}/%s.run" % n.replace("do_", ""))):
+            bb.note("SState: Found valid sstate for %s (already run)" % n)
+            ret.append(task)
         else:
             missed.append(task)
             bb.note("SState: Found no valid sstate for %s" % n)
-- 
2.20.1



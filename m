Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id EB998731C4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 06:41:32 +0000 (UTC)
Received: by mail-pa0-f68.google.com with SMTP id fl4so772207pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 22:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=bpOwwEnPg50e3ulZbgO8KZLCGXyH9ErKhJsQs3XDz6M=;
	b=YlsaDLy0cyFDiUOyJJP0euEBCsoKILhuPE49VJeAMWblfXS3h7o/iG/j6mOWBiatek
	0Vj9xJ/0IRbtaaEPRfUabfRo6RVlQZiGVBmcisW2KKluk/XcuhMeV0hETUA19r7inSFe
	BwiQudeY8SuAoP0M2QMXCDUlWHDS7ufLk+IMGtQrFyCHF1MWaj4Qu342toz2FsSchs/h
	euE5vFF0lJSzvIYZxnC4Qrw9SF0Idq5NStJ2aEx2U3/2ux76HFFOfnLTo3M/i/ZdjYCi
	+TWGkkZuoeWs2Y4NE0q2pq3AtW5pwJwf3RigQgl23Cw6X/AYzsHHhiCeQzFWfZqySEks
	zXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=bpOwwEnPg50e3ulZbgO8KZLCGXyH9ErKhJsQs3XDz6M=;
	b=XVoQS0x1J0X13oJTyMMO94Gxg/I63KkmW79btifIrZ3ngScG7RzV+l/8a7i1fDZlCo
	yG/sfB1PzVFi12KW475AbM1JPvXwP7AVVVHkBUXOAWdhQpClQUXmeU308cfvo6LOcHEL
	9EyxytDfr/xo1qc60MCPzYhOBH1LEs7OqYGEgAQaYhMsY572+nKRJ/q9IeyfeZlQqIgs
	xgtkVu/voZ4z8qd2SL+DVXn+tw6Y3u3vNPcR8I2bz2fLrEr6rtgY9SXdxYQRkcKErORS
	clZ96G2+6pnmWkTt6BgqXulwRPBR41CDyA52LtXSgjN8c2y7wcNu/8fnpDSQZ+dSEc4T
	xAmg==
X-Gm-Message-State: AD7BkJIBA2tu14SxMNleAJDAoQrvT4lieSkLHHgC89j6LM1hNLz1TwW/QiPf2KvVB3hacQ==
X-Received: by 10.66.144.134 with SMTP id sm6mr1431502pab.158.1456987294000;
	Wed, 02 Mar 2016 22:41:34 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	r62sm57476673pfr.26.2016.03.02.22.41.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 22:41:33 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 22:47:41 -0800
Message-Id: <6c8b2e579691e66720cf1bb80dc0fc36ad4b56e2.1456987460.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
References: <05400d100e891245541e10b1d5db9a783004b20e.1456987460.git.avery.brian@gmail.com>
In-Reply-To: <cover.1456987460.git.avery.brian@gmail.com>
References: <cover.1456987460.git.avery.brian@gmail.com>
Subject: [PATCH 4/7] toasterui: check if setEventMask succeeded
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
X-List-Received-Date: Thu, 03 Mar 2016 06:41:33 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Currently toasterui ignores return value of setEventMask
command, which created confusing difference between set of
events set by this command and the real set used in the code.

Checked if setEventMask succeeded. Print error message and
exit if it's not.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/toasterui.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 4bb33f1..fec6962 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -154,8 +154,10 @@ def main(server, eventHandler, params):
     logger.addHandler(console)
     logger.setLevel(logging.INFO)
     llevel, debug_domains = bb.msg.constructLogOptions()
-    server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
-
+    result, error = server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
+    if not result or error:
+        logger.error("can't set event mask: %s", error)
+        return 1
 
     # verify and warn
     build_history_enabled = True
-- 
1.9.1



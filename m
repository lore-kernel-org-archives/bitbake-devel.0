Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
	[209.85.128.45])
	by mail.openembedded.org (Postfix) with ESMTP id 06486745C2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Dec 2018 13:07:07 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id m22so12858657wml.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Dec 2018 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=fmBKzSDQmnqM8ZSRT6D7hepee46ODQRvvfOvxhgDKYY=;
	b=RcaXOd4J1diHQlYdiGkzZscocKiWh/+FicEcP9xdP8HXyfNOXp4Qwpuekd/oQIL88V
	E3vUvdy1diqJ2/4sLpySlE8FZazS5aTJRH8n11AMmaSgXzHKy5298IPhcPCBzCeX9dDw
	crRYpdYCRqs6a4jjcqf3O0C0ND626HsPD37fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fmBKzSDQmnqM8ZSRT6D7hepee46ODQRvvfOvxhgDKYY=;
	b=sdbDPCE3NMjIC4KatV0OlnxvDlhJpoQKzddbYF4i5Fu80TlcZGCWca1Whi/TJJIQr1
	rlem7/RtKtLxh8HawF3DL2azNZ/3D2U6fxjSBzm30enR8zF0Cor6PI4RDtVE6J1kqFYY
	5UKHFDujUTMlP5NYE1OzLRs2lqykX6tndLP07w/ZtSLTseizcrUp7AUoyVjjqkQsF4tX
	1ZUm5DMBHxd+E/5ZBCyTLgGFlFTvrpSuQwtmrXOUupSfsZya2yYAfPxz9+ucprKFP28F
	epVieT59gsP4sLk7uGG9pyfTiMLedRTNbTDnfpVjaT0W2Omjydeou4QEfLsMTMKJXFr/
	r1kw==
X-Gm-Message-State: AA+aEWYYHNDBkEGnqYDo6k3dKXJqaplooEdWMMYgWMdH7uVy6oj1iyka
	/ENWrUcOBkAB1RK5gwgvS9I1xqkc3W0=
X-Google-Smtp-Source: AFSGD/Xq6XjINA2q8q9Bd7kBms+AIAr61z0iv5t3z9twSi2ImCCrCRvsDl+vrwn9UhdWZrWtriZaHQ==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr16040681wmh.0.1544015227464; 
	Wed, 05 Dec 2018 05:07:07 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l197sm11825711wma.44.2018.12.05.05.07.06
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Dec 2018 05:07:06 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Dec 2018 13:07:02 +0000
Message-Id: <20181205130703.13546-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181205130703.13546-1-richard.purdie@linuxfoundation.org>
References: <20181205130703.13546-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/4] process: Flush key output to logs
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
X-List-Received-Date: Wed, 05 Dec 2018 13:07:08 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index fd1ba47fd5..49973d6670 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -445,6 +445,8 @@ class BitBakeServer(object):
 
     def _startServer(self):
         print(self.start_log_format % (os.getpid(), datetime.datetime.now().strftime(self.start_log_datetime_format)))
+        sys.stdout.flush()
+
         server = ProcessServer(self.bitbake_lock, self.sock, self.sockname)
         self.configuration.setServerRegIdleCallback(server.register_idle_function)
         os.close(self.readypipe)
@@ -456,6 +458,8 @@ class BitBakeServer(object):
         server.server_timeout = self.configuration.server_timeout
         server.xmlrpcinterface = self.configuration.xmlrpcinterface
         print("Started bitbake server pid %d" % os.getpid())
+        sys.stdout.flush()
+
         server.start()
 
 def connectProcessServer(sockname, featureset):
-- 
2.19.1



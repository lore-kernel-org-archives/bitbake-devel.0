Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id 8815F7EF6F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 11:31:00 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id v15so5340502wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=fmXD9oCOkkkeq9dkUBmM24f4/zbXswKkNCX3M50Bzv4=;
	b=fOFITMYZs+YKTbWKzvilsYF6XxrlkzGgH3zwALCc7NzXvspWMTCKMjNOgt9m/QztgD
	nBiOU3QsE/nm7YClTaFzddm6MUvDfCeQ/WWLk7mZXMmBGNEVrMiukT69iwlKOVdqqEnm
	39Pp8sUMj1K8P8gYpVpveKt9YnCfcvtbMeOzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=fmXD9oCOkkkeq9dkUBmM24f4/zbXswKkNCX3M50Bzv4=;
	b=VOzU1PO0RHClBUmtFhfFZLvOOZUPTscpzoYoCkSvhJhdfujvB41shdcapZMmVKGTgY
	7/e1295O2v2wF+dU39CMJLIfjasJ3DewhogqbqjC8fQcBXS3u1CHy9AcXgj986G1DGjM
	jeP5hJB27QXoS07bGiobrzNu64zzJUP2OtucfEVDUBtxDgo9bho/+KDXKIXiJ/DBJENd
	z3zqtI+/Iws3eCOpoOevpc4S+hMwX1Ts6JHEvvY03Vb+50pR2sv/2AhmlLkPlWS5dRxk
	n2T0NLj1rPLI6JCtCEgH+6gKlGq/LxO0iBk1l0FDRccNa5Ysh2u8j28rAmJ82GT9M/Fu
	XTrw==
X-Gm-Message-State: APjAAAV/J75+04fQc1j5rJ8rFEzc006PHZict3q9Xs59INaDcDay90Xd
	SRVVHImz/slvzM+BdeGd5KRdDvaWQXc=
X-Google-Smtp-Source: APXvYqyO5fzRrYoyRTen+c6MgHajPH66iV5QuThHAA16ankOYsvuQuHWmA3ti7ekLezhih7wP/oiHw==
X-Received: by 2002:a1c:a101:: with SMTP id k1mr4014192wme.98.1562844660983;
	Thu, 11 Jul 2019 04:31:00 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	k17sm1692718wrq.83.2019.07.11.04.30.59
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 11 Jul 2019 04:31:00 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 12:30:59 +0100
Message-Id: <20190711113059.32148-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] uihelper: No longer listen to scenequeue task started
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
X-List-Received-Date: Thu, 11 Jul 2019 11:31:00 -0000
Content-Transfer-Encoding: 8bit

With the merge of the scenequeue with real tasks, this now confuses the
statistics. The real tasks are the definitive progress so monitor only
those.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/uihelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index db7f0ca08b..c8dd7df087 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -40,7 +40,7 @@ class BBUIHelper:
             self.running_pids.remove(event.pid)
             self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
             self.needUpdate = True
-        elif isinstance(event, bb.runqueue.runQueueTaskStarted) or isinstance(event, bb.runqueue.sceneQueueTaskStarted):
+        elif isinstance(event, bb.runqueue.runQueueTaskStarted):
             self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
             self.tasknumber_total = event.stats.total
             self.needUpdate = True
-- 
2.20.1



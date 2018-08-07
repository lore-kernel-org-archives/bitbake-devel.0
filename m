Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id DDA446E650
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Aug 2018 14:48:52 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so18539102wmq.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Aug 2018 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=tuIRS6pkau5odRqKxGhpy/Xxce6s5T8fr59GhnRgkFQ=;
	b=WUF09ODTf0Sv86L2t5L2eoeRjlI5o5cBoZkgH5jTJ12zOGtHcdOXk30qxCxirAp4Lu
	c0KxRPrAVmSQGbxmOvPyh9wXy84GDbMJX+nviQb8+PbJ7Ybl91V6CPwgWIgBhWrHp6gt
	XF/LqfFWo+/pM5gLwmgf3mHQBhd0tqeDyKGJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=tuIRS6pkau5odRqKxGhpy/Xxce6s5T8fr59GhnRgkFQ=;
	b=SY0hqdtk6o29QQc/SFKdzp6ma5j1cAjueczQA45xXjhrO65+Yqraqpi8fkXbXB5mtx
	okhg3IHTrOM5QegRR9eAWvJ9z9KDIvoHJrFYVnWMMqbBv33gLHwwhhsT52fSypNxOB3a
	jecv1g1JabqSUyIRgKXQhWFaRJPOKsnM8KD8+tgKdq6JJS9EmIjVuWD/fK6VUYNS/F7v
	sscFYHToopi0Z3zgOs0yL1WZMvJ0kb3fFtKW9ptpuxrxfBV+8S4ipEQOe4hJBH7lUWEB
	/90eKucVAKXX58OJ8Fi2Coo2O2YvP82E13fExfLiX/OMh/zm0CrYOkzYaw/TNXP59Izw
	7n/w==
X-Gm-Message-State: AOUpUlH+huFsqvYlbqA4ejrAlysN92/vgY1/HyfhS8UhcawkPHx2aYMh
	0LwEebTqKn4UD+GYKljSwLDLuYW2zhA=
X-Google-Smtp-Source: AA+uWPz88cgVXxhMJnPIODCSNDdXMt5eBfzA7pfYboJlniHxZdct6MeZz2IfehCiMM/JuDkIDWeyiw==
X-Received: by 2002:a1c:3:: with SMTP id 3-v6mr1767362wma.99.1533653333314;
	Tue, 07 Aug 2018 07:48:53 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	s124-v6sm2356515wmf.47.2018.08.07.07.48.52
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 Aug 2018 07:48:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Aug 2018 15:48:51 +0100
Message-Id: <20180807144851.26127-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] runqueue: Allow the hash validate function to have an idea of build completion
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
X-List-Received-Date: Tue, 07 Aug 2018 14:48:53 -0000

There is an oversight in the current hash validation API in that the
function can't know how many setscene tasks already completed. Rather
than trying to add additional parameters to the function, causing
incompatibilities, store the value in the datastore.

This is useful to allow build status reporting to the user for
figures on sstate reusage and build completion.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a43c9983a1..400709c160 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2314,10 +2314,15 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_hash.append(self.rqdata.runtaskentries[tid].hash)
                 sq_taskname.append(taskname)
                 sq_task.append(tid)
+
+            self.cooker.data.setVar("BB_SETSCENE_STAMPCURRENT_COUNT", len(stamppresent))
+
             call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
             locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
             valid = bb.utils.better_eval(call, locs)
 
+            self.cooker.data.delVar("BB_SETSCENE_STAMPCURRENT_COUNT")
+
             valid_new = stamppresent
             for v in valid:
                 valid_new.append(sq_task[v])
-- 
2.17.1



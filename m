Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 8F4097F119
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 13:13:51 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id z1so9902062wru.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 06:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=kvTULf1BPhncWc6SIlTWQe6H9HG/0HabcBPG1GLMxII=;
	b=JCNFS/OsqiUALIODwhQVrukGrBD31RabP6cgAAGJC1truhRyAPrz5QbLiXL411kCzf
	/Ge7/tJGjdEXyt5iTpkri5r+iPWe2gsEhK2krsRlR4J0fUSrlwa8iP8LERn2JRTCTnKk
	1Lnu4YJQJgR29IogunpHt91Fuqd6iFYComajM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kvTULf1BPhncWc6SIlTWQe6H9HG/0HabcBPG1GLMxII=;
	b=hjItEgGmrFPR7xto9rBLVwK5yP5yjftjx3US4YiBe7KpmhVTr1JpJePTT/+UX+qHcZ
	K8W86sDB6x4oN9++L5bQFIFvSzuhmqwYMjiMMppj2TRpyZHwnFzCBHKOqEv6pH+yMFvj
	d2K95hmYCRTcY4ffgGXH4eOnBntve/1ou9izLfXtRRaxUUnYXle9OdjUCM6XdaD0HaP6
	B14fAW8zcg+5sosJj4kYIKpiqlvloBLdY8QuUwx1H6Wal3aLcXMfumIAvTmPfmFDoG5R
	9duqBqiq3FBFHjJNFsEt05H2dQJBnk4iaYwAEDlFzrnscggcn8UgtJeor9BZKJQpV20c
	EE4g==
X-Gm-Message-State: APjAAAUbGQN64DKqsv1SCaXG3uGgkJN4JQcOOAeA0aKl6AIEsGS10qdo
	R2ubCdQpCG3WlFM1N1iOj5JI6pfQP1E=
X-Google-Smtp-Source: APXvYqzZ90ZTJQKFTL6JU/vBRy3mMJznMKLL6qH70C4MbCeoyZeRSfvFtQHA7z6e1UV5M3JL4TiHCA==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr12519328wro.284.1562937232163;
	Fri, 12 Jul 2019 06:13:52 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	k9sm6015169wmi.33.2019.07.12.06.13.51
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 12 Jul 2019 06:13:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Jul 2019 14:13:44 +0100
Message-Id: <20190712131349.29918-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
References: <20190712131349.29918-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/7] runqueue: Streamline outright setscene failure handling
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
X-List-Received-Date: Fri, 12 Jul 2019 13:13:51 -0000
Content-Transfer-Encoding: 8bit

With the recent codebase changes we can just call the outrightfail
function immediately, removing some intermediate data structures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 48b668abc1..2d52ef3190 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1913,9 +1913,6 @@ class RunQueueExecute:
                             self.sq_task_skip(nexttask)
                             self.scenequeue_notneeded.add(nexttask)
                             return True
-                    if nexttask in self.sqdata.outrightfail:
-                        self.sq_task_failoutright(nexttask)
-                        return True
                     task = nexttask
                     break
         if task is not None:
@@ -2330,8 +2327,6 @@ class SQData(object):
         self.stamps = {}
         # Setscene tasks directly depended upon by the build
         self.unskippable = set()
-        # List of setscene tasks which aren't present
-        self.outrightfail = []
         # A list of normal tasks a setscene task covers
         self.sq_covered_tasks = {}
 
@@ -2553,7 +2548,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
         for tid in sqdata.sq_revdeps:
             if tid not in valid_new and tid not in noexec:
                 logger.debug(2, 'No package found, so skipping setscene task %s', tid)
-                sqdata.outrightfail.append(tid)
+                sqrq.sq_task_failoutright(tid)
 
 class TaskFailure(Exception):
     """
-- 
2.20.1



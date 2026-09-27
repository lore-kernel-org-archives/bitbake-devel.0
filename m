Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93469C98324
	for <webhook@archiver.kernel.org>; Sun, 27 Sep 2026 07:46:48 +0000 (UTC)
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33618.1790495200173231951
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Sep 2026 00:46:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=FYlMBGIR;
 spf=pass (domain: smile.fr, ip: 74.125.225.99, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so1118493f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 00:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790495198; x=1791099998; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WIFxBJLTzbvqMPkKIkzCjT2UyQq6nDbDujxiEhH/Fvc=;
        b=FYlMBGIRngvgG2A45r4MPUqCMuZ6ORhc+PA7Qa78iZovcHiBonD0lK6suGyAYEjViJ
         cnMS4clr5JL1y5BD6oZYQ0Kuwqqv2NvU0tPHpI+17Y2V4XmaauNLNAcHNsCGsnfnjwrU
         ANqOKprKe3JXDo2Eoe4bhvUNTwKLy9zci8vts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495198; x=1791099998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WIFxBJLTzbvqMPkKIkzCjT2UyQq6nDbDujxiEhH/Fvc=;
        b=wyuMSNiXSLU9rv9Ht1R68mNX56x3ecFusEI7UDQr44GdcVIBrSEulnrVJve0PnvfcO
         zTlnJJQSAb5NER352Qq6eN0RLwJv5G0C02Ht9S8Nb5EBHTpCqLTg0t8PbXssTFjQyfw0
         Ch1tf56Cw2FKVfB84YbKnllGXYjw+tkgEMuq1wF9NqPV95pZ1Didc2CWvgFjG6oVjZ1o
         eT7xndEat7xwwRS6QpAXLaLCG53hFOZciDaAPOVkIUfzLYA0UkvYz3fLIIKHUS3ZRWcL
         jH7z8tYaXlpn4AiAyXxnyz//IakfPO47pBAfjPlXyevbHqySVKkp0O0oRIBHzpBfGyB5
         uPLA==
X-Gm-Message-State: AFq9FYL3jlna7BmV2ZAqlASQWaJhysZvE+lTB0j/OCpLFtHm5OCG1izQ
	ZhwBLAOITP+PoluL/p0ARunIHnnAr5vUIciOltME7W8pOhbvpIjH5tcU1tzMqQHV96Cy5r3sH6B
	VLgoVtxY=
X-Gm-Gg: AYBFou3EE2Npa4lMPsQnJ4WIXp+VEikq4pHGlbFirzZ1Nw3gXnmPbH48Dk+F3cXGkxQ
	9mCYlln6BS9c1t1RPIM2JtIkil5YCmDb9NhGxz332hu9xY9zdNSlOHs8Ppt1E+QiB2myFDk5LGd
	+gHVhtiKyRaA7LwKlr76wdWabu+5W87R6VwgBN6/4ghEsfYSyKHgSmuxK1f1c0xKs+GiQ3QFMPp
	/Kmaw7QW1DdxGsAmWPeNleusm8uqbA1FnHe+SeLRikwSR/4dMh4Prw0IowR+EA2BzXmPJS9xS2V
	sYOMaFoKAfNbPTg0Jn/iRQONn8dwAKu1mKMvvKNKO8ibgfwgo8/p7yWd2J22k3cWDnvN4yhLPHX
	p6TqqPxwAMSDKwsuT9vw9h0/tQ5P2qlPCkawkLYkwkASEYsU/ZnrbBe1XAFotz470FQcytcZdvb
	dglwHBBEaJqpncmuc8tpJd+p2qYru8z98NYMoUZk4t9H7RDl+/w1hGdEnJ3rxgICHJnLd+3yPOo
	tVsDVssMwtr0fExUiP2NKmTP5RH3EseSazsRTW+/tpBBfrJnW+7ulnhw3p4N2wnmnN5Xt9BamLt
	pjxEdtKoGQ==
X-Received: by 2002:a05:6000:2685:b0:488:8ab9:f74c with SMTP id ffacd0b85a97d-4888ab9f860mr3584470f8f.3.1790495198425;
        Sun, 27 Sep 2026 00:46:38 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm18485266f8f.2.2026.09.27.00.46.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:46:38 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 1/6] runqueue: Fix pending_hash_index not including taskname
Date: Sun, 27 Sep 2026 09:46:30 +0200
Message-ID: <54d387f575de2a1cfb77a1d8c92f0f268fa2e3ee.1790495161.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790495160.git.yoann.congal@smile.fr>
References: <cover.1790495160.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 07:46:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20260

From: Chris Laplante <chris.laplante@agilent.com>

The intention was probably not to use the literal string, "taskname"

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit c6a1288cb15171297c5607a8f6f6c01595ba8b8e)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a4689e134..544081053 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -84,7 +84,7 @@ def pending_hash_index(tid, rqdata):
     (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
     pn = rqdata.dataCaches[mc].pkg_fn[taskfn]
     h = rqdata.runtaskentries[tid].unihash
-    return pn + ":" + "taskname" + h
+    return pn + ":" + taskname + h
 
 class RunQueueStats:
     """


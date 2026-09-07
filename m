Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4F4C79F9E
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 13:10:41 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34332.1788786638942195791
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 06:10:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=D5nHlkWE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so28340545e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 06:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788786637; x=1789391437; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J/fEDbQzuRiMwLix6S0TE0sd12tUF/5U2f018xSMj8I=;
        b=D5nHlkWEm7eTVBT8eczH+CCxsbNwZf+bIA4wqMN8I6YyzUNbXmVXYc0eSRsbfPgAOy
         lyY+M3f0CHqZDKeT8hsZ7n0LyYs4BY7oejyynfLSIsG/d6aLRSUdASg/gdhZpTd+7eMU
         Sno3ZGAt6Jdc88fS4BOSVRJ8tUjkpvuXfebuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786637; x=1789391437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=J/fEDbQzuRiMwLix6S0TE0sd12tUF/5U2f018xSMj8I=;
        b=FcJgUN8T3kAxY2xFItkeGJnX1ry64Uvmyz/DspIp6swr0b2kSf4B6i099SVC09JGdi
         4wbs7n7uMVBILm6twGVNgSPZPfEkkA9Wym9JJR18dIOcuSRAi5480826uCAp+lrR6H4s
         G1KqEIc06Bm0d0KrMb2R78mu7907Qna6QoX7RomeuxyntY/n9OauMLxiy04PINZvaUZe
         0jY10wbvBDPx4dbLrI1+/3fpINB5mnSwk+cNGh1ppxnyzamIwgJa6g/2k79Wod1zILm7
         UtHFjaPXzenDNMjRNYHRzesNgLvv4qNHZLOO1qY3vQ8KQnwynUr+PP0cyPChvEJnH+N0
         DQag==
X-Gm-Message-State: AFuF++kwqeWUKwqVsuGOenjrN5uunSVgpLpxM4opAMknF5s3EjlS29AB
	qN52RWxERTXFH+2v6z5SMcwxVV39jwAQVvw7G6ia1s+GBdrAkuLn2f4FZa4pXuz1KY4WOsSzJ4f
	od4CADHI=
X-Gm-Gg: AYBFou00grPp7GkBfMN25LEageHRNWpZY894DdKXBnv1vvT4AxwoNm9k398O+LM8L43
	RThlKqa93HoXnq59N1ZXlYAjYKPxzkJxXN934I0NcXIEwk/CuYEyCFSTHgyfCVlydnwSncM5/SM
	6HLt754gByuOUL54Tewy14otUYN7IzkNXYLwsm6CLesEwuY2rChXZnatniAXY8c+McCYAQI9v/q
	sdm4uJlTl4cru6UZKW1o+wtmEN+2tBW8tX4s45kAdPESLMba6zmf4DyY2zg/3druyzfkYFI+ono
	+Otti/QDyga0lo0Eu2k84mjJ0nRWMwFNKtnT1rx5W6zmDHjYyNBtODr4LfG8tAxS16mHyVi0R/i
	h7pM+bjqx06QUg/ldPMD2r17MTb/iElbINjI/TrgU+HUfhiyhjCzrSq17ldpyQG8NfIa6XSJYSP
	TeDoGiptFCx36I5YNBPzjfRPpWMFXQTs4wBoIo+xPE1HCM4BeyMOPcHlRLywemezLL3T09+B5DK
	+LhkhZTc3xC4kuj0ziRsUQSwggv
X-Received: by 2002:a05:600c:524b:b0:49c:fa20:cc08 with SMTP id 5b1f17b1804b1-49cfa20cd2cmr205474325e9.31.1788786636964;
        Mon, 07 Sep 2026 06:10:36 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e2ae:fec4:d03e:3153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf770fcf5sm307037555e9.6.2026.09.07.06.10.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:10:36 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] tests/fetch: Swap github grpc repo for our own small test repo
Date: Mon,  7 Sep 2026 14:10:34 +0100
Message-ID: <20260907131034.3989354-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907131034.3989354-1-richard.purdie@linuxfoundation.org>
References: <20260907131034.3989354-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 13:10:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20160

The grpc repo is 1GB in size and makes a poor choice of test repo. With github
rate limiting, it is proving probematic.

Swap if for our own gitsm test repo which is smaller but can serve the purposes
of the test.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 1f3b4ccae17..4d15a8a235c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1197,7 +1197,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_git_submodule_restricted_network_premirrors(self):
         # this test is to ensure that premirrors will be tried in restricted network
         # that is, BB_ALLOWED_NETWORKS does not contain the domain the url uses
-        url = "gitsm://github.com/grpc/grpc.git;protocol=https;name=grpc;branch=v1.60.x;rev=0ef13a7555dbaadd4633399242524129eef5e231"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=38e61644af90dccd73c03ed3acaed98c8dda9294;branch=master;protocol=https"
         # create a download directory to be used as premirror later
         tempdir = tempfile.mkdtemp(prefix="bitbake-fetch-")
         dl_premirror = os.path.join(tempdir, "download-premirror")


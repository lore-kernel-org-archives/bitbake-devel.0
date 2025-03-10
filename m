Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F160EC28B2E
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 14:58:27 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.40363.1741618702750347978
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Mar 2025 07:58:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TmN4BWo2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so25462495e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741618701; x=1742223501; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCuGIlL42XllXTw7Q1y/jXVE6iSCef70UY3No3VpvBk=;
        b=TmN4BWo2i8DPShqHM7/liabQc3Yw2V3iun3wKX8VT+08i0DcFZFkT5yplLBY9uEcNz
         QBnX7ge+nVWcg90K7xCp7VHo8LQ7QFPh6pmPJL8QO10MPR8Nmodrljk3Ix+pyNIU3DcV
         TEpb862a/K199LSIvkb/95aUM6vM2yV1tk/Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618701; x=1742223501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCuGIlL42XllXTw7Q1y/jXVE6iSCef70UY3No3VpvBk=;
        b=JcYPn6SdkBpIgcovfW6FaxtGkSmp5jucSFDj57zNd5L4EvKBFCR1UMdKAeeXSUQ24k
         o0yLErcL4aOylYYRJkDq1OdgVCz9NHBTyDa3IHM4ub3Fk6odwolqgwrjGv7ctJ1YW+BI
         QOoygK+eRjmYIdXHTRejUigsO1d7XBHpj8yWV4zk+ESsxiL3hNgRUemQw5ssUSvIuoQM
         jO8EUh1vjRm6WAv9iDrYOC2w/WLiBD5WjLWIs1nS3sIRr0MlW63FlJ67U8BeGwkwPvQh
         s5Pe/jbT0OuqDxOwIRO25i6mf+mp1XOgMeAPKk4+NddWGFrxTukz7/75qeq6dulCYHw6
         lAdg==
X-Gm-Message-State: AOJu0YzGqR+s424FBt6pzaHfz4a8+C/HDNCcNXDvLjVGDzDawp/asZGo
	Svy4xWd4jk5IdsRf7fdjiONJ2jj/bl35XdBOlq6pg0GJjvIdJEcRj62lCvG0cmjN1Ir0cQ46aU3
	Q
X-Gm-Gg: ASbGnctJRWY5VW0N7UVY/z9J1ZN7AsE8D1QaYWHzlMjMEVheuPls5YjzeaiSREPfQK3
	TJz9gbD3YhProJVVXFD/qlb1tUggoVHEYfgW6V3G6hgDDcM1Z7xhcAc37yG0XSMBeW6DRRdGBqE
	KOX9pmuNCYTBiHqffETlAMIKyrumj1SH3+8H0S/ep/kJ55aGyIuHlMRSFv29vXDIIJrXT1K2t2P
	+dAfrbQwAm9SRnaFEsOG8nQFu7VA6aCZNej743ZbK3H972dkxXujizzUnNd3lrcTkD56XLODUm3
	pP9NjzAiygl0PhK7YrxJbYyWqyIm7iL1cdS72K9+M1skb0NAtEY++KUtd/8Qi9vTncwKxssKeLs
	xqIiuXrL3
X-Google-Smtp-Source: AGHT+IFSpeG8IqEqqyqN+hsKGJwe7XRNWINU/9FIR9dySdmYSvdAVaNyPjcfPiQGLnsjkABA4MDMMQ==
X-Received: by 2002:a05:600c:354b:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-43ce4ab02eamr65458415e9.3.1741618700695;
        Mon, 10 Mar 2025 07:58:20 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3d30:def0:6e8d:cbc8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea4619e9sm62353735e9.1.2025.03.10.07.58.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:58:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Add debug for parsing being complete
Date: Mon, 10 Mar 2025 14:58:18 +0000
Message-ID: <20250310145819.2869616-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 14:58:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17423

We have a "parsing started" event in the cooker deamon log but we don't
currently log the corresponding "parsing complete" event which is
confusing. Add this so that the logs are more logical.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index e21815daad..1810bcc604 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1636,6 +1636,7 @@ You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result in si
         self.state = State.PARSING
 
         if not self.parser.parse_next():
+            bb.server.process.serverlog("Parsing completed")
             collectlog.debug("parsing complete")
             if self.parser.error:
                 raise bb.BBHandledException()


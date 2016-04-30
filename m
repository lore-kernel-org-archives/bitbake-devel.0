Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
	[209.85.220.65])
	by mail.openembedded.org (Postfix) with ESMTP id BB097770DF
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:44:01 +0000 (UTC)
Received: by mail-pa0-f65.google.com with SMTP id vv3so17814056pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=PLwoOVn/u6JVzahl8GP9eeAbWvvNc/ffVF5UHBK5gCc=;
	b=AYwuLg4yWlrzjsxJKi00XctRk+2Z+A54DCmd54LSRR7FTIFcol9aHZ7FggbIeo8OYP
	UEk8qLZR90/Za9oaddGuZ3qeDt4Gh5grkfZi+4rhZV58Ddcqafl+p9S0BsUijvB1pBEh
	fjzEXgoTIdNK0vKKKUTK1tBTXkz9Hc27EdVPtBvMl47YBE9f8y45xlajg+n3FZbbmxB8
	N+C9Fknx6ys716/eKYV2cBRiT4NTOVe65uqwv6EU5pVrBoGAms7dQxJbyt6RhHqs5ckx
	LPueC9AuJCJpTiYmP6WLSWkuNhb0bmEAIW1jtLLz1UJAMEAbFpMgfuvyJOKoeXDhMwZh
	s4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=PLwoOVn/u6JVzahl8GP9eeAbWvvNc/ffVF5UHBK5gCc=;
	b=TXxeB3alKkD3zRZBn4GM4MHJ6TcFQSyRnfssq5YrKMPp2DeEebA0M1Yr0hmm1m9F5Z
	XiR10MCavSUf+3z206nhNYDX2MfpHZTYQzlqfqQzupGTW05js2En0qghOReJS+7kQJCs
	WgsPUGP/zJWI7s/oK7vyJlYL3M3WnwKOHkRHPMA6x0bq9/MLqiRNMsuJGXM6s3y9kU40
	T5/JGuzbrejCDjdXXzPtymd9uILFyzZh84Ofi8JbYHYifCUdYk2ecoSj0XfCsP6K6faG
	Jlwzey6Oui/INh8t1XIvHvW9Gf0dAHqpny3You0owCtRs8i6IVBsqOXm4C0dwSknEKtZ
	WzeQ==
X-Gm-Message-State: AOPr4FUCkSzT3KrjRQetczHNP68HFqfkK1UF4LlZx5nejJpOzAMP6ac2SENSuY7uD2E6+Q==
X-Received: by 10.66.232.226 with SMTP id tr2mr39130374pac.44.1462045442811;
	Sat, 30 Apr 2016 12:44:02 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	fh14sm33540798pab.31.2016.04.30.12.44.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:44:01 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:43:54 -0700
Message-Id: <b84dba2bf03198d8b10b2a5c2a2ec1ff94f260d8.1462040900.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <fec58af5443888769f2737837bb8b307d7a7c32f.1462040900.git.chris_larson@mentor.com>
References: <fec58af5443888769f2737837bb8b307d7a7c32f.1462040900.git.chris_larson@mentor.com>
In-Reply-To: <cover.1462040900.git.chris_larson@mentor.com>
References: <cover.1462040900.git.chris_larson@mentor.com>
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH 3/3] bb.data_smart: use iter() for __len__
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
X-List-Received-Date: Sat, 30 Apr 2016 19:44:01 -0000

From: Christopher Larson <chris_larson@mentor.com>

It seems the frozenset constructor in pypy runs len(), so we can't pass the
DataSmart instance directly to it, instead pass the iterator. Fixes pypy
support.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index fa1e794..2ab884b 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -917,7 +917,7 @@ class DataSmart(MutableMapping):
              yield k
 
     def __len__(self):
-        return len(frozenset(self))
+        return len(frozenset(iter(self)))
 
     def __getitem__(self, item):
         value = self.getVar(item, False)
-- 
2.8.0



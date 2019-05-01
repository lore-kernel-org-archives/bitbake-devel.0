Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id D019D7DACC
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 May 2019 11:19:11 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id a12so24236507wrq.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 May 2019 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=an0ya7drFXN8+dFS7IfpeOvk5wUuRAg/NAJsPJRxd/Y=;
	b=dRwGwiPx2mSXHHdmydjc7OAAKzTYNByEp45GoCp04aUP1kBAvGDhDeKpur3KKQj/qr
	6+m8weEEIxDf/Un4S8dNe/nnLZFjOz3OOh0AclpLEzmzs4H9OwuUAcMYj3p4QfFVlXhT
	wrR62vDpPhsW6kk9iGNpysbiz3lQVxDJTghIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=an0ya7drFXN8+dFS7IfpeOvk5wUuRAg/NAJsPJRxd/Y=;
	b=Fe1cXRxQyUgPgR2u8TRwyVBiMTmLTdMJVZMKGskPLRarVEwarhMFjz7TDqDYgLrW9t
	XSdtBkQZZWGR6paWWpaUnKsb+ewH4X6FDB2v68wY4qGRvPe9/1sKsFZRd+giFjzlyQQc
	M9qqUDI5PFb1109D+qzalGxuZVKnDcw0wbnE6yEtX1ds0prr5hKKNnBi6136JF0ycZGp
	FEibc+RHNifJUmhv2SrioG2u7Hp54iUoYeMVaa9sLw4SzGK4Hdyw8qHi763dUXZFQBHj
	AVTYq1jFYykyfVMf4SZBU/dfsw3kCqsLFH04/rJZdwA5DkAObSZNz3IyHAjD5pH3cuDc
	PGRA==
X-Gm-Message-State: APjAAAWQQPDo+A/lTiexASosZPeFli/ypQwdzF0wsTD7sDmP9QeI+syl
	Mi4S9ddLaLwAFwnf2cOkxSn+vNTnJcw=
X-Google-Smtp-Source: APXvYqz24sh9y6CH2bgx1+WEeqMMX0mEuCkhEkP16dsWDynHvdAt/eujOgcDaVIhOYk2BNbqrbXB9w==
X-Received: by 2002:adf:e944:: with SMTP id m4mr5563094wrn.130.1556709552309; 
	Wed, 01 May 2019 04:19:12 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	j10sm3494597wrb.0.2019.05.01.04.19.11
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 04:19:11 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 May 2019 12:18:59 +0100
Message-Id: <20190501111859.5699-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
References: <20190501111859.5699-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 6/6] HEADER: Drop it
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
X-List-Received-Date: Wed, 01 May 2019 11:19:13 -0000
Content-Transfer-Encoding: 8bit

We don't really need a header boilerplate now the header is simplified, drop it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 HEADER      | 5 -----
 MANIFEST.in | 1 -
 2 files changed, 6 deletions(-)
 delete mode 100644 HEADER

diff --git a/HEADER b/HEADER
deleted file mode 100644
index 5f9e745ff4..0000000000
--- a/HEADER
+++ /dev/null
@@ -1,5 +0,0 @@
-# <one line to give the program's name and a brief idea of what it does.>
-# Copyright (C) <year>  <name of author>
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
diff --git a/MANIFEST.in b/MANIFEST.in
index 82552390b4..f24969a5f5 100644
--- a/MANIFEST.in
+++ b/MANIFEST.in
@@ -10,4 +10,3 @@ include classes/*
 include doc/*
 include doc/manual/*
 include ez_setup.py
-include HEADER
-- 
2.20.1



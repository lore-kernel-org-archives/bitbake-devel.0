Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id DC7FA7BEB8;
	Wed, 19 Dec 2018 03:10:42 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id m8so9838947itk.0;
	Tue, 18 Dec 2018 19:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=vKAPFHJ34Q0s8twWhRON9GptS/wooWWjTMlFW1//FqU=;
	b=DLzFMjHRJ7rwGDWVSoYpPsQmTEGziNFW3btyHQQng1ORxBtDf+uG8K/RcfmognhkHM
	+xzwtYrFqVx5iMCK9AfgegyVRNHLvwCQnre+7zwpYBZ2TznsNCCnnLS917g77wsAVcxf
	Jndon4sBTehhhKXPDpfhbuPvAL+VFDqDUqJQo3FXoaYtepKJtG1+MS+zVMLGX2Wbn11i
	nYHBOm0m8r6ZbS+QMHmcI/CGOKxMEsY5dFJq/cf5YBMgmavUJBgo4wCucHZTwsvMAt+Y
	1Fmgf2SpXnFLeoew1VJ2IOUeGFJJtOjghEN+l2vABnaiMbeSEmKHpl6NRO6C2QaR5B2i
	yn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=vKAPFHJ34Q0s8twWhRON9GptS/wooWWjTMlFW1//FqU=;
	b=hoLox4drTNqvF92kI/+NIheTfc/3sOVjizyHndCkGCArhpN38If+8F9U6dhFBcB+Xa
	YCVHOg7x6N0cll1/SlECLaF6xVQel9Nf7YQ3zMXMo3pnIjetiF/MFXBQVr9PbW7OB2XC
	Baumg6GT/EFRb7ODZweDZPJG+aY+LCcRWwMWD+vwva/3G3c53u2s8CK2bwAeZJQyQVNG
	fxAXZrdvaiqQflbY65iAeGtAUcZyknVcpS1J9jWDZr8lV8vInCgOR+Sn/2y1J0CLarJQ
	juHBeWHQewOlik0yop+dsqy4sstyjGk1QwljVphlB7OZ4reRZB7NB6linx5tgRkbayfv
	pu3g==
X-Gm-Message-State: AA+aEWbZTm4KASvAgu3oHrt6ZerEtD5OjX1dVJsqBygS5IY43fwcrQi2
	V491E2DP/iHkW5p2Dku57Nr6a+a0
X-Google-Smtp-Source: AFSGD/UvVmZvJpD1r6X5fp9dIrUpEODGs0Gf0FPYuTnxRY3UKTUbXEjHU1wbRjtizBfNs2CN2XWzDw==
X-Received: by 2002:a24:c8d7:: with SMTP id w206mr5303515itf.56.1545189043829; 
	Tue, 18 Dec 2018 19:10:43 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id r63sm2795992ita.2.2018.12.18.19.10.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 19:10:43 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 21:10:31 -0600
Message-Id: <20181219031033.28045-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219031033.28045-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v5 6/8] classes/sstate: Handle unihash in hash check
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
X-List-Received-Date: Wed, 19 Dec 2018 03:10:43 -0000
Content-Transfer-Encoding: 8bit

Handles the argument that passes task unique hash in the hash check
function, as it is now required by bitbake

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/classes/sstate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 8b48ab465fd..41a2f9b7b77 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -774,7 +774,7 @@ sstate_unpack_package () {
 
 BB_HASHCHECK_FUNCTION = "sstate_checkhashes"
 
-def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False):
+def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *, sq_unihash):
 
     ret = []
     missed = []
-- 
2.19.2



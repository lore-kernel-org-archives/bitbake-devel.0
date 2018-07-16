Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
	[209.85.223.182])
	by mail.openembedded.org (Postfix) with ESMTP id 5EA0F7885E;
	Mon, 16 Jul 2018 20:38:09 +0000 (UTC)
Received: by mail-io0-f182.google.com with SMTP id q4-v6so39122144iob.2;
	Mon, 16 Jul 2018 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=QST87woGd/8rnWj9USG1ZgQQZZlG5VrD8W7zJ6WCS0k=;
	b=J1Gfq2WPz86YMDOBWBsZKoUVeFV8nq49hMcpkbpITxJsuVkk37hhAMk8aenhK45NRA
	JEzLL/YnsczcL2IjIOOIwBljLunWO1fcDG5F2C3Nm2f11Udu3bJPgriBYU2BcoTjGx5F
	VTuzNLOcWKmk8QuWq9SeHzEfHH63LT6dg168m534NfvdPgXRGcS1H4Qe32V2qGrPEjNr
	R2Lv6fV6jlLiG+UdeqmZR5ag/DXa5/stqEz+iECduZj8u6g2pXhKWDwPWmurzUXP9thR
	VETPxEe70Q/sqXzSIBHvAPn9LBfFq/SmLmKVUWY3fp+4Zl+eFzzWi1h/XElD2IfRdmk3
	Ah0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=QST87woGd/8rnWj9USG1ZgQQZZlG5VrD8W7zJ6WCS0k=;
	b=rS/Klp0QLq2xx0C+ZlZKue7pZDR0IVDI//ymfO25OO2nxDJUqZJYJdO3Xwfr4Qtcjk
	JJXvXHC5KVfx0RmpX65jzqH0w5KUCdY/tPNjsgBcnXoul9IodzpFnKMh4ua09EvjNh07
	t5WHF7HObeR88KS5L2eMVqW2YPWbVzYQJWr4pyQqaC9W+Tk22ZfACDgx5vv/IZDYEuRR
	0uZ31Sk87j6mD9BjnNURrfOevPBpZAI1t+pnzszNy37Y77f3ffMLMQ5v0UIP8D6mjDXB
	/LRvgyYlf+PCjYRRtIzm8HvldYsKKXpU7P/SjuaEur2MvtHkOoB1QnK7RyWfJ8l6/CyM
	cX/w==
X-Gm-Message-State: AOUpUlGvuUpljuvUjaQEsHSZjXDHHRUntzQzNt7HqHHTdhQsyMXKmDza
	xjXJLUCoc/QmtEW8i0iYm/BLMPaY
X-Google-Smtp-Source: AAOMgpcPs5vfu7YDFI2mrLz4+QoafRVX/31cw9ZBStztiki3ZGeFbt2gIYN67GDjFBkbXFjXphqAVw==
X-Received: by 2002:a6b:b983:: with SMTP id
	j125-v6mr39165392iof.43.1531773490234; 
	Mon, 16 Jul 2018 13:38:10 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r199-v6sm8988222itb.8.2018.07.16.13.38.09
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 16 Jul 2018 13:38:09 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Mon, 16 Jul 2018 15:37:26 -0500
Message-Id: <20180716203728.23078-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716203728.23078-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
Subject: [RFC 7/9] classes/sstate: Handle depid in hash check
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
X-List-Received-Date: Mon, 16 Jul 2018 20:38:09 -0000

Handles the argument that passes task dependency IDs in the hash check
function, as it is now required by bitbake

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/classes/sstate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 5a0722567a5..b11f56b799b 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -759,7 +759,7 @@ sstate_unpack_package () {
 
 BB_HASHCHECK_FUNCTION = "sstate_checkhashes"
 
-def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False):
+def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d, siginfo=False):
 
     ret = []
     missed = []
-- 
2.17.1



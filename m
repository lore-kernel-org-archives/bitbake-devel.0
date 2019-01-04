Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f196.google.com (mail-it1-f196.google.com
	[209.85.166.196])
	by mail.openembedded.org (Postfix) with ESMTP id B2D336BC88;
	Fri,  4 Jan 2019 16:20:26 +0000 (UTC)
Received: by mail-it1-f196.google.com with SMTP id h65so2145196ith.3;
	Fri, 04 Jan 2019 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=MhQhdQOoUBJKJtdWCJPpTx03zIiVrX3JbUsnmiIe1I8=;
	b=UBrCjwPJ3rzWIDh4t7ezKB2J3G0m7cemCzMc2DUPMtlN5Z05eWtTSlvPUBaRFFF+SU
	87yhF7bPFfH6AJnigC2VWsJ2d0ny9y5XWxCk4Cb8UeWUepHXls9yu+4muYX8jp0kULsA
	ISEEBn3Fa5kRLTZHa6quB6PGHgAIsIUON02lOWGBzjTpUK4Ntj2wnkgsEovlSdkDv/bD
	QGI+JDJ+U9jLCGQ6FgS+o1ysssKBgFOYQTQBEumZMfwh2SpdtOb2jIFtHPWVouL69XEY
	N/Y2pmbdEWch6h0fRSBcAXWzye5zKRqVKGgEBsy1vv/cPnwOB+X4J71y3Iq9v0ZhNtNx
	pqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=MhQhdQOoUBJKJtdWCJPpTx03zIiVrX3JbUsnmiIe1I8=;
	b=QMr+yOpe8I8RhHFUwJSTACnOC/eXlFgrs/k5CqtlwhubY+bMjPmhNSrkYIMtFc1Nxa
	S2QJ2Yh3A5ZjvTkzoZJcz4OV5WApf7f4OTWvH9MqXiDQ3XzmoT3daz6+ZyAMYRHVq8Dh
	luYN8tkmdQqvpmgCg8QqE2z2+UIswsDI8Yu1MMjUddyvrOWF+/edZvr2pkXBCNuLy5mQ
	0nvOlAQnhxecLgc2NM4BA/hX6SH0wVyQPymxrQyQLLbhcRK4MaqZ5JFVbZw6eIHXrEt3
	RKfoMnCTBE3cFfIu6c84AsLZfRaaYw5uPbukhuPrEV8qMenVF8lEvQ19erQpSsyHoqMw
	QA/w==
X-Gm-Message-State: AA+aEWa/CWK4YjAky24420BodzpsrYCEFgOf0Ed9XrLtcLbbG2B6lZXh
	IGlmEnwZBlSLms8jHTTgYjS3AnvL
X-Google-Smtp-Source: AFSGD/WkwVJ/tUgpVW2nsYYbKY9VE6voTwZ8jGFQwg1IFRUDw6pZ79IEzdNw//bQ7R2cWxoiytprBA==
X-Received: by 2002:a02:1885:: with SMTP id 5mr36951359jar.110.1546618827480; 
	Fri, 04 Jan 2019 08:20:27 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id j8sm736702itb.30.2019.01.04.08.20.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 04 Jan 2019 08:20:26 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Fri,  4 Jan 2019 10:20:13 -0600
Message-Id: <20190104162015.456-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104162015.456-1-JPEWhacker@gmail.com>
References: <20190104024217.3316-1-JPEWhacker@gmail.com>
	<20190104162015.456-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v7 1/3] classes/sstate: Handle unihash in hash check
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
X-List-Received-Date: Fri, 04 Jan 2019 16:20:27 -0000
Content-Transfer-Encoding: 8bit

Handles the argument that passes task unique hash in the hash check
function, as it is now required by bitbake

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/classes/sstate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/classes/sstate.bbclass b/meta/classes/sstate.bbclass
index 0abebce6996..59ebc3ab5cc 100644
--- a/meta/classes/sstate.bbclass
+++ b/meta/classes/sstate.bbclass
@@ -780,7 +780,7 @@ sstate_unpack_package () {
 
 BB_HASHCHECK_FUNCTION = "sstate_checkhashes"
 
-def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False):
+def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *, sq_unihash=None):
 
     ret = []
     missed = []
-- 
2.20.1



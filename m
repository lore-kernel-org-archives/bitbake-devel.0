Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2536.1794947839346965738
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 12:37:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=t9lL1LJy;
 spf=pass (domain: gmail.com, ip: 209.85.221.170, mailfrom: maxime.roussinbelanger@gmail.com)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so1094855e0c.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 12:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794947838; x=1795552638; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MDr8KPFBvz/RqAqWaBffWXM4ZoGzh5OhHSyBrL2b1Fk=;
        b=t9lL1LJyuRMl3RTSZqsP5mPmWjuaNCGB1CMXcmZQxrH28AOMPxhiRJyWiHMq/WPChs
         hq9FV3ba8bC0xtmDTN5yyJNPHfjD2wvjHBQQj5D5IQ26AZwxqs2ayx7kWzXPzf4w85vq
         m4zIrDICbCJrBNwgj3nDObSxBGS7r5yA72054Yvog/UGdz03RA09X/P4bCV4vNm3u8SN
         u14CTPwSRTtXZvo8dAtBpT1OdunzPuIqGM8UtFjH8kVZluB1jsCFe4x8Ec4OtWWYNpAL
         em2yy6EJ2Ypbvn43zZn9jUPtIE2PhTOzo+diZWhk4G1+R5o54ooVpKYBSCSNZ6UP7Y6Y
         /pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794947838; x=1795552638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MDr8KPFBvz/RqAqWaBffWXM4ZoGzh5OhHSyBrL2b1Fk=;
        b=h/Vk/BtPzw1VmM/bTeAfVTg6ZcZ5vH6WE2tNSejzGaW4L1obftF+XP1T0fRqqkwS4E
         jPilWGkZY9E20cHQeq72NHBV4Wu7Uvr6y+cmGyWNFbL5tkASsuKsenI4PDtV3+Abdd/u
         9b2AOR8IwYUf/lKlVY8TScIZuNnvf7kK0iIICP3PlfQBRLXo5DkpsEAuQGbQZUIOFC3n
         6J95UVqGRVHJ/EDn0xAttyGy7vvrz+pzCYPgN+2pzNykCjR+giNE+jmBvI9Psp5QYrMa
         EDxh6nX4iG8MmsN5Vb7EFz5+lbEU8pBMKOqQpMfuOmMM7kCHofWRLC9RNj27eMlPD27R
         8Txw==
X-Gm-Message-State: APuU4Z9UImf+2N+X2yRiNyVSOT/I4DGDx1WhW3hDnaPUcH0ffW4n4rBs
	FKTCMM/TEWrnpwOr1y8AkR4pLma2uCrRSYJ7xMgUYe2iwUCJDW7liAfQhzrWmA==
X-Gm-Gg: AYBFou0WXu6bXlJn90UONJZZiMwgqRS+HdhYAOvNsoc25tcjifigDir5bVnx4CYTM4X
	tV4i5vR3Ednh/PjWH7HknDmGGht1poMsx0I9UWzkAzxL6dYbSmggVt4QnLquNaGVw3W4NpaEwIz
	5McmVNgz45ul7LXZAr5bYv7Iuwiyvehlzzt2b7PMzRoSQCBrfhKPOkYI2dSZcKEgJVBxRdhBswA
	1QcxAWXOFTJGUZ49C2Xwy3JjBr8Cx/XJeZZ4+oLYqK3B2+d35hah3O7sS1+hTwnq2sf/LVyNxT3
	uJTrLnArcu/AcXEWtCdl2zHzrJd2hwjT7mXN2+6T7RcE3cb5ET4KPsBvj9k7xmF+C5Ut4ShSQhm
	2PJOeD4jlUcsV4QZgowM3j9zYEjYs8RfKjNfvwPtS7a+iG3aqJvu+U28rJHChIQbOSVcXT6mfVr
	UehUvIfw3+w+hLJZp8mgFBD8H2SksRL1I6mXWEZj68n9UmnLrwloUd30cLIUl/tZelu/8sHNanW
	Q9d4SVVaFbYGzFn1BwPYZniHpSyhFS/uITgfxuUitCOL/Le4YcCDh9P8hVpN+PrTGbOmfRcfAtT
	17aR0ukGUn1GvKbvlU3xMIfkIfRdOvGz0mAW8cAS5O69F1OkdJKWkMSDixyLZaKgyH5T58VLFuC
	4hiPQwFXARyPBAA==
X-Received: by 2002:a05:6122:5c:b0:5ec:e7e4:a1b9 with SMTP id 71dfb90a1353d-5ee5b626fabmr1068694e0c.1.1794947838217;
        Tue, 17 Nov 2026 12:37:18 -0800 (PST)
Return-Path: <maxime.roussinbelanger@gmail.com>
Received: from mbelap.can-explore.com ([70.54.251.90])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64ed7adesm342572e0c.15.2026.11.17.12.37.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:37:17 -0800 (PST)
From: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 1/2] tests/data: Remove testfunc from the global context after use
Date: Tue, 17 Nov 2026 15:37:15 -0500
Message-ID: <20261117203716.3276852-1-maxime.roussinbelanger@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117152318.2560775-1-maxime.roussinbelanger@gmail.com>
References: <20261117152318.2560775-1-maxime.roussinbelanger@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 20:37:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20452
Content-Type: text/plain; charset="utf-8"

test_python_snippet_function_reference() adds testfunc to the global
context and leaves it there, so every test that runs later in the same
process sees it.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
---
 lib/bb/tests/data.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 491774747..a2b0f43cb 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -83,6 +83,7 @@ class DataExpansions(unittest.TestCase):
         self.d.setVar("testfunc", 'd.getVar("TESTVAL")')
         context = bb.utils.get_context()
         context["testfunc"] = lambda d: d.getVar("TESTVAL")
+        self.addCleanup(context.pop, "testfunc")
         val = self.d.expand("${@testfunc(d)}")
         self.assertEqual(str(val), "testvalue")
 
-- 
2.56.1


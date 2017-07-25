Return-Path: <armccurdy@gmail.com>
Received: from mail-pf0-f178.google.com (mail-pf0-f178.google.com
	[209.85.192.178])
	by mail.openembedded.org (Postfix) with ESMTP id 2006A71E4B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jul 2017 21:30:06 +0000 (UTC)
Received: by mail-pf0-f178.google.com with SMTP id q85so62998984pfq.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jul 2017 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=glMi0tDdwYjVJjLRO9bgec8xhayda6D7aJAXmer3jgU=;
	b=oPIiZn+KbVfYRyNkBLemqTpRIAVWtZkbhfLQ4nYkfknl1BBmGVSo6oqSLHu+TAnn1E
	pwTsW8Fr966dYjS5Aw3TTH2X/q9lTgr/oI1O9maSXoi/GibntBpmn+VSwZLalTjV+2Ii
	INeKijLuzis9a3cVlTC6bwUulehxa98W+ImsfmGRVaMhhnIz/rgQD67oqR55g7bfz0rT
	Nqdf0+OhGFpyyHdz0fF24jlyKxm5b863616O7geaofowdO2F8YdV8aMycz+Y+cm0bbFH
	c6XzijyKoudrv7+oN+nfN8Z2lFQ7uR5798AMTDgRrkp4cF3E6wjKhIjGpsydiL+4WsMU
	Mt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=glMi0tDdwYjVJjLRO9bgec8xhayda6D7aJAXmer3jgU=;
	b=WzEXIdlXwIz5A1vG7MFBfwnwenB5szeLn7+W3XMalW+IaeTjPtYdbwdIE+lkOj/7xa
	SsAyCDUnjGTcoFLVjouZOLREdPkFBOa/hl6e59Qc6G5Mpv8opr2dm5AHSHwi81iv4euA
	zwL+J9GYcGP5+uvJlgvZfaQg+8ZDFwNHyX1gxNEXBzlJ1S6g/HBjV2ZH8ZzdmATi/e1O
	ft2I2Zjvm7VUSDVIaTNvfF20Zb2HJV0z15aiHCG/AQD0oE467++MhwflsjYzE2yjRONy
	1vbllzSAskdIVJdRs1IbK1t9gBgdKahJxYbZmtTIbBgtFjy8UNZQ1FATrXP+6KhxNE4V
	6WbQ==
X-Gm-Message-State: AIVw110525I6vRuM+AoZqklby0xvGMh3T9snBeULtekwULqhTBGi/AgC
	5jcM9eInU35Bn86A
X-Received: by 10.84.131.78 with SMTP id 72mr22738680pld.43.1501018208068;
	Tue, 25 Jul 2017 14:30:08 -0700 (PDT)
Received: from e6520.cablelabs.com ([4.16.80.121])
	by smtp.gmail.com with ESMTPSA id
	u26sm9916560pfi.140.2017.07.25.14.30.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 25 Jul 2017 14:30:07 -0700 (PDT)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Jul 2017 14:30:01 -0700
Message-Id: <1501018201-26197-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] fetch2/__init__.py: replace stray logger.warn() with logger.warning()
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
X-List-Received-Date: Tue, 25 Jul 2017 21:30:07 -0000

Update stray usage of deprecated logger.warn(), which was introduced
to fetch2/__init__.py after all other instances had been replaced by
logger.warning():

  http://git.openembedded.org/bitbake/commit/?id=5a53e7d7b017769a6eb0f0a6335735a1fe51a5ec
  http://git.openembedded.org/bitbake/commit/?id=676a5f592e8507e81b8f748d58acfea7572f8796

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 74ba37f..a78279c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1033,7 +1033,7 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
 
     except IOError as e:
         if e.errno in [os.errno.ESTALE]:
-            logger.warn("Stale Error Observed %s." % ud.url)
+            logger.warning("Stale Error Observed %s." % ud.url)
             return False
         raise
 
-- 
1.9.1



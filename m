Return-Path: <kvserr@gmail.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 527DC62252
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jul 2014 15:26:04 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id hi2so1346135wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Jul 2014 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=3iweTombhaeSVXLLFH7pG0IoANYQOpnvogzjODPb2nc=;
	b=jaRARjTbREq2pvbwWWdotMaL6JXqFmfs/ILHD4+sazm1aoOtqRheWwGZgszjI265Nb
	fH2QIIjZr2QG2eCo/ykN1z2bjwxhv7sL7zbpOpmwxJ+GSMvYrkxpCBy6FiWT7l4F3IlZ
	4cyNlXMyTXL1acgd5E9PGl9SI6ylJwGLoFkE7+z6RfskpYv/3oopMzdUctAHX/9WRp39
	IU+w0K+FGF9x7da0KZbZpKRKaWY1fC3IfpzEZhmNPoRJoX0tt7AH+X66aC/7lLm+k1iN
	55ldc/Y0py54qfiAr+JetEvY6dJIs7gzyXw95xZFBA3LlRdJaN4lrbnAymvz4too5j6d
	jx6g==
X-Received: by 10.194.173.7 with SMTP id bg7mr40162087wjc.3.1404833165931;
	Tue, 08 Jul 2014 08:26:05 -0700 (PDT)
Received: from debivit.LGE.NET ([195.160.253.4])
	by mx.google.com with ESMTPSA id p3sm97058854wjw.13.2014.07.08.08.26.03
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 08 Jul 2014 08:26:05 -0700 (PDT)
From: Vitaliy Kharin <kvserr@gmail.com>
X-Google-Original-From: Vitaliy Kharin <vitaliy.kharin@lge.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Jul 2014 19:21:26 +0400
Message-Id: <1404832886-16550-1-git-send-email-vitaliy.kharin@lge.com>
X-Mailer: git-send-email 2.0.0
Cc: Vitaliy Kharin <vitaliy.kharin@lge.com>
Subject: [PATCH] bb.utils.which is intend to locate regular file only as it is written in comment
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
X-List-Received-Date: Tue, 08 Jul 2014 15:26:14 -0000

Signed-off-by: Vitaliy Kharin <vitaliy.kharin@lge.com>
---
 bitbake/lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 0be45e1..c48b237 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -809,7 +809,7 @@ def which(path, item, direction = 0, history = False):
     for p in paths:
         next = os.path.join(p, item)
         hist.append(next)
-        if os.path.exists(next):
+        if os.path.isfile(next):
             if not os.path.isabs(next):
                 next = os.path.abspath(next)
             if history:
-- 
2.0.0



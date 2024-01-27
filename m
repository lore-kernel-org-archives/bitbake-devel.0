Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD566C46CD2
	for <webhook@archiver.kernel.org>; Sat, 27 Jan 2024 12:16:32 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
 by mx.groups.io with SMTP id smtpd.web11.14436.1706357790843048856
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 27 Jan 2024 04:16:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zhukoff.net header.s=fm3 header.b=Z/+b1eU2;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=D09xgo8z;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.20, mailfrom: pavel@zhukoff.net)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id BCBDE320090C;
	Sat, 27 Jan 2024 07:16:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 27 Jan 2024 07:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1706357789; x=1706444189; bh=h3J1XK9M6kiTpBqTM6OX5
	1SM1K8w90uPaJb5cMjLD80=; b=Z/+b1eU21wnw4POdSh7NOontdU089QsznHVcg
	uigoKz3Etc2swZFHaNdME20dSP7nCj4OVWGXkzLAQrwDUYnEzbsqAzW9rlZ5kc4x
	Kk/qaGtpUDIbrypTcU+KV9uPVvaKFRt/kNe5GXC+lLims5yxsj3jCNWROn8KPgP2
	twFvDS0IUijwAqq3pSp5bZIvxZgq7pyM5jgotnu6+p3mAhqdXUxoN4t1iRrUx3KO
	k9YpoOm1goApU3cRLZor3Q6YvJEvpyKHjkrtOEG2Q93LlnR2lNTaDBuJl5D79qmT
	owxQ3bgD4olRptrEaA9F1NK7011teXlkQzy18SHWa1Wk8cHeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706357789; x=1706444189; bh=h3J1XK9M6kiTpBqTM6OX51SM1K8w
	90uPaJb5cMjLD80=; b=D09xgo8zCEKZUqs0xo11whuZfLyg+X8ToHGwqPbqJNw0
	tl3R+MtHeY5Tqnzqa440toX+TWGk6XJ0OMvROcDS8NJy9PAKPCw6N8e+8XPUMeq4
	ZpxFa/4vNx9I+XigoqJdAH3TJw6XJRZEBM+baF+FLJF4IAim9jnQiETueWfg8W2I
	nvJbC8IdiKxE2rl45arXGz7LuMtE+Ca7co63VQkoLz35BQZGEz5QAHphXGIq5aiq
	gV5Yd4WU7bPi4tkuuAwAYetp6GNAEN1MqjbyVDeZ0DM9pkvQhGi0xfXMz3G67GD8
	IfynaVZUlpEf25UJeZ3CXmV0zO7IhZksS68ueSscjw==
X-ME-Sender: <xms:HfS0ZXD4npS7SJ93zMTb76_G9nX7EZtE33d22RUHPv1eGMjBSUzcQA>
    <xme:HfS0ZdiDGooz8FokSCT6g0wUPfLoeT-qYZyIaLR6FCHWOGSAyePAUxq8wDUPp0WV-
    KxmEhzfqHvyKrrxLDw>
X-ME-Received: <xmr:HfS0ZSmLPnKjVniUCC1o94dFF6o0kWdR7iMDWl9vFh3D9l02tyrBNFtyaNmk9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefrrghvvghlucgkhhhukhhovhcuoehprghvvghlseiihhhukhho
    fhhfrdhnvghtqeenucggtffrrghtthgvrhhnpeevfeejkeejudegledtkeejhfettdefje
    euffehieekvddugfdtffffledvvdefhfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:HfS0ZZyCV_LmN4-fvjBRca2_8Od26r3iBJIpawLKyfLUQwRWauobfg>
    <xmx:HfS0ZcSIrrqrywnjU020hGCHyehSMoh2NkEOv1-2NF98h3iOmNJMCw>
    <xmx:HfS0ZcbvxtiFZS5lNIyDH12oN0Ggv3Vg3eHe0MTSMcqwszPcH0xauQ>
    <xmx:HfS0ZV6EuE5_lYxp1gmTJIIz2Q4Q7y0aAXjQiLRJCsE6u9FOaf0WNg>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 07:16:28 -0500 (EST)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH 1/2] fetch2/git.py: Fetch mirror into HEAD
Date: Sat, 27 Jan 2024 13:15:36 +0100
Message-ID: <20240127121536.2849664-2-pavel@zhukoff.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 27 Jan 2024 12:16:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15800

Fix the issue with using of (pre)mirror in case if clonedir exists but
outdated.
Previous version of the code fetched new mirror content into FETCH_HEAD
instead of branch which caused refetch from the upstream. Add new remote
add fetch from it instead so the ref can be found by "_contains_ref"

Fixes [Yocto #15369]

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 bitbake/lib/bb/fetch2/git.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 0deeb5cee1..b4497911f1 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -375,7 +375,11 @@ class Git(FetchMethod):
             else:
                 tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
                 runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
-                fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
+                output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
+                if 'mirror' in output:
+                    runfetchcmd("%s remote rm mirror" % ud.basecmd, d, workdir=ud.clonedir)
+                runfetchcmd("%s remote add --mirror=fetch mirror %s" % (ud.basecmd, tmpdir), d, workdir=ud.clonedir)
+                fetch_cmd = "LANG=C %s fetch -f --update-head-ok  --progress mirror " % (ud.basecmd)
                 runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
         repourl = self._get_repo_url(ud)
 
-- 
2.43.0



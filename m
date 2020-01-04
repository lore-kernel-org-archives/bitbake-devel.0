Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
	[209.85.214.170])
	by mail.openembedded.org (Postfix) with ESMTP id E07507F9A2
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:19 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id c13so19665696pls.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=xy9xzTnOJ6KkikHQxsJ1gzgU/Ey8fDAohwSAxet6Z9U=;
	b=htLgEgmAorROypJV5sO7EBYyEkhQolMPsDO9zTvQPwaL2vcgLFOB9NuAO4KCMg3/5Q
	n4SEDfzeKHySCogQMahUBzn5A3/429iKSXPMtCkxuxj3IWCFGBbT2hmhng9pH15r7GYF
	18BUAg5U9f26/YAuGHJKDYJcQnImeDKl7RFO42WeasHpar0b9bnfj0P8zpE5HBzfHyzx
	R4Aa7RLBpk/ez2+xM3EvqMSg1oNc5ovKsBU57581Pv07zqM4o+If3pPq96b/RrMvcJn1
	Kji7B3zWQBA/FxSizNhPjwN8wRVph49O8A7g7TT5X6JpO1zHT7dmHH8jKg2gZALTrb28
	4v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=xy9xzTnOJ6KkikHQxsJ1gzgU/Ey8fDAohwSAxet6Z9U=;
	b=nFIVfyZi+Sl7ei8Qha1wufDzOpfGWDluzxXnvCQtpepFzzo6M60XJC/4hTyIa/NB7P
	bcIOxfu61EABPoncDzIzMnMWuovDnZlVwcV/ItDcux6TdG9IiH0FahZNB5/UslE4okiR
	meoyx31PG4xoanaJLvdUrLs3XNcxB0cacOhEOGrYjRkoiPmlMVc1yiTLLUQo4+3AZhIW
	kwtLwrwFzDoH8kWdqa1I33tkZidJrJi2wjMRC4IhPQspYkjR3TR4A08JPXimewgNmM8U
	4MK6Sb4HxqOXeQPPO+AwLT1PkITV591YuUV7NSwW5nIw7w+f/kP3HsiWL6bjDcP0O5cV
	Zm2g==
X-Gm-Message-State: APjAAAUq63RrcQ1FD5ZGcAifbDUV2XCJ6inNWXpKDG3AmEPVD0xllIgN
	Gv2u3m/sCF2bhLIQh0uHfF8SrcB0fBc=
X-Google-Smtp-Source: APXvYqwQDH28Z656T4m+p+RsktX6EYGVzhk1sAXiP4TESbp5dBESq7Sh33RJjNXMfHh6L6yX1qd4kQ==
X-Received: by 2002:a17:902:6501:: with SMTP id
	b1mr84398124plk.121.1578104600119; 
	Fri, 03 Jan 2020 18:23:20 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.19
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:19 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:51 -0800
Message-Id: <0aee83e4e31dff7f4354e4eb4cbd35dd592e9f06.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 06/25] siggen: Ensure new unihash propagates through the system
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:21 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Its possible the new unihash may not exist in sstate. Currently the code
would create an sstate object with the old hash however this updates it to
create the object with the new unihash.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit abcaa1398031fa5338a43859c661e6d4a9ce863d)
---
 lib/bb/siggen.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index de853268..dbf51023 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -513,6 +513,7 @@ class SignatureGeneratorUniHashMixIn(object):
                     bb.debug(1, 'Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
                     bb.event.fire(bb.runqueue.taskUniHashUpdate(fn + ':do_' + task, new_unihash), d)
                     self.set_unihash(tid, new_unihash)
+                    d.setVar('BB_UNIHASH', new_unihash)
                 else:
                     bb.debug(1, 'Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
             except hashserv.client.HashConnectionError as e:
-- 
2.17.1



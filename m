Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1B3C636CD
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 13:39:45 +0000 (UTC)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 by mx.groups.io with SMTP id smtpd.web11.14540.1676036385011596810
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Feb 2023 05:39:45 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=k3o1FosU;
 spf=pass (domain: myneves.com, ip: 185.70.40.18, mailfrom: paulo@myneves.com)
Date: Fri, 10 Feb 2023 13:39:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676036382; x=1676295582;
	bh=kUyhV8wUriS8tbyUxh3tqvE0sMd2pZ7QJXaB0BxkGZg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=k3o1FosU8kyUKN9ct3WG2e4b/vMGPisHQrBApnkqyHylJ6xSAzanecC6ADfAO4Qml
	 cvJZ9tJ12+kgxL4RqftIQaDZJmcRPfJE3WunWORbtMVA/sen8yCew/1pQGSNChgO9f
	 39vdGCz7/5p+MOAjD8TTKGnpdoN5KNM9Ut+YrrjIS5IRq98mrOweKWJE77wFHMPosm
	 phlaIE6q7UnSKsxIx0IiQv7gnkuRAcXcSOfIzfUMiT2Zx2Z97zUGSQMiRtXczGqqVg
	 YqriH1vg8QUMwW9Guyy6CBoQX9Vm88nvVjZAWEQPFI1bUmx5IYLM6FqqGGHJzI+cCA
	 OJF0pH7PJ0kcA==
To: bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Cc: Paulo Neves <paulo@myneves.com>
Subject: [PATCH 2/3] tests: Make test_lfs_enabled actually test git-lfs
Message-ID: <20230210133921.1268885-2-paulo@myneves.com>
In-Reply-To: <20230210133921.1268885-1-paulo@myneves.com>
References: <20230210133921.1268885-1-paulo@myneves.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Feb 2023 13:39:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14392

Due to the datastore not having the PATH variable set, _find_git_lfs
would never return true and thus fetcher's git lfs test logic was
unreachable.

Now we set PATH on the datastore of the test and if the test host has
git-lfs the test will actually test git-lfs logic.

Signed-off-by: Paulo Neves <paulo@myneves.com>
---
 lib/bb/tests/fetch.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 122d7e05f..a9ad247d9 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2237,6 +2237,7 @@ class GitLfsTest(FetcherTest):

         uri =3D 'git://%s;protocol=3Dfile;branch=3Dmaster' % self.srcdir
         self.d.setVar('SRC_URI', uri)
+        self.d.setVar('PATH', os.environ.get('PATH'))

         # Careful: suppress initial attempt at downloading until
         # we know whether git-lfs is installed.
--
2.34.1




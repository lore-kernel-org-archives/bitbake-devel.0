Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510EBCF6D2C
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 15:08:15 +0000 (UTC)
Received: from cichlid.ash.relay.mailchannels.net (cichlid.ash.relay.mailchannels.net [23.83.222.36])
 by mx.groups.io with SMTP id smtpd.web11.9824.1727881686397785855
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Oct 2024 08:08:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@rootcommit.com header.s=hostingermail-a header.b=ZzwjPxKB;
 spf=pass (domain: rootcommit.com, ip: 23.83.222.36, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 320098489DE
	for <bitbake-devel@lists.openembedded.org>; Wed,  2 Oct 2024 15:08:05 +0000 (UTC)
Received: from nl-srv-smtpout2.hostinger.io (unknown [127.0.0.6])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7AFB5848827
	for <bitbake-devel@lists.openembedded.org>; Wed,  2 Oct 2024 15:08:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727881684; a=rsa-sha256;
	cv=none;
	b=ewDW9YbH8HoxynL0etWLm/GajU93sYj3UGtulRWw+nQKoTJSbmxRQlvXh8EmvOJ7uQ1xsn
	0P5niL0r1m6kUwu2f6nG/l83V75AklFK3MBJ1+vmIzMmWKXoXcj101m7X6uToUrRuowkIa
	gE5XtPYE2wzgac+LI55gs+CfYemRajud8pEm1hj8fRKMETiM7rYqYVsBpJCcnmgyP9YFcA
	vGIC/klprQPe7uXmNg/F4e2uv2mYUQpIQ/sOojWCDwyXUNN+3SD0eE9C8L8kG47RhrkOP9
	IpBQz/9byW2W2ZdJHO2/eGN+BO3aJET+B6mtmEnEVApO+u5Xr3R9H84QzM7uGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727881684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=2hSJAciNz664UvvvsisSavQvs/0K99iy7//TjpArLmk=;
	b=9pmnBcFAsa8kIILWrek4FmEPbdPPmEwC2ykzxAtS+gx/R3KtMHsqdk7FXg/+ERlU/xS6Lk
	JiHMydzZssHvuMwZhYK6iMedO927HEcqvOw5SuLKCf2FXtjhh62rOjngpaXTLwIs/NYT0v
	g9+ICIT+wn0BtqKFysoYKGhCiWyXQ0p4eT2Mfx5Ci73Cmd62IT2TYg6/azkxAijOCyk9Nd
	zTKg1bcMlkcAv0MHEDf4fNMMQsvAoN6SpF6VpCk7zRUFjrio1pZjJofKBvz8gFmmHCJ5tr
	i28CZ15OUG/haaF7A5kL29reP2KLoZ208m4eQiaTuALlZzlay4Neu1VCr9SwZQ==
ARC-Authentication-Results: i=1;
	rspamd-7d7d79db7c-mfbmb;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Zesty-Whimsical: 4ab97ef25587cdc3_1727881684965_1357838754
X-MC-Loop-Signature: 1727881684965:2165715046
X-MC-Ingress-Time: 1727881684964
Received: from nl-srv-smtpout2.hostinger.io (nl-srv-smtpout2.hostinger.io
 [145.14.150.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.138.74 (trex/7.0.2);
	Wed, 02 Oct 2024 15:08:04 +0000
From: michael.opdenacker@rootcommit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1727881682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2hSJAciNz664UvvvsisSavQvs/0K99iy7//TjpArLmk=;
	b=ZzwjPxKBqxSWYre0g9iy2OwysDOvfDSV5BGNt5P4NeJlxjryZDLVBX2+as8XEF6Ydo7YWn
	8b/FkQZDczRbDgs7CqtlEq3wSOQhtfjUvVnZvIRI2gLO4XOZ7kjqd+iZfljUaU7v+trfo1
	g3GOXrn3Tgl9uH30JMSv/mfLGFRLGBuVb42oe1CTqKnscJ4RO30x4p95b5Zfcyc1BJJh8O
	yEY0uwyo/376nqwL5AQ8ibv8m94i/0Wkqi9E7LZjzCU38+PN8K8F5jw4EAaOXLyX/7eWmZ
	9FYVSZuTnlHipIHVwwhfADBIBCNyi0yEEMF4NtevQ5WzAsMKepLNNW8waq95rQ==
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Subject: [PATCH] bitbake-prserver: use PRSERV_UPSTREAM as default setting
Message-ID: <20241002150747.85513-1-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 15:08:02 +0000 (UTC)
X-CM-Envelope: MS4xfLvS0U0a2Bj193NnaHBJT3WWHqogITNaPW6kTakMvbnPQ9k3tcgVfIybAMmIr0XbkVbcDmRD564HYIxYeEbzfsOx+aueKUsrsPfuwCoFn0cnlqsIC13D PcqYBjN+AfiKsGcZLHmQacxF/woo+Ellt2UbS1AZ4pQBI0qxFIbaRGeOVHWrBDfqHewnzhsfO/5qNeDXivyI1abgXaVK1k5ZzENXc0RDOz1SxJXUB+2gmhtl GWfvnv7WuqFbYu2nGe38nm658Xosw5WQJN6eqthZSLxLIs+uDPe1LZnZOh+u7HbWcmmmyBl6f7UlPKXgRWPMuaxje4s8pfCmhAvd7GK7slHGpFW0pQhcq5TV ZBe6ClVd
X-CM-Analysis: v=2.4 cv=b6rg4cGx c=1 sm=1 tr=0 ts=66fd61d2 a=ECbuaEMMx6F9i7Ts0igI3g==:617 a=xqWC_Br6kY4A:10 a=d70CFdQeAAAA:8 a=arJsDxmavH0KIvacWs4A:9 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Oct 2024 15:08:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16621

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Instead of PRSERVER_UPSTREAM.
The intended variable name is PRSERV_UPSTREAM, as
already used in lib/prserv/serv.py, an consistently
with the PRSERV_HOST variable name.

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 bin/bitbake-prserv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index 580e021fda..3992e84eab 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -80,7 +80,7 @@ def main():
     parser.add_argument(
         "-u",
         "--upstream",
-        default=3Dos.environ.get("PRSERVER_UPSTREAM", None),
+        default=3Dos.environ.get("PRSERV_UPSTREAM", None),
         help=3D"Upstream PR service (host:port)",
     )
=20


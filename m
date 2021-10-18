Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C09BC433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 19:01:59 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web09.18.1634583717685783352
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Oct 2021 12:01:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=mesmtp header.b=dTpeQWiP;
 spf=pass (domain: cold-front.org, ip: 66.111.4.29,
 mailfrom: jsbronder@cold-front.org)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 06A4F5C01BA;
	Mon, 18 Oct 2021 15:01:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Oct 2021 15:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=mesmtp; bh=JPvxf4Gs7b
	dumL+8SiMR68R7IIw84ThJEaRxVWZuT1I=; b=dTpeQWiPNNg/TXpBJHO5H2ZZjk
	bqZwZUsC2gRtfF3yEXobF00rcFHUa9xtYp4++Mw7htSpQJRYLz64caOAYffHsbKx
	Hp+o38RvIKSGv+lDzC2AdTK3E97RfGbSZH6qRK5yaWqSjvWEF2fQzIH75dZtQdSa
	Fnvb07dttBExOVKI8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=JPvxf4Gs7bdumL+8SiMR68R7IIw84ThJEaRxVWZuT1I=; b=SIEgvWzx
	FJSJF+d0DeQBN1JhSy1nt7xunVBqxDrBEGzNL2ATi4c7wO8MuBKdM9f6nMMC4muM
	KU6uQVBbd3njVBQ7C+jfSVM5pB2IPLyGswzUg4tBxa0bqxYIztfRIeYlcVTnQ09q
	Sg3Hy/GVEUKUGKQ0NJy4mZ89WtH4VyKy2uOIjbr1jJ8jZmLHxwXue4LuYEhXMFqG
	tfixO1OAk+lgSD2uWvjfhL1b5fd/jmNHDsKcL8j5NbNZVM9yDEQO4WG+zxwjpypv
	LAVjU89unH6qztdhkgSqWi6faNfTUWDUz9QUUyC5+rcmnNFTaSQD+605Q9Md1bL0
	uDkflOXvZlg9Gw==
X-ME-Sender: <xms:pMRtYXrubIFIwpcHo4PW5TWVsJwMbO6nkDM1m7DWUW4F334M13K3jg>
    <xme:pMRtYRpCEebJUtt0zcIgTA_pSMahA0Nkk4K9sUaZpnEVW8Ems3aCxCdC1TbpIX-ZL
    KWBAzcUBD_wxEd3Zw>
X-ME-Received: 
 <xmr:pMRtYUPZFOot0PU6M4HGspSRJnFricmzLYP_YDASTSxz6qyolEWNOtWA8QQhxPDkznuOlgXW99KGOCFn-CopqUx_VCbbywdUhp_AXX6LZLR8>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhushht
    ihhnuceurhhonhguvghruceojhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorh
    hgqeenucggtffrrghtthgvrhhnpeehleetteejieeiteejueeufeduudelgfegffevieek
    veffleegiefgfeethefgkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhssghrohhnuggv
    rhestgholhguqdhfrhhonhhtrdhorhhg
X-ME-Proxy: <xmx:pMRtYa4fug6qHs-9vimdwne0qgIe-esDPRvXfmrUSjTzWtb3mGherA>
    <xmx:pMRtYW6VYdJnI9hPpd-t_cP082AutuH0GEyNvlZDwWw5zI6AZ6S8RQ>
    <xmx:pMRtYSgQHOYd3uICOYxTP_dDug4LVJB-49se5H5yUDj9j8cNDwAYdQ>
    <xmx:pcRtYcQyKEHCWcO9WWyKKIevOo4v048ahY2vKRSOtHjoiUjQw1hGag>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 15:01:56 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Justin Bronder <jsbronder@cold-front.org>
Subject: [1.46][PATCH 7/8] test/fetch: Update urls to match upstream branch
 name changes
Date: Mon, 18 Oct 2021 15:01:40 -0400
Message-Id: <20211018190141.15806-8-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018190141.15806-1-jsbronder@cold-front.org>
References: <20211018190141.15806-1-jsbronder@cold-front.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 19:01:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12800

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
---
 lib/bb/tests/fetch.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a0787952..8ad10708 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -937,7 +937,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_CLI11(self):
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -952,12 +952,12 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule_update_CLI11(self):
         """ Prevent regression on update detection not finding missing submodule, or modules without needed commits """
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
 
         # CLI11 that pulls in a newer nlohmann-json
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
-- 
2.33.0



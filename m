Return-Path: <rs@hqv.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1080FC7EE22
	for <webhook@archiver.kernel.org>; Tue,  9 May 2023 17:20:44 +0000 (UTC)
Subject: Re: ERROR: meta-environment.bb:do_generate_content, the basehash value changed
To: bitbake-devel@lists.openembedded.org
From: "Reto Schneider" <rs@hqv.ch>
X-Originating-Location: Dubendorf, Zurich, CH (145.14.211.90)
X-Originating-Platform: Linux Firefox 112
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 09 May 2023 10:20:43 -0700
References: <3f7b085dca10cfb5f14d3a8fd9dade0324f3b8da.camel@infinera.com>
In-Reply-To: <3f7b085dca10cfb5f14d3a8fd9dade0324f3b8da.camel@infinera.com>
Message-ID: <32281.1683652843330787753@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="aXs4nAKLUWbdAtI2ojNM"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 May 2023 17:20:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14771

--aXs4nAKLUWbdAtI2ojNM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This boils down to a git safe.directory issue.

Solution 1:
$ git config --global --add safe.directory /path/to/openembedded-core

Solution 2 (backporting from current master):
$ cd /path/to/openembedded-core
git cherry-pick -x 3266c327dfa186791e0f1e2ad63c6f5d39714814 af27c81eaf68ee6=
81dcd9456a74cca6a9ab40bf6

--aXs4nAKLUWbdAtI2ojNM
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This boils down to a git safe.directory issue.<br /><br />Solution 1:<br />=
$ git config --global --add safe.directory /path/to/openembedded-core<br />=
<br />Solution 2 (backporting from current master):<br />$ cd /path/to/open=
embedded-core<br />git cherry-pick -x 3266c327dfa186791e0f1e2ad63c6f5d39714=
814 af27c81eaf68ee681dcd9456a74cca6a9ab40bf6

--aXs4nAKLUWbdAtI2ojNM--


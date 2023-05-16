Return-Path: <rs@hqv.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45091C77B7A
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 15:17:43 +0000 (UTC)
Subject: Re: ERROR: meta-environment.bb:do_generate_content, the basehash value changed
To: bitbake-devel@lists.openembedded.org
From: "Reto Schneider" <rs@hqv.ch>
X-Originating-Location: Dubendorf, Zurich, CH (145.14.211.90)
X-Originating-Platform: Linux Firefox 113
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 16 May 2023 08:17:37 -0700
References: <32281.1683652843330787753@lists.openembedded.org>
In-Reply-To: <32281.1683652843330787753@lists.openembedded.org>
Message-ID: <22447.1684250257202368307@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="d0MdqG5jir3Eb9kNZ2ww"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 May 2023 15:17:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14789

--d0MdqG5jir3Eb9kNZ2ww
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Actually, it seems like some more commits need to be backported:
* 3266c327dfa186791e0f1e2ad63c6f5d39714814 (install/devshell: Introduce git=
 intercept script due to fakeroot issues)
* 0982977dc052ad4e65608f6853f930121d08837a (base: Drop git intercept)
* af27c81eaf68ee681dcd9456a74cca6a9ab40bf6 (scripts: Make git intercept glo=
bal)
* 27de610ac30d4c81352efc794df7e9b1060f7a68 (scripts/git: Ensure we don't ha=
ve circular references)
* 52c37e133fa55846aca2248ffcf3a10648dbb8d7 (base: Avoid circular references=
 to our own scripts)
Again, all commits are contained in the current master branch.

--d0MdqG5jir3Eb9kNZ2ww
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Actually, it seems like some more commits need to be backported:<br />
<ol>
<li>3266c327dfa186791e0f1e2ad63c6f5d39714814 (install/devshell: Introduce g=
it intercept script due to fakeroot issues)</li>
<li>0982977dc052ad4e65608f6853f930121d08837a (base: Drop git intercept)</li=
>
<li>af27c81eaf68ee681dcd9456a74cca6a9ab40bf6 (scripts: Make git intercept g=
lobal)</li>
<li>27de610ac30d4c81352efc794df7e9b1060f7a68 (scripts/git: Ensure we don't =
have circular references)</li>
<li>52c37e133fa55846aca2248ffcf3a10648dbb8d7 (base: Avoid circular referenc=
es to our own scripts)</li>
</ol>
Again, all commits are contained in the current master branch.

--d0MdqG5jir3Eb9kNZ2ww--


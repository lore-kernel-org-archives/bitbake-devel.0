Return-Path: <neha.dubey@omron.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CFDD42BBA
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 18:19:19 +0000 (UTC)
Subject: AWS S3 fetcher help
To: bitbake-devel@lists.openembedded.org
From: neha.dubey@omron.com
X-Originating-Location: Beaverton, Oregon, US (136.226.60.90)
X-Originating-Platform: Linux Chrome 100
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Tue, 12 Nov 2024 10:19:17 -0800
Message-ID: <bi5D.1731435557154707775.iQWz@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="GH3blNhFDxLn8ABXaS1h"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Nov 2024 18:19:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16791

--GH3blNhFDxLn8ABXaS1h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I am working on adding the capability of fetching from S3 buckets. When I a=
dd the SRC_URI I can see that bitbake is using aws s3 fetcher, as it posts =
the command it is using to fetch. But it is unable to find credentials file=
. This is what I get from failure logs: 'fatal error: unable to locate cred=
entials'. Yocto documentation does not have much help on s3 fetcher but how=
 can I find some helpful example code to see how to pass credentials to the=
 recipe? I have tried adding aws credentials file and then exporting it as =
environment variable when building like: 'AWS_CONFIG_FILE=3D<path-to-file>'=
. Would appreciate any help.
Thanks so much!

--GH3blNhFDxLn8ABXaS1h
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>I am working on adding the capability of fetching from S3 buckets. Whe=
n I add the SRC_URI I can see that bitbake is using aws s3 fetcher, as it p=
osts the command it is using to fetch. But it is unable to find credentials=
 file. This is what I get from failure logs: 'fatal error: unable to locate=
 credentials'. Yocto documentation does not have much help on s3 fetcher bu=
t how can I find some helpful example code to see how to pass credentials t=
o the recipe? I have tried adding aws credentials file and then exporting i=
t as environment variable when building like: 'AWS_CONFIG_FILE=3D&lt;path-t=
o-file&gt;'. Would appreciate any help.</div>
<div>Thanks so much!</div>

--GH3blNhFDxLn8ABXaS1h--


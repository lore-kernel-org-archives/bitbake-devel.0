Return-Path: <praveen44com@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ED2C433F5
	for <webhook@archiver.kernel.org>; Mon, 24 Jan 2022 17:52:44 +0000 (UTC)
Subject: Custom SDK generation from YoctoSDK
To: bitbake-devel@lists.openembedded.org
From: "Praveen" <praveen44com@gmail.com>
X-Originating-Location: Mumbai, Maharashtra, IN (52.95.75.26)
X-Originating-Platform: Mac Firefox 91
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Mon, 24 Jan 2022 09:52:44 -0800
Message-ID: <5aln.1643046764438530024.CPYI@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="sqVMdkwFZrrNXefbSgXH"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Jan 2022 17:52:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13274

--sqVMdkwFZrrNXefbSgXH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

We have a new requirement generating Custom SDK with filtered Header files/=
libraries based on some rules/approvals. It means not all files from YoctoS=
DK will be packaged in the CustomSDK.

What is the mechanism or approach where we can pull only those approved hea=
der files & libraries from YoctoSDK and package as Customized SDK tar?

Is there a way we can fetch those approved header files from YOCTO SDK and =
filter it?

We are thinking like creating subset versioned module recipe and specify th=
ose approved header files and package only those files. Is there any better=
 mechanism on packaging or filtering the SDK based on some rules to filter =
some header files?

Like for example in YoctoSDK, we have 2 modules moduleA (A1.h, A2.h,A3.h an=
d libA.so), moduleB (B1.h, B2.h, B3.h and libB.so)
Lets say A3.h & B3.h are not approved in my Custom SDK, then in final Custo=
mer SDK we will only package
moduleA (A1.h, A2.h and libA.so), moduleB (B1.h, B2.h, and libB.so)

We have a requirement to keep YoctoSDK without any filters, so that A3.h/B3=
.h can be used for internal purposes without any issue.

--sqVMdkwFZrrNXefbSgXH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>We have a new requirement generating Custom SDK with filtered Header f=
iles/libraries based on some rules/approvals. It means not all files from Y=
octoSDK will be packaged in the CustomSDK. </div>
<div>&nbsp;</div>
<div>What is the mechanism or approach where we can pull only those approve=
d header files &amp; libraries from YoctoSDK and package as Customized SDK =
tar?</div>
<div>&nbsp;</div>
<div>Is there a way we can fetch those approved header files from YOCTO SDK=
 and filter it?<br /><br />We are thinking like creating subset versioned m=
odule recipe and specify those approved header files and package only those=
 files. Is there any better mechanism on packaging or filtering the SDK bas=
ed on some rules to filter some header files?<br /><br />Like for example i=
n YoctoSDK, we have 2 modules moduleA (A1.h, A2.h,A3.h and libA.so), module=
B <span style=3D"color: #000000;"><span style=3D"color: #888888;">(B1.h, B2=
.h, B3.h and libB.so)<br />Lets say A3.h &amp; B3.h are not approved in my =
Custom SDK, then in final Customer SDK we will only package </span></span><=
br /><span style=3D"color: #888888;"><span style=3D"color: #000000;">module=
A (A1.h, A2.h and libA.so), moduleB </span><span style=3D"color: #888888;">=
<span style=3D"color: #000000;">(B1.h, B2.h, and libB.so)</span><br /><br /=
><span style=3D"color: #000000;">We have a requirement to keep YoctoSDK wit=
hout any filters, so that A3.h/B3.h can be used for internal purposes witho=
ut any issue.</span><br /></span></span></div>

--sqVMdkwFZrrNXefbSgXH--


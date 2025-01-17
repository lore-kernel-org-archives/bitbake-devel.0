Return-Path: <ganesh.manoj.mahajan@signify.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2423C02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 13:02:38 +0000 (UTC)
Subject: [scarthgap] Gplv2 layer incompatibility
To: bitbake-devel@lists.openembedded.org
From: "Ganesh Mahajan" <ganesh.manoj.mahajan@signify.com>
X-Originating-Location: IN (165.225.124.181)
X-Originating-Platform: Windows Chrome 131
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 17 Jan 2025 05:02:35 -0800
Message-ID: <sHHJ.1737118955583729476.ujxu@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="WpjCsNrcWad8TkeEWMp3"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 13:02:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17029

--WpjCsNrcWad8TkeEWMp3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

As we have phased out meta-gplv2 for Scarthgap, but my system needs gplv2 a=
nd also i need to upgrade to scarthgap. Is there a way to have both accompl=
ished.
I am getting below error. When i run bitbake.

build@ubuntu-bionic:~/project/build$ bitbake
ERROR: Layer gplv2 is not compatible with the core layer which only support=
s these series: scarthgap (layer is compatible with dunfell)

--WpjCsNrcWad8TkeEWMp3
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>As we have phased out meta-gplv2 for Scarthgap, but my system needs gp=
lv2 and also i need to upgrade to scarthgap. Is there a way to have both ac=
complished.<br />I am getting below error. When i run bitbake.<br /><br />b=
uild@ubuntu-bionic:~/project/build$ bitbake<br />ERROR: Layer gplv2 is not =
compatible with the core layer which only supports these series: scarthgap =
(layer is compatible with dunfell)<br /><br /><br /><br /><br /></div>

--WpjCsNrcWad8TkeEWMp3--


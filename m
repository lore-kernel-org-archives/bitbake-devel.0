Return-Path: <asifaligorikhan97@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B2EE57EB
	for <webhook@archiver.kernel.org>; Fri,  8 Sep 2023 09:40:25 +0000 (UTC)
Subject: Error in bitbake-selftest
To: bitbake-devel@lists.openembedded.org
From: asifaligorikhan97@gmail.com
X-Originating-Location: Bengaluru, Karnataka, IN (122.166.120.168)
X-Originating-Platform: Linux Chrome 116
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Fri, 08 Sep 2023 02:40:21 -0700
Message-ID: <a8Vo.1694166021887221847.XYCR@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="zG3mO2nQgsthR7IJjChH"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Sep 2023 09:40:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15015

--zG3mO2nQgsthR7IJjChH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi

I am getting this error when I run bitbake-selftest command=C2=A0 in my bit=
bake directory. My Image is built ready. I need to run selftest in my built=
 image, help me to solve this issue

Error is as follows:

Stdout:
Fetcher accessed the network with the command git -c core.fsyncobjectfiles=
=3D0 ls-remote "git://github.com/clutter-project/mx.git" refs/tags/*
Running export PSEUDO_DISABLED=3D1; git -c core.fsyncobjectfiles=3D0 ls-rem=
ote "git://github.com/clutter-project/mx.git" refs/tags/*
Could not list remote: Fetcher failure: Fetch command export PSEUDO_DISABLE=
D=3D1; git -c core.fsyncobjectfiles=3D0 ls-remote "git://github.com/clutter=
-project/mx.git" refs/tags/* failed with exit code 128, output:
fatal: unable to connect to github.com:
github.com[0: 20.207.73.82]: errno=3DConnection timed out

--zG3mO2nQgsthR7IJjChH
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi<br /><br />I am getting this error when I run bitbake-selftest command&n=
bsp; in my bitbake directory. My Image is built ready. I need to run selfte=
st in my built image, help me to solve this issue <br /><br />Error is as f=
ollows:<br /><br />Stdout: <br />Fetcher accessed the network with the comm=
and git -c core.fsyncobjectfiles=3D0 ls-remote "git://github.com/clutter-pr=
oject/mx.git" refs/tags/* <br />Running export PSEUDO_DISABLED=3D1; git -c =
core.fsyncobjectfiles=3D0 ls-remote "git://github.com/clutter-project/mx.gi=
t" refs/tags/* <br />Could not list remote: Fetcher failure: Fetch command =
export PSEUDO_DISABLED=3D1; git -c core.fsyncobjectfiles=3D0 ls-remote "git=
://github.com/clutter-project/mx.git" refs/tags/* failed with exit code 128=
, output: <br />fatal: unable to connect to github.com: <br />github.com[0:=
 20.207.73.82]: errno=3DConnection timed out&nbsp;

--zG3mO2nQgsthR7IJjChH--


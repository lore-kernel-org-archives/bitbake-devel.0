Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC39C27C77
	for <webhook@archiver.kernel.org>; Sat, 15 Jun 2024 10:58:30 +0000 (UTC)
Subject: Re: [docs] [PATCH v3] fetch2/wget: Add user_agent parameter so it can be used optionally
To: bitbake-devel@lists.openembedded.org
From: "Livius" <egyszeregy@freemail.hu>
X-Originating-Location: Budapest, HU (80.98.74.198)
X-Originating-Platform: Windows Chrome 125
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Sat, 15 Jun 2024 03:58:09 -0700
References: <CANNYZj8wFjFyLTbA7ug501hs=n+UZd=K9Y4YsW=qLTNf6b_K8w@mail.gmail.com>
In-Reply-To: <CANNYZj8wFjFyLTbA7ug501hs=n+UZd=K9Y4YsW=qLTNf6b_K8w@mail.gmail.com>
Message-ID: <20106.1718449089919947051@lists.openembedded.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 15 Jun 2024 10:58:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16358

PMU_ROM downloading issue was solved by Xilinx.
https://lists.yoctoproject.org/g/meta-xilinx/topic/106394220#msg5364

There was a commit (which was reverted later) where this issue was also rep=
orted for openjdk downloading. It is still not working via wget.
https://github.com/openembedded/bitbake/commit/d6fa261a9603677f0b3abbd309c1=
ca6073b63f4c

In openjdk-8 272 recipe all of link are broken if wget downloading doeas no=
t use any custom user-agent.
https://layers.openembedded.org/layerindex/recipe/44301/

does not work -> wget https://hg.openjdk.java.net/jdk8u/jdk8u/langtools/arc=
hive/jdk8u272-ga.tar.bz2
works -> wget --user-agent=3D'bitbake/2.8.0' https://hg.openjdk.java.net/jd=
k8u/jdk8u/langtools/archive/jdk8u272-ga.tar.bz2

So it seems this patch is neccesery provide and able to solve this kind of =
issues in the future.


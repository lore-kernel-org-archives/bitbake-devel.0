Return-Path: <git@oliver-kaestner.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB364CF2570
	for <webhook@archiver.kernel.org>; Sat, 12 Oct 2024 16:38:40 +0000 (UTC)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
 by mx.groups.io with SMTP id smtpd.web10.14235.1728751110727952869
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 12 Oct 2024 09:38:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@oliver-kaestner.de header.s=key2 header.b=UG4ssHRv;
 spf=pass (domain: oliver-kaestner.de, ip: 188.68.63.102, mailfrom: git@oliver-kaestner.de)
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4XQq1c0W3Vz61S6;
	Sat, 12 Oct 2024 18:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oliver-kaestner.de;
	s=key2; t=1728751108;
	bh=/kmjj/y9kUrwO9YRKAavphaZY+vmehefaVVgAFTFQZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UG4ssHRvCtrNfo7D3rJxNXXqmQTp6qqIARuTWxG913UTl/3woUyE3Egc02A/qTTw0
	 PzWu6M0evp0eYusRkyd6+2iRlkj2TC/vxg1GkgRW6eHMTE20Suo/bXb91VAlKr9dlM
	 +gW1Vn6Fqnh2ANLBcYb8bD8FKytQIMSQdZCWtMrQZOYbxn3lDvrd2cLqMUnIxoTy3g
	 ItZLXMihlbF+SA4O+514wqs9QVZrPdyE+fExJw0PTpLNCOl15TR7qeYHdrg/BQh9r5
	 aWPimR03ssvMP0uaTHatSaGsVA9vKt3Z8OHUTpuR+AMiRmJ8MWYVjsSD0mh5liutwM
	 GATFh+oC6ck6w==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4XQq1b6v1cz4wfR;
	Sat, 12 Oct 2024 18:38:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mx2fa3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4XQq1b0h2Hz8tXW;
	Sat, 12 Oct 2024 18:38:27 +0200 (CEST)
Received: from [192.168.178.10] (p5de75435.dip0.t-ipconnect.de [93.231.84.53])
	by mx2fa3.netcup.net (Postfix) with ESMTPSA id 9AD77E0224;
	Sat, 12 Oct 2024 18:38:22 +0200 (CEST)
Authentication-Results: mx2fa3;
        spf=pass (sender IP is 93.231.84.53) smtp.mailfrom=git@oliver-kaestner.de smtp.helo=[192.168.178.10]
Received-SPF: pass (mx2fa3: connection is authenticated)
Message-ID: <cb9971c7-749d-4868-97c3-eaf1f80d6156@oliver-kaestner.de>
Date: Sat, 12 Oct 2024 18:38:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] fetch2: add GitHub Codespaces support
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: 
 <CANNYZj9B2LV2ZH1VivrwdfH1T2FJTV1FU9MV3X+TwWcDCUqtFw@mail.gmail.com>
 <17710.1728337442729823697@lists.openembedded.org>
 <CANNYZj9+CLT81zNGCw8nTZAZa-1BPMn5UYjy3hUuAUDGGs0_ZA@mail.gmail.com>
 <8c2a1863-8b07-45ff-b519-3cc6b8fe3b14@oliver-kaestner.de>
 <CANNYZj-iaojsDJUcFqU976c3q7gvo0i-Mt6bnJXtNB3Sx68o0w@mail.gmail.com>
Content-Language: de-DE, en-US
From: =?UTF-8?Q?Oliver_K=C3=A4stner?= <git@oliver-kaestner.de>
In-Reply-To: 
 <CANNYZj-iaojsDJUcFqU976c3q7gvo0i-Mt6bnJXtNB3Sx68o0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-PPP-Message-ID: <172875110286.718.12721674037569903617@mx2fa3.netcup.net>
X-Rspamd-Queue-Id: 9AD77E0224
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: UFWr6eOpFoMa71l8XVGSoqe2gQ21xUX7QCdl1jCILxQfMe2IhG2z
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 16:38:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16675

On 12.10.24 18:06, Alexander Kanavin wrote:
> On Sat, 12 Oct 2024 at 17:29, Oliver K=C3=A4stner via
> lists.openembedded.org <git=3Doliver-kaestner.de@lists.openembedded.org=
>
> wrote:
>=20
>> I couldn't find a source for this script. I assume it is injected into=
 the Codespaces container at creation time. However, the script is mentio=
ned in the GitHub docs: https://docs.github.com/en/codespaces/troubleshoo=
ting/troubleshooting-gpg-verification-for-github-codespaces#checking-for-=
conflicting-configuration
>>
>> Please let me know if you think that this reference should be part of =
the commit.
>=20
> How is this environment set up in the first place? Is it on your local
> machine, or is it something that github magically creates and lets you
> access remotely?
>=20
> Alex
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16674): https://lists.openembedded.org/g/bitbake-de=
vel/message/16674
> Mute This Topic: https://lists.openembedded.org/mt/108858120/9002280
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [git@=
oliver-kaestner.de]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

Simply put, GitHub Codespaces are Docker containers with a VS Code
server that run on GitHub's infrastructure. You can launch a Codespace
directly from the GitHub web UI and use VS Code in the browser or
connect to it with a VS Code instance running locally. It checks out the
selected repo and lets you work inside the container as you like. You
can use an own container image (e.g. crops/poky) and thus get a
pre-configured development system that you can use from any client
system, even Chromebooks.
In the free tier, users have free 120 "CPU hours" each month, and
enterprise users on a pay-as-you-go basis.

Oliver


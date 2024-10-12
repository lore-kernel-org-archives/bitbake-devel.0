Return-Path: <git@oliver-kaestner.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6657ACF256D
	for <webhook@archiver.kernel.org>; Sat, 12 Oct 2024 15:29:20 +0000 (UTC)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
 by mx.groups.io with SMTP id smtpd.web10.12940.1728746950391595839
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 12 Oct 2024 08:29:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@oliver-kaestner.de header.s=key2 header.b=Q/m2E80Y;
 spf=pass (domain: oliver-kaestner.de, ip: 188.68.61.103, mailfrom: git@oliver-kaestner.de)
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4XQnTc3vv0z80Dw
	for <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 17:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oliver-kaestner.de;
	s=key2; t=1728746948;
	bh=+pvRePAZrO9EAQHeJOz7qcMhF2+lmUCAK3gGyG4AmxA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Q/m2E80Y+T5/04H4wkp6e8Jo1IdDnOzsMMin+Fki0Ac46dADC//H9gMVYtlQlskoz
	 S37oVQ5Yh4/nnrUk+g6My/a+9zwI64gmHkPdzUUg4y1J8N3ST1PaMD6i1kwStsAV0H
	 uvTSk/ei7YJZM62XduDFOkVVZCUYSQxuMsL/RPL2HODg72RfSuaz7F96BzeU4FCcxr
	 dvEmx/33gndLhaLFsh51jasRE1DXojDVddRhCdU/vr53oE2RZHLqkaZpD5k1Kci0m+
	 2ShiUCpNubrGt80sOOwExuEo46RjOzqTqO0lhyCyo/3a0ZjgHGPqXeInpzxgVIbjPu
	 jN4RQaGhBoJvw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4XQnTc3WVHz808P
	for <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 17:29:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
Received: from mx2fa3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4XQnTb67lmz8t2h
	for <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 17:29:07 +0200 (CEST)
Received: from [192.168.178.10] (p5de75435.dip0.t-ipconnect.de [93.231.84.53])
	by mx2fa3.netcup.net (Postfix) with ESMTPSA id 2394CE0224
	for <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 17:29:03 +0200 (CEST)
Authentication-Results: mx2fa3;
        spf=pass (sender IP is 93.231.84.53) smtp.mailfrom=git@oliver-kaestner.de smtp.helo=[192.168.178.10]
Received-SPF: pass (mx2fa3: connection is authenticated)
Message-ID: <8c2a1863-8b07-45ff-b519-3cc6b8fe3b14@oliver-kaestner.de>
Date: Sat, 12 Oct 2024 17:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] fetch2: add GitHub Codespaces support
To: bitbake-devel@lists.openembedded.org
References: 
 <CANNYZj9B2LV2ZH1VivrwdfH1T2FJTV1FU9MV3X+TwWcDCUqtFw@mail.gmail.com>
 <17710.1728337442729823697@lists.openembedded.org>
 <CANNYZj9+CLT81zNGCw8nTZAZa-1BPMn5UYjy3hUuAUDGGs0_ZA@mail.gmail.com>
Content-Language: de-DE
From: =?UTF-8?Q?Oliver_K=C3=A4stner?= <git@oliver-kaestner.de>
In-Reply-To: 
 <CANNYZj9+CLT81zNGCw8nTZAZa-1BPMn5UYjy3hUuAUDGGs0_ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-PPP-Message-ID: <172874694338.24889.16538766652903137297@mx2fa3.netcup.net>
X-Rspamd-Queue-Id: 2394CE0224
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: cnjNmrn8vt4Dl0zNUwYEe3zuQMqfW8/0f93oBQ1FmscO4TGJtu2M
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 12 Oct 2024 15:29:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16673

On 08.10.24 11:01, Alexander Kanavin wrote:
> On Mon, 7 Oct 2024 at 23:44, Oliver K=C3=A4stner via lists.openembedded=
.org
> <git=3Doliver-kaestner.de@lists.openembedded.org> wrote:
>> GitHub Codespaces use a Git credential helper that provides access to
>> authorized private GitHub repos. To do this, it requires access to the
>> `GITHUB_TOKEN` env var, so add it to FETCH_EXPORT_VARS.
>>
>> Which fetcher would be using this environment variable? Presumably it
>> would be picked up by some external executable run by one of the
>> fetchers, which one is that?
>>
>> Alex
>>
>> You're right, it's the git fetcher calling the host system's git execu=
table, which uses the configured `credential.helper=3D/.codespaces/bin/gi=
tcredential_github.sh`. This script only contains:
>>
>> #!/bin/sh
>> echo protocol=3Dhttps
>> echo host=3Dgithub.com
>> echo path=3D
>> echo username=3DPersonalAccessToken
>> echo password=3D$GITHUB_TOKEN
>>
>> That's why we need to retain the GITHUB_TOKEN env var.
> Thanks, where is this gitcredential_github.sh coming from though? Is
> it an official script maintained by github? Where? I don't see it in I
> don't see it in https://git-scm.com/doc/credential-helpers
>
> If you can find the link, and place it into the commit message and/or
> comment in the code, then we'd be able to track down actual usage of
> the variable in the future when needed.
>
> Alex

I couldn't find a source for this script. I assume it is injected into th=
e Codespaces container at creation time. However, the script is mentioned=
 in the GitHub docs: https://docs.github.com/en/codespaces/troubleshootin=
g/troubleshooting-gpg-verification-for-github-codespaces#checking-for-con=
flicting-configuration

Please let me know if you think that this reference should be part of the=
 commit.

Oliver



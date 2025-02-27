Return-Path: <l.goehrs@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67C9C021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 10:37:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web10.7843.1740652631714109431
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 02:37:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: l.goehrs@pengutronix.de)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <l.goehrs@pengutronix.de>)
	id 1tnbGQ-0005pj-5X; Thu, 27 Feb 2025 11:37:10 +0100
Message-ID: <c800a81e-d6cd-414b-a0bb-e011ca257bf9@pengutronix.de>
Date: Thu, 27 Feb 2025 11:37:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [docs] [PATCH v2 2/5]
 fetch2/github_release_artifact: fetcher for (private) release artifacts
To: Alexander Kanavin <alex.kanavin@gmail.com>, lgo@pengutronix.de
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org,
 yocto@pengutronix.de
References: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
 <20250227090853.1632280-3-l.goehrs@pengutronix.de>
 <CANNYZj_8DU=8eFrbjEBPhupuu13KG7a19V9z_zcj+WPhWAQ_ig@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
In-Reply-To: <CANNYZj_8DU=8eFrbjEBPhupuu13KG7a19V9z_zcj+WPhWAQ_ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.goehrs@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 10:37:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17344

Hi,

On 27.02.25 10:42, Alexander Kanavin via lists.openembedded.org wrote:
> On Thu, 27 Feb 2025 at 10:09, Leonard Göhrs via lists.yoctoproject.org
> <lgo=pengutronix.de@lists.yoctoproject.org> wrote:
> 
>> Authentication is provided using tokens, for example by configuring them
>> in the `local.conf`¹:
>>
>>    $ grep TOKEN build/conf/local.conf
>>    GH_TOKEN = "github_pat_123456789abc...
>>
>> The token may also be provided using an environment variable,
>> e.g. for CI builds:
>>
>>    $ export BB_ENV_PASSTHROUGH_ADDITIONS="GH_TOKEN"
>>    $ export GH_TOKEN="github_pat_123456789abc...
>>    $ bitbake rauc
> 
> Unfortunately I have to say no again. These still put the secret token
> into a bitbake variable, and are therefore not any more secure than
> just putting the token directly into a recipe. 

The fetcher is written under the assumption that users will either use
the fetcher inside a GitHub action, where a GitHub token valid for the
duration of the build is automatically provided, or on their machine,
using a Fine-grained personal access token[1] that only allows download
access to a limited set of repositories.

I agree that it would be a very bad idea to use a classic personal access
token or a Fine-grained personal access token with too many permissions.
The documentation should be written in a way that makes this quite clear
and should warn of the dangers of doing so.

Given the fine grained permission model I don't really see why the token
needs stricter protection than e.g. the `AZ_SAS` secret used in the Azure
Storage fetcher or the `username:password` combinations used e.g.
in `https://`-URLs.

An attacker that is able to gain access to the token, which would enable
them to download release artifacts, would likely also be able to just gain
access to the artifacts that bitbake has downloaded.
The only thing they would have gained is access to future and prior
releases as well.

> I have to restate: you need to find a way for wget to pick up the
> needed token and produce a header directly from netrc or similar
> file that is managed outside of layer/bitbake metadata, so that
> bitbake never even sees it.
I've had a look at the `.netrc` / `.wgetrc` documentation and it looks
like it possible to provide custom headers in the `.wgetrc`, but it do not
see a way to specify which hosts they should be sent to.

We could add a mechanism to `wget.py` that searches for a per-host
`.wgetrc` and maybe allow overrides via a `SRC_URI`-Parameter.
But I don't really like the idea. One misconfiguration would mean silently
sending the GitHub token Authentication header on _every_ request to any host.

Leonard

[1]: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#fine-grained-personal-access-tokens


Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0907C38A2D
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 21:36:38 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.134.1666733791179680023
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Oct 2022 14:36:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from [192.168.2.107] ([70.99.78.137])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 29PLaTYZ004723
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Oct 2022 16:36:29 -0500
Message-ID: <2f445be4-70b0-786c-e0ab-1e579c0edb0b@kernel.crashing.org>
Date: Tue, 25 Oct 2022 16:36:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [bitbake-devel][kirkstone,langdale,master][PATCH] utils/ply:
 Update md5 to better report errors with hashlib
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
References: <171B99736E534D59.1795@lists.openembedded.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <171B99736E534D59.1795@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Oct 2022 21:36:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14050

Ping on this one.

On 10/6/22 4:53 PM, Mark Hatle wrote:
> In the case where hashlib is not available, the try would fail and fall
> through resulting in a backtrace on the usage of the 'sig'.  The backtrace
> itself was confusing and made it difficult to determine what went wrong.
> 
> Update the import to be in it's own try block with an appropriate
> message to indicate what went wrong.
> 
> Note, the current version of ply all of this code has been restructured
> so this is not applicable upstream.
> 
> Additionally, some versions of hashlib don't appear to implement the
> second FIPS related argument.  Detect this and support both versions.
> 
> Signed-off-by: Mark Hatle <mark.hatle@amd.com>
> Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
> ---
> This was found on an internal Ubuntu 18.04 container.  Unfortunately I
> don't have access to the container itself but this resolves the issue.
> 
>   bitbake/lib/bb/utils.py | 7 ++++++-
>   bitbake/lib/ply/yacc.py | 7 +++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index e6e21e20fe..64a004d0d8 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -547,7 +547,12 @@ def md5_file(filename):
>       Return the hex string representation of the MD5 checksum of filename.
>       """
>       import hashlib
> -    return _hasher(hashlib.new('MD5', usedforsecurity=False), filename)
> +    try:
> +        sig = hashlib.new('MD5', usedforsecurity=False)
> +    except TypeError:
> +        # Some configurations don't appear to support two arguments
> +        sig = hashlib.new('MD5')
> +    return _hasher(sig, filename)
>   
>   def sha256_file(filename):
>       """
> diff --git a/lib/ply/yacc.py b/lib/ply/yacc.py
> index 767c4e4674..381b50cf0b 100644
> --- a/lib/ply/yacc.py
> +++ b/lib/ply/yacc.py
> @@ -2798,7 +2798,14 @@ class ParserReflect(object):
>       def signature(self):
>           try:
>               import hashlib
> +        except ImportError:
> +            raise RuntimeError("Unable to import hashlib")
> +        try:
>               sig = hashlib.new('MD5', usedforsecurity=False)
> +        except TypeError:
> +            # Some configurations don't appear to support two arguments
> +            sig = hashlib.new('MD5')
> +        try:
>               if self.start:
>                   sig.update(self.start.encode('latin-1'))
>               if self.prec:
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14027): https://lists.openembedded.org/g/bitbake-devel/message/14027
> Mute This Topic: https://lists.openembedded.org/mt/94168114/3616948
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71997C433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Feb 2022 12:43:42 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.21448.1644237821085911479
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Feb 2022 04:43:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=M9/N5NWs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id i15so2147413wrb.3
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Feb 2022 04:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=YoIu3yPPCiRWGawhNYxdBQiHjE1QezKOWJZm5L0J7N0=;
        b=M9/N5NWsEnWN45BppPeGdSbCFgqNNaqVrEsS6c+Ixm7Tqsku2a2YinKiIZ6oRYDxtD
         aMyatq1nEuO1v+kU9It5EP1RBugKA/EIp33KSvFNNIJetehw0jVC7R35CODSD3gINdEN
         KROmkEhUJNE8bvowcyioGV4mt/PbEPbXEAoaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YoIu3yPPCiRWGawhNYxdBQiHjE1QezKOWJZm5L0J7N0=;
        b=usm3MUG09lwzRNCnauGUEyGpkMT250XpK9IUs8I150w1yX7BSbtKHfq2Uwqttp4OIx
         HizBWDiC89u6e6iK5FVS1Ge3kIwNXMGs/O+c/6/KG/nrnmbJ4CIENTP80ajfUwzcLDYG
         lRQUNypElvcbw044eX9np+CDgiTOL+0pc9sCvwzOf7DfUcxl+PYRSrlUWGtLhmGTcIcR
         bxi07IxAxp9awhfKqsMrAKzE/txoKA8lAwDsXpff4P+aKYO2nZRiSehNk4VHxlZD/f/D
         YlRF1SmBcvx066Q0l5GKvZT6UEzuCfGEIxMATkjHAv3b9c5NsIXPQ7i1bVLbQqIOeMam
         YX1w==
X-Gm-Message-State: AOAM5302I8sMh7CqKxKehA58uZnCx6BELjgr3h3v5v4JNFiSoYHS4Tln
	QTDOk311SM4uDxBMsz0y2nh63g==
X-Google-Smtp-Source: 
 ABdhPJxGmOD/6mYANXSHWbq2UcwkMT4vBReAW7KZ3C0ekCvTvKRtXjarHkye4rl+V1Ai0D+Ia4TEOA==
X-Received: by 2002:adf:fb10:: with SMTP id
 c16mr10030406wrr.200.1644237819521;
        Mon, 07 Feb 2022 04:43:39 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6244:607e:d5da:d0fc?
 ([2001:8b0:aba:5f3c:6244:607e:d5da:d0fc])
        by smtp.gmail.com with ESMTPSA id
 x11sm3478167wmi.37.2022.02.07.04.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 04:43:39 -0800 (PST)
Message-ID: 
 <803e4c5c9ffe5b8a347826aa4cf86e979ebe54d0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch: Use git rev-parse if network is
 not available
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Pavel Zhukov <pavel@zhukoff.net>, bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel.zhukov@huawei.com>
Date: Mon, 07 Feb 2022 12:43:36 +0000
In-Reply-To: <20220207115322.28209-1-pavel@zhukoff.net>
References: <20220207115322.28209-1-pavel@zhukoff.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Feb 2022 12:43:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13320

On Mon, 2022-02-07 at 12:53 +0100, Pavel Zhukov wrote:
> Sometimes Fetcher is initialized while network is disabled (unpack() is
> one of such cases) and Fetcher fails to map non SHA1 SRCREV to SHA1 one.
> In such cases git ls-remote cannot be used to determinate latest
> revision and git rev-parse can be used instead. This approach doesn't
> work with rebaseable repos so exception will occur for such repos.
> 
> See [YOCTO #14707] for more details. Note: the issue doesn't occur each
> time in unpack() because in normal flow (fetch->unpack in one build)
> URI_HEADREVs are cached.
> 
> Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
> ---

Thanks for looking at this. I like the idea of some tests to demonstrate the
problem so we should start there.


> +class GitUnpackOfflineTest(FetcherTest):
> +
> +    def setUp(self):
> +        super(GitUnpackOfflineTest, self).setUp()
> +        self.tempdir = self.tempdir
> +        self.persistdir = os.path.join(self.tempdir, "persistdata")
> +
> +    def setData(self):
> +        self.recipe_url = "git://github.com/lz4/lz4.git;branch=release;protocol=https;"
> +        self.d.setVar('SRCREV', 'v1.9.0')
> +        self.d.setVar("PERSISTENT_DIR", self.persistdir)
> +        self.d.setVar("DL_DIR", self.dldir)
> +
> +    @skipIfNoNetwork()
> +    def test_unpack_offline(self):
> +        self.setData()
> +        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
> +        bb.fetch.fetcher_init(self.d)
> +        fetcher.download()
> +        fetcher.unpack(self.unpackdir)
> +
> +        ## emulate do_unpack (disable network)
> +        self.d.setVar("BB_NO_NETWORK", "1")
> +        unpacker = bb.fetch.Fetch([self.recipe_url], self.d)
> +        bb.fetch.fetcher_init(self.d)
> +        unpacker.unpack(self.unpackdir)
> +

I don't think this is a valid test. I think it should only call
bb.fetch.fetcher_init() once and at the start of the test before the Fetch()
call.

If we change it to do that, the test passes.

Going back to your original bug report, the issue could be that
bb.fetch.fetcher_init() is being called in the do_unpack task and "destroying"
the source revs in the worker context.

I suspect but haven't looked into that yet. What we may need to do is transfer
the bb.fetch2.saved_headrevs into the worker context?

Cheers,

Richard






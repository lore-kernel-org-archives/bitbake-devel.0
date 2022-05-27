Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A923C433EF
	for <webhook@archiver.kernel.org>; Fri, 27 May 2022 23:02:32 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.9749.1653692550002915952
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 May 2022 16:02:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dcCrwwn2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id t20so1673019wrh.11
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 May 2022 16:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=1ErqOmcU5+FCV5Yw5f8CNGM885kj7P9jFV05CW4CBTg=;
        b=dcCrwwn2QJ0jsNmIR5dDYBvPaOkhOh7M0OTPxCrcDOsikARK6mL8dgYJDApbT318AW
         RqjTsTrPnY9GtZSmO6R8x4bpXfLFU5jGJgppVK4heTTVdHUyG7T3auBXqrjrOHfL3VK6
         evgapz4zcxC8WuwxgU+uN39BC99oIU9RPyOW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=1ErqOmcU5+FCV5Yw5f8CNGM885kj7P9jFV05CW4CBTg=;
        b=x6gm5tV0nB38rrf6rUllMpXSgCcF+HY71NA1w/U+2pwYFM8EnXsCCROOQSSi6GIxwy
         P3iJSR7ab8H6X4dpTpfe9qCvBZquRFTOTaSXb4ga/vQ6DnWIKrUbtysTcuEFSq0XvvGm
         RPUZn1O1nrf1kicuJlH2B15CTwtNqUXDns3t5RXuxZ+rK+ZRNBunipNurFddXjKpBhKY
         +BU9z6oQf9eyxhNinXS86Pg9wVgea9liMnVG4WcwLxNCSN72UI0+zR7nAJRzaZFU3cEb
         9d4PYiZRA0KHrm+VFu29FMCaaZjfOBuVuwoZL/ePmh236KyalWZa3rvWMrmODR3vFL5+
         h/lg==
X-Gm-Message-State: AOAM532uA9gXjrcRnDzkRxMtQXgjidVGKwiDZErScd/qN+QLT2iqMRlW
	EbzkS2+4q+k/G/BHUfeR7xAlIg==
X-Google-Smtp-Source: 
 ABdhPJySvfqIn2NrVcGbJ9B4g5GcV8/db+QXUOwnNoXt73KQQ361T0hlfqx5EH9vUsLatDoKk9XOyQ==
X-Received: by 2002:a5d:6c64:0:b0:20f:f413:8af8 with SMTP id
 r4-20020a5d6c64000000b0020ff4138af8mr15728819wrz.129.1653692548385;
        Fri, 27 May 2022 16:02:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:41b6:b722:6b4c:6704?
 ([2001:8b0:aba:5f3c:41b6:b722:6b4c:6704])
        by smtp.gmail.com with ESMTPSA id
 c2-20020a1c3502000000b00398d2f6b5d8sm530625wma.4.2022.05.27.16.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 16:02:27 -0700 (PDT)
Message-ID: 
 <e958110b6b8c6c075c4e416f3e6a7c41291377c6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of
 taskexp.py
From: richard.purdie@linuxfoundation.org
To: "Reyna, David" <david.reyna@windriver.com>, Peter Kjellerstedt
	 <peter.kjellerstedt@axis.com>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sat, 28 May 2022 00:02:26 +0100
In-Reply-To: 
 <BY5PR11MB4167DAB8764220B01375B73AEAD89@BY5PR11MB4167.namprd11.prod.outlook.com>
References: <cover.1653448549.git.David.Reyna@windriver.com>
	 <b17960eece2c4985b066539792242c23@axis.com>
	 <BY5PR11MB4167CBD5CFCAC739E65B50BFEAD69@BY5PR11MB4167.namprd11.prod.outlook.com>
	 <bab9cb806dbb1d11b8e29db5e66f5d58ace98b53.camel@linuxfoundation.org>
	 <BY5PR11MB4167DAB8764220B01375B73AEAD89@BY5PR11MB4167.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 May 2022 23:02:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13718

On Fri, 2022-05-27 at 20:34 +0000, Reyna, David wrote:
> > My biggest worry is about maintenance and testing as we don't have
> > any tests covering this.
>=20
> I will look at including a type of an "expect" self-test, where we
> could pass a text file (via an environment variable) of key commands
> and resulting display confirmations.
>=20
> For me, the scope of potential maintenance issues appear to be:
> =C2=A0=C2=A0=C2=A0(a) a change in the bitbake metadata for the dependenci=
es,=20
> =C2=A0=C2=A0=C2=A0(b) unexpected content in that metadata for an unusual =
recipe,
> =C2=A0=C2=A0=C2=A0(c) hosts that do not render the ncurses as expected

Yes, it doesn't need to be too complicated, as long as we have some
test exercising the UI, I'm much happier than no testing at all! :)

I know we're going to have to make changes to the UI/server API at some
point so I don't want to this to break and not be noticed.

Cheers,

Richard


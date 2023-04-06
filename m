Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C492C76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 08:42:44 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.153646.1680770554028396128
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 01:42:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PboquuOw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so24789514wmq.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680770552;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mo25IB+Ps/FgJjIycH+1N1Jpj+VT58qYfkEyA07RoF0=;
        b=PboquuOwAzlpDyrthBY/J9M79Y7JwSgjOBOyxykQ6I2Oolwq8XrKkZ5FDkSGfwcMq1
         AYgwc6Zdb0CG+1+lxxanOZjDMP9FKyS5sebyOswzcWbiWZgTr/XuRIGgmmThYFWQaUdg
         OR1pLA1uMpewjcni+6r3bkbxr49VVRg3e2h5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770552;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mo25IB+Ps/FgJjIycH+1N1Jpj+VT58qYfkEyA07RoF0=;
        b=R75iuImkYq+GqS85i+1m1Y3El7izyp/TKS4WWw196xG/mpEoBm+EgScRhdQG8iRuQr
         3BeULLVYuLcyEy8uA6V4jxNs0OVAl1W34/CoAEQrxbwOyvELzi8QOmCqQA98USmNAgWx
         DJUtC150C2c0UV1nobsg8dtIwh+wFLp8PCqaGxMuraUiVIPDv5Lm57tHe9EtCL25Y44e
         mHk/46JgffRPUYpA9a0E8JjTyjFdRyX8BdKzyiNcAzvo/2nfubeRpMUlK/c65FiyCcwK
         lX7o0qmZiiyJEqRSMm1AzqUiUZAikPagfhsm7JUEp5Zl938MEAVQQVeUExUuPYKgx+hi
         iOTQ==
X-Gm-Message-State: AAQBX9cnnIu0c9lek78twjepDOS/aMpNIHVRcsnroDtrKltbrfaoe1TB
	OBjqZ3v0NDb3P3ZtvJRv2eGqgw==
X-Google-Smtp-Source: AKy350ary2/8GQsk7cC9ke8le9/96GgMIaB4J9n1tn5mcymOFFgRYcMohEuX0mbd1TAWNvgYWa8AdA==
X-Received: by 2002:a7b:c3d9:0:b0:3ee:3fd7:5f85 with SMTP id t25-20020a7bc3d9000000b003ee3fd75f85mr3601007wmj.11.1680770552338;
        Thu, 06 Apr 2023 01:42:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6a84:552d:cd38:8d5? ([2001:8b0:aba:5f3c:6a84:552d:cd38:8d5])
        by smtp.gmail.com with ESMTPSA id z12-20020a7bc7cc000000b003edd1c44b57sm926658wmk.27.2023.04.06.01.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 01:42:31 -0700 (PDT)
Message-ID: <37f0b57bb3fc25c4232378f94fb8d30929c53e6d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v2 3/3] crate.py: authorize crate url
 with parameters
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Steve Sakoman
	 <steve@sakoman.com>
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Thu, 06 Apr 2023 09:42:31 +0100
In-Reply-To: <DB5PR02MB10213D211F48E6ACF5D4505BFEF919@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
	 <20230317081916.1857201-3-frederic.martinsons@gmail.com>
	 <DB5PR02MB10213D211F48E6ACF5D4505BFEF919@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 08:42:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14664

On Thu, 2023-04-06 at 03:40 +0000, Peter Kjellerstedt wrote:
> Please cherry-pick this to Kirkstone and Langdale so that they can read=
=20
> updated recipes that use crate:// URIs with parameters.
>=20
> I assume it should be ok to cherry-pick part one of this series too, as=
=20
> long as you do not cherry-pick part two, as it would be a breaking change=
.

If we do this does this mean we're committing to forwards
compatibility? I'm not sure I like that precedent...

Cheers,

Richard


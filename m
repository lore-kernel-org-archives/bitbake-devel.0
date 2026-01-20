Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD801D2ED0F
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 12:37:35 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5472.1768912650227882110
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 04:37:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iZi7jW2S;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c52f15c5b3so611375285a.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 04:37:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768912649; cv=none;
        d=google.com; s=arc-20240605;
        b=A5Y9zS3AUwYcXUf9GYhBUaW00uz+FB/zqNDXOVcesKUt2p1S0lv0R+PXyyQog9nkiL
         xNXjyR84Oa+FbIOXh0qJNoXg+POySrnDs5HPc/Mgwb22Bcgrq/HtUlQ5b9IB7qgktaIc
         dIdL1MbpX7WDN3Dg/MBDwgBa2oC1kBMEM5y2kfwcF4+eTXm/MSK6RFhvw0/Jpb2GC5SK
         RTSbZ725ONfngdi+YKe+n1IpQ0VJ+reJdwaK37jRkleJTx7+gMkAsfsapl3h6Xy8uPa+
         3wWEJaSyEi1cASyqOI7vtwUU1+RnkaqpDQwe8WNoHJNLBlLCfpUWt/Ly+i9k/VhhXaC0
         vwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=v7k9KPYDs1mwiNIRnWB0md4RgBEDadW2oOhiWlRBrRI=;
        fh=4iyoqXWXzr419C+IQOwDq6Y51UQKhKZf37iVDBoh7vA=;
        b=MHpUoS1u2/RWTmvJ3gVRUuppe4BXtcGgTT+ehlUqpeMCYptxyC87g5q5Lc3wvRABSr
         yHkAJvJnaYCAe7y9L4KLKhMJkBtrrBbs1NsY+GVAWxS2BhjypjmyZLP6RlO1tOOUBlVL
         yW7+VmcaGcy9KphAyMgvr+z1gGr9GImlnGZ3HZBZiLTKf8G2tGp+fFcLITdu4YR6SP/0
         dN42kdT79ygt64rfBeDwAmUaQbae1hyZOYv0t2bqSGw7+s21qZwyDWHjlihezbYJhhMd
         TKcFMOzBHI5O5DXBkk2MtW7OAL4PaUYxODgpntv0uHW7eKI4S5W6t4dtmreokzzl0h/p
         T4nA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768912649; x=1769517449; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v7k9KPYDs1mwiNIRnWB0md4RgBEDadW2oOhiWlRBrRI=;
        b=iZi7jW2S9/KXsRdl0IoDeEyxGs4wiQ9oOC9mqgx9niHrLyOy5KSgG3RKRgae83pdTB
         nAyyCb4Bkxa6P5E8Bh8XPHYnf/0uD7wn/gPZStrt+CbY0VPtfRnDFUtkWEDjeEybfG8Z
         8q2TYX2J6wLhQguASEs+sFJ9aLIuD2/opqBO8K3NhABU7YVQkpsiJ9y8D374EZFZPkGf
         xzTv2nF/eTs1fYkrYfFbR2/6rZkxNh0kgNQui3iqNBAVGYUPhfuE/kg9e4Ab4NmoCFtm
         e85d8YNHjgQndHmU/QQXJnqAC71sb1dJyiFuuBkdf3L9TGeTFtqALsP0wG9bTCvV6Dyo
         XGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912649; x=1769517449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7k9KPYDs1mwiNIRnWB0md4RgBEDadW2oOhiWlRBrRI=;
        b=hKmmTIxtbhV4gSWWhXCP4eQKROOhu6CXxL9jHWWOIF6RYiC8e8YU/lnirbxJ2jFpst
         RUP+6r1pIZ7Tzugz+mf/qi4s09PyMdRibBxQFMrzsltkR0WCnW6lR7n1Rh8FbXL9mKLK
         0YTWVByFlWM6UM1JaKxCJjEr9Fis3+rgtnaCK0UKG3UJCXidDQWdYAexewf5ahC6NRSl
         XL7e4sSaTe5HJzUDwExFJlpwqMfqSU5u3yn4s9oNky7j7SZ4IXYAs22XSZkI8a5Fg9J9
         K5kufVW7NUaQWjCNANdBYmEkkaXXoJbd3PtsQeoSPy2ZPwm0AclgQam6aRVQsCTgE2HV
         c5aQ==
X-Gm-Message-State: AOJu0YxPqFAxVK4p5Xh13r3Syuybp/TH2hr0PEej+7mSY9GSh0dXJmtn
	RQJ8slN2ctMUsMjRwvNXYpxndxhP1NfLYVL1oz18Gx0+VMpawTCyIWRK5g1MYlFCl8Z3jtW1WDr
	t3mzlYnApUDyDEIDfJN+0O5d3z+d2eQo=
X-Gm-Gg: AY/fxX4felaWTsogvp+sqDw0yZP8cexRMJc+SX2TOPXeUgBg4CPzL5vX5hm8kOt2TOU
	rINyY3AN7Ykhc49Td3WblZBwO4lMUSzcU53AqwQc2KXz/wu018pO10YuOJf/ChJUZWlTLCed9oK
	D66xzcZiaUSWboE/uEssUsY5VSQb4gbLYEA34dQvslymInyWBj6dWNLhQLTN3u9/hTuUR2WS/0L
	w0CSWHekO+pRwQJkl4r6EMV7aBnLxb/nCJzYjYqXcOzUQXnw7uMn1/pz4FjrqKTUaGN9MXHWyuS
	5D4X2Ed+WLPZuDiU2eFKADA7Gr25fQ==
X-Received: by 2002:a05:620a:44c1:b0:89e:99b3:2eaa with SMTP id
 af79cd13be357-8c6a66d665amr1932590985a.8.1768912649091; Tue, 20 Jan 2026
 04:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com>
 <20260120-bitbake-setup-choose-builtin-v2-1-ade604ff2351@bootlin.com>
In-Reply-To: <20260120-bitbake-setup-choose-builtin-v2-1-ade604ff2351@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 20 Jan 2026 13:37:17 +0100
X-Gm-Features: AZwV_QjobJh2RLsQbOakjU1gjp_0jDuzLaJTapbL9N783IfOQzUxADsUaXzCbrI
Message-ID: <CANNYZj9pmrFRNoLt9od1yVfDiR=5xZafPrYSaXPe1bsDoayOJw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 1/2] bin/bitbake-setup: add
 descriptions for fragment choices
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 12:37:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18819

On Tue, 20 Jan 2026 at 09:57, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
>  bin/bitbake-setup                                  | 21 ++++++++++++-----
>  .../bitbake-user-manual-environment-setup.rst      | 26 ++++++++++++++++++++--
>  setup-schema/bitbake-setup.schema.json             | 21 ++++++++++++++++-

Oh, one more thing: adjust lib/bb/tests/setup.py to use the new
format. Even better if you can tweak it to use both old and new in
test configs. And it needs to pass of course :D

Alex


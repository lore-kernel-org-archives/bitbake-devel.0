Return-Path: <eric.sun@meraki.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C841C41513
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 16:33:05 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web11.518.1715963580400228391
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 May 2024 09:33:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@meraki.net header.s=google header.b=axUETx1s;
 spf=pass (domain: meraki.net, ip: 209.85.219.174, mailfrom: eric.sun@meraki.net)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df1cfa7f124so357223276.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 May 2024 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meraki.net; s=google; t=1715963579; x=1716568379; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=asfUlsykViYLOWma1KjM2pSJWbpETRBksbhvVQeWbBs=;
        b=axUETx1s+QHQQhjj88jbCKLP4jT2b1f8vIuQZnYzAh2R6TGQPnuWPoZ9Sx8addL0Al
         PlwtiMxiBsQDSnxO6qoM5EOTOv3Ut/Vz0dNg50O5n5qV3TjRNrXSU14IJMJREluGm9j4
         Y8CeDp/T54aAScYl8YctLIUG5scdS93BpyPFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715963579; x=1716568379;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asfUlsykViYLOWma1KjM2pSJWbpETRBksbhvVQeWbBs=;
        b=v+qeBIEhuVbC+L181/2bJCE96YLsUqvBuQD0Qh4NU2az7ql6MvFmKURrBFrCnR37UA
         91iRSS77D0stsv05sYn7aPreOOSI4UU4EHKT53IGMjuH5kFx1IDosnzBdc3wN2LOK17N
         tatNLVBv1w82L4Tp0iHgg4bVH9lIT2yh5EMdWWdmug5KcnywgZ7SETRXwUrsoVlm1DhJ
         QrKpIamgyi9otL3vh3q/HeTU70blPta56ghBz2PLAF9fgY1+KnIentAM62ndo2opIF+l
         i02Vahl2EWHfUkDa4LJSj0IPMf6DYRxfSBhCt1TkxeyPyDFLxM93O7Qy86ZGejPa7Ruh
         GwGA==
X-Gm-Message-State: AOJu0YyJEvVs6r65bxme/v7is7baRz+m66hDVxqKORQp+evDfDjO8GzB
	oJzK+c+abndSWySrr9ax9y6Eb4lGEfKPQ409PYL33jRQjp/dmO9hvA0QA7rfNeSPVM/N3Rv0ejy
	wLdD3zchB7/nMzjavDZjYLngyesrSbwLzOU2JCXhZ2TCpTpE5yw==
X-Google-Smtp-Source: AGHT+IFx2P4UYn1U6PWV0xJS7XXeI7+t8jpvlan4C4dwV4qsb+0LaP+oCdEABJUIByzKs+m/RP2PsgxLIxL9NKFw+I0=
X-Received: by 2002:a25:ad95:0:b0:de6:107b:6557 with SMTP id
 3f1490d57ef6-dee4f2e424bmr20701031276.27.1715963579142; Fri, 17 May 2024
 09:32:59 -0700 (PDT)
MIME-Version: 1.0
From: Eric Sun <eric.sun@meraki.net>
Date: Fri, 17 May 2024 09:32:48 -0700
Message-ID: <CAFSkHJ9opKaxq01b62+TztjqXWipHrayAwU=vCN3ZRAbO+G1-A@mail.gmail.com>
Subject: Possible kirkstone 4.0.17 variable dependency bug
To: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 May 2024 16:33:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16228

Hello,

I believe commit 8ec4f29e432feec9d8deedc06bfb90d57e7436cf to the
kirkstone branch broke some variable dependency calculations in python
3.6 (and likely 3.7).

Specifically, those python versions still parse string arguments to
functions in python expressions into ast.Str, rather than
ast.Constant. And so the code in question is no longer able to
determine dependencies involving e.g. bb.utils.contains.

As an illustrative example, consider the results of the following:
import ast; print(ast.dump(ast.parse('f("a", "b", "c")')))

Python 3.6:
Module(body=[Expr(value=Call(func=Name(id='f', ctx=Load()),
args=[Str(s='a'), Str(s='b'), Str(s='c')], keywords=[]))])

Python 3.8:
Module(body=[Expr(value=Call(func=Name(id='f', ctx=Load()),
args=[Constant(value='a', kind=None), Constant(value='b', kind=None),
Constant(value='c', kind=None)], keywords=[]))], type_ignores=[])

Happy to try to submit a patch if that'd be helpful. This is only an
issue on kirkstone where the minimum required python version is 3.6.

Thanks,
Eric Sun


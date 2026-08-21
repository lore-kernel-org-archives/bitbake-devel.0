Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112CEC5DF8C
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 17:17:59 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.258.1787332674782593251
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2026 10:17:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kL1J9JJ8;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c1372f84dso7888301cf.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 10:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787332674; cv=none;
        d=google.com; s=arc-20260327;
        b=r14RBAXW9hRLdWyW9AYVMeh2lp7p1gwgoy4WcIIZ85Y4NJSJsIj7fTDbyoloTz8Iv/
         ymuIin/NGRi9sIQUwFbpofy4eKTT40A8oNTIxUvG1FVGaKeqpKemi1ZgnExg+l9uIeQm
         ZlOHvT3uSee6GZv2uhCs2IZYhg5hcotZUbzTE85mXJYojhzDyHRC6DjUUf1EB4ezPyTQ
         oD7Hx3GwPOjPiOmp6wXaYGmKnbZ7Zys+41j+oorsunp27p4w3bH2pP+0vKOCPfaDtEdw
         E3+af3skQrI27hzVrCPOZIw8/1m0gIB9oR9YxYH/FbAqqoOuqBf7SFr+WsAfJ3sVwmsZ
         youA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LgpeNHhfg3ubFmhX6HyvT2UBnuPWG/f4V41XrZVVzhA=;
        fh=eXhDJDsIfFzCgyQ0Q2WLQFoLX1rIBonapojPdzUIvqQ=;
        b=fucuCBAnEs/cRyM05Ik+wCuKBMXs+TpCAU+Q6g3GElgJoXqC6XB7x/iaxcjwmp6JRw
         dCkBJPWbk8Rv7dzbVam70qyuzWHOjO3EQIC8akl/0mxBlv4hFuPQRubwALQWtxE9hGYt
         vpuwmEA9CDoIVXV68udHzU9sOjZrrwk+7otZXYySJpLbdtYgdrT7EFWXRjBaYn7gAhvz
         bDbTE8srNUuKdzmH67lIlNt5OrjtpivuhGBmDwcWeRfI/7Bu34Xw7D/1QNc6U415Tvrj
         OF29Z7FG9f0RrJDL/lUEs01IwaJyoQFqL9OLa7pUCz7kdMt/qij6SWO0/jnB8S7Rwjxi
         DuLg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787332674; x=1787937474; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LgpeNHhfg3ubFmhX6HyvT2UBnuPWG/f4V41XrZVVzhA=;
        b=kL1J9JJ8wpsdpSKD09OZd0uxPXEMkOGTxb8y4n4ps3EnY6YNOvSGDX+8RyCBnZOAR1
         E5PJVASS7fjacCeD2Eb606dSZNwFi6amnD0NF+oubtIrPz/1iWQowvOH0REi8856+iVk
         7CMlAGtb+OfJ6H9Lnmi2X/aPTYOqsrIQxulDHN5ksFnTsFv0sWEUb199o+BUosnyzj8r
         wqz9zkVepaig+B9H65HPEXCHt27G5GXXkWBs/b930k+47NUc5hNQRXiNn6+F1YnpLysG
         2Ogep00cicyemk4j6uwbDnS/+obhryjpdXxtueij3+qXvpKMnmqKCkrkPeloNBHC+JXy
         KhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787332674; x=1787937474;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LgpeNHhfg3ubFmhX6HyvT2UBnuPWG/f4V41XrZVVzhA=;
        b=kcQaPSqbRwYvDX4KZXAFVdbWRXJahuzEHMfAc4Ip90LK9wTXGp2H2OpeSHQKiZ0kTc
         pRLem6lDUrdar+k97li9Ph5tCbOXVqVZb1kzwyIj7+38d/4JYX9xlzCbA5XIMZjwvyED
         qPqTQDdKCkgG6taZndaM5gEgnrithcHGKQISdVsqFQ4yO26fU7eHFTvjx9ty3Yf4hXOw
         hzqPJZHII0O1xc3zVhAASd9TiGuz9w3g7iXCmZtwhaiVfmXl3Tr6QFgUPOyMjoJ6xPYN
         9vpeIBHYFa6D5AgyH7eOWgp/z9Vd5yZT8mneoU9gjj4F0gJSYMvXtHQeOb9LBKL3HNmz
         ed7g==
X-Gm-Message-State: AOJu0YyT8JUp9090MXKXSC5MsciV1QNTTqUXZWrRdDprIrZCznizbKXN
	7qNgsleTQrxYGnV8TKMD+cWycuKrzEwXcC00eoVv7mB1dMh75E9vDApNP847cx9+zTS2qXiWcq+
	7czJyGYbGFIl5yFxvljQXLCER/oknVW8=
X-Gm-Gg: AR+sD11jQhq3lK77FzdJga2GkCIqYaYsLriPLEn7xYm6FzfXtQaRBI21RWKutpHgMVI
	CgvQDk+p0UpCsZi20DqsmGuei0EIzpBrIue6G4un54p3PncEBgsmqjPgEcQaq0Zg4mSnQ3/ByyG
	LmEmbaXkZNFvZwLeChldC7+XTduRFOgmR+YK2+zaWdQcm0nBxgLuBDVEu7OT3xQg2kGQTcZxGhW
	A7cK32ocsMIKNyMtw/cltpsr5KZ5hd6MrV3tr3DCSe5xECeo7Ex0ipZWPUHpAWQTBt9ji+fyPDy
	iV6XGeAO8pY/OhOJvEAxi/TSDhbkd61oTmn113jk/WmAHoxs+sfiLjh2dmQS1ZPRUH87+d+733B
	GcmKK
X-Received: by 2002:ac8:6f0b:0:b0:516:d812:c35e with SMTP id
 d75a77b69052e-52df5a012e8mr84383371cf.21.1787332673644; Fri, 21 Aug 2026
 10:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260821170624.436725-1-chris.laplante@agilent.com>
In-Reply-To: <20260821170624.436725-1-chris.laplante@agilent.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 21 Aug 2026 19:17:42 +0200
X-Gm-Features: AcwNN1UgkoIP3O39h1lOcLJlV1qkZVD0_SblH1KcI-BZvHtEsfe7GfVXxlCKrew
Message-ID: <CANNYZj9wrRh4JR3cuwKchRFXEKEKa+oyCSh1XMN=tWJihY-8Ug@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/3] Remove bb.fetch compatibility shim module
To: chris.laplante@agilent.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Aug 2026 17:17:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20012

On Fri, 21 Aug 2026 at 19:06, Chris Laplante via
lists.openembedded.org
<chris.laplante=agilent.com@lists.openembedded.org> wrote:
> fetch2 replaced fetch a long time ago (2012) so I argue it is time to
> say goodbye the bb.fetch shim.

Why not instead rename fetch2 to fetch and drop the unneeded '2'? Is
there a reason to keep the number?

Alex


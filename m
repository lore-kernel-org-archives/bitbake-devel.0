Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48AAC982F1
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 18:23:36 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4049.1768587816318205767
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 10:23:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HD3ooZGz;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so21410706d6.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 10:23:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768587815; cv=none;
        d=google.com; s=arc-20240605;
        b=MX0UKfV0C6LPgk0W1yNukCjfcxDBCWAFdKTbsRAgrG5gh+CCuSB7ZocsUTNCndbUTF
         YaQTHFww/p15DGMKOAL6J84w24sddoCdJhZvxS0/THGF/2dHwwEJr8JCBOeMZyaYleBv
         mF2kQBN3nQy1/qVy+D8qmZWAPAAcWK2oJkkbAqIUoSV17ZCAtG1MafKcBRRHlX1oWmuZ
         fm91YgkEaxLMh3dnmXAJouf9X7hNVgq5vsxFhYSQVH98pEvTlYpZ5E8vOi0hLdC1PzqD
         47tMD8c6DezT6a7+XHm8u/S7ww0HhvGVnVvNqcrBfjGSPFOgiwD4r8al8FNAXuFkj1D3
         WAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZZmozKIMcZ6woPCG6Gog7/sAXAP6BVus9NNbaUcw11E=;
        fh=4iyoqXWXzr419C+IQOwDq6Y51UQKhKZf37iVDBoh7vA=;
        b=Aui2AXKDGtx5rUvUQlle8ivVZ8QTZ0av1hNJjakJN39ULOUXtjyps/cbr1YBh69h2e
         JpFpQyuBm8SYBV6pi7feW6IXc7vYB6oyw/jipTd6qijlJCpkCrykaU/fSc+kt/kbM0cS
         yL067p+xy85RMWTSwMxbpZrplwO9kSmr01HRcVkAucDo+jL3RagDHCbaiFBqQsvJbGr4
         EG8BWEjZseyaYOwUmm8yZUsfWb1Dlg7iqzfEkcVzRM7CipGTGYob/qoDhS6DYEEXSwZM
         AOZG2Onmfn+aaS9+LTRkQR/gjpY/0tas6oHt/vPqkt7AUmXcBa28NcC/23HDNG3GxIJL
         6B5Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768587815; x=1769192615; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZmozKIMcZ6woPCG6Gog7/sAXAP6BVus9NNbaUcw11E=;
        b=HD3ooZGzbfIgIKlBP8ESsWBGgnPGl0ln8zl7BKTtuJWbjz8DRCv2accNiuk9ajURJN
         KerPOKLJBVIYL+TBqBpwW4VoIoLew8yz4CWlWEp027iz3h7aA+kaQPhp5Wzky0+WPmvL
         KCOKQGNSKWmyb5UD6XCOx1tv3kDyppLxRFVB0sA3mRbxCLywJpqkMbNgc7jwhAzE66q1
         5/m5TpQpfxNoa7lT/koQ5ERUWu+d5L8tJAK6IlBSarYJsLiPSD7zY2mHmKEnsxxES6kj
         WWb0Ej90C1g+/8WpQp0K8FA0KxA3OIEGA/f4KLLJY8dwqjL1uDDCqn+5RiyCg3hFntMW
         zhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768587815; x=1769192615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZmozKIMcZ6woPCG6Gog7/sAXAP6BVus9NNbaUcw11E=;
        b=LhDZaSDaRw2afD3KdeZRL+kBn6EXvrtMCebEpN3zrm8Zdl6/VajGXd2No/scoCWoPQ
         ntW1GKFGoOnaU0SNnYglhpdbAxDP6okR7gE+oE84j7l9TfTTcKerGQNEDjmXpG8Iihtb
         ygNmxNWap8ReytdBYfeZDZ0i0cXVgDlaI6WphZNJrEGOvdNIBLZ09aF7W+KV88l/2v9H
         3Jb0lgxuzWBOVJWQ6KhxXgxSgXpXucVNyyKUFRXXT+ROh87jQ81z73yCqUqSVnK6qd2K
         8BemQeQryckzLlXP6meX3epdryQU7Ndb4Ci9K3mV9aNmV/yEMZUyfYGjnvXn7raqYTS4
         nf3g==
X-Gm-Message-State: AOJu0Yxyvf1b7zGAmwKx7nedr9X1I9qX3wLSyQqjOZy81zI1SrzAy81+
	z4/FVfkb5sZuMylnG4R71hVaZN/Ch3wZU57boNR9N5ogT7a1PNwCmWuEkW1p2DGLuI0sFq9xrbY
	GPE73RLFvigARxU8W8V2jeyvdu4Oz5eN8fg4d
X-Gm-Gg: AY/fxX6jHiwWND4S/7QE+QvEV7RewXDpxhaf9MvN4ck4iaZWX50TzrUSeWPjFtsCaXb
	lMS5Lq1lpzMcYh79HFOTRkls1u4K9nUci+cYwLNeSFfbukgzSUOqogsKWpRqkJ6Owz0yXMsSbxw
	OM72s2yG7EvjScajUmIA9+mn1fcYXzT7SJFYZT5pKJFW1vHahS70x7kBjDC1hIuoSJo1VcLhTQw
	B0Jt1l4XYrPxnDd2T4KsF9xEP/Okm+EU7+EG73U9TdrkG8jJ6AvrMVeBUdQIhyMoytCy7KoOSgQ
	Z9Y=
X-Received: by 2002:ad4:574e:0:b0:88f:a4ff:454e with SMTP id
 6a1803df08f44-8942dbf126dmr56609396d6.10.1768587815333; Fri, 16 Jan 2026
 10:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com>
 <20260116-bitbake-setup-choose-builtin-v1-1-8d66666a9efd@bootlin.com>
In-Reply-To: <20260116-bitbake-setup-choose-builtin-v1-1-8d66666a9efd@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 16 Jan 2026 19:23:24 +0100
X-Gm-Features: AZwV_Qi7jqFMn7lqYWdJMZ5JIvEe3BU7kudNh3FKrhvOR4W-t8h2CQfTzrFxl2s
Message-ID: <CANNYZj-Oh-WWLEhX=ZKpB2ddrR=oYseXBBgT-zQQ0CPUdA+HBg@mail.gmail.com>
Subject: Re: [docs] [PATCH 1/2] bin/bitbake-setup: add descriptions for
 fragment choices
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 18:23:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18802

On Fri, 16 Jan 2026 at 16:49, Antonin Godard via
lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
> -                        "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
> +                        "options" : {
> +                            "machine/qemux86-64": "Machine configuration for running an x86-64 system on QEMU",
> +                            "machine/qemuarm64": "Machine configuration for running an ARMv8 system on QEMU",
> +                            "machine/qemuriscv64": "Machine configuration for running an RISC-V system on QEMU",
> +                            "machine/genericarm64": "Machine configuration for Arm64 SystemReady IR/ES platforms",
> +                            "machine/genericx86-64": "Machine configuration for generic x86_64 (64-bit) PCs and servers"

Let's make this properly extensible:

options: [ {"name":"machine/qemux86-64","description":"Machine
configuration for ..."}, {"name":...},...]

Basically "options" remains a list, but each item in that list can be
either a string, or a dictionary. That way more keys can be added to
the dictionary in the future if needed.

Alex


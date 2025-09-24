Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1F9CAC5A5
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 14:22:18 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.15117.1758723732362157086
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Sep 2025 07:22:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NZ45LnLx;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7bb414430d4so8054206d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758723731; x=1759328531; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WcVUpE/NasgExEhXEJ+GhFxe4QC7AQrk6Ato96u9rNA=;
        b=NZ45LnLxBxUjH+OZecuxawy7cb7nron5Ux8r/SHv9kqlSA1UiusIjykiXFT3cL/Uuu
         WISkz8DKKjsRZNaXwnjBbvzU7K9laK5cdC87sdlg/Y9AwOuO7pYlxmLD/AQAuOLJ8BGA
         0pZ5ehscw+RY0NyhZGnh1dbrIQu7MgFgXwY05ONHjAaJs5Mi5/j6/9OqesvvXZNVJCl0
         43JxQaDOO9CFgZoHu9JmSahRKNQictQBAs/n4nui9nDXZqkbowJTGABg7ATnmn7g2cSy
         8ni8Laq7Emjv4K7e+EiquNRKJWuIxMkgbEGpiqoddOLycZ2P+zqjDIf3NQqaLuG8Ts6w
         /aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758723731; x=1759328531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcVUpE/NasgExEhXEJ+GhFxe4QC7AQrk6Ato96u9rNA=;
        b=s11xQ08yFUEFze10idQxrkp8L/A+hYeXPzYqLcd4ZfkSDHfuV3jKTF0sh9gswPm+zV
         uRLZ080731DhPQOcYzoUtRTD0xYZw3nGr7k9c6YP6ECXBu//msKJIe0R5FFVIdu3QsxL
         y/oKCn3K53U7YZwpZtr8HvXIJxWNYWt9VfC6pTJ9Du5AgcN3BqQm1sIJSEP4ophe+6K8
         UPF4c/pCTNCEnrV2zhp8VhCTPxjf90PeS3C7kjKxe5jlZQhEdSI5piO7Et559y3WAa48
         3dNyjs2xXqLo9VN7hcW5syk7LyCMyTJUXtVg1EEvAy2dtUuw9LlOBM9PBcLdpwWw9paW
         ID5A==
X-Gm-Message-State: AOJu0YyzI1cJ956gluyu4pRmG14oODIOk9+dfVvqW14gD/L6zkS/fqIJ
	eBUxdXkFHmm3qdvs8hcTXeO2KYXAh68OVAN4CgzE2AIxbviMsLLmMUwbo02mFKLmTN4tEahBc+D
	KOS4zNNL62AcEtcgCrcgn7/ctUKyDwRF+9g==
X-Gm-Gg: ASbGncsQZDS7cvh8c1pByNrNeJmPBa5N4AAUvQn4msmJ88uzMo+h8xS5zSMshAWSjk1
	kSkLv55r7+mX8dbsYJiND2p/RqH9pVjrQQj9sLYsof40ZziGS3Gb7ZofKulBZunlSoeBBgNnhAI
	dLFXkxTOgU3fCblne9JH7O7Lc8C9zOvTtNBtFEXqDIhPxIi1L1ZpeoZIqs5PtXRnhAlncNLeifG
	W2RRcxyx6A46klaLvoN9A/NFGl0xrMFHuGGFYuVp01HYjsY7w6Tb7Wo5rJHmO+OPKQF2Ml3Xp8g
	jDMItfYDyvXOs9+Q/jH7cJoDjRnwB9cjC3EPXL1b
X-Google-Smtp-Source: AGHT+IGVQLM87MSwyOTdfFqMQVz+i7yjUOJkLXkx1EOvthuCzihQXxpFRv1vIepIU42TSWd4yHiaUBs3OFv3QS54X0M=
X-Received: by 2002:a05:6214:5289:b0:775:6a7c:dbd5 with SMTP id
 6a1803df08f44-7f2e34f995cmr21648776d6.33.1758723731113; Wed, 24 Sep 2025
 07:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250924-fix-no-builtin-fragment-v1-1-4d7f734b6d21@bootlin.com>
In-Reply-To: <20250924-fix-no-builtin-fragment-v1-1-4d7f734b6d21@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 24 Sep 2025 16:22:00 +0200
X-Gm-Features: AS18NWAUQ653oibKPdqR2yQahDIA_qEU1aXiQ597faffI-48XRBzdiWCI1m7AKo
Message-ID: <CANNYZj_MT-cC6xAy8nG=HdUJBa-NnwSOzaoGztDu4QaQLi=06g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] parse/ast: avoid AttributeError when
 built-in fragment variable isn't defined
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Sep 2025 14:22:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18089

On Wed, 24 Sept 2025 at 15:48, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
> -        builtin_fragments = {f[0]:f[1] for f in [f.split(':') for f in data.getVar(self.builtin_fragments_variable).split()] }
> +        builtin_fragments = {}
> +        builtin_fragments_var = data.getVar(self.builtin_fragments_variable)
> +        if builtin_fragments_var is not None:
> +            builtin_fragments = {f[0]:f[1] for f in [f.split(':') for f in builtin_fragments_var.split()]}

I'm not sure setting builtins to empty is the correct behavior.
Perhaps an error should be raised instead?

Also, do other items from addfragments need similar guards?

Alex


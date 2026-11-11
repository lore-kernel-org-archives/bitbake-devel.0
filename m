Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7864.1794398329059385546
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Nov 2026 03:58:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=g4a4d0VC;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: stondo@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-497614c95f0so1679285f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 03:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794398327; x=1795003127; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NC8gcCH4tYv9mrm4qZiYwlg0BDE83Bo8qgWlDSNkkSQ=;
        b=g4a4d0VC6gtuf1wsar6FUATM4A6VZZei1nsC/raZovyvxzXOw8nW8M1kuQ1OAK+GeT
         KwHaDWPGI6n93s5GjjHz6Ia9n9vcZs3eIzZgNCgFjWU/U97wszB5b/Whbd62eMtjcYcG
         wzUPYVUD+VyMRhrGFlTpOgZvL8wLX6GXeYfWSxa2bg4lN6Rs47VaUG5KZnkXDuB4QfFn
         KeR1OxBMo6CgIanbDj36WrYajrAw+w0P7S+pRU5IOTbdUjQQHqwCeorMJeMySXHdgpN0
         IpmHSruKJa51tqzKV9WIcjw8tFTXgQwhsATgFtA0OTsJko9RjMG6Sif88sOBbEctT/LA
         ZHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794398327; x=1795003127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NC8gcCH4tYv9mrm4qZiYwlg0BDE83Bo8qgWlDSNkkSQ=;
        b=bdJ6OhYhbwK9kCkXvTEoIgzjILxviHiX0MyDxcUoUEu/r5wXgjHZWXPFpD8aCVRUim
         1tdDbekr3tk7GrQQXxpNtriN4Z7t5943cAjdoquSjC23OSOcwVZ/g/a8aBHc9dpDAHZm
         rOI43tcQIquc2TYB0nhh5lIVmsNXTx7SUMSVhylXFTkJheMaykac7aV0FuJSftYagOWH
         yp6UK0jqCFzthtJDozXLtKU47N1yAJd64ibe4A9xCbFy2pLCcohVB+5ZsKO01mzFrag9
         /T6GsKoI9iWMRTKqbwpLCDaexVa69hEh8w/V939o9nV7vCxdhfkFGmTpEuxdNbzhKZaV
         SEiA==
X-Forwarded-Encrypted: i=1; AL+hErFUtc0sQAe7MjEPyl2Y/6bnv1HCGjb5YFydXiuvT8pcFxy1uG5z9r46v+MOJRfh0UeJrfa46SWrB6pbq74q@lists.openembedded.org
X-Gm-Message-State: APuU4Z/iwinXAM7xSB2zI/AzkJpdQiFemYyCRdkjVf9STmUdgK+AuuD9
	frLDK5cUofWtcLBbsHTLaRA9fblZMuJDpH2AZ6HYey6QYErlXxGHcuPG
X-Gm-Gg: AYBFou3WZo5qo8AkUzcMgVTfr8r1+1pRWt9ZbSDJRvT+SQQyLcJBTPjCiGvH2aEIG9Q
	YkD9cUJwwoQx1U5G9TyWBbF9HwYLrkfPgN7mBFoCGCQD9gNYFCUg9HxkRbqSNsYvlY33g6XoPyJ
	XHxWUlr1rlCrgDR2+u+hOqY8BO0ML/tavjA9SKE0T5g9s8mGMQizAIR+A+O4XUwNlZk4h3Ijvsn
	v6e4bOf9V11XY7GTg3Y3ec0vkdogJlPbR7dQx5JM3rTW/1+PkgOiURXqVLNnfzhAt1ZhmIAOLLV
	OTQxxvQbPH2ZaMCdCH+OEVixGbXf3fqvfVEOny5Cz9fzVgGKpnvQoR6KgFcXXTLWS2zOUhg6Vaq
	XhK9e25NNFXXbKNrLfouE9XzsXGIRmUssOIM44Kat4uhm9RF3tBXMWlrHMd8yR4z+TIlYjNpgjB
	Fk41J01M1C7OSaeSCLGPP8ISVcrSRd5Fjw2hltOTFIANARsd7U5pXYl9rjPL8eZy3UZWvTicbCk
	g9NexPaVoAyB6zRWT04/JU2tsFao1wLdak5WPKVIg5quRNncvj5r2ztAROw/+7H3UtlT98nQzEk
	al0pGjBhMAbCGgQtzx4xWi3q7YnnimvygpteNjzPU239ZA==
X-Received: by 2002:a05:6000:250b:b0:486:f907:ebec with SMTP id ffacd0b85a97d-499c7ef33famr3553679f8f.31.1794398326995;
        Wed, 11 Nov 2026 03:58:46 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49836a9951csm10655967f8f.56.2026.11.11.03.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:58:46 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: stefano.tondo.ext@siemens.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Peter Marko <peter.marko@siemens.com>,
	Adrian Freihofer <adrian.freihofer@siemens.com>,
	Patrick Wicki <patrick.wicki@siemens.com>
Subject: Re: [RFC] spdx30: name, version and purl for dependency downloads
Date: Wed, 11 Nov 2026 12:58:45 +0100
Message-ID: <20261111115845.1940227-1-stondo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAJdd5GZTCwr9VE8OmOw7RAki+Xu+kokCgtOHG+9ghE3frWPbqg@mail.gmail.com>
References: <CAJdd5GZTCwr9VE8OmOw7RAki+Xu+kokCgtOHG+9ghE3frWPbqg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 11 Nov 2026 11:58:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20417
Content-Type: text/plain; charset="utf-8"

On Tue, 10 Nov 2026 at 23:53, Joshua Watt <JPEWhacker@gmail.com> wrote:
> Perhaps, the better option would be to propagate the SRC_URI purls to
> the output packages, but apply some sort of (optional) filter that can
> remove a SRC_URI if it is not actually present in the output. That way,
> if we have positive confirmation that some input is not present in the
> output, we can remove its PURL from the output package (but, barring
> that, we include it).

Hi Joshua,

Thanks, that model makes sense to me. A purl stays unless there is
proof that the dependency is not in the output. For vulnerability
checks, that is the safer side.

The cargo prototype already works as that kind of filter.
cargo metadata --filter-platform resolves the dependencies for the
target. For python3-bcrypt, it gives the proof for 17 of the 42
crates: 5 are not used on the target, and 12 only run at build time
(build scripts and proc-macros). None of them end up in the binary,
so they lose their purl, and the 25 runtime crates keep it. For Go,
go version -m on each binary lists the modules compiled into it, so
it can give the same proof.

One question about the output side: how do you want the purls on the
output package? I see two options:

1. Add them to the externalIdentifier list of the output package, the
   way set_purls() handles SPDX_PACKAGE_URLS today.
2. Link the output package to the source download elements, which
   carry the purls, with a relationship such as contains.

Option 1 is simpler. But an external identifier says what the package
itself is, so a scanner can take python3-bcrypt for one of its crates.
Option 2 keeps each dependency as its own element. I prefer option 2,
unless you see a reason against it.

Thanks,
Stefano

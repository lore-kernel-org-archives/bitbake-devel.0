Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EEDC021A0
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 10:43:50 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.8036.1739443429208430366
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Feb 2025 02:43:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=D8kCsnur;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso7682835e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 02:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739443427; x=1740048227; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r1BzbStemz16D8JHS6MPvjEAMJXrW4U+WBejc/r1AoI=;
        b=D8kCsnurigVHpGNNdrVHRSd0pIVMGinn4YsG1ySvaMZNX9PsubgS94epZy7P7JNsTA
         /1CDqt89a7gPZlxYCEot9pCVMAYM/jzifSEQBfbr/WV0B4GQNzLAxHfTjiMYm3XU2Vyk
         QjLwd1yixDherI/7bU4GkiYmRk//JrULPsER0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739443427; x=1740048227;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1BzbStemz16D8JHS6MPvjEAMJXrW4U+WBejc/r1AoI=;
        b=uK1LQlhZXI+ksMTuDZUiJNZNxCSRQNBBvbVPShH/u5kAwwvEnRPYZ6RPWzciDAjDM9
         SRAOYNzLrLrxoPUbJdYPRyVSrcPHy5Enu0Xk+Jqxsi/o+75keKNOScI8vfre3F/h/D8F
         12PHSiOkd6LVpG+GS2+Tzl279h/EKhn4nnpJ1EegR6dfsrV2SwtjgM9B4XA1yq0N6mEv
         r91+WONh6HhhxazL0RXSg8FjpFbpeaDuvBOWb1eysAW4J5D1SuvL4BdEKmIyqF+DyhFi
         GM8kGMjFwjeKJDmu9k9CQRZpf19X5MxdnTYivoFXeRRDBgWQh3imJ2y3aqnMOGuPsVOp
         qy1A==
X-Forwarded-Encrypted: i=1; AJvYcCUjVqO6uZUOTetj4UUgAX0MGRh0/OF6a+zMxs+TxhcxSDFsxOA5V0ODzeHf1xTGnmEkgeygKIbjBsImfgBr@lists.openembedded.org
X-Gm-Message-State: AOJu0Yypdy+H1pIhyMc+RRIWtGEu13Q9WalOQlAQlJX90z/1p9H/fZE/
	vaffOjrzedlzV2fYtSDWSkRjx8bkVJhIoRXw4lXyB0RPC7KSxYhY/myENAMeYrM=
X-Gm-Gg: ASbGncsY2Em/KgrCcmCXm/PHnjrIoxFVdckDoIqjJqzDOVjTYP9+ULGz7iz+J/xYVlf
	AATgZfi8gJPa05HIct9QrH5c0pjCHE+UsBnL4uk9CFuDmv80FIJEW90mBEA4uLNh94DjDWKvXtY
	ufGrpNIPJym346nOEouFGUgeq3HqEi12ghR80jSjXIow/1VXJZoMQVS+ZgIYKO/AphGuKRcTc8v
	aC4+pzyWuIsBnzn8r00SVZcmccMFo7x7kw3+VnDJ67KYpDT7DfTZ91c/axWfeMFvZeIR75kP3ao
	O+UG2Nut0yWuEl5QYz0VGTB7ZYsz1HztX9/i3lc0h71roXCUQIHuzxz1dOWzVBd9n/rubuRIlNp
	1g3qO
X-Google-Smtp-Source: AGHT+IFye9CUds+oSEcqqTib2gjgvaOMLAQRPYAlNs73lJIJPwFhxUXQSq6XjCcCkc9Bk7wT59+1Gg==
X-Received: by 2002:a05:600c:3b9e:b0:439:40c1:1343 with SMTP id 5b1f17b1804b1-43960191549mr33645555e9.15.1739443427505;
        Thu, 13 Feb 2025 02:43:47 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:62a1:585d:a736:8828? ([2001:8b0:aba:5f3c:62a1:585d:a736:8828])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f8c1sm45476695e9.8.2025.02.13.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 02:43:46 -0800 (PST)
Message-ID: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
Subject: 'vendor' fetching discussion cont.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: openembedded-core@lists.openembedded.org, Stefan Herbrechtsmeier	
 <stefan.herbrechtsmeier-oss@weidmueller.com>, Bruce Ashfield	
 <bruce.ashfield@gmail.com>, bitbake-devel
 <bitbake-devel@lists.openembedded.org>
Date: Thu, 13 Feb 2025 10:43:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 10:43:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17212

I've pulled this to a separate email/thread since I'd like to take a
slight step back and put some different ideas into the mix as well as
explain where my own thoughts are right now. I'm also doing this so
that we can focus the discussion and give others a place to catch up
from. For that reason I may restate some information below.

We have two fundamentally different approaches:

a) a single entry in SRC_URI with magic behind the scenes expanding
this into a list of dependencies

b) multiple entries in SRC_URI generated with tooling

gitsm is similar to a), partly because it can contain recursive
references to other submodules so the second approach wouldn't work.
crates are handled with the b) approach today.

Developers in general are more comfortable with b) since they can more
easily see what is going on but it is also the harder one since it
deviates most from the underlying tools and has two sets of data that
require to be in sync.

Some feel the .inc files enabling b) are effectively machine generated
and could be removed with the work happening transparently instead,
simplifying the recipes and commits. This allows easier use of the
underlying tooling too.

I think firstly, we need to document some key principles. Behind the
scenes, any given url should expand to a defined list of components and
that list has to be deterministic and not "floating", i.e. always the
same regardless of changes in any registry or other upstream. If there
are changes, they need to be detected and there needs to be a hard
error. Also, if the code sees things declared in a way they could vary,
that also needs to be a hard error.

Most of the concerns I've seen are about how easy it is to understand
what is going on behind the scenes. The move of code to OE and
splitting everything into multiple tasks/stages does do that to some
extent but it does it in a way which I think is going to create a new
and different set of problems.

I'm therefore wondering if there is a different way. The changes I'm
wondering about would be to:

a) embrace the single SRC_URI entry

b) require a checksum of the internal "URL list" that is included
in=C2=A0SRC_URI, much in the same way that we have checksums of tarballs.
For better or worse, we have low trust in the underlying tools to get
this right (they are getting better).

c) if the checksum doesn't match, we know something went wrong and
error

d) require the new modules to write the URL list into a known location
as part of unpack

e) add the ability to add custom hooks in the fetch process to handle
the cases of needing to alter the flow for patching the components list

f) create new tools that allow the fetcher to be stepped through and
for example partially run, or run with clear debug output showing what
was happening at each stage (show the list of components?). This may be
standalone tools, maybe a devtool module, I don't know. We may want to
make the fetch/unpack logs more useful in general as right now you
don't get much useful data about what it is doing.


If we do those things, where does that get us? How much buy in do our
different stakeholders have?

FWIW I am leaning towards having this code in the bitbake fetcher as a
first class citizen as to do otherwise is going to create layers of
abstraction and we probably have enough of those already.

Cheers,

Richard










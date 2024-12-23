Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D8BE7718B
	for <webhook@archiver.kernel.org>; Mon, 23 Dec 2024 10:04:03 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.11091.1734948237074365812
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Dec 2024 02:03:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ic5O2t7g;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e87b25f0so3218322f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Dec 2024 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734948235; x=1735553035; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BzekVMOE7uEDgSbJP5wh69Y7qklsGG1gVO+RZbqlQfE=;
        b=Ic5O2t7geJSIfq7Z1iAm3JMjcQZ6geu/mOZ3mZxbrW09g9u5hX3UwA6p/a2otZftih
         KblX1xrNSED+MQqiidcR+GRGlUKAS79qMIXt6S9/weXusrgJUvVrsmzMKk9oG0CGiXId
         bFBRZg1qi03UlbfAPJpYhQeRQ0MtmkkxvdTBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734948235; x=1735553035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzekVMOE7uEDgSbJP5wh69Y7qklsGG1gVO+RZbqlQfE=;
        b=CPEpDoQADGpBzPyq3RxjXktvfKMfd2cato0f5T4ojJlWSlJHwv1BQvxGjdCaQ3DoOF
         ZG4ebsFx2ZwAOMvqB+pu/Fg6r87jb6gPhsy2IYIepjXKDAnbf+G0OxQIlG4Itg1/jfmi
         TDhY6fxloDWj7lMffTNPkLPWxL0IZXWpLa5gp1dAn2WP92tzxOkCFLitO1/KM5Zawmac
         xUhiOzHFwO44noiJWQytNw4xPstmb4bg0E2xGyRMLeQiDdL5R88Cd5KJNoTY6QCcLXn0
         ISZcKXAGR+aNbyoqudg3hOu4PJ4eAcjl1M9lX7Iz7vWyydic/e6wj8PZTpkiVYL/ajBu
         IbUA==
X-Forwarded-Encrypted: i=1; AJvYcCXx0XjTi8F4fwygQrrPFOwnzYWgxqemuKIEYs/FzHJ4Na2FgrApeloOWJxgI4bnNqUNBheGZZ/JAB9NlZzg@lists.openembedded.org
X-Gm-Message-State: AOJu0YyIQDZsf9wYC+ijiHQEc945v5BoyltfExX/w3JZ+rn9/b//Nbmd
	O1VZI0HosYypksvpHh2IgiQMo8R1ayHkLVmAGj8RtbDc31yjJ5oLouY/47JwCms=
X-Gm-Gg: ASbGncs1EyUhesNEd2hJEoUda8ACtfSSFRLXAaxpUYqVzYdZvGsF7VfKvLYZ1qDlr8D
	12w0kB4jp8hbHm/MhVx+5BlGBMqygEie1T5b2fLpln1EEHM8qUZExhHA68ddyZiN5/+oSNQRbZt
	NRhg3t3QiOxwktwra91VjUhheveXR/fH5if9iB+SqOgwV0tn1xGu80U99rfeKRJvoz5MMykT3JU
	88InU5MUSUBvqlJu48hPxSpb2uaYCwY5Ku+rFxjg+wk6Qe3VBjQ1Z5koMH+4IhRqv4SaWXAxYQ1
	+XSXdpMbyq5zQikxoE/ZkDZEmd2KNo/2ylnk1qe6qSngKw==
X-Google-Smtp-Source: AGHT+IEyi2/sc1LAVQHePq4gZ7ETsGT4iBR0z9Ucdmq27NhJkQ1SyhBVpoJdk3rSx5v4uWyHGVWjVg==
X-Received: by 2002:a5d:6485:0:b0:386:3711:ffa9 with SMTP id ffacd0b85a97d-38a1a233376mr12922511f8f.16.1734948235279;
        Mon, 23 Dec 2024 02:03:55 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6ed5:9162:4947:2803? ([2001:8b0:aba:5f3c:6ed5:9162:4947:2803])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e528sm11118531f8f.83.2024.12.23.02.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 02:03:54 -0800 (PST)
Message-ID: <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan.herbrechtsmeier-oss@weidmueller.com, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Mon, 23 Dec 2024 10:03:52 +0000
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
	<20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Dec 2024 10:04:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16945

On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.openemb=
edded.org wrote:
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>=20
> The patch series improves the fetcher support for tightly coupled
> package manager (npm, go and cargo). It adds support for embedded
> dependency fetcher via a common dependency mixin. The patch series
> reworks the npm-shrinkwrap.json (package-lock.json) support and adds a
> fetcher for go.sum and cargo.lock files. The dependency mixin contains
> two stages. The first stage locates a local specification file or
> fetches an archive or git repository with a specification file. The
> second stage resolves the dependency URLs from the specification file
> and fetches the dependencies.
>=20
> SRC_URI =3D "<type>://npm-shrinkwrap.json"
> SRC_URI =3D "<type>+http://example.com/=C2=A0npm-shrinkwrap.json"
> SRC_URI =3D "<type>+http://example.com/${BP}.tar.gz;striplevel=3D1;subdir=
=3D${BP}"
> SRC_URI =3D "<type>+git://example.com/${BPN}.git;protocol=3Dhttps"
>=20
> Additionally, the patch series reworks the npm fetcher to work without a
> npm binary and external package repository. It adds support for a common
> dependency name and version schema to integrate the dependencies into
> the SBOM.

This certainly sounds promising, thanks for working on it. It will take
me a bit of time to digest the changes.

A while back I was asked to document the constraints the fetchers
operate within and I documented this here:

https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/fetch2/README

Would you be able to check if this work meets the criteria set out
there and if not, what the differences are?

Thanks,

Richard


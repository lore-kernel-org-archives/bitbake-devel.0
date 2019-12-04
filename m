Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id F0B2D7E422
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Dec 2019 18:22:26 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id z7so295295wrl.13
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Dec 2019 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=q95MyfUR7y7wPlIee5VFhSXAIXZGnek+kuqQEsj9gTE=;
	b=OcMESvPLRqMxOwlfmm8SwwY7rUKfYJ1cJ72PaiGSFA3t1fgv+W1HQH7NwguAUarj0/
	KrJ0pW/SZfanuM+hosRtwqouO+JqJpCv2V5MY6h4glR7UvZo2ip0WOHpOYR9mKY/Cg5A
	4cesHcA2KlLndt2bvflSRoVfVtxmlGZflYON0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=q95MyfUR7y7wPlIee5VFhSXAIXZGnek+kuqQEsj9gTE=;
	b=m6sgHcBeLVNyd41CuyA9yndhPTWvgBRi64m82IBqXsZxmV0FZgGRi2etj1yjXnMYTp
	9SWlWS8OstcfQOLNRake/sp8+8mxD3ANkHAcTXSWs/Gei5n1//9+q+tG/i+erqF2f+re
	mt8K61+NaFPi8DANkMkIi5XNe4wTaMd/Qjd0fGYGnmM5T24wGBSnlb8+1iel8Uqd20lI
	r8m0yY0kAb7nG3EdK/au15mMOaNZ2PDal+sW0qqfUe3ffkgtmSOBo9g77d06vzWK6xL6
	C++mKiwixPJPzQj29zj5YQY0ik/afX52pqhGfFRuRLQroJTGnGjjMUVX3jjSTKiQLTQo
	XrXg==
X-Gm-Message-State: APjAAAVto8CiNB/HbEp5dx8JoH1suM9ljnkk1lNgyV3dGeppBEArV7MH
	kHn08imfuqzBxsxZs1ZoqWLROQ==
X-Google-Smtp-Source: APXvYqx8UJQgdQPPDvQJwFyM7Z6EHlivM3wJa1LOeWDrHlWRAWQrgzyWlhh3oqwixBnFxpDPUl+p0w==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr5384177wrr.252.1575483747428; 
	Wed, 04 Dec 2019 10:22:27 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	t13sm7910520wmt.23.2019.12.04.10.22.26
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Dec 2019 10:22:26 -0800 (PST)
Message-ID: <6fbfff43cfa01ec37eabc31c9ec12620e21b2d27.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: akuster808 <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 04 Dec 2019 18:22:25 +0000
In-Reply-To: <ce3c43d8-9d74-366a-145b-ca6d78778235@gmail.com>
References: <20191204115302.24692-1-richard.purdie@linuxfoundation.org>
	<ce3c43d8-9d74-366a-145b-ca6d78778235@gmail.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] hashserv: Add support for equivalent hash reporting
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 04 Dec 2019 18:22:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-12-04 at 10:20 -0800, akuster808 wrote:
> 
> On 12/4/19 3:52 AM, Richard Purdie wrote:
> > The reason for this should be recorded in the commit logs. Imagine
> > you have a target recipe (e.g. meta-extsdk-toolchain) which depends
> > on
> > gdb-cross. sstate in OE-Core allows gdb-cross to have the same hash
> > regardless of whether its built on x86 or arm. The outhash will be
> > different.
> > 
> > We need hashequiv to be able to adapt to the prescence of sstate
> > artefacts
> > for meta-extsdk-toolchain and allow the hashes to re-intersect,
> > rather than
> > trying to force a rebuild of meta-extsdk-toolchain. By this point
> > in the build,
> > it would have already been installed from sstate so the build needs
> > to adapt.
> > 
> > Equivalent hashes should be reported to the server as a taskhash
> > that
> > needs to map to an specific unihash. This patch adds API to the
> > hashserv
> > client/server to allow this.
> > 
> > [Thanks to Joshua Watt for help with this patch]
> 
> This sounds like 1.44 backport worthy?

Yes. Needs a little settling time in master first though.

Cheers,

Richard



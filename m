Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id A6D0D789E0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jul 2018 11:24:17 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id v25-v6so1123064wmc.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Jul 2018 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=cZniS6JXH0/oMjRDa/5jb7TM819XucNHkZsaw1/weOc=;
	b=c5hEa+htwfYTO0o+c9Mc4qAw5WPPuJd1/CQXfX2Z7C9o4CdRGdC1vv+CeSMyLmh23Y
	jW9eD23KuK610Bm6jDo0ky8C3HrFgUMZGGQlVZXciuJAGguTRFV/ft+Ict+Wh2IaIctT
	ufqcqQbFsSbDL27/vp7JzWSk9cmqvuIVdSMSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=cZniS6JXH0/oMjRDa/5jb7TM819XucNHkZsaw1/weOc=;
	b=RCV0Iji1CQLG7xqmOE5wFic7u23KEhX2ukw1iVczscmjP6smGZYKRWoMXue11y3wHb
	Ve+1J9lIxZvFjcCzG7Y0k9EWxp0R3WvQWcOTTH3ZkM2Xzk1OpUxMUfx7B8kNx5/1BrW/
	r4jIDxlhCgmLbfXWVF86adxxaZCWBw8t3dlivYHPsb80TU3DwJ3/lyPLB+3qkpzyE+a7
	iKELy980TIaUmc8/C/5m7jwLShc99qiwbqCpFaOqi+8yJ7XS2SppEYx4lO5Naa4j+LH9
	Qz/ZdcuYBKWdI+yLqFONZbloGw+7rGMFi8st3WilM9tZ/WeLyvf67dBAP5kjUxv1dz3g
	WG7Q==
X-Gm-Message-State: AOUpUlEbSNf9XG2H6grsEptPqQBzxl/gxFSMITE8rR+JG14eoNFOahGx
	LxD0acz19lwuVUaftAhzWo6jkA==
X-Google-Smtp-Source: AAOMgpchDar+nc83/am1U5qQiRSQYQ/GPR0/zanYjXkAjGDQNH+TNIDsAsCbwiizissaHhG8OM3gXw==
X-Received: by 2002:a1c:a8d6:: with SMTP id
	r205-v6mr1071381wme.6.1531826658447; 
	Tue, 17 Jul 2018 04:24:18 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	u73-v6sm1916258wmd.4.2018.07.17.04.24.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 17 Jul 2018 04:24:17 -0700 (PDT)
Message-ID: <27b7bf4b1cd46e051b3c9c9e109ecacf6f238336.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Urs =?ISO-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 17 Jul 2018 12:24:16 +0100
In-Reply-To: <1531826153.2962.36.camel@bbv.ch>
References: <1531826153.2962.36.camel@bbv.ch>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Subject: Re: Issue with bitbake fetch/unpack when using MIRRORS rewrite
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
X-List-Received-Date: Tue, 17 Jul 2018 11:24:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Urs,

On Tue, 2018-07-17 at 13:15 +0200, Urs Fässler wrote:
> I investigated the issue that the unpack step fails when using mirror
> rewrite rules.
> 
> The root of the problem is, that the download step uses the
> mirrored url to create the local filename while the unpack step uses
> the url from the recipe to create the local filename.
> 
> As I understand the code, the link between the filename from
> download and the filename from unpack is missing. It seems to work
> because they are usually the same.
> 
> I tried both solutions proposed by Richard: Using symlinks and the
> recipe-url.
> The symlink solution is nice since it follows the same methods as for
> git clones. Unfortunately, it is not practical for us. We like to
> store
> the tarballs on a SMB share or S3 storage. Both do not support
> symlinks.
> The recipe-url naming method is nice since the tarball is named after
> the url as it is written in the recipe. This is easy understandable.
> But unfortunately this method breaks the test
> "FetcherNetworkTest.test_gitfetch_premirror", which tests the
> following: when 2 different recipe-urls point to the same mirrored-
> url, the repository is cloned only once.

Would you be able to provide a kind of worked example of the problem? I
think I understand the problem but some example urls, the mirror format
and the resulting different mirror tarball names would probably make it
easier for me to comment on this.

> Now the question is which solution we should implement. For us, it is
> the second one (tarball naming after recipe-url). It comes with the
> downside that the one mentioned test fails and has to be removed. In
> a
> real scenario this results in downloading a repository twice and
> having
> 2 tarballs with the same content. But I expect this to be unlikely in
> a
> real world scenario.
> 
> A third solution may be that we add a link between the download and
> unpack task. But this would be the most intrusive solution for
> Bitbake.

I'm more than a little concerned about the symlink comment since the
fetcher assumes that symlinks work in other places too.

Also, do you have any new test cases to add which illustrate it?

Cheers,

Richard





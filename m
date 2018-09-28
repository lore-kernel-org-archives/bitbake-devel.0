Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id AC3BB7999F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2018 07:52:39 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id z14-v6so5262858wrs.10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2018 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=V7650sglGYQZC4aOJLlts1BtYFP4znuC7Rm15GarJmg=;
	b=BjDmCk85d7fgCKQ0ZJ7f/c1gUSPIR4888+chjaXrcfP0WSDMzeHzVbhdbBoT8u5fLx
	W/zVWhyc12fJ5dKhT4ZefC+M06z2JlCe9I7BYBQVrYvwojF9XP5ONTfFtxEZUeh0A76p
	bM1NG0vZx/4+AGb+E24qdozlsQpl7BECgK6VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=V7650sglGYQZC4aOJLlts1BtYFP4znuC7Rm15GarJmg=;
	b=WiZ9i4rMKjCm4JCSVYFSZehbquZVTEaGmd7gUqCeCU8v4sZR4YUrTamrV/THiSa4uV
	rz3zGpk0DJA4Xus07b8ZfQMO5hLVTL/iCMucyLrGxtLq0RJgkuT9wkDiDcKirIvzfQJU
	U6zIeonexQatlQDCOq6zGRsD1CX0R6hIS4vXDVjpgVoo9BTdtokh4zErd2iPtFQ1zFcb
	7+AdTbox4R35yOvPxk7gLBScoJUc1WBGmsznVtNs7ssmBUrh+1zbYAvX5yxfWHsKCcYH
	dK2MMeXrGLE8OvDsXwRvbZLBophwvD+cD43ujHXQebk6sKfoUpG8EcsP03Ka3cqE7pBJ
	8oBQ==
X-Gm-Message-State: ABuFfohU1+ptYfIcP1FrrWGqMG9UhDiJrpMjA338C6RII4Ev/8UYqbgS
	MOCSrNIMDs39oX91KANbszL39A==
X-Google-Smtp-Source: ACcGV62/uQgYfHH5gsXjD446nikaDpjg46p2SSY4cB/EbEQSVDoyblGrDMmiwbb2MbHtuxvMhGNPZQ==
X-Received: by 2002:adf:a599:: with SMTP id
	g25-v6mr11115804wrc.88.1538121160340; 
	Fri, 28 Sep 2018 00:52:40 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	n8-v6sm3652123wrw.31.2018.09.28.00.52.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 28 Sep 2018 00:52:39 -0700 (PDT)
Message-ID: <573089240e7086a6091c1123454a842cec4cff78.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: "Belal, Awais" <Awais_Belal@mentor.com>, "Reyna, David"
	<david.reyna@windriver.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Sep 2018 08:52:35 +0100
In-Reply-To: <1538120253384.1227@mentor.com>
References: <1536831336527.93802@mentor.com>
	, <5E53D14CE4667A45B9A06760DE5D13D0F3AC15D6@ALA-MBD.corp.ad.wrs.com>
	, <1537430385445.98207@mentor.com> <1538034849901.46023@mentor.com>
	,<f3a9349906015f5961c688f27b82fa92967e5510.camel@linuxfoundation.org>
	<1538120253384.1227@mentor.com>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Subject: Re: [sumo][PATCH] toaster: localhostbecontroller: fix bitbake path resolution
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
X-List-Received-Date: Fri, 28 Sep 2018 07:52:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2018-09-28 at 07:37 +0000, Belal, Awais wrote:
> > > I'm confused. Does master need the patch? or only sumo?
> 
> Both.

The patch doesn't apply to master so could you send a version which
applies there please? 

I can then apply the sumo one at the same time which does presumably
apply to sumo (I've not tried that as yet).

Thanks,

Richard


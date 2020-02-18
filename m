Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id EB12E61517
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 15:48:02 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id q9so3249837wmj.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 07:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=mw3rAKXF4A1BkepAHOe45jlCUFTAru125KZ/D7DyNzw=;
	b=fEu36pR5tcMRt8VZ6npop7qznIyu5mnLAJ/229IWCiadqmWUgFSL35B+mYS0wv7wUQ
	5eu7YWla0+ulRUPe2hENgiOmPqs/UkgHb6wTA6Dp4pdQESZ5C4c3u5kr2WcnyYrs70my
	Wgvq6ENrebvxmFGssQFxlKTAtvIKKXXYuhkJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=mw3rAKXF4A1BkepAHOe45jlCUFTAru125KZ/D7DyNzw=;
	b=ea0sEN5B/Cu78q8VRaJz/LdhfTVcmeRLjNcZUwcxZzM0wL41StNqU3RLGwLTmD+dR2
	M2ZU2PKgmqJLfI4Ii5Ifp86obrlq2uiRnXjkuX/PWdRwlIY8012UbJ48W61iL+ZzPM1c
	OjvFN3BaLnHSTvhE5Z99i377jFgp2XsALw/DErGPjdhzLGBlaYR52tsA1VGwtqjtt/Ns
	36CeiBDNjd1q0gjZXynJWvPJ+KqN6J/QXlzbZX+xNeCmyehqhv+S+/FmQl6m1CU0OkHA
	JrlwvUbd/M0dzRTV4nwtqfowlwHxT3iB63zdWsGW6crOhOwPvBUPQW2unXtzphT/2iJy
	JAYg==
X-Gm-Message-State: APjAAAUf+RcHWeKXm8WwiGM85cEdzNCmAp68RhXWKatU1J4x0WPTOksg
	GpmyXuSHTIx9JWkLjng7asLxFA==
X-Google-Smtp-Source: APXvYqyiyvnoy+xZeaRpSvpiAy7dkiBj/uqPVHVyTT2HjOQp6naIrtsG4Kg5JhFJjigaCdvZlRrslg==
X-Received: by 2002:a1c:1d09:: with SMTP id d9mr3946690wmd.91.1582040883440;
	Tue, 18 Feb 2020 07:48:03 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	q124sm4641854wme.2.2020.02.18.07.48.02
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 18 Feb 2020 07:48:02 -0800 (PST)
Message-ID: <bff19e6863158641908a0035fc8e834f95a0b9ee.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: akuster808 <akuster808@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 18 Feb 2020 15:48:01 +0000
In-Reply-To: <781da9cf-0229-1d3f-ab03-e064cd27265a@gmail.com>
References: <20200217162307.36082-1-richard.purdie@linuxfoundation.org>
	<781da9cf-0229-1d3f-ab03-e064cd27265a@gmail.com>
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
Subject: Re: [PATCH] cooker/siggen: Empty siggen cache during parsing
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
X-List-Received-Date: Tue, 18 Feb 2020 15:48:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-02-18 at 07:44 -0800, akuster808 wrote:
> 
> On 2/17/20 8:23 AM, Richard Purdie wrote:
> > When parsing recipes its apparent the memory usage of bitbake rises
> > linearly
> > with number of recipes parsed. It shouldn't.
> This seems back port worthy to 1.44, 1.42

Yes, I did it already! :)

(With my bitbake maintainer hat on)

Cheers,

Richard



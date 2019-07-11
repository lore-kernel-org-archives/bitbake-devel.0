Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
	[209.85.128.53])
	by mail.openembedded.org (Postfix) with ESMTP id 0677C7EF50
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 16:14:48 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id h19so7328247wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=jSTaXIzHsISHNKsdxymXw0lzhjc08RCps+ejfyv+waw=;
	b=JsMX/uPZRrAOh/uiEd+bjw+sHtbl4yEaY6uirWBRBnidq/Snj28YbBGVjTWrJnbFLF
	fYquwsfCWJi6b6EkExfMtWoKsTJG4GfNDFkJuf0u96jYhA13w4Q421We7kUgTSa6pctc
	AepZOjacdJ/MYle0xcVano+zGmdwB3lTSWiUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=jSTaXIzHsISHNKsdxymXw0lzhjc08RCps+ejfyv+waw=;
	b=I/Zqi0Vb+fKRzVyBvH7T0Z7uKMsjmJlz1cnuwUYQOC7vVa/uqN8bPL1qiwrt6nRsvh
	zTMYWQE98IvnLeVevAmN1W7ilwD7jEnqS9ccq9TMfIUWAuP2cg5dNvFzFnmxTU2bZ3HK
	hN9Qx/hv2Ei7+jK32eREv+94eJjURNxvSJ/ODn2ScPozpk4E8Zr3FMqsyONvgbdydHyj
	b0MiCLE8jan4ZdMvcEe0zq5DzwaAr5YV2SgTyc02lLe0F8opRCQ8ZfbAnkWv1HAQRGcg
	9FAteGXSitVWVTmsmc00007UaWMngaEtqlaZuNiYFSfsuX15jYDA7JdSewrustsjx2OC
	iY2Q==
X-Gm-Message-State: APjAAAV6qVEjxXMID5n4bCy47Iqq5uvqEmXfQbL8bNELghVdWZPucOu+
	T94jEO+H8c1SbbUjwtGVq50/tDJIjow=
X-Google-Smtp-Source: APXvYqzdrfn0d2ClLYzHIPWjdlhH4X+JV6C3Q/uTY3zJB0XwVYZ8vFobf7GjTxDMjuRJlAvD7gIB/w==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr4884658wmf.2.1562861689691;
	Thu, 11 Jul 2019 09:14:49 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id a8sm4721770wma.31.2019.07.11.09.14.48
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 11 Jul 2019 09:14:49 -0700 (PDT)
Message-ID: <a964c86b9ef3301b22f75c2cc79af35cfa1ed598.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Alan Kozlay <alan.kozlay@ves-solutions.com>
Date: Thu, 11 Jul 2019 17:14:47 +0100
In-Reply-To: <CAJE9sGk59TaZiijPx5GqsJ7KVEeq3yW3ywTC7Z6phihCjua4mg@mail.gmail.com>
References: <CAJE9sG=4MPryg2+h5a-jmhhpqPW=o6E26rte-JSPc31UioNbwQ@mail.gmail.com>
	<d12b286a3b55653e61d8d8e7672d87b374ae37d6.camel@linuxfoundation.org>
	<CAJE9sGmynaeD3uL-UBJnJt74rhv-sjSYjtQ=mNByQ69pVwaerg@mail.gmail.com>
	<a29ff39b8e26b1c9dd7d1f24e8991e93097225ec.camel@linuxfoundation.org>
	<CAJE9sGk59TaZiijPx5GqsJ7KVEeq3yW3ywTC7Z6phihCjua4mg@mail.gmail.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Should multiconfig save build time?
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
X-List-Received-Date: Thu, 11 Jul 2019 16:14:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-07-10 at 11:58 -0400, Alan Kozlay wrote:
> Thanks for the feedback. 

Good news is that with the basics of the work done, optimising the
multiconfig case turned out not to be too bad.

I've shared some further patches on the mailing list (also in master-
next) and you could give those a try if you're feeling adventurous.

I've shown they do the right thing in the test I wrote for it. Its had
no real world testing as yet, you're at the edge of development here.

Cheers,

Richard


